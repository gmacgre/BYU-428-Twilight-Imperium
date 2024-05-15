package com.twilightimperium.backend.test.java;




import org.junit.jupiter.api.Test;

import com.twilightimperium.backend.Server;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.assertEquals;


public class ServerConnectionTest {

    @Test
    public void testServerConnection() throws IOException {
        // Start server
        Server server = new Server();
        server.startServer();

        // Send request and modify sendRequest to return the response body
        Client client = new Client();
        String response = client.sendRequest();

        // Assert response is as expected
        assertEquals("This is the response", response);

    }
}
