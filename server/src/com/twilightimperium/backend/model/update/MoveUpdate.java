package com.twilightimperium.backend.model.update;

public class MoveUpdate extends Update {

    public MoveUpdate(int player) {
        super("move", player, new MoveUpdateInfo());
        //TODO Auto-generated constructor stub
    }
}


final class MoveUpdateInfo implements UpdateInfo {

    
}