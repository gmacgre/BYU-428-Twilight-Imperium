package com.twilightimperium.Handlers;

import com.google.gson.Gson;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.twilightimperium.backend.Game;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.CreateRequest;
import com.twilightimperium.backend.model.RequestResponse.CreateResponse;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

/**
 * Handles game creation requests to the /create endpoint.
 */
public class CreateGameHandler implements HttpHandler {
    private final Server server;

    public CreateGameHandler(Server server) {
        this.server = server;
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        Gson gson = new Gson();

        // Only process POST requests
        if (!"POST".equals(exchange.getRequestMethod())) {
            sendResponse(exchange, "Game Already Exists", 405);
            return;
        }
        try {
            InputStream body = exchange.getRequestBody();
            String requestBodyString = new String(body.readAllBytes());
            CreateRequest request = gson.fromJson(requestBodyString,CreateRequest.class);
            String roomCode = request.getRoomCode();
            String roomPass = request.getRoomPassword();

            Game newGame = new Game();
            String token = server.addNewGame(newGame, roomCode, roomPass); // Add game to list and get a token
            newGame.addPlayer(token);
            Integer gameIndex = server.getGameIndexByToken(token); // Retrieve the game index by token
            CreateResponse response = new CreateResponse(token, 0);
            String jsonResponse = gson.toJson(response);

            // Respond with the token.
            sendResponse(exchange, jsonResponse, 200);
        } catch (Exception e) {
            sendResponse(exchange, "Game Already Exists", 405);
            e.printStackTrace();
        }
    }


    /**
     * Sends an HTTP response with the given body and status code.
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

