package com.twilightimperium.backend.model.game;

public class Ship {
    Location coords;
    String shipClass;

    public Ship clone(){
        return new Ship(Integer.valueOf(coords.x),Integer.valueOf(coords.y),new String(shipClass));
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

    public Ship(int x, int y, String cl){
        this.coords = new Location(x,y);
        this.shipClass = cl;
    }

    public String getShipClass() {
        return this.shipClass;
    }

    public void setShipClass(String shipClass) {
        this.shipClass = shipClass;
    }
    
}
