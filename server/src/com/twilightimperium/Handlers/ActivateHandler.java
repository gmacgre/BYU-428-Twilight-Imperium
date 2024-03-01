package com.twilightimperium.Handlers;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

import com.google.gson.Gson;
import com.sun.net.httpserver.*;
import com.twilightimperium.backend.Game;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ActivateRequest;

public class ActivateHandler implements HttpHandler{
    private final Server server;

    public ActivateHandler(Server server) {
        this.server = server;
    }

    public void handle(HttpExchange exchange) throws IOException {
        Gson gson = new Gson();
        System.out.println("Handling Activate");
        if (!"POST".equals(exchange.getRequestMethod())) {
            sendResponse(exchange, "Bad Request Method", 501);
            return;
        } else {
            Headers header = exchange.getRequestHeaders();
            String token = header.getFirst("token");
            ActivateRequest request = gson.fromJson(new String(exchange.getRequestBody().readAllBytes()),ActivateRequest.class);
            int x = request.getCoords().x;
            int y = request.getCoords().y;
            Game game = server.getGameByToken(token);
            if(game == null){
                sendResponse(exchange, "Bad token", 405);
                return;
            }
            if (game.activateSystem(x, y, token)){
                sendResponse(exchange, "Success",200);
            } else {
                sendResponse(exchange, "System already active",405);
            }
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
        System.out.println("Sending response");
        System.out.println(String.format("Sending response with status %d and body %s",statusCode, responseBody));
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(statusCode, responseBody.getBytes(StandardCharsets.UTF_8).length);
        OutputStream os = exchange.getResponseBody();
        os.write(responseBody.getBytes(StandardCharsets.UTF_8));
        os.close();
    }
}
