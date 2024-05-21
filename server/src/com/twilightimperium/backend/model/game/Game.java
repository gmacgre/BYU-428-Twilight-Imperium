package com.twilightimperium.backend.model.game;

import java.util.*;

import com.google.gson.Gson;
import com.twilightimperium.backend.Pair;
import com.twilightimperium.backend.model.game.entities.Ship;
import com.twilightimperium.backend.model.game.message.AddPlayerMessage;
import com.twilightimperium.backend.model.game.state.GameState;
import com.twilightimperium.backend.model.game.state.GameStateNode;
import com.twilightimperium.backend.model.update.MoveUpdate;
import com.twilightimperium.backend.model.update.NewPlayerUpdate;
import com.twilightimperium.backend.model.update.Update;
import com.twilightimperium.backend.model.update.placed.ActivateUpdate;
import com.twilightimperium.backend.model.update.placed.AirForcePlacedUpdate;
import com.twilightimperium.backend.model.update.placed.GroundForcePlacedUpdate;
import com.twilightimperium.backend.model.update.placed.PDSPlacedUpdate;
import com.twilightimperium.backend.model.update.placed.SpacedockPlacedUpdate;
import com.twilightimperium.backend.model.update.placed.SystemPlacedUpdate;

// While this class is the top of an individual game's heirarchy, it's main purpose
// Is to be an interface for handlers, and to deal with authenticating incoming actions (i.e. with tokens)
// And housing updates to send to clients
// It should not hold business logic, that should be in GameState
public class Game {
    private GameState state;
    private Map<String,Integer> tokens;
    private Map<Integer, String> playerNumToToken;
    private int maxPlayers;
     //This stores what the game is waiting on. Does it expect an activate system or move command etc.

    private Map<String, Integer> tokenToUpdate;
    private List<Pair<Integer,Update>> updates;

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

    public String jsonGameState(String token){
        //encode state as json
        Gson gson = new Gson();
        updatePlayer(token);
        return gson.toJson(state);
    }

    public int getMaxPlayers() {
        return maxPlayers;
    }
    public int getPlayerSeatId(String token){
        return tokens.get(token);
    }

    public boolean isCurrentlyActivePlayer(String token) {
        return state.getActivePlayer() == tokens.get(token);
    }

    public List<Update> getUpdatesToSend(String token) {
        int oldUpdate = tokenToUpdate.containsKey(token) ? tokenToUpdate.get(token) : -1;
        List<Update> updatesToSend = new ArrayList<>();
        //find the Update the player currently has. Then get all updates after that
        for(Pair<Integer,Update> i : updates){
            if(i.first() <= oldUpdate){
                continue;
            } else {
                updatesToSend.addLast(i.second());
            }
        }
        // Now shift the players counter to the end
        updatePlayer(token);
        return updatesToSend;
    }

    private void addUpdate(Update update, String token){
        int newIndex;
        if(updates.size() < 1){
            newIndex = 0;
        } else {
            newIndex = updates.getLast().first() + 1;
        }
        updates.addLast(new Pair<Integer,Update>(newIndex,update));
        updatePlayer(token);
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

    public String requestToken(int playerNum){
        return playerNumToToken.get(playerNum);
    }

    private void updatePlayer(String token){
        if(updates.size() == 0) {
            // Everyone is completely up to date! :)
            tokenToUpdate.put(token, -1);
            return;
        }
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

    public void addPlayer(String token, int seatId) {
        if(seatId < maxPlayers){
            tokens.put(token, seatId);
            playerNumToToken.put(seatId,token);
            tokenToUpdate.put(token,-1); //This means they haven't gotten any updates
            
            String[] race = {
                "jol_nar",
                "sol",
                "hacan",
                "l1z1x",
                "xxcha",
                "mentak",
            };

            AddPlayerMessage msg = state.addPlayer(seatId, race[seatId]);
            if(!msg.modified) return; // Don't make updates if nothing was changed!
            Location location = new Location(msg.x, msg.y);
            addUpdate(new NewPlayerUpdate(seatId, race[seatId]), token);
            addUpdate(new SystemPlacedUpdate(seatId, location, msg.subMessage.system), token);
            addUpdate(new SpacedockPlacedUpdate(seatId, location, msg.subMessage.spacedockLocation), token);
            addUpdate(new AirForcePlacedUpdate(seatId, location, msg.subMessage.airforce), token);
            if(msg.subMessage.pdsLocation != null) {
                for(int i : msg.subMessage.pdsLocation) {
                    addUpdate(new PDSPlacedUpdate(seatId, location, i), token);
                }
            }
            for(int i = 0; i < msg.subMessage.forces.length; i++) {
                addUpdate(new GroundForcePlacedUpdate(seatId, location, i, msg.subMessage.forces[i]), token);
            }

        } else {
            throw new RuntimeException();
        }
    }

    public boolean activateSystem(int x, int y, String token){
        Integer player = tokens.get(token);
        if (player == null){
            return false;
        }
        if(!state.activateSystem(x, y, player)) {
            return false;
        }
        addUpdate(new ActivateUpdate(player, new Location(x, y)), token);
        return true;
    }

    public boolean move(Ship[] ships, String token){
        int playerNum = getPlayerSeatId(token);
        if(!state.move(ships, playerNum)){
            return false;
            
        }
        addUpdate(new MoveUpdate(playerNum), token);
        return true;
    }    
}

