package com.twilightimperium.backend.model.update;

public class ActivateUpdate extends Update {

    public ActivateUpdate(int player, int x, int y) {
        super("activate", player, new ActivateUpdateInfo(x, y));
    }
    
}

final class ActivateUpdateInfo implements UpdateInfo {
    int x;
    int y;
    public ActivateUpdateInfo(int x, int y) {
        this.x = x;
        this.y = y;
    }
}
