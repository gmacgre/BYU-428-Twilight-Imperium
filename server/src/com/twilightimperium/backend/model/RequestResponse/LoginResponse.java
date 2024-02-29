package com.twilightimperium.backend.model.RequestResponse;

public class LoginResponse {
    private final String token;
    private final int playerTurn;

    public LoginResponse(String token, int playerTurn) {
        this.token = token;
        this.playerTurn = playerTurn;
    }

    
    
}
