package com.twilightimperium.backend.model.update;

public class Update {
    String type;
    String content;
    int player;


    public Update(String type, String content, int player) {
        this.type = type;
        this.content = content;
        this.player = player;
    }
    

}
