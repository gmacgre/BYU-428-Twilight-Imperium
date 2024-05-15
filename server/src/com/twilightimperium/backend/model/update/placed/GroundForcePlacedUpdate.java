package com.twilightimperium.backend.model.update.placed;

import com.twilightimperium.backend.model.game.Location;
import com.twilightimperium.backend.model.update.Update;

public class GroundForcePlacedUpdate extends Update {

    public GroundForcePlacedUpdate(int player, Location location, int idx, int forces) {
        super("groundForcePlaced", player, new GroundForcePlacedUpdateInfo(location, idx, forces));
    }
    
}

final class GroundForcePlacedUpdateInfo extends PlacedUpdateInfo {
    int planet;
    int numForces;
    GroundForcePlacedUpdateInfo(Location location, int planet, int numForces) {
        super(location);
        this.planet = planet;
        this.numForces = numForces;
    }

}