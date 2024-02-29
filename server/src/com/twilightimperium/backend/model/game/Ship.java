package com.twilightimperium.backend.model.game;

public class Ship {
    int x;
    int y;
    String shipClass;

    public Ship(){
        x = 0;
        y = 0;
        shipClass = "undefined";
    }
    public Ship(int x, int y){

    }

    public int getX() {
        return this.x;
    }

    public void setX(int x) {
        this.x = x;
    }

    public int getY() {
        return this.y;
    }

    public void setY(int y) {
        this.y = y;
    }

    public String getShipClass() {
        return this.shipClass;
    }

    public void setShipClass(String shipClass) {
        this.shipClass = shipClass;
    }
    
}
