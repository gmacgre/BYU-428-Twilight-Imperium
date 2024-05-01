package com.twilightimperium.Handlers;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.twilightimperium.backend.Server;

public abstract class BaseHandler implements HttpHandler {

    //For now, have each inheritor handle the whole exchange themselves.
    protected Server server;

    protected BaseHandler(Server server) {
        this.server = server;
    }

    /**
     * Sends an HTTP response with the given body and status code.
     *
     * @param exchange The HttpExchange object.
     * @param responseBody The response body as a String.
     * @param statusCode The HTTP status code.
     */
    protected void sendResponse(HttpExchange exchange, String responseBody, int statusCode) throws IOException {
        exchange.getResponseHeaders().add("Access-Control-Allow-Origin", "*");
        exchange.getResponseHeaders().add("Access-Control-Allow-Methods", "*");
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(statusCode, responseBody.getBytes(StandardCharsets.UTF_8).length);
        OutputStream os = exchange.getResponseBody();
        os.write(responseBody.getBytes(StandardCharsets.UTF_8));
        os.close();
    }  
}
