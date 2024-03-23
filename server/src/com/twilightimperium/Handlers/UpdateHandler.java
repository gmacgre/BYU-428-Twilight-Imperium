package com.twilightimperium.Handlers;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.sun.net.httpserver.Headers;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.twilightimperium.backend.Pair;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;
import com.twilightimperium.backend.model.RequestResponse.Update;
import com.twilightimperium.backend.model.RequestResponse.UpdateResponse;

public class UpdateHandler implements HttpHandler{
    private final Server server;


    public UpdateHandler(Server server) {
        this.server = server;
    }
    
    public void handle(HttpExchange exchange) throws IOException {
        Gson gson = new Gson();
        if (!"GET".equals(exchange.getRequestMethod())) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Request Method")), 501);
            return;
        }
        
        Headers header = exchange.getRequestHeaders();
        String token = header.getFirst("token");
        int oldUpdate = server.getPlayerUpdate(token);
        List<Pair<Integer,Update>> allUpdates = server.getUpdateList(token);
        List<Update> updatesToSend = new ArrayList<>();
        //find the Update the player currently has. Then get all updates after that
        for(Pair<Integer,Update> i : allUpdates){
            if(i.first() <= oldUpdate){
                continue;
            } else {
                updatesToSend.addLast(i.second());
            }
        }
        //UpdateResponse response = new UpdateResponse(updatesToSend.toArray(new Update[0]));
        sendResponse(exchange,gson.toJson(updatesToSend.toArray(new Update[0])),200);
        
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
