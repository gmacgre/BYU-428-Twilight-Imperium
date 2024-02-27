package com.twilightimperium.backend;

import java.util.List;

import com.twilightimperium.backend.model.Player;
import com.twilightimperium.backend.model.Move;
import com.twilightimperium.backend.model.Map;


public class Game {
    private List<Player> players;
    private Map gameMap;
    private List<Move> moveHistory;

    public Game createGame() {
        // Code to create a new game
    }

    public void joinGame(Player player) {
        // Code to add a player to the game
    }

    public List<Game> listUserGames(User user) {
        // Code to list all games a user is part of
    }

    public boolean verifyMove(Move move) {
        // Code to verify the validity of a move
    }

    public void broadcastMove(Move move) {
        // Code to broadcast move to all clients
    }

    // Other methods
}

