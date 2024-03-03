package com.twilightimperium.backend.model.RequestResponse;

public class CreateResponse {
    private final String token;
    private final Integer playerTurn;

    public CreateResponse(String token, Integer playerTurn){
        this.token = token;
        this.playerTurn = playerTurn;
    }

    public String getToken() {
        return this.token;
    }

    public Integer getPlayerTurn() {
        return this.playerTurn;
    }

    
}
