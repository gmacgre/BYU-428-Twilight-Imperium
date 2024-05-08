package com.twilightimperium.Handlers;

import com.google.gson.Gson;
import com.sun.net.httpserver.HttpExchange;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.CreateRequestResponse;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;
import com.twilightimperium.backend.model.game.Game;

import java.io.IOException;
import java.io.InputStream;

/**
 * Handles game creation requests to the /create endpoint.
 */
public class CreateGameHandler extends BaseHandler {

    public CreateGameHandler(Server server) {
        super(server);
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        Gson gson = new Gson();

        // Only process POST requests
        if (!"POST".equals(exchange.getRequestMethod())) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Wrong HTTP Method")), 405);
            return;
        }
        try {
            InputStream body = exchange.getRequestBody();
            String requestBodyString = new String(body.readAllBytes());
            CreateRequestResponse request = gson.fromJson(requestBodyString,CreateRequestResponse.class);
            String roomCode = request.getRoomCode();
            String roomPass = request.getRoomPassword();

            Game newGame = new Game();
            server.addNewGame(newGame, roomCode, roomPass); // Add game to list and get a token
            CreateRequestResponse response = new CreateRequestResponse(request.getRoomCode(), request.getRoomPassword());
            String jsonResponse = gson.toJson(response);

            // Respond with the token.
            sendResponse(exchange, jsonResponse, 200);
        } catch (Exception e) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Game already Exists")), 405);
            e.printStackTrace();
        }
    }
}

