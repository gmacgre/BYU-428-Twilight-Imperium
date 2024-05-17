import 'dart:collection';

import 'package:client/data/system_data.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/model/system_state.dart';
import 'package:client/res/coordinate.dart';
import 'package:client/res/pair.dart';

//Ship Wrapper for Coords and gas/movement
class Ship{
  Coords location;
  int gas;

  Ship(this.location, this.gas);

  @override
  bool  operator == (Object other) =>
      identical(this, other) ||
        other is Ship &&
          runtimeType == other.runtimeType &&
          location == other.location &&
          gas == other.gas;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}

class ShipMovementLogic{
  // Run a BFS on the board to see who can move to a system.
  // If there is at least one ship with the movement large enough to reach the activated system
  // At that system to the list as a coordinate.
  static List<Coords> possibleMoves(Coords activatedSystem, List<List<SystemState>> board, int activePlayer) {

    // Do a "Tech Check" here for the active player

    List<Coords> toReturn = [];
    Set<Coords> visited = {};
    Queue<Pair<Coords, int>> queue = Queue();
    queue.addLast(Pair(activatedSystem, 0));
    while(queue.isNotEmpty) {

      // PreTraversal Checks
      Pair<Coords, int> pair = queue.removeFirst();
      Coords currSystem = pair.first;
      int distance = pair.second;
      if(currSystem.x > 6 || currSystem.x < 0 ||
        currSystem.y > 6 || currSystem.y < 0) {
        continue;
      }
      if(visited.contains(currSystem)) {
        continue;
      }
      visited.add(currSystem);

      SystemState s = board[currSystem.x][currSystem.y];

      if (s.systemModel.anomaly != null && s.systemModel.anomaly == Anomaly.nebula) {
        // Leaving a nebula is only possible at distance 1.
        // TODO: UPDATE WITH GRAVITY DRIVE AND FLANK SPEED?
        if(distance > 1) {
          continue;
        }
      }

      // Determine whether to add the system or not to the return list
      if(s.airSpace.isNotEmpty &&
        s.systemOwner == activePlayer &&
        distance != 0) {
        for (ShipModel ship in s.airSpace) {
          if(ship.movement >= distance) {
            toReturn.add(currSystem);
            break;
          }
        }
      }

      

      // Add adjacent systems
      distance++;
      Coords adjacent = Coords(currSystem.x-1, currSystem.y);
      queue.addLast(Pair(adjacent, distance));

      adjacent = Coords(currSystem.x+1, currSystem.y);
      queue.addLast(Pair(adjacent, distance));

      adjacent = Coords(currSystem.x+1, currSystem.y-1);
      queue.addLast(Pair(adjacent, distance));

      adjacent = Coords(currSystem.x-1, currSystem.y+1);
      queue.addLast(Pair(adjacent, distance));

      adjacent = Coords(currSystem.x, currSystem.y+1);
      queue.addLast(Pair(adjacent, distance));

      adjacent = Coords(currSystem.x, currSystem.y-1);
      queue.addLast(Pair(adjacent, distance));

      if(s.systemModel.wormhole != null) {
        for(int x = 0; x < board.length; x++) {
          for(int y = 0; y < board[x].length; y++) {
            // Don't go out the wormhole the way you came in!
            if(x == currSystem.x && y == currSystem.y) {
              continue;
            }

            if(board[x][y].systemModel.wormhole != null && board[x][y].systemModel.wormhole == s.systemModel.wormhole) {
              adjacent = Coords(x, y);
              queue.addLast(Pair(adjacent, distance));
            }
          }
        }
      }
    }  
    return toReturn;
  }


