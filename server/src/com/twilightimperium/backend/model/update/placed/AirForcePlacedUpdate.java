package com.twilightimperium.backend.model.update.placed;

import com.twilightimperium.backend.model.game.Location;
import com.twilightimperium.backend.model.game.entities.ShipClass;
import com.twilightimperium.backend.model.update.Update;

public class AirForcePlacedUpdate extends Update {

    public AirForcePlacedUpdate(int player, Location location, ShipClass[] airforce) {
        super("airforcePlaced", player, new AirForcePlacedUpdateInfo(location, airforce));
    }
}

final class AirForcePlacedUpdateInfo extends PlacedUpdateInfo {

    ShipClass[] airforce;
    AirForcePlacedUpdateInfo(Location location, ShipClass[] airforce) {
        super(location);
        this.airforce = airforce;
    }
    public ShipClass[] getAirforce() {
        return airforce;
    }
    public void setAirforce(ShipClass[] airforce) {
        this.airforce = airforce;
    }
}
