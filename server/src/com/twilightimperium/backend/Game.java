package com.twilightimperium.backend;

import java.util.*;

import com.google.gson.Gson;
import com.twilightimperium.backend.model.game.GameState;
import com.twilightimperium.backend.model.game.GameStateNode;
import com.twilightimperium.backend.model.game.entities.Player;
import com.twilightimperium.backend.model.game.entities.Ship;
import com.twilightimperium.backend.model.update.NewPlayerUpdate;
import com.twilightimperium.backend.model.update.Update;


public class Game {
    private GameState state;
    private Map<String,Integer> tokens;
    private Map<Integer, String> playerNumToToken;
    private int maxPlayers;
     //This stores what the game is waiting on. Does it expect an activate system or move command etc.

    private Map<String, Integer> tokenToUpdate;
    private List<Pair<Integer,Update>> updates;

    public int getMaxPlayers() {
        return maxPlayers;
    }
    public int getPlayerSeatId(String token){
        return tokens.get(token);
    }

    public boolean isCurrentlyActivePlayer(String token) {
        return state.getWorld().getActivePlayer() == tokens.get(token);
    }
    public String jsonGameState(){
        //encode state as json
        Gson gson = new Gson();
        return gson.toJson(state);
    }

    public int getActivePlayer(){
        return state.getWorld().getActivePlayer();
    }
    
    public GameState getGameState(){
        return state;
    }

    public List<Pair<Integer,Update>> getUpdateList(){
        return updates;
    }

    public void addUpdate(Update update){
        int newIndex;
        if(updates.size() < 1){
            newIndex = 0;
        } else {
            newIndex = updates.getLast().first() + 1;
        }
        updates.addLast(new Pair<Integer,Update>(newIndex,update));
    }

    public Integer getPlayerUpdate(String token){
        if(!tokenToUpdate.containsKey(token)){
            return -1; //Since the first update is 0, this will get all updates
        }
        return tokenToUpdate.get(token);
    }

    public boolean isToDate(String token){
        if(updates.size() == 0){
            return true;
        }
        if(!tokenToUpdate.containsKey(token)){
            return false;
        }
        return tokenToUpdate.get(token) == updates.getLast().first();
    }

    public void updatePlayer(String token){
        tokenToUpdate.put(token,updates.getLast().first());
        if (tokenToUpdate.containsValue(-1)){
            return;
        }
        List<Pair<Integer,Update>> newUpdates = new LinkedList<>(updates);
        //Now we check for updates we no longer need to keep track of
        //we loop through the updates from oldest to newest deleting all that don't have
        //a token referencing it until we hit the first update referenced by at least one token
        for(Pair<Integer,Update> i : updates){
            if (!tokenToUpdate.containsValue(i.first())){
                newUpdates.removeFirst();
            } else {
                break;
            }
        }
        updates = newUpdates;
    }

    public Game() {
        tokens = new HashMap<String, Integer>();
        playerNumToToken = new HashMap<>();
        maxPlayers = 6;
        state = new GameState(maxPlayers);
        state.getWorld().setNextCommand(GameStateNode.ACTION); // we start for now by expecting an activate System command
        state.getWorld().setActivePlayer(0);      // Assume Player 1 starts the game
        tokenToUpdate = new HashMap<>();
        updates = new LinkedList<>();
    }


    public void addPlayer(String token, int seatId) {
        if(seatId < maxPlayers){
            tokens.put(token, seatId);
            playerNumToToken.put(seatId,token);
            tokenToUpdate.put(token,-1); //This means they haven't gotten any updates
            Player toadd = new Player();
            toadd.setRace("jol_nar");
            state.getPlayers().set(seatId, toadd);
            addUpdate(new NewPlayerUpdate(seatId, "jol_nar"));
        } else {
            throw new RuntimeException();
        }
    }

    public String requestToken(int playerNum){
        return playerNumToToken.get(playerNum);
    }

    public boolean activateSystem(int x, int y, String token){
        if(state.getWorld().getNextCommand() == GameStateNode.ACTION){
            //first we get the player number from the token.
            Integer player = tokens.get(token);
            if (player == null){
                return false;
            }
            boolean success = placeTokenSystem(x, y, player);
            if (success){
                state.getWorld().setActiveSystem(x, y);
                state.getWorld().setNextCommand(GameStateNode.MOVE);
            }
            return success;
        } else {
            return false;
        }
    }

    private boolean placeTokenSystem(int x, int y, int player){
        //true indicates a success
        //false indicates that the tile was already activated by that player
        return state.getMap().activateTile(x, y, player);
    }

    public boolean move(Ship[] ships){
        if(state.getWorld().getNextCommand() == GameStateNode.MOVE){
            boolean success = moveShips(new ArrayList<Ship>(Arrays.asList(ships)));
            if (success){
                state.getWorld().setNextCommand(GameStateNode.ACTION);
            }
            return success;
        }else {
            return false;
        }
    }

    private boolean moveShips(List<Ship> ships){
        return state.moveShips(ships);
    }
    
    public void setPlayerUpdate(String token, Integer first) {
        tokenToUpdate.put(token, first);
    }


    // Other methods
}

