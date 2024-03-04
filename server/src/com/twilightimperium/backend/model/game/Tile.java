package com.twilightimperium.backend.model.game;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Tile {
    Set<Integer> tokens; //contains the player numbers of players who have activated this system
    List<Ship> ships;
    String system;

    public Tile(){
        tokens = new HashSet<>();
        system = "Empty";
        ships = new ArrayList<>();
    }

    public Tile(String system){
        this.system = system;
    }

    public String getSystem(){
        return system;
    }

    public void setSystem(String system){
        this.system = system;
    }

    public Tile clone(){
        //INCOMPLETE, maybe use a JSON library to more easily copy all of the sub objects?
        Tile copyTile = new Tile();
        copyTile.setSystem(new String(system));
        for (Ship i : ships){
            copyTile.getShips().add(i.clone());
        }
        for (Integer i : tokens){
            copyTile.getTokens().add(Integer.valueOf(i));
        }
        return copyTile;
    }


    public Set<Integer> getTokens() {
        return this.tokens;
    }

    public void setTokens(Set<Integer> tokens) {
        this.tokens = tokens;
    }

    public List<Ship> getShips() {
        return this.ships;
    }

    public void setShips(List<Ship> ships) {
        this.ships = ships;
    }

    
}
