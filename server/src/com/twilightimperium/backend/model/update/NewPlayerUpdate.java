package com.twilightimperium.backend.model.update;

public class NewPlayerUpdate extends Update {
    public NewPlayerUpdate(int player, String race) {

        super("newPlayer", player, new NewPlayerInfo(race));
    }
}

final class NewPlayerInfo implements UpdateInfo {
    public String race;  
    public NewPlayerInfo(String race) {
        this.race = race;
    }  
}