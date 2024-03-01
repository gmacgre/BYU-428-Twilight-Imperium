package com.twilightimperium.backend.model.RequestResponse;

public class CreateResponse {
    private final String token;
    private final int turnId;



    public CreateResponse(String token, int playerTurn) {
        this.token = token;
        this.turnId = playerTurn;
    }

    public String getToken() {
        return this.token;
    }

    
}
