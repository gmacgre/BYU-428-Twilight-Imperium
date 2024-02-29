package com.twilightimperium.backend.test.java;



import com.twilightimperium.backend.Client;
import com.twilightimperium.backend.Server;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;


public class ServerConnectionTest {

    @Test
    public void testServerConnection() {
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
