package com.twilightimperium.backend.model.RequestResponse;

public class CreateResponse {
    private final String token;
    private final int playerTurn;



    public CreateResponse(String token, int playerTurn) {
        this.token = token;
        this.playerTurn = playerTurn;
    }

    public String getToken() {
        return this.token;
    }

    
}
