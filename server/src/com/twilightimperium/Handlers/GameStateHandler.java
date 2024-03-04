package com.twilightimperium.Handlers;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

import com.google.gson.Gson;
import com.sun.net.httpserver.*;
import com.twilightimperium.backend.Game;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;

public class GameStateHandler implements HttpHandler{
    private Server server;

    public GameStateHandler(Server server) {
        this.server = server;
    }
    
    public void handle(HttpExchange exchange) throws IOException {
        Gson gson = new Gson();
        if (!"GET".equals(exchange.getRequestMethod())) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Request Method")), 501);
            return;
        } else {
            Headers header = exchange.getRequestHeaders();
            String token = header.getFirst("token");
            Game game = server.getGameByToken(token);
            if (game == null){
                sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Token")), 405);
            }
            sendResponse(exchange, game.jsonGameState(),200);
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
