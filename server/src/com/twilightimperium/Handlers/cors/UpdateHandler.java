package com.twilightimperium.Handlers.cors;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;
import com.sun.net.httpserver.HttpExchange;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.ErrorResponse;
import com.twilightimperium.backend.model.game.Game;
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
        Game game = server.getGameByToken(token);
        if (game == null) {
            sendResponse(exchange, gson.toJson(new ErrorResponse("Game Does Not Exist")), 0);
        }
        List<Update> updatesToSend = game.getUpdatesToSend(token);
        sendResponse(exchange,gson.toJson(updatesToSend.toArray(new Update[0])),200);
    }
}
