package com.twilightimperium.backend;

import java.util.List;
import java.util.Map;

import com.twilightimperium.backend.model.game.GameState;


public class Game {
    private GameState state;
    private Map<String,Integer> tokens;
    int currentPlayer; //stores the next player # to hand out. The first player is 0, the second is 1 etc.

    String getGameState(){
        //encode state as json
        return null;
    }

    public Game(){
        currentPlayer = 0;
    }

    public void addPlayer(String token) {
        tokens.put(token, currentPlayer);
        currentPlayer++;
    }


    // Other methods
}

