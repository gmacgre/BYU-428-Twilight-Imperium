package com.twilightimperium.backend.model.game.state;

import java.util.ArrayList;
import java.util.List;

import com.twilightimperium.backend.model.game.Location;
import com.twilightimperium.backend.model.game.entities.Player;
import com.twilightimperium.backend.model.game.entities.Ship;

public class GameState {
    WorldInfo world;
    BoardState map;
    List<Player> players;

    public GameState(int numPlayers){
        world = new WorldInfo();
        map = new BoardState(7);
        players = new ArrayList<>(numPlayers);
        while(players.size() < numPlayers) players.add(new Player());
    }


    public WorldInfo getWorld() {
        return this.world;
    }

    public void setWorld(WorldInfo world) {
        this.world = world;
    }

    public BoardState getMap() {
        return this.map;
    }

    public void setMap(BoardState map) {
        this.map = map;
    }

    public List<Player> getPlayers() {
        return this.players;
    }

    public void setPlayers(List<Player> players) {
        this.players = players;
    }


    public boolean moveShips(List<Ship> ships) {
        BoardState oldMap = map.clone();
        int player = world.getActivePlayer();
        Location activeSystem = world.getActiveSystem();
        for(Ship currentShip : ships){
            if(!validateMove(currentShip, world.getActiveSystem())){
                setMap(oldMap);
                return false;
            } else {
                map.addShip(activeSystem.x, activeSystem.y, currentShip.getShipClass(), player);
                map.removeShip(currentShip.getX(), currentShip.getY(), currentShip.getShipClass());
            }
        }
        return true;
    }

    private boolean validateMove(Ship ship, Location activeSystem) {
        return true;
    }
    
}
