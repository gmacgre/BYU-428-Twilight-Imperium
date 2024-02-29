package com.twilightimperium.backend.model.game;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Tile {
    Set<Integer> tokens; //contains the player numbers of players who have activated this system
    List<Planet> planets;
    List<Ship> ships;
    String anomaly;

    public Tile(){
        tokens = new HashSet<>();
        planets = new ArrayList<>();
        ships = new ArrayList<>();
        anomaly = null;
    }

    public Tile clone(){
        //INCOMPLETE, maybe use a JSON library to more easily copy all of the sub objects?
        Tile copyTile = new Tile();
        return copyTile;
    }

    public String getAnomaly() {
        return this.anomaly;
    }

    public void setAnomaly(String anomaly) {
        this.anomaly = anomaly;
    }

    public Set<Integer> getTokens() {
        return this.tokens;
    }

    public void setTokens(Set<Integer> tokens) {
        this.tokens = tokens;
    }

    public List<Planet> getPlanets() {
        return this.planets;
    }

    public void setPlanets(List<Planet> planets) {
        this.planets = planets;
    }

    public List<Ship> getShips() {
        return this.ships;
    }

    public void setShips(List<Ship> ships) {
        this.ships = ships;
    }

    
}
