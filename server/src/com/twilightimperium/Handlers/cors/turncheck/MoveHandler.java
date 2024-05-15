package com.twilightimperium.Handlers.cors.turncheck;

import java.io.IOException;
import com.sun.net.httpserver.*;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;
import com.twilightimperium.backend.model.RequestResponse.MoveRequest;
import com.twilightimperium.backend.model.game.Game;
import com.twilightimperium.backend.model.game.entities.Ship;

public class MoveHandler extends BaseTurnCheckHandler{

    public MoveHandler(Server server) {
        super(server);
    }

    @Override
    protected void handleTurnFree(HttpExchange exchange, String token) throws IOException {
        if (!"POST".equals(exchange.getRequestMethod())) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Bad Request Method")), 501);
            return;
        } else {
            MoveRequest request = gson.fromJson(new String(exchange.getRequestBody().readAllBytes()),MoveRequest.class);
            Ship[] ships = request.getShips();

            Game game = server.getGameByToken(token);
            if (game.move(ships, token)){
                sendResponse(exchange, "",200);
            } else {
                sendResponse(exchange, gson.toJson(new ErrorResponse("Invalid Move Command")),405);
            }
        }
    }

}
