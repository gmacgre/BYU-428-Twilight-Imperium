package com.twilightimperium.backend.model.game.state;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.twilightimperium.backend.model.game.Location;
import com.twilightimperium.backend.model.game.entities.Player;
import com.twilightimperium.backend.model.game.entities.Ship;
import com.twilightimperium.backend.model.game.message.AddPlayerMessage;

public class GameState {
    WorldInfo world;
    BoardState board;
    List<Player> players;

    public GameState(int numPlayers){
        world = new WorldInfo();
        board = new BoardState(7);
        players = new ArrayList<>(numPlayers);
        while(players.size() < numPlayers) players.add(new Player());
    }

    public WorldInfo getWorld() {
        return this.world;
    }

    private void setBoard(BoardState map) {
        this.board = map;
    }

    public List<Player> getPlayers() {
        return this.players;
    }

    public AddPlayerMessage addPlayer(int seatId, String race) {
        int[][] homeSystemLocation = {
            {3, 0},
            {0, 3},
            {0, 6},
            {3, 6},
            {6, 3},
            {6, 0},
        };
        int[] spot = homeSystemLocation[seatId];
        if(board.systemAlreadySet(spot[0], spot[1])) {
            return new AddPlayerMessage(true);
        }
        Player toadd = new Player();
        toadd.setRace(race);
        players.set(seatId, toadd);
        String system = board.setPlayerHomeSystem(race, spot, seatId);
        return new AddPlayerMessage(spot[0], spot[1], system);
    }

    public boolean activateSystem(int x, int y, int player) {
        if(world.getNextCommand() != GameStateNode.ACTION) {
            return false;
        }
        if(!board.activateTile(x, y, player)) {
            return false;
        }
        world.setActiveSystem(x, y);
        world.setNextCommand(GameStateNode.MOVE);
        return true;

    }

    public boolean move(Ship[] ships, int player) {
        if(world.getNextCommand() != GameStateNode.MOVE) {
            return false;
        }
        boolean success = moveShips(new ArrayList<Ship>(Arrays.asList(ships)));
        if (success){
            world.setNextCommand(GameStateNode.ACTION);
        }
        return true;
    }

    private boolean moveShips(List<Ship> ships) {
        BoardState oldMap = board.clone();
        int player = world.getActivePlayer();
        Location activeSystem = world.getActiveSystem();
        for(Ship currentShip : ships){
            if(!validateMove(currentShip, world.getActiveSystem())){
                setBoard(oldMap);
                return false;
            } else {
                board.addShip(activeSystem.x, activeSystem.y, currentShip.getShipClass(), player);
                board.removeShip(currentShip.getX(), currentShip.getY(), currentShip.getShipClass());
            }
        }
        return true;
    }

    private boolean validateMove(Ship ship, Location activeSystem) {
        return true;
    }

    public Integer getActivePlayer() {
        return world.getActivePlayer();
    }

    
    
}
