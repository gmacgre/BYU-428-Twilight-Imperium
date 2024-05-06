package com.twilightimperium.backend.model.game;

public class WorldInfo {
    public WorldInfo() {
        activePlayer = 0;
        activeSystem = new Location(0, 0);
        nextCommand = GameStateNode.OBSERVE;
    }

    private int activePlayer;
    private Location activeSystem;
    private GameStateNode nextCommand;


    public int getActivePlayer() {
        return activePlayer;
    }
    public void setActivePlayer(int activePlayer) {
        this.activePlayer = activePlayer;
    }
    public Location getActiveSystem() {
        return activeSystem;
    }
    public void setActiveSystem(int x, int y){
        this.activeSystem.x = x;
        this.activeSystem.y = y;
    }

    public GameStateNode getNextCommand() {
        return nextCommand;
    }
    public void setNextCommand(GameStateNode nextCommand) {
        this.nextCommand = nextCommand;
    }
}
