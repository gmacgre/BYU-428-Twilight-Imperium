package com.twilightimperium.backend.data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.twilightimperium.backend.data.PlanetData;
import com.twilightimperium.backend.data.PlanetModel;


public class SystemData {


  public static final Map<String, SystemModel> systemList = new HashMap<>();

  static {
    systemList.put("Mecatol Rex", new SystemModel(new ArrayList<>(List.of(PlanetData.planets.get("Mecatol Rex")))));
    systemList.put("Abyz", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Abyz"),
        PlanetData.planets.get("Fria")
    ))));
    systemList.put("Arinam", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Arinam"),
        PlanetData.planets.get("Meer")
    ))));
    systemList.put("Arnor", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Arnor"),
        PlanetData.planets.get("Lor")
    ))));
    systemList.put("Bereg", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Bereg"),
        PlanetData.planets.get("Lirta IV")
    ))));
    systemList.put("Centauri", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Centauri"),
        PlanetData.planets.get("Gral")
    ))));
    systemList.put("Coorneeq", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Coorneeq"),
        PlanetData.planets.get("Resculon")
    ))));
    systemList.put("Dal Bootha", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Dal Bootha"),
        PlanetData.planets.get("Xxehan")
    ))));
    systemList.put("Lazar", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Lazar"),
        PlanetData.planets.get("Sakulag")
    ))));
    systemList.put("Lodor", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Lodor")
    )), SystemModel.Wormhole.alpha));
    systemList.put("Mehar Xull", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Mehar Xull")
    ))));
    systemList.put("Mellon", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Mellon"),
        PlanetData.planets.get("Zohbat")
    ))));
    systemList.put("New Albion", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("New Albion"),
        PlanetData.planets.get("Starpoint")
    ))));
    systemList.put("Quann", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Quann")
    )), SystemModel.Wormhole.beta));
    systemList.put("Qucen'n", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Qucen'n"),
        PlanetData.planets.get("Rarron")
    ))));
    systemList.put("Saudor", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Saudor")
    ))));
    systemList.put("Tar'Mann", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Tar'Mann")
    ))));
    systemList.put("Tequ'ran", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Tequ'ran"),
        PlanetData.planets.get("Torkan")
    ))));
    systemList.put("Thibah", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Thibah")
    ))));
    systemList.put("Vefut II", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Vefut II")
    ))));
    systemList.put("Wellon", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Wellon")
    ))));
    systemList.put("Nestphar", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Nestphar")
    )), "Arborec"));
    systemList.put("Arc Prime", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Arc Prime"),
        PlanetData.planets.get("Wren Terra")
    )), "Letnev"));
    systemList.put("Lisis II", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Lisis II"),
        PlanetData.planets.get("Ragh")
    )), "Saar"));
    systemList.put("Muaat", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Muaat")
    )), "Muaat"));
    systemList.put("Hercant", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Hercant"),
        PlanetData.planets.get("Arretze"),
        PlanetData.planets.get("Kamdorn")
    )), "Hacan"));
    systemList.put("Jord", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Jord")
    )), "Sol"));
    systemList.put("Creuss", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Creuss")
    )), SystemModel.Wormhole.delta, "Creuss"));
    systemList.put("[0.0.0]", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("[0.0.0]")
    )), "L1Z1X"));
    systemList.put("Moll Primus", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Moll Primus")
    )), "Mentak"));
    systemList.put("Druaa", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Druaa"),
        PlanetData.planets.get("Maaluuk")
    )), "Naalu"));
    systemList.put("Mordai II", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Mordai II")
    )), "Nekro"));
    systemList.put("Tren'Lak", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Tren'Lak"),
        PlanetData.planets.get("Quinarra")
    )), "Sardakk"));
    systemList.put("Jol", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Jol"),
        PlanetData.planets.get("Nar")
    )), "Jol-Nar"));
    systemList.put("Winnu", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Winnu")
    )), "Winnu"));
    systemList.put("Archon Ren", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Archon Ren"),
        PlanetData.planets.get("Archon Tau")
    )), "Xxcha"));
    systemList.put("Darien", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Darien")
    )), "Yin"));
    systemList.put("Retillion", new SystemModel(new ArrayList<>(List.of(
        PlanetData.planets.get("Retillion"),
        PlanetData.planets.get("Shalloq")
    )), "Yssaril"));
    systemList.put("Asteroid", new SystemModel(SystemModel.Anomaly.asteroid));
    systemList.put("Supernova", new SystemModel(SystemModel.Anomaly.asteroid));
    systemList.put("Rift", new SystemModel(SystemModel.Anomaly.asteroid));
    systemList.put("Nebula", new SystemModel(SystemModel.Anomaly.asteroid));
    systemList.put("WormholeAlpha", new SystemModel(SystemModel.Wormhole.alpha));
    systemList.put("WormholeBeta", new SystemModel(SystemModel.Wormhole.beta));
    systemList.put("CreussGate", new SystemModel(SystemModel.Wormhole.delta));
    systemList.put("Empty", new SystemModel());
}
}
