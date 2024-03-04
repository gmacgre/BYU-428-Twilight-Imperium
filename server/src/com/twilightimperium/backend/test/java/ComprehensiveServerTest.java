package com.twilightimperium.backend.test.java;

import static org.junit.Assert.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;

import org.junit.Test;
import org.junit.jupiter.api.Assertions;

import com.google.gson.Gson;
import com.twilightimperium.backend.Server;
import com.twilightimperium.backend.model.RequestResponse.*;
import com.twilightimperium.backend.model.game.Location;
import com.twilightimperium.backend.model.game.Ship;


public class ComprehensiveServerTest {
    private Server server;

    @Test
    public void moveTest(){
        Gson gson = new Gson();
        try{
        server = new Server();
        server.startServer();
        } catch (IOException ex){
            ex.printStackTrace();
        }

        CreateRequest cRequest = new CreateRequest("testGame","testPass");
        CreateResponse cresponse = gson.fromJson(sendRequest("POST", null, null, gson.toJson(cRequest),"create"),CreateResponse.class);
        Assertions.assertNotNull(cresponse);
        String myToken = cresponse.getToken();
        Assertions.assertNotNull(myToken);

        LoginRequest lRequest = new LoginRequest("testGame","testPass",1);
        LoginResponse lresponse = gson.fromJson(sendRequest("POST", null, null, gson.toJson(lRequest),"login"),LoginResponse.class);
        Assertions.assertNotNull(lresponse);
        String token2 = lresponse.getToken();
        Assertions.assertNotNull(token2);

        //Activate a system right next to Sol
        ActivateRequest aRequest = new ActivateRequest(new Location(1,3));
        String aresponse = sendRequest("POST","token",myToken,gson.toJson(aRequest),"activate");
        Assertions.assertNotNull(aresponse);

        //attempt to activate again, should result in error
        ActivateRequest aRequest2 = new ActivateRequest(new Location(2,3));
        int aresponse2 = getHttpStatus("POST","token",myToken,gson.toJson(aRequest2),"activate");
        assertEquals(405,aresponse2);

        Ship[] shipsToMove = {new Ship(0,3,"destroyer")};
        MoveRequest mRequest = new MoveRequest(shipsToMove);
        String mResponse = sendRequest("POST", "token", myToken, gson.toJson(mRequest), "move");
        assertNotNull(mResponse);
        assertEquals(1,server.getGameByToken(myToken).getGameState().getMap().getTile(1, 3).getShips().size());
        assertEquals(11,server.getGameByToken(myToken).getGameState().getMap().getTile(0, 3).getShips().size());

        Ship[] moveShips2 = {new Ship(0,3,"carrier")};
        MoveRequest move2 = new MoveRequest(moveShips2);
        int move2Code = getHttpStatus("POST", "token", myToken, gson.toJson(move2), "move");
        assertEquals(405,move2Code);

        ActivateRequest aRequest3 = new ActivateRequest(new Location(1,3));
        int aresponse3 = getHttpStatus("POST","token",myToken,gson.toJson(aRequest3),"activate");
        assertEquals(405,aresponse3);



        server.stop();
    }

    @Test
    public void getJson(){
        Gson gson = new Gson();
        try{
        server = new Server();
        server.startServer();
        } catch (IOException ex){
            ex.printStackTrace();
        }

        CreateRequest request = new CreateRequest("testGame", "testPass");
        CreateResponse cresponse = gson.fromJson(sendRequest("POST", null, null, gson.toJson(request), "create"), CreateResponse.class);
        assertNotNull(cresponse);
        String myToken = cresponse.getToken();

        String gameState = sendRequest("GET","token",myToken,"","gameState");
        System.out.println(gameState);
    }

    private int getHttpStatus(String method, String headerKey, String headerVal, String body, String endpoint){
        try{
            URL url = new URI(String.format("http://localhost:%d/",Server.PORT) + endpoint).toURL();
            // Open a connection to the URL
            HttpURLConnection con = (HttpURLConnection) url.openConnection();

            con.setRequestMethod(method);
            if(headerKey != null){
            con.setRequestProperty(headerKey,headerVal);
            }

            con.setDoInput(true);
            if(method.equals("POST")){
            con.setDoOutput(true);
            }
            if(method.equals("POST")){
            try(OutputStream os = con.getOutputStream(); BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(os, "UTF-8"))) {
                writer.write(body);
                writer.flush();
            }
            }

            // Get the response code to determine if the request was successful
            int responseCode = con.getResponseCode();
            return responseCode;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }


    private String sendRequest(String method, String headerKey, String headerVal, String body, String endpoint){
        try{
            URL url = new URI("http://localhost:8080/" + endpoint).toURL();
            // Open a connection to the URL
            HttpURLConnection con = (HttpURLConnection) url.openConnection();

            con.setRequestMethod(method);
            if(headerKey != null){
            con.setRequestProperty(headerKey,headerVal);
            }

            con.setDoInput(true);
            if(method.equals("POST")){
            con.setDoOutput(true);
            }
            if(method.equals("POST")){
            try(OutputStream os = con.getOutputStream(); BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(os, "UTF-8"))) {
                writer.write(body);
                writer.flush();
            }
            }

            // Get the response code to determine if the request was successful
            int responseCode = con.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            // Read the response
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            return response.toString();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
