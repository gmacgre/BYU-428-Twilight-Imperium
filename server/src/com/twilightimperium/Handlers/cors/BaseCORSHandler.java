package com.twilightimperium.Handlers.cors;

import java.io.IOException;

import com.sun.net.httpserver.Headers;
import com.sun.net.httpserver.HttpExchange;
import com.twilightimperium.Handlers.BaseHandler;
import com.twilightimperium.backend.Server;

public abstract class BaseCORSHandler extends BaseHandler {

    protected BaseCORSHandler(Server server) {
        super(server);
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        if ("OPTIONS".equals(exchange.getRequestMethod())) {
            sendResponse(exchange, "", 204);
            return;
        }
        Headers header = exchange.getRequestHeaders();
        String token = header.getFirst("token");
        handleCORSFree(exchange, token);
    }

    public abstract void handleCORSFree(HttpExchange exchange, String token) throws IOException;   
}
