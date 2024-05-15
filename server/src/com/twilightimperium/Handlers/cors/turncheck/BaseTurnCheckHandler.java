package com.twilightimperium.Handlers.cors.turncheck;

import java.io.IOException;

import com.google.gson.Gson;
import com.sun.net.httpserver.HttpExchange;
import com.twilightimperium.Handlers.cors.BaseCORSHandler;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;
import com.twilightimperium.backend.model.game.Game;

public abstract class BaseTurnCheckHandler extends BaseCORSHandler {

    protected BaseTurnCheckHandler(Server server) {
        super(server);
        gson = new Gson();
    }

    protected Gson gson;
    

    @Override
    public void handleCORSFree(HttpExchange exchange, String token) throws IOException {
        Game game = server.getGameByToken(token);
        if(game == null){
            sendResponse(exchange, gson.toJson(new ErrorResponse("Bad token")), 401);
            return;
        }
        if(!game.isToDate(token)) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Client not up to date")), 402);
            return;
        }
        if(!game.isCurrentlyActivePlayer(token)) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Not the Client's Turn")), 401);
        }
        handleTurnFree(exchange, token);
    }

    protected abstract void handleTurnFree(HttpExchange exchange, String token) throws IOException;
}
