package com.twilightimperium.backend.model.game.message;

public class AddPlayerMessage {
    public int x;
    public int y;
    public String system;
    public boolean modified;
    public AddPlayerMessage(int x, int y, String system) {

    }

    public AddPlayerMessage(boolean modified) {
        x = -1;
        y = -1;
        system = "Undefined";
        this.modified = modified;
    }
}
