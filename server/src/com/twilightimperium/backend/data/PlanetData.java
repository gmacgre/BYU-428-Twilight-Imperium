package com.twilightimperium.backend.data;

import java.util.HashMap;
import java.util.Map;

public class PlanetData {
    
      static final Map<String, PlanetModel> planets = new HashMap<>();

      static {
        planets.put("Mecatol Rex", new PlanetModel("Mecatol Rex", 1, 6));
        planets.put("Abyz", new PlanetModel("Abyz", 3, 0, PlanetTrait.hazardous));
        planets.put("Fria", new PlanetModel("Fria", 2, 0, PlanetTrait.hazardous));
        planets.put("Arinam", new PlanetModel("Arinam", 1, 2, PlanetTrait.industrial));
        planets.put("Meer", new PlanetModel("Meer", 0, 4, PlanetTrait.hazardous, Tech.red));
        planets.put("Arnor", new PlanetModel("Arnor", 2, 1, PlanetTrait.industrial));
        planets.put("Lor", new PlanetModel("Lor", 1, 2, PlanetTrait.industrial));
        planets.put("Bereg", new PlanetModel("Bereg", 3, 1, PlanetTrait.hazardous));
        planets.put("Lirta IV", new PlanetModel("Lirta IV", 2, 3, PlanetTrait.hazardous));
        planets.put("Centauri", new PlanetModel("Centauri", 1, 3, PlanetTrait.cultural));
        planets.put("Gral", new PlanetModel("Gral", 1, 1, PlanetTrait.industrial, Tech.blue));
        planets.put("Coorneeq", new PlanetModel("Coorneeq", 1, 2, PlanetTrait.cultural));
        planets.put("Resculon", new PlanetModel("Resculon", 2, 0, PlanetTrait.cultural));
        planets.put("Dal Bootha", new PlanetModel("Dal Bootha", 0, 2, PlanetTrait.cultural));
        planets.put("Xxehan", new PlanetModel("Xxehan", 1, 1, PlanetTrait.cultural));
        planets.put("Lazar", new PlanetModel("Lazar", 1, 0, PlanetTrait.industrial, Tech.yellow));
        planets.put("Sakulag", new PlanetModel("Sakulag", 2, 1, PlanetTrait.hazardous));
        planets.put("Lodor", new PlanetModel("Lodor", 3, 1, PlanetTrait.cultural));
        planets.put("Mehar Xull", new PlanetModel("Mehar Xull", 1, 3, PlanetTrait.hazardous, Tech.red));
        planets.put("Mellon", new PlanetModel("Mellon", 0, 2, PlanetTrait.cultural));
        planets.put("Zohbat", new PlanetModel("Zohbat", 3, 1, PlanetTrait.hazardous));
        planets.put("New Albion", new PlanetModel("New Albion", 1, 1, PlanetTrait.industrial, Tech.green));
        planets.put("Starpoint", new PlanetModel("Starpoint", 3, 1, PlanetTrait.hazardous));
        planets.put("Quann", new PlanetModel("Quann", 2, 1, PlanetTrait.cultural));
        planets.put("Qucen'n", new PlanetModel("Qucen'n", 1, 2, PlanetTrait.industrial));
        planets.put("Rarron", new PlanetModel("Rarron", 0, 3, PlanetTrait.cultural));
        planets.put("Saudor", new PlanetModel("Saudor", 2, 2, PlanetTrait.industrial));
        planets.put("Tar'Mann", new PlanetModel("Tar'Mann", 1, 1, PlanetTrait.industrial, Tech.green));
        planets.put("Tequ'ran", new PlanetModel("Tequ'ran", 2, 0, PlanetTrait.hazardous));
        planets.put("Torkan", new PlanetModel("Torkan", 0, 3, PlanetTrait.cultural));
        planets.put("Thibah", new PlanetModel("Thibah", 1, 1, PlanetTrait.industrial, Tech.blue));
        planets.put("Vefut II", new PlanetModel("Vefut II", 2, 2, PlanetTrait.hazardous));
        planets.put("Wellon", new PlanetModel("Wellon", 1, 2, PlanetTrait.industrial, Tech.yellow));
        planets.put("Nestphar", new PlanetModel("Nestphar", 3, 2));
        planets.put("Arc Prime", new PlanetModel("Arc Prime", 4, 0));
        planets.put("Wren Terra", new PlanetModel("Wren Terra", 2, 1));
        planets.put("Lisis II", new PlanetModel("Lisis II", 1, 0));
        planets.put("Ragh", new PlanetModel("Ragh", 2, 1));
        planets.put("Muaat", new PlanetModel("Muaat", 4, 1));
        planets.put("Hercant", new PlanetModel("Hercant", 1, 1));
        planets.put("Arretze", new PlanetModel("Arretze", 2, 0));
        planets.put("Kamdorn", new PlanetModel("Kamdorn", 0, 1));
        planets.put("Jord", new PlanetModel("Jord", 4, 2));
        planets.put("Creuss", new PlanetModel("Creuss", 4, 2));
        planets.put("[0.0.0]", new PlanetModel("[0.0.0]", 5, 0));
        planets.put("Moll Primus", new PlanetModel("Moll Primus", 4, 1));
        planets.put("Druaa", new PlanetModel("Druaa", 3, 1));
        planets.put("Maaluuk", new PlanetModel("Maaluuk", 0, 2));
        planets.put("Mordai II", new PlanetModel("Mordai II", 4, 0));
        planets.put("Tren'Lak", new PlanetModel("Tren'Lak", 1, 0));
        planets.put("Quinarra", new PlanetModel("Quinarra", 3, 1));
        planets.put("Jol", new PlanetModel("Jol", 1, 2));
        planets.put("Nar", new PlanetModel("Nar", 2, 3));
        planets.put("Winnu", new PlanetModel("Winnu", 3, 4));
        planets.put("Archon Ren", new PlanetModel("Archon Ren", 2, 3));
        planets.put("Archon Tau", new PlanetModel("Archon Tau", 1, 1));
        planets.put("Darien", new PlanetModel("Darien", 4, 4));
        planets.put("Retillion", new PlanetModel("Retillion", 2, 3));
        planets.put("Shalloq", new PlanetModel("Shalloq", 1, 2));
    }
}
