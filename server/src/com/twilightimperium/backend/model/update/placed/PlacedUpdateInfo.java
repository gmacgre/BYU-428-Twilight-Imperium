package com.twilightimperium.backend.model.update.placed;

import com.twilightimperium.backend.model.game.Location;
import com.twilightimperium.backend.model.update.UpdateInfo;

abstract class PlacedUpdateInfo implements UpdateInfo {
    Location location;
    PlacedUpdateInfo(Location location) {
        this.location = location;
    }
    public Location getLocation() {
        return location;
    }
    public void setLocation(Location location) {
        this.location = location;
    }    
}
