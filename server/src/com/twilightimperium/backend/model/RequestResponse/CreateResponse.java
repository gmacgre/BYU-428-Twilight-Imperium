package com.twilightimperium.backend.model.RequestResponse;

public class CreateResponse {
    private final String token;
    private final int turnId;


    private final Integer playerTurn;

    public CreateResponse(String token, Integer playerTurn, int playerTurn) {
        this.token = token;
        this.turnId = playerTurn;
        this.playerTurn = playerTurn;
    }

    public String getToken() {
        return this.token;
    }

    public Integer getPlayerTurn() {
        return this.playerTurn;
    }

    
}
