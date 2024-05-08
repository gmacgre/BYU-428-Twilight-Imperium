package com.twilightimperium.backend.model.game;
import com.twilightimperium.backend.model.game.entities.ShipClass;
import com.twilightimperium.backend.model.game.tile.Tile;

public class BoardState {
    Tile[][] map;

    public BoardState(int dimension) {
        map = new Tile[dimension][dimension];
        for(int i = 0; i < dimension; i++){
            for(int j = 0; j < dimension; j++){
                map[j][i] = new Tile();
            }
        }
        
        // This is a default map, use it for now.
        // 6 Player default map
        String[][] row = {
            {   "Empty", "Empty", "Empty", "Jord", "Tequ'ran", "Empty", "Winnu"},
            {   "Empty", "Empty", "Thibah", "Mellon", "Lodor", "New Albion", "Vefut II"},
            {   "Empty", "Supernova", "WormholeBeta", "Asteroid", "Mehar Xull", "Empty", "Centauri"},
            {   "Jol", "Bereg", "Tar'Mann", "Mecatol Rex", "Nebula", "Corneeq", "Hercant"},
            {   "Dal Bootha", "Saudor", "Asteroid", "Wellon", "Quann", "Qucen'n", "Empty"},
            {   "Empty", "Arnor", "WormholeAlpha", "Abyz", "Arinam", "Empty", "Empty"},
            {   "Archon Ren", "Lazar", "Empty", "Lisis II", "Empty", "Empty", "Empty"}
        };
        for(int i = 0; i < row.length; i++) {
            for(int j = 0; j < row[i].length; j++) {
                map[i][j].setSystem(row[i][j]);
            }
        }
        

        addShip(3, 0, ShipClass.CARRIER, 1);
        addShip(3, 0, ShipClass.FIGHTER, 1);
        addShip(3, 0, ShipClass.FIGHTER, 1);
        addShip(3, 0, ShipClass.FIGHTER, 1);
    }

    private void setTile(int x, int y, Tile newTile){
        map[y][x] = newTile;
    }

    public void removeShip(int x, int y, ShipClass shipClass){
        map[y][x].removeShip(shipClass);
    }

    public BoardState clone(){
        BoardState copyState = new BoardState(7);
        for(int i = 0; i < 7; i++){
            for(int j = 0; j < 7; j++){
                copyState.setTile(i, j, map[j][i].clone());
            }
        }
        return copyState;
    }

    public void addShip(int x, int y, ShipClass shipClass, int owner){
        map[y][x].addShip(x, y, shipClass, owner);
    }

    public boolean activateTile(int x, int y, int player){
        return map[y][x].activate(player);       
    }

    public class InvalidMoveException extends Exception{
        String error_message;
        InvalidMoveException(String msg){
            error_message = msg;
        }
    }
}
