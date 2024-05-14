package com.twilightimperium.backend.model.game.state.tile;
import java.util.List;

import com.twilightimperium.backend.data.SystemData;
import com.twilightimperium.backend.model.game.entities.Ship;
import com.twilightimperium.backend.model.game.entities.ShipClass;

public class Tile {
    // All needed variables
    SystemState state;
    String system;

    // Constructors and Clone method
    public Tile() {
        system = "Undefined";
    }
    public Tile(String system) {
        this.system = system;
        updateModels();
    }
    private Tile(String system, SystemState newState) {
        this.system = system;
        updateModels();
        this.state = newState;
    }
    public Tile clone() {
        return new Tile(system, state.clone());
    }

    // All necessary setters and getters
    public void setSystem(String system) {
        this.system = system;
        updateModels();
    }

    public String getSystem() {
        return system;
    }

    // Private Setter method for constructors and setSystem()
    private void updateModels() {
        if (system != null) {
            this.state = new SystemState(SystemData.systemList.get(system));
        }
    }

    // All Tile modification comes from here onward
    public boolean activate(int player) {
        return state.tokens.add(player);
    }

    public void addShip(int x, int y, ShipClass shipClass, int owner) {
        // Convert the String to a class
        Ship newShip = new Ship(x, y, shipClass);
        if(state.ships.size() == 0) {
            state.owner = owner;
        }
        state.ships.add(newShip);
    }
    public void removeShip(ShipClass shipClass) {
        List<Ship> current = state.ships;
        for(Ship i : current){
            if (i.getShipClass().equals(shipClass)){
                current.remove(i);
                break;
            }
        }
        state.ships = current;
    }
    public void addGroundForce(int planet, int quantity, int owner) {
        state.planetStates.get(planet).addGroundForce(quantity, owner);
    }


    public void spreadForces(int groundForces, int owner) {
        int size = state.planetStates.size();
        int perPlanet = groundForces / size;
        int remainder = groundForces % size;
        for(int i = 0; i < size; i++) {
            addGroundForce(i, perPlanet, owner);
            if(remainder != 0) {
                addGroundForce(i, 1, owner);
                remainder--;
            }
        }
    }

    public boolean addSpacedock(int owner) {
        // Always pick the system with the greater value that the owner controls
        int idx = -1;
        int value = -1;
        for(int i = 0; i < SystemData.systemList.get(system).getPlanets().size(); i++) {
            if(state.planetStates.get(i).hasSpacedock || state.planetStates.get(i).owner != owner) {
                continue;
            }
            int nVal = SystemData.systemList.get(system).getPlanets().get(i).getResources();
            if(nVal > value) {
                value = nVal;
                idx = i;
            }
        }
        if(idx == -1) {
            // All systems have spacedocks or are controlled by others already!
            return false;
        }
        state.planetStates.get(idx).hasSpacedock = true;
        return true;
    }
}
