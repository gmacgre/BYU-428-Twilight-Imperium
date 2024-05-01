package com.twilightimperium.Handlers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.sun.net.httpserver.Headers;
import com.sun.net.httpserver.HttpExchange;
import com.twilightimperium.backend.Pair;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;
import com.twilightimperium.backend.model.RequestResponse.Update;

public class UpdateHandler extends BaseHandler{

    public UpdateHandler(Server server) {
        super(server);
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
}
