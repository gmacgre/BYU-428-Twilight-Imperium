package com.twilightimperium.backend.model.RequestResponse;

public class ErrorResponse {
    private final String message;


    public ErrorResponse(String message) {
        this.message = message;
    }

    public String getMesssage() {
        return message;
    }
    
}
