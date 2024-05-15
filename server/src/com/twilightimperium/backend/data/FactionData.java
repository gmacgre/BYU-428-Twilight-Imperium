package com.twilightimperium.backend.data;
import java.util.HashMap;
import java.util.Map;

import com.twilightimperium.backend.model.game.entities.ShipClass;

// Basic Faction Differentiation Class, to get all Faction info
public class FactionData {
    public static final Map<String, FactionSetup> setup = new HashMap<>();
    static {
        setup.put("sol", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.CARRIER,
                ShipClass.DESTROYER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            },
            5,
            "Jord",
            0
        ));

        setup.put("hacan", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.CARRIER,
                ShipClass.CRUISER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            }, 
            4,
            "Hercant",
            0
        ));

        setup.put("arborec", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.CRUISER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            }, 
            4,
            "Nestphar",
            1
        ));

        setup.put("letnev", new FactionSetup(
            new ShipClass[]{
                ShipClass.DREADNOUGHT,
                ShipClass.CARRIER,
                ShipClass.DESTROYER,
                ShipClass.FIGHTER,
            }, 
            3,
            "Arc Prime",
            1
        ));

        setup.put("saar", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.CARRIER,
                ShipClass.CRUISER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            }, 
            4,
            "Lisis II",
            0
        ));

        setup.put("muaat", new FactionSetup(
            new ShipClass[]{
                ShipClass.WARSUN,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            }, 
            4,
            "Muaat",
            0
        ));

        setup.put("creuss", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.DESTROYER,
                ShipClass.DESTROYER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            }, 
            4,
            "Creuss",
            0
        ));

        setup.put("l1z1x", new FactionSetup(
            new ShipClass[]{
                ShipClass.DREADNOUGHT,
                ShipClass.CARRIER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            }, 
            5,
            "[0.0.0]",
            1
        ));

        setup.put("mentak", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.CRUISER,
                ShipClass.CRUISER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            }, 
            4,
            "Moll Primus",
            1
        ));

        setup.put("naalu", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.CRUISER,
                ShipClass.DESTROYER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            }, 
            4,
            "Druaa",
            1
        ));

        setup.put("mentak", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.CRUISER,
                ShipClass.CRUISER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            }, 
            4,
            "Moll Primus",
            1
        ));

        setup.put("nekro", new FactionSetup(
            new ShipClass[]{
                ShipClass.DREADNOUGHT,
                ShipClass.CARRIER,
                ShipClass.CRUISER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            }, 
            2,
            "Mordai II",
            0
        ));

        setup.put("sardakk", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.CARRIER,
                ShipClass.CRUISER,
            }, 
            5,
            "Tren'Lak",
            1
        ));

        setup.put("jol_nar", new FactionSetup(
            new ShipClass[]{
                ShipClass.DREADNOUGHT,
                ShipClass.CARRIER,
                ShipClass.CARRIER,
                ShipClass.FIGHTER,
            }, 
            2,
            "Jol",
            2
        ));

        setup.put("winnu", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.CRUISER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            }, 
            2,
            "Winnu",
            1
        ));

        setup.put("xxcha", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.CRUISER,
                ShipClass.CRUISER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER
            }, 
            4,
            "Archon Ren",
            1
        ));

        setup.put("yin", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.CARRIER,
                ShipClass.DESTROYER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER
            }, 
            4,
            "Darien",
            0
        ));

        setup.put("yssaril", new FactionSetup(
            new ShipClass[]{
                ShipClass.CARRIER,
                ShipClass.CARRIER,
                ShipClass.CRUISER,
                ShipClass.FIGHTER,
                ShipClass.FIGHTER,
            }, 
            5,
            "Retillion",
            1
        ));
    }
}
