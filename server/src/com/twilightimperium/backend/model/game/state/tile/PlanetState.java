package com.twilightimperium.backend.model.game.state.tile;

public class PlanetState {
    int numPds;
    boolean hasSpacedock;
    int owner;
    int numGroundForces;

    PlanetState() {
        numPds = 0;
        hasSpacedock = false;
        owner = -1;
        numGroundForces = 0;
    }

    public void addGroundForce(int quantity, int owner) {
        if (this.owner == -1) {
            this.owner = owner;
        }
        numGroundForces += quantity;
    }
}
