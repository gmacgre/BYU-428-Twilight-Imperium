package com.twilightimperium.backend.data;

import com.twilightimperium.backend.model.game.entities.ShipClass;

public class FactionSetup {
    private ShipClass[] airforce;
    private int groundForces;
    private String homeSystem;
    private int numPds;
    // TODO: Add Starting techs

    public FactionSetup(
            ShipClass[] airforce,
            int groundForces, 
            String homeString,
            int numPds) {
        this.airforce = airforce;
        this.groundForces = groundForces;
        homeSystem = homeString;
        this.numPds = numPds;
    }

    public ShipClass[] getAirforce() {
        return airforce;
    }

    public int getGroundForces() {
        return groundForces;
    }

    public String getHomeSystem() {
        return homeSystem;
    }

    public int getNumPds() {
        return numPds;
    }
    
}
