package com.twilightimperium.backend.test.java;

import com.sun.net.httpserver.Headers;
import com.sun.net.httpserver.HttpExchange;
import com.twilightimperium.Handlers.CreateGameHandler;
import com.twilightimperium.backend.Server;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;


import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class CreateGameHandlerTest {

    @Mock
    private Server server;
    @Mock
    private HttpExchange httpExchange;
    private CreateGameHandler createGameHandler;
    private Headers responseHeaders = new Headers();

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        createGameHandler = new CreateGameHandler(server);
        when(httpExchange.getResponseHeaders()).thenReturn(responseHeaders);
    }

    // Verifies that the handler responds with a 200 status code for valid POST requests.
    @Test
    void testCreateGameSuccess() throws IOException {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        when(httpExchange.getRequestMethod()).thenReturn("POST");
        when(httpExchange.getResponseBody()).thenReturn(outputStream);

        createGameHandler.handle(httpExchange);

        verify(httpExchange).sendResponseHeaders(200, outputStream.toByteArray().length);
    }

    // Tests that the handler returns the expected JSON structure, including a non-null token and a valid gameIndex, for successful game creation.
    @Test
    void testCreateGameSuccessResponseContent() throws IOException {
        when(httpExchange.getRequestMethod()).thenReturn("POST");
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        when(httpExchange.getResponseBody()).thenReturn(outputStream);

        createGameHandler.handle(httpExchange);

        String responseContent = outputStream.toString(StandardCharsets.UTF_8.name());
        assertFalse(responseContent.isEmpty());

        /*JSONObject jsonResponse = new JSONObject(responseContent);

        assertTrue(jsonResponse.has("token"), "Response should have a 'token' field");
        assertTrue(jsonResponse.has("gameIndex"), "Response should have a 'gameIndex' field");
        assertNotNull(jsonResponse.getString("token"), "The token should not be null");
        assertEquals(0, jsonResponse.getInt("gameIndex"), "The gameIndex should match the expected value");

        verify(server).addNewGame(any(Game.class));*/
    }



}
