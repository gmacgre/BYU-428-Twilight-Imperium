package com.twilightimperium.Handlers;

import com.google.gson.Gson;
import com.sun.net.httpserver.HttpExchange;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;
import com.twilightimperium.backend.model.RequestResponse.LoginRequest;
import com.twilightimperium.backend.model.RequestResponse.LoginResponse;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

/**
 * Handles login requests to the /login endpoint.
 */
public class LoginHandler extends BaseHandler {

    public LoginHandler(Server server) {
        super(server);
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        // Only process POST requests
        Gson gson = new Gson();
        if (!"POST".equals(exchange.getRequestMethod())) {
            
            sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Request Method")), 405);
            return;
        }
        try {
            // Here I would parse through JSON file when we have things implemented
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            LoginRequest request = gson.fromJson(requestBody, LoginRequest.class);
            
            // Simulated authentication check
            String token = server.login(request.getRoomCode(), request.getRoomPass(),request.getPlayerNum());
            

            if (token != null) {
                int playerId = server.getGameByToken(token).getPlayerTurn(token);
                // Respond with the generated token
                LoginResponse response = new LoginResponse(token, playerId);
                String jsonResponse = gson.toJson(response);
                sendResponse(exchange, jsonResponse, 200);
            } else {
                // Authentication failed
                sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Input")), 401);
            }
        } catch (Exception e) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Internal Server Error")), 500);
            e.printStackTrace();
        }
    }
}
