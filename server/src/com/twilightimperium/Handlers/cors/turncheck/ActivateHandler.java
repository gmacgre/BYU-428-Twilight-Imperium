package com.twilightimperium.Handlers.cors.turncheck;

import java.io.IOException;
import com.sun.net.httpserver.*;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ActivateRequest;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;
import com.twilightimperium.backend.model.game.Game;

public class ActivateHandler extends BaseTurnCheckHandler{

    public ActivateHandler(Server server) {
        super(server);
    }

    @Override
    protected void handleTurnFree(HttpExchange exchange, String token) throws IOException {
        if (!"POST".equals(exchange.getRequestMethod())) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Request Method")), 501);
            return;
        } else {
            ActivateRequest request = gson.fromJson(new String(exchange.getRequestBody().readAllBytes()),ActivateRequest.class);
            int x = request.getCoords().x;
            int y = request.getCoords().y;
            Game game = server.getGameByToken(token);
            if (game.activateSystem(x, y, token)){
                
                sendResponse(exchange, "",200);
            } else {
                sendResponse(exchange, gson.toJson(new ErrorResponse("System already active")),405);
            }
        }
    }
}
