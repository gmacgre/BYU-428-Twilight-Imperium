package com.twilightimperium.backend.model.RequestResponse;

import com.twilightimperium.backend.model.game.entities.Ship;

public class MoveRequest {
    private final Ship[] ships;

    public MoveRequest(Ship[] ships) {
        this.ships = ships;
    }

    public Ship[] getShips() {
        return this.ships;
    }

    
    
}
