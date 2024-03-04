package com.twilightimperium.backend.model.RequestResponse;

public class LoginResponse {
    private final String token;
    private final int turnId;

    public LoginResponse(String token, int playerTurn) {
        this.token = token;
        this.turnId = playerTurn;
    }

    public String getToken() {
        return this.token;
    }


    public int getPlayerTurn() {
        return this.turnId;
    }


    
    
}
