package com.twilightimperium.backend.model.game.tile;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import com.twilightimperium.backend.data.SystemModel;
import com.twilightimperium.backend.model.game.entities.Ship;

public class SystemState {
    int owner;
    List<Ship> ships;
    Set<Integer> tokens;
    List<PlanetState> planetStates;

    public SystemState() {
        owner = -1;
        ships = new ArrayList<>();
        tokens = new HashSet<>();
        planetStates = new ArrayList<>();
    }

    SystemState(SystemModel base) {
        owner = -1;
        ships = new ArrayList<>();
        tokens = new HashSet<>();
        planetStates = new ArrayList<>();
        if (base == null) {
            return;
        }
        if (base.getPlanets() == null) {
            return;
        }
        for (int i = 0; i < base.getPlanets().size(); i++) {
            planetStates.add(new PlanetState());
        }
    }

    private SystemState(int owner, List<Ship> ships, Set<Integer> tokens) {
        this.owner = owner;
        this.ships = ships;
        this.tokens = tokens;
        planetStates = new ArrayList<>();
    }

    public SystemState clone() {
        return new SystemState(owner, new ArrayList<>(ships), new HashSet<>(tokens));
    }


    public Set<Integer> getTokens() {
        return tokens;
    }
    void setTokens(Set<Integer> tokens) {
        this.tokens = tokens;
    }
    List<Ship> getShips() {
        return ships;
    }
    void setShips(List<Ship> newList) {
        ships = newList;
    }
}
