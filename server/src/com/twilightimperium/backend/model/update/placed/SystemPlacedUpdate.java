package com.twilightimperium.backend.model.update.placed;

import com.twilightimperium.backend.model.game.Location;
import com.twilightimperium.backend.model.update.Update;

public class SystemPlacedUpdate extends Update {
    public SystemPlacedUpdate(int player, Location loc, String systemName) {
        super("systemPlaced", player, new SystemPlacedInfo(loc, systemName));
    }
}

final class SystemPlacedInfo extends PlacedUpdateInfo {
    private String system;
    public SystemPlacedInfo(Location location, String system) {
        super(location);
        this.system = system;
    }
    public String getSystem() {
        return system;
    }
    public void setSystem(String system) {
        this.system = system;
    }
}
