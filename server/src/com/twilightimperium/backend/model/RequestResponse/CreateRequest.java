package com.twilightimperium.backend.model.RequestResponse;

public class CreateRequest {
    final String roomCode;
    final String roomPassword;

    public String getRoomCode() {
        return this.roomCode;
    }


    public String getRoomPassword() {
        return this.roomPassword;
    }

    CreateRequest(String code, String password){
        roomCode = code;
        roomPassword = password;
    }
}