  /*
  Map<Coords, List<ShipModel>> shipsToMove
    Coords represent a system located at that space on the board. The List<ShipModel> shows the types of ships being moved 
    from that system.
  Coords activatedSystem
    The system (given as Coords) we are trying to validate we can reach.
  */
  static bool validateMoves(Map<Coords, List<ShipModel>> shipsToMove, Coords activatedSystem){
    //For each ship start pathfinding until movement is 0
      //BFS for each ship path
      //Check Airspace
      //Anomalies
    //Origin System and shortest Distance-- Not repeating calculations

    for(var system in shipsToMove.keys){ // For each System
      //Grab list of ships from parameters
      var ships = shipsToMove[system];
      List<Ship> validShips = [];
      
      int shipsToValidate = 0;
      if(ships != null) shipsToValidate = ships.length;

      for(var shipType in ships!){
        var ship = Ship(system, shipType.movement);
        if(!checkDistance(ship.gas, system, activatedSystem)){
          continue;
        }

        final queue = Queue<Ship>();
        queue.add(ship);

        //Coords of System and state of ship
        Map<Coords, Ship> systemsVisited = {};

        while (queue.isNotEmpty){
          var curShip = queue.removeFirst();
          // Arrived at activatedSystem
          if(curShip.location == activatedSystem && curShip.gas >= 0){
            validShips.add(curShip);
            break;
          }
          // Out of gas/movement
          if(curShip.gas < 0){
            continue;
          }
          // Too far away at this point -- culling
          if(!checkDistance(curShip.gas, system, activatedSystem)){
            continue;
          }
          //TODO: Check system at location for enemy ships
          //TODO: Check for anomalies

          addToQueue(curShip, systemsVisited, queue);
          
        }// while
      }// For each Ship

      //Check if each ship move from the system is valid
      if(validShips.length != shipsToValidate){
        return false;
      }
    } // For each System

    //TODO: Wormhole adjacency
    //TODO: Check for Fleet Size

    //If reaches end, then
    return true;
  }

  static void addToQueue(Ship curShip, Map<Coords, Ship> systemsVisited, Queue<Ship> queue) {
    if(onBoard(curShip.location.x,   curShip.location.y-1) && !systemsVisited.containsKey(Coords(curShip.location.x,   curShip.location.y-1))) queue.add(Ship(Coords(curShip.location.x,   curShip.location.y-1), curShip.gas-1));
    if(onBoard(curShip.location.x+1, curShip.location.y-1) && !systemsVisited.containsKey(Coords(curShip.location.x+1, curShip.location.y-1))) queue.add(Ship(Coords(curShip.location.x+1, curShip.location.y-1), curShip.gas-1));
    if(onBoard(curShip.location.x+1, curShip.location.y)   && !systemsVisited.containsKey(Coords(curShip.location.x+1, curShip.location.y)))   queue.add(Ship(Coords(curShip.location.x+1, curShip.location.y), curShip.gas-1));
    if(onBoard(curShip.location.x-1, curShip.location.y)   && !systemsVisited.containsKey(Coords(curShip.location.x-1, curShip.location.y)))   queue.add(Ship(Coords(curShip.location.x-1, curShip.location.y), curShip.gas-1));
    if(onBoard(curShip.location.x-1, curShip.location.y+1) && !systemsVisited.containsKey(Coords(curShip.location.x-1, curShip.location.y+1))) queue.add(Ship(Coords(curShip.location.x-1, curShip.location.y+1), curShip.gas-1));
    if(onBoard(curShip.location.x,   curShip.location.y+1) && !systemsVisited.containsKey(Coords(curShip.location.x,   curShip.location.y+1))) queue.add(Ship(Coords(curShip.location.x,   curShip.location.y+1), curShip.gas-1));
  }

  static bool checkDistance(int gas, Coords start, Coords end){
    // IF y1>y0 THEN Distance=x1-x0+y1-y0
    // ELSEIF x0+y0>x1+y1 THEN Distance=y0-y1
    // ELSE Distance=x1-x0
    int distance = 0;
    if(end.y > start.y){
      distance = end.x - start.x + end.y - start.y;
    } else if(start.x + start.y > end.x + end.y){
      distance = start.y - end.y;
    } else {
      distance = end.x - start.x;
    }

    //if the movement of the ship can reach the system, check pathing, otherwise, skip
    if(distance > gas) return false;

    return true;
  }

  static onBoard(int x, int y){
    if((x == 0 && y <= 2) ||
      (x == 1 && y <= 1) ||
      (x == 0 && y <= 0) ||
      (x == 4 && y >= 6) ||
      (x == 5 && y >= 5) ||
      (x == 6 && y >= 4) ||
      (x < 0 || y > 6)){
        return false;
      } 
      else {
        return true;
      }
  }
}