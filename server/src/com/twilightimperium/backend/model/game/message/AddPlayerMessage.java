package com.twilightimperium.backend.model.game.message;

public class AddPlayerMessage {
    public int x;
    public int y;
    public AddPlayerSubMessage subMessage;
    public boolean modified;
    public AddPlayerMessage(int x, int y, AddPlayerSubMessage msg) {
        modified = true;
        this.x = x;
        this.y = y;
        this.subMessage = msg;
    }

    public AddPlayerMessage(boolean modified) {
        x = -1;
        y = -1;
        subMessage = new AddPlayerSubMessage();
        this.modified = modified;
    }
}
