package com.twilightimperium.Handlers;

import com.google.gson.Gson;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;
import com.twilightimperium.backend.model.RequestResponse.LoginRequest;
import com.twilightimperium.backend.model.RequestResponse.LoginResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

/**
 * Handles login requests to the /login endpoint.
 */
public class LoginHandler implements HttpHandler {
    private final Server server;
    //Fake user to test login

    public LoginHandler(Server server) {
        this.server = server;
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        // Only process POST requests
        Gson gson = new Gson();
        System.err.println(exchange.getRequestMethod());
        if (!"POST".equals(exchange.getRequestMethod())) {
            
            sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Request Method")), 405);
            return;
        }
        try {
            // Here I would parse through JSON file when we have things implemented
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            LoginRequest request = gson.fromJson(requestBody, LoginRequest.class);

            System.err.println(requestBody);
            
            // Simulated authentication check
            String token = server.login(request.getRoomCode(), request.getRoomPass(),request.getPlayerNum());
            

            if (token != null) {
                int playerId = server.getGameByToken(token).getPlayerTurn(token);
                // Respond with the generated token
                LoginResponse response = new LoginResponse(token, playerId);
                String jsonResponse = gson.toJson(response);
                sendResponse(exchange, jsonResponse, 200);
            } else {
                System.err.println("bad input");
                // Authentication failed
                sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Input")), 401);
            }
        } catch (Exception e) {
            System.err.println("Internal Error");
            sendResponse(exchange, gson.toJson(new ErrorResponse("Internal Server Error")), 500);
            e.printStackTrace();
        }
    }

    /**
     * Sends a HTTP response with the given body and status code.
     *
     * @param exchange The HttpExchange object.
     * @param responseBody The response body as a String.
     * @param statusCode The HTTP status code.
     */
    private void sendResponse(HttpExchange exchange, String responseBody, int statusCode) throws IOException {
        exchange.getResponseHeaders().add("Access-Control-Allow-Origin", "*");
        exchange.getResponseHeaders().add("Access-Control-Allow-Methods", "POST");
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(statusCode, responseBody.getBytes(StandardCharsets.UTF_8).length);
        OutputStream os = exchange.getResponseBody();
        os.write(responseBody.getBytes(StandardCharsets.UTF_8));
        os.close();
    }
}
