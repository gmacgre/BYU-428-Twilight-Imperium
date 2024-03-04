package com.twilightimperium.backend.model.game;

public class Planet {
    String name;
    int resource;
    int influence;

    public Planet(String name, int resource, int influence) {
        this.name = name;
        this.resource = resource;
        this.influence = influence;
    }

    public Planet clone(){
        return new Planet(new String(name),Integer.valueOf(resource),Integer.valueOf(influence));
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getResource() {
        return this.resource;
    }

    public void setResource(int resource) {
        this.resource = resource;
    }

    public int getInfluence() {
        return this.influence;
    }

    public void setInfluence(int influence) {
        this.influence = influence;
    }
    
}
