package com.twilightimperium.backend.model.RequestResponse;

public class CreateResponse {
    private final String token;

    public CreateResponse(String token){
        this.token = token;
    }

    public String getToken() {
        return this.token;
    }

    
}
