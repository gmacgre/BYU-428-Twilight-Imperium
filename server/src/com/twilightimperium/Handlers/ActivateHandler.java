package com.twilightimperium.Handlers;

import java.io.IOException;
import com.google.gson.Gson;
import com.sun.net.httpserver.*;
import com.twilightimperium.Handlers.cors.BaseCORSHandler;
import com.twilightimperium.backend.Game;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ActivateRequest;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;
import com.twilightimperium.backend.model.update.ActivateUpdate;
import com.twilightimperium.backend.model.update.Update;

public class ActivateHandler extends BaseCORSHandler{

    public ActivateHandler(Server server) {
        super(server);
    }

    @Override
    public void handleCORSFree(HttpExchange exchange, String token) throws IOException {
        Gson gson = new Gson();
        if (!"POST".equals(exchange.getRequestMethod())) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Request Method")), 501);
            return;
        } else {
            ActivateRequest request = gson.fromJson(new String(exchange.getRequestBody().readAllBytes()),ActivateRequest.class);
            int x = request.getCoords().x;
            int y = request.getCoords().y;
            Game game = server.getGameByToken(token);
            if(game == null){
                sendResponse(exchange, gson.toJson(new ErrorResponse("Bad token")), 405);
                return;
            }
            if(!game.isToDate(token)){
                sendResponse(exchange, gson.toJson(new ErrorResponse("Client not up to date")), 405);
                return;
            }
            if (game.activateSystem(x, y, token)){
                int playerNum = game.getPlayerTurn(token);
                
                Update newUpdate = new ActivateUpdate(playerNum, x, y);
                game.addUpdate(newUpdate);
                server.updatePlayer(token);
                sendResponse(exchange, "",200);
            } else {
                sendResponse(exchange, gson.toJson(new ErrorResponse("System already active")),405);
            }
        }
    }
}
