package com.twilightimperium.backend.model.game;

import java.util.ArrayList;
import java.util.List;

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
    
}
