package com.twilightimperium.backend.model.update.placed;

import com.twilightimperium.backend.model.game.Location;
import com.twilightimperium.backend.model.update.Update;

public class SpacedockPlacedUpdate extends Update{

    public SpacedockPlacedUpdate(int seatId, Location location, int spacedockLocation) {
        super("spacedockPlaced", seatId, new SpacedockPlacedUpdateInfo(location, spacedockLocation));
    }
}

final class SpacedockPlacedUpdateInfo extends PlacedUpdateInfo {

    int spacedockIndex;
    SpacedockPlacedUpdateInfo(Location location, int idx) {
        super(location);
        this.spacedockIndex = idx;
    }
    
}
