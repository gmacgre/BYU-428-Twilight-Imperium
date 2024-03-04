package com.twilightimperium.backend.data;

import java.util.ArrayList;
import java.util.List;

public class SystemModel {
    public enum Wormhole { alpha, beta, delta }

    public enum Anomaly { asteroid, nebula, supernova, rift }
        List<PlanetModel> planets;
        List<Anomaly> anomalies;
        Wormhole wormhole;
        String homeSystem;

    public List<PlanetModel> getPlanets() {
        return this.planets;
    }

    public void setPlanets(List<PlanetModel> planets) {
        this.planets = planets;
    }

    public List<Anomaly> getAnomalies() {
        return this.anomalies;
    }

    public void setAnomalies(List<Anomaly> anomalies) {
        this.anomalies = anomalies;
    }

    public Wormhole getWormhole() {
        return this.wormhole;
    }

    public void setWormhole(Wormhole wormhole) {
        this.wormhole = wormhole;
    }

    public String getHomeSystem() {
        return this.homeSystem;
    }

    public void setHomeSystem(String homeSystem) {
        this.homeSystem = homeSystem;
    }
      
        SystemModel(List<PlanetModel> planets, List<Anomaly> anomalies, Wormhole wormhole, String homeSystem){
            this.planets = planets;
            this.anomalies = anomalies;
            this.wormhole = wormhole;
            this.homeSystem = homeSystem;
        }
        SystemModel(List<PlanetModel> planets){
            this.planets = planets;
            this.anomalies = new ArrayList<>();
            this.wormhole = null;
            this.homeSystem = "";
        }
        SystemModel(List<PlanetModel> planets, Wormhole wormhole){
            this.planets = planets;
            this.anomalies = new ArrayList<>();
            this.wormhole = wormhole;
            this.homeSystem = "";
        }
        SystemModel(List<PlanetModel> planets,String homesystem){
            this.planets = planets;
            this.anomalies = new ArrayList<>();
            this.wormhole = null;
            this.homeSystem = homesystem;
        }
        SystemModel(List<PlanetModel> planets,Wormhole wormhole, String homesystem){
            this.planets = planets;
            this.anomalies = new ArrayList<>();
            this.wormhole = wormhole;
            this.homeSystem = homesystem;
        }
        SystemModel(Anomaly anomaly){
            this.planets = new ArrayList<>();
            this.anomalies = new ArrayList<>();
            this.anomalies.add(anomaly);
            this.wormhole = null;
            this.homeSystem = "";
        }
        SystemModel(Wormhole wormhole){
            this.planets = new ArrayList<>();
            this.anomalies = new ArrayList<>();
            this.wormhole = wormhole;
            this.homeSystem = "";
        }
        SystemModel(){
            this.planets = new ArrayList<>();
            this.anomalies = new ArrayList<>();
            this.wormhole = null;
            this.homeSystem = "";
        }
}
