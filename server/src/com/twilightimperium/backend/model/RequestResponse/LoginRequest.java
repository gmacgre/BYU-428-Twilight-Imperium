package com.twilightimperium.backend.model.RequestResponse;

public class LoginRequest {
    private final String roomCode;
    private final String roomPass;

    public LoginRequest(String roomCode, String roomPass, int playerNum) {
        this.roomCode = roomCode;
        this.roomPass = roomPass;
        this.playerNum = playerNum;
    }
    private final int playerNum;

    

    public String getRoomCode() {
        return this.roomCode;
    }


    public String getRoomPass() {
        return this.roomPass;
    }


    public int getPlayerNum() {
        return this.playerNum;
    }


    
}
