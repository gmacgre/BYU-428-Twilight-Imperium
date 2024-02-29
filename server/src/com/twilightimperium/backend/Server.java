package com.twilightimperium.backend;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * The Server class is responsible for setting up and starting a simple HTTP server
 * that listens for requests on port 8000.
 */
public class Server {
    private HttpServer server;
    private List<Game> ongoingGames;
    private Map<String,Integer> token;

    public Server() {

        ongoingGames = new ArrayList<Game>();
        token = new HashMap<>();
    }

    public void startServer() {
        try {
            server = HttpServer.create(new InetSocketAddress(8000), 0);
            server.createContext("/test", new MyHandler());
            server.setExecutor(null); // creates a default executor
            server.start();
            System.out.println("Server started on port 8000");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * MyHandler implements the HttpHandler interface.
     * It is used to handle HTTP requests sent to the "/test" path.
     */
    static class MyHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange t) throws IOException {
            String response = "This is the response";
            t.sendResponseHeaders(200, response.length());
            OutputStream os = t.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }
    }


    // Other methods
}

