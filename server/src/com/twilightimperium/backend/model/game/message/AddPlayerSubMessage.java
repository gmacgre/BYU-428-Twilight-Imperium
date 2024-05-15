package com.twilightimperium.backend.model.game.message;

import com.twilightimperium.backend.model.game.entities.ShipClass;

public class AddPlayerSubMessage {
    public String system;
    public int[] forces;
    public int spacedockLocation;
    public ShipClass[] airforce;

    public AddPlayerSubMessage(String nSys, int[] nForce, int nSD, ShipClass[] airforce) {
        system = nSys;
        forces = nForce;
        spacedockLocation = nSD;
        this.airforce = airforce;
    }

    public AddPlayerSubMessage() {
        system = "Undefined";
        forces = null;
        spacedockLocation = -1;
    }
}
