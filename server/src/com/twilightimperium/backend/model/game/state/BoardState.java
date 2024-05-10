package com.twilightimperium.backend.model.game.state;
import com.twilightimperium.backend.model.game.entities.ShipClass;
import com.twilightimperium.backend.model.game.state.tile.Tile;

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
        addShip(3, 0, ShipClass.CARRIER, 0);
        addShip(3, 0, ShipClass.FIGHTER, 0);
        addShip(3, 0, ShipClass.FIGHTER, 0);
        addShip(3, 0, ShipClass.FIGHTER, 0);
        addGroundForce(3, 0, 0, 2, 0);
        addGroundForce(3, 1, 0, 0, 3);
        addGroundForce(3, 1, 1, 0, 3);
        addShip(3, 6, ShipClass.DREADNOUGHT, 2);
        addShip(3, 6, ShipClass.WARSUN, 2);
        addShip(3, 6, ShipClass.WARSUN, 2);
    }

    private void setTile(int x, int y, Tile newTile){
        map[x][y] = newTile;
    }

    public void removeShip(int x, int y, ShipClass shipClass){
        map[x][y].removeShip(shipClass);
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
        map[x][y].addShip(x, y, shipClass, owner);
    }

    public void addGroundForce(int x, int y, int planet, int quantity, int owner) {
        map[x][y].addGroundForce(planet, quantity, owner);
    }

    public boolean activateTile(int x, int y, int player){
        return map[x][y].activate(player);       
    }

    public class InvalidMoveException extends Exception{
        String error_message;
        InvalidMoveException(String msg){
            error_message = msg;
        }
    }
}
