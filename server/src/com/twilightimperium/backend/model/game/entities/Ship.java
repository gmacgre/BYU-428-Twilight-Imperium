package com.twilightimperium.backend.model.game.entities;

import com.twilightimperium.backend.model.game.Location;

public class Ship {
    Location coords;
    ShipClass shipClass;

    public Ship clone(){
        return new Ship(Integer.valueOf(coords.x),Integer.valueOf(coords.y), shipClass);
    }

    public Location getCoords() {
        return coords;
    }

    public int getX() {
        return this.coords.x;
    }

    public void setX(int x) {
        this.coords.x = x;
    }

    public int getY() {
        return this.coords.y;
    }

    public void setY(int y) {
        this.coords.y = y;
    }

    public Ship(int x, int y, ShipClass cl){
        this.coords = new Location(x,y);
        this.shipClass = cl;
    }

    public ShipClass getShipClass() {
        return this.shipClass;
    }

    public void setShipClass(ShipClass shipClass) {
        this.shipClass = shipClass;
    }
    
}
