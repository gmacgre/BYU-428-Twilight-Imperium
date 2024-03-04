package com.twilightimperium.backend.model.game;

public class Player {
    private String race;
    private Integer strategyCardId;
    private boolean strategyExhaused; //stores if a  player has used their strategy
    private int tactic;
    private int fleet;
    private int strategyPool;
    private int victoryPoints;
    private boolean passed;


    public Player(){
        race = "Not chosen";
        passed = false;
    }


    public String getRace() {
        return this.race;
    }

    public void setRace(String race) {
        this.race = race;
    }

    public Integer getStrategyCardId() {
        return this.strategyCardId;
    }

    public void setStrategyCardId(Integer strategyCardId) {
        this.strategyCardId = strategyCardId;
    }

    public boolean isStrategyExhaused() {
        return this.strategyExhaused;
    }

    public boolean getStrategyExhaused() {
        return this.strategyExhaused;
    }

    public void setStrategyExhaused(boolean strategyExhaused) {
        this.strategyExhaused = strategyExhaused;
    }

    public int getTactic() {
        return this.tactic;
    }

    public void setTactic(int tactic) {
        this.tactic = tactic;
    }

    public int getFleet() {
        return this.fleet;
    }

    public void setFleet(int fleet) {
        this.fleet = fleet;
    }

    public int getStrategyPool() {
        return this.strategyPool;
    }

    public void setStrategyPool(int strategyPool) {
        this.strategyPool = strategyPool;
    }

    public int getVictoryPoints() {
        return this.victoryPoints;
    }

    public void setVictoryPoints(int victoryPoints) {
        this.victoryPoints = victoryPoints;
    }

    public boolean isPassed() {
        return this.passed;
    }

    public boolean getPassed() {
        return this.passed;
    }

    public void setPassed(boolean passed) {
        this.passed = passed;
    }

    
    // Other methods
}
