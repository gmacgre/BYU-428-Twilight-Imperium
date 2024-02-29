package com.twilightimperium.Handlers;

import com.google.gson.Gson;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.LoginRequest;
import com.twilightimperium.backend.model.RequestResponse.LoginResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

/**
 * Handles login requests to the /login endpoint.
 */
public class LoginHandler implements HttpHandler {
    private final Server server;
    //Fake user to test login
    private final String DEMO_USERNAME = "demoUser";
    private final String DEMO_PASSWORD = "demoPass";

    public LoginHandler(Server server) {
        this.server = server;
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        // Only process POST requests
        if (!"POST".equals(exchange.getRequestMethod())) {
            sendResponse(exchange, "Method Not Allowed", 405);
            return;
        }
        Gson gson = new Gson();
        try {
            // Here I would parse through JSON file when we have things implemented
            String requestBody = new String(exchange.getRequestBody().readAllBytes(), StandardCharsets.UTF_8);
            LoginRequest request = gson.fromJson(requestBody, LoginRequest.class);
            
            // Simulated authentication check
            String token = server.login(request.getRoomCode(), request.getRoomPass(),request.getPlayerNum());

            if (token != null) {
                // Respond with the generated token
                LoginResponse response = new LoginResponse(token, 0);
                String jsonResponse = gson.toJson(response);
                sendResponse(exchange, jsonResponse, 200);
            } else {
                // Authentication failed
                sendResponse(exchange, "Bad Input", 401);
            }
        } catch (Exception e) {
            sendResponse(exchange, "Internal Server Error", 500);
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
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(statusCode, responseBody.getBytes(StandardCharsets.UTF_8).length);
        OutputStream os = exchange.getResponseBody();
        os.write(responseBody.getBytes(StandardCharsets.UTF_8));
        os.close();
    }
}
