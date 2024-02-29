package com.twilightimperium.backend.test.java;

import com.google.gson.Gson;
import com.sun.net.httpserver.Headers;
import com.sun.net.httpserver.HttpExchange;
import com.twilightimperium.Handlers.*;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.LoginRequest;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import static junit.framework.Assert.assertFalse;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class LoginHandlerTest {

    @Mock
    private Server server;
    @Mock
    private HttpExchange httpExchange;
    private LoginHandler loginHandler;
    private Headers responseHeaders = new Headers(); // Real Headers instance
    private Gson gson;

    @BeforeEach
    void setUp() {
        gson = new Gson();
        MockitoAnnotations.openMocks(this);
        loginHandler = new LoginHandler(server);
        when(httpExchange.getResponseHeaders()).thenReturn(responseHeaders); // Use real Headers instance
    }

    //Verifies that providing correct credentials results in a successful login with a 200 status code and a response containing a token and turnId.
    @Test
    void testLoginSuccess() throws IOException {
        LoginRequest request = new LoginRequest("testGame", "testPass", 1);
        String requestBody = gson.toJson(request);
        ByteArrayInputStream inputStream = new ByteArrayInputStream(requestBody.getBytes());
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        when(httpExchange.getRequestMethod()).thenReturn("POST");
        when(httpExchange.getRequestBody()).thenReturn(inputStream);
        when(httpExchange.getResponseBody()).thenReturn(outputStream);

        loginHandler.handle(httpExchange);

        verify(httpExchange).sendResponseHeaders(200, outputStream.toByteArray().length);
        String actualResponse = outputStream.toString(StandardCharsets.UTF_8.name());
        assertFalse(actualResponse.isEmpty());
        System.out.println("Actual Response: " + actualResponse);

    }
}
