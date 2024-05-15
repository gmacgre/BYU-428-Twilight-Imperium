package com.twilightimperium.backend.model.update.placed;

import com.twilightimperium.backend.model.game.Location;
import com.twilightimperium.backend.model.update.Update;

public class ActivateUpdate extends Update {

    public ActivateUpdate(int player, Location location) {
        super("activate", player, new ActivateUpdateInfo(location));
    }
    
}

final class ActivateUpdateInfo extends PlacedUpdateInfo {
    public ActivateUpdateInfo(Location location) {
        super(location);
    }
}
