package com.twilightimperium.Handlers.cors;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.sun.net.httpserver.HttpExchange;
import com.twilightimperium.backend.Pair;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;
import com.twilightimperium.backend.model.update.Update;

public final class UpdateHandler extends BaseCORSHandler{

    public UpdateHandler(Server server) {
        super(server);
    }
    
    public void handleCORSFree(HttpExchange exchange, String token) throws IOException {
        Gson gson = new Gson();
        if (!"GET".equals(exchange.getRequestMethod())) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Request Method")), 501);
            return;
        }
        if (server.getGameByToken(token) == null) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Game Does Not Exist")), 0);
        }
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
        // Now shift the players counter to the end
        server.setPlayerUpdate(token, allUpdates.getLast().first());
        sendResponse(exchange,gson.toJson(updatesToSend.toArray(new Update[0])),200);
        
    }
}
