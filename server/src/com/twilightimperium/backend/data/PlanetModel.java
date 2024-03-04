package com.twilightimperium.backend.data;

public class PlanetModel {
        final String name;
        final int resources;
        final int influence;
        final Tech techColor;
        final PlanetTrait trait;
      
        public PlanetModel(String name, int resources, int influence, PlanetTrait trait,Tech techColor){
            this.name = name;
            this.resources = resources;
            this.influence = influence;
            this.techColor = techColor;
            this.trait = trait;
        }
        public PlanetModel(String name, int resources, int influence){
            this.name = name;
            this.resources = resources;
            this.influence = influence;
            this.techColor = Tech.none;
            this.trait = PlanetTrait.none;
        }    
        public PlanetModel(String name, int resources, int influence, PlanetTrait trait){
            this.name = name;
            this.resources = resources;
            this.influence = influence;
            this.techColor = Tech.none;
            this.trait = trait;
        } 
      }
      
      enum PlanetTrait {
        hazardous,
        industrial,
        cultural,
        none,
      }
      
      enum Tech {
        red,
        green,
        blue,
        yellow,
        none,
}
