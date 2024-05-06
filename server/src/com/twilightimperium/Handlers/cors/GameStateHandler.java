package com.twilightimperium.Handlers.cors;

import java.io.IOException;
import com.google.gson.Gson;
import com.sun.net.httpserver.*;
import com.twilightimperium.backend.Game;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;

public final class GameStateHandler extends BaseCORSHandler{

    public GameStateHandler(Server server) {
        super(server);
    }
    
    public void handleCORSFree(HttpExchange exchange, String token) throws IOException {
        Gson gson = new Gson(); 
        if (!"GET".equals(exchange.getRequestMethod())) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Request Method")), 501);
            return;
        }
        else {
            
            Game game = server.getGameByToken(token);
            if (game == null){
                System.err.println("No Game Found");
                sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Token")), 405);
            }
            server.updatePlayer(token);
            
            sendResponse(exchange, game.jsonGameState(),200);
        }
    }
}
