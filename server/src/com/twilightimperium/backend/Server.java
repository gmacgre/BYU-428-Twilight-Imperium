package com.twilightimperium.backend;

import com.sun.net.httpserver.HttpServer;
import com.twilightimperium.Handlers.*;
import com.twilightimperium.backend.model.update.Update;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.*;

/**
 * The Server class is responsible for setting up and starting a simple HTTP server
 * that listens for requests on port PORT
 */
public class Server {
    private HttpServer server;
    private List<Game> ongoingGames;
    private Map<String, Integer> tokenToGameIndex;
    private Map<String, Integer> gameIdToIndex;
    private Map<String, String> gamePassword;

    

    public static final int PORT = 8080;

    public Server() throws IOException {
        ongoingGames = new ArrayList<>();
        tokenToGameIndex  = new HashMap<>();
        gameIdToIndex = new HashMap<>();
        gamePassword = new HashMap<>();

        server = HttpServer.create(new InetSocketAddress(PORT), 0);
        server.createContext("/login", new LoginHandler(this));
        server.createContext("/create", new CreateGameHandler(this));
        server.createContext("/gameState",new GameStateHandler(this));
        server.createContext("/activate",new ActivateHandler(this));
        server.createContext("/move",new MoveHandler(this));
        server.createContext("/update",new UpdateHandler(this));
        server.createContext("/", new DefaultHandler(this));
        server.setExecutor(null);
    }

    public void startServer() {
        server.start();
        System.out.println(String.format("Server started on port %d",PORT));
    }

    public void stop(){
        server.stop(1);
    }

    public synchronized void addNewGame(Game game, String gameId, String password) throws Exception{
        if(gameIdToIndex.containsKey(gameId)){
            throw new Exception("Game already exists");
        }
        ongoingGames.add(game);
        gameIdToIndex.put(gameId, ongoingGames.size()-1);

        //Eventually we hash the password with salt before storing it for safety. For now I'm rushing to get the demo done
        gamePassword.put(gameId, password);
    }

    public synchronized Integer getGameIndexByToken(String token) {
        return tokenToGameIndex.get(token);
    }

    public synchronized Game getGameByToken(String token) {
        Integer gameIndex = getGameIndexByToken(token);
        if (gameIndex != null && gameIndex >= 0 && gameIndex < ongoingGames.size()) {
            return ongoingGames.get(gameIndex);
        }
        return null;
    }

    public synchronized String login(String gameCode, String password, int playerNum){
        if(!gameIdToIndex.containsKey(gameCode)){
            //This checks if the game exists
            return null;
        }
        if(!(gamePassword.get(gameCode).equals(password))){
            //This authenticates the password
            //once again, eventually we will need to salt and hash for security
            return null;
        }
        Game game = ongoingGames.get(gameIdToIndex.get(gameCode));
        if (playerNum >= game.getMaxPlayers()) {
            // Asking for an unavailable seat
            return null;
        }
        String token;
        if(game.requestToken(playerNum) != null) {
            token = game.requestToken(playerNum);
        }
        else {
            token = UUID.randomUUID().toString();
        }
        game.addPlayer(token, playerNum);
        tokenToGameIndex.put(token, gameIdToIndex.get(gameCode));
        return token;
    }

    public List<Pair<Integer,Update>> getUpdateList(String token){
        return ongoingGames.get(tokenToGameIndex.get(token)).getUpdateList();
    }

    public Integer getPlayerUpdate(String token){
        return ongoingGames.get(tokenToGameIndex.get(token)).getPlayerUpdate(token);
    }

    public void updatePlayer(String token){
        ongoingGames.get(tokenToGameIndex.get(token)).updatePlayer(token);
    }

    public void addUpdate(String token, Update update){
        ongoingGames.get(tokenToGameIndex.get(token)).addUpdate(update);
    }

    /*public boolean checkUpToDate(String token){
        return ongoingGames.get(tokenToGameIndex.get(token)).isToDate(token);
    }*/

    // Other server methods...
}


