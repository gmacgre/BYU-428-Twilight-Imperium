package com.twilightimperium.backend.model.update;

import com.twilightimperium.backend.model.game.Location;

public class SystemPlacedUpdate extends Update {
    public SystemPlacedUpdate(int player, Location loc, String systemName) {
        super("systemPlaced", player, new SystemPlacedInfo(loc, systemName));
    }
}

final class SystemPlacedInfo implements UpdateInfo {
    private Location location;
    private String system;
    public SystemPlacedInfo(Location location, String system) {
        this.location = location;
        this.system = system;
    }
    public String getSystem() {
        return system;
    }
    public void setSystem(String system) {
        this.system = system;
    }
    public Location getLocation() {
        return location;
    }
    public void setLocation(Location location) {
        this.location = location;
    }
}
