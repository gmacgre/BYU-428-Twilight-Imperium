package com.twilightimperium.backend.model.RequestResponse;

import com.twilightimperium.backend.model.game.Location;

public class ActivateRequest {
    private final Location coords;

    public ActivateRequest(Location coords) {
        this.coords = coords;
    }

    public Location getCoords() {
        return this.coords;
    }


}
