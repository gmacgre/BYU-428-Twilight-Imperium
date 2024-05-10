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
}
