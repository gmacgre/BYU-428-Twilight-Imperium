package com.twilightimperium.Handlers;

import java.io.IOException;
import com.sun.net.httpserver.HttpExchange;
import com.twilightimperium.backend.Server;

public class DefaultHandler extends BaseHandler {

    public DefaultHandler(Server server) {
        super(server);
    }

    @Override
    public void handle(HttpExchange exchange) throws IOException {
        System.err.println(exchange.getRequestMethod());
        System.err.println(exchange.getRequestBody());
        sendResponse(exchange, "", 200);
    }   
}
