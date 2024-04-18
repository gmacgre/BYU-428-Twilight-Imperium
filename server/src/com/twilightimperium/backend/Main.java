package com.twilightimperium.backend;

import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        try{
        Server server = new Server();
        server.startServer();
        } catch (IOException ex){
            ex.printStackTrace();
        }

        // Code for connecting to the server
    }

    // Other methods


}