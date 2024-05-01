package com.twilightimperium.Handlers;

import java.io.IOException;
import com.google.gson.Gson;
import com.sun.net.httpserver.*;
import com.twilightimperium.backend.Game;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;

public class GameStateHandler extends BaseHandler{

    public GameStateHandler(Server server) {
        super(server);
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
            server.updatePlayer(token);
            sendResponse(exchange, game.jsonGameState(),200);
        }

    }
}
