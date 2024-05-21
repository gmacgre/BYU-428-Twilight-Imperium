package com.twilightimperium.backend.model.update.placed;

import com.twilightimperium.backend.model.game.Location;
import com.twilightimperium.backend.model.update.Update;

public class PDSPlacedUpdate extends Update {

    public PDSPlacedUpdate(int player, Location location, int idx) {
        super("pdsPlaced", player, new PDSPlacedUpdateInfo(location, idx));
    }
    
}

final class PDSPlacedUpdateInfo extends PlacedUpdateInfo {

    int pdsIdx;
    PDSPlacedUpdateInfo(Location location, int pdsIdx) {
        super(location);
        this.pdsIdx = pdsIdx;
    }

}