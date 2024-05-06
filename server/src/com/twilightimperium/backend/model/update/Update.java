package com.twilightimperium.backend.model.update;

public abstract class Update {
    protected String type;
    protected int player;
    protected UpdateInfo info;


    Update(String type, int player, UpdateInfo info) {
        this.type = type;
        this.player = player;
        this.info = info;
    }
    
    public String getType() {
        return type;
    }

    public int getPlayer() {
        return player;
    }
}
