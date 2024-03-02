package com.twilightimperium.backend;

import java.util.*;

import com.google.gson.Gson;
import com.twilightimperium.backend.data.SystemModel;
import com.twilightimperium.backend.data.SystemModel.Anomaly;
import com.twilightimperium.backend.model.game.BoardState;
import com.twilightimperium.backend.model.game.GameState;
import com.twilightimperium.backend.model.game.Location;
import com.twilightimperium.backend.model.game.Player;
import com.twilightimperium.backend.model.game.Ship;

import com.twilightimperium.backend.data.SystemData;;


public class Game {
    private static final int ACTION = 0;
    private static final int MOVE = 1;
    private GameState state;
    private Map<String,Integer> tokens;
    private Map<Integer, String> playerNumToToken;
    private int playerNum; //stores the next player # to hand out. The first player is 0, the second is 1 etc.
    private Location activeSystem;
    private int activePlayer;
    private int maxPlayers;
    private int nextCommand; //This stores what the game is waiting on. Does it expect an activate system or move command etc.


    public int getPlayerTurn(String token){
        return tokens.get(token);
    }
    public String jsonGameState(){
        //encode state as json
        Gson gson = new Gson();
        return gson.toJson(state);
    }

    private void nextTurn(){
        //in the future, this will handle initiative.
        //for now, it just goes in order of join.
        if(activePlayer < playerNum-1){
            activePlayer++;
        } else {
            activePlayer = 0;
        }
    }

    public int getActivePlayer(){
        return activePlayer;
    }

    public int getPlayerNum(){
        return playerNum;
    }
    
    public GameState getGameState(){
        return state;
    }

    public Game(){
        nextCommand = ACTION; // we start for now by expecting an activate System command
        playerNum = 0;
        tokens = new HashMap<String, Integer>();
        playerNumToToken = new HashMap<>();
        state = new GameState(maxPlayers);
        activePlayer = 0; //assume that the creator of the game goes first;
        maxPlayers = 6;
        activeSystem = new Location(-1,-1);
    }


    public void addPlayer(String token) {
        if(playerNum < maxPlayers){
            tokens.put(token, playerNum);
            playerNumToToken.put(playerNum,token);
            playerNum++;
            state.getPlayers().add(new Player());
        } else {
            throw new RuntimeException();
        }
    }

    public String requestToken(int playerNum){
        return playerNumToToken.get(playerNum);
    }

    public boolean activateSystem(int x, int y, String token){
        //first we get the player number from the token.
        
        if(nextCommand == ACTION){
            Integer player = tokens.get(token);
            if (player == null){
                return false;
            }
            boolean success = placeTokenSystem(x, y, player);
            if (success){
                nextCommand = MOVE;
            }
            return success;
        } else {
            return false;
        }
    }

    private boolean placeTokenSystem(int x, int y, int player){
            activeSystem.x = x;
            activeSystem.y = y;

            //true indicates a success
            //false indicates that the tile was already activated by that player
            return state.getMap().activateTile(x, y, player);
    }

    public boolean move(Ship[] ships){
        if(nextCommand == MOVE){
            boolean success = moveShips(new ArrayList<Ship>(Arrays.asList(ships)));
            if (success){
                nextCommand = ACTION;
            }
            return success;
        }else {
            return false;
        }
    }

    private boolean moveShips(List<Ship> ships){
        BoardState oldMap = state.getMap().clone();
        for(Ship currentShip : ships){
            if(!validateMove(currentShip, activeSystem)){
                state.setMap(oldMap);
                return false;
            } else {
                state.getMap().addShip(activeSystem.x, activeSystem.y, currentShip.getShipClass());
                state.getMap().removeShip(currentShip.getX(), currentShip.getY(), currentShip.getShipClass());
            }
        }
        return true;

    }

    public boolean validateMove(Ship ship, Location end) {
        return true;
        /*BoardState board = state.getMap();
        int[7][7] visited = {false};
        if()
        */
    }

    private boolean validateMoveHelper(Location current, Location goal, int remaining, int[][] visited, BoardState board){
        //TODO INCOMPLETE
        if (current.x > 6 || current.x < 0 || current.y > 6 || current.y < 0){
            return false;
        }
        if (remaining < 0){
            return false;
        }
        if(current.x == goal.x && current.y == goal.y){
            return true;
        }
        if(remaining == 0){
            return false;
        }
        if (visited[current.y][current.x] >= remaining){
            return false;
        }
        SystemModel system = SystemData.systemList.get(board.getTile(current.x,current.y).getSystem());
        if(system.getAnomalies().size() < 1){
            Location newCoords = new Location(current.x+1,current.y-1);
            if(validateMoveHelper(newCoords, goal, remaining-1, visited, board)){
                return true;
            }
            newCoords = new Location(current.x+1,current.y);
            if(validateMoveHelper(newCoords, goal, remaining-1, visited, board)){
                return true;
            }
            newCoords = new Location(current.x,current.y+1);
            if(validateMoveHelper(newCoords, goal, remaining-1, visited, board)){
                return true;
            }
            newCoords = new Location(current.x-1,current.y);
            if(validateMoveHelper(newCoords, goal, remaining-1, visited, board)){
                return true;
            }
            newCoords = new Location(current.x,current.y-1);
            if(validateMoveHelper(newCoords, goal, remaining-1, visited, board)){
                return true;
            }
            newCoords = new Location(current.x-1,current.y+1);
            if(validateMoveHelper(newCoords, goal, remaining-1, visited, board)){
                return true;
            }
            visited[current.y][current.x] = remaining;
            return false;
        }
        return false;
    }


    // Other methods
}

