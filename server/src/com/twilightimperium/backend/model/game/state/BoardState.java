package com.twilightimperium.backend.model.game.state;
import com.twilightimperium.backend.data.FactionData;
import com.twilightimperium.backend.data.FactionSetup;
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
            {   "Undefined", "Undefined", "Undefined", "Undefined", "Tequ'ran", "Empty", "Undefined"},
            {   "Undefined", "Undefined", "Thibah", "Mellon", "Lodor", "New Albion", "Vefut II"},
            {   "Undefined", "Supernova", "WormholeBeta", "Asteroid", "Mehar Xull", "Empty", "Centauri"},
            {   "Undefined", "Bereg", "Tar'Mann", "Mecatol Rex", "Nebula", "Corneeq", "Undefined"},
            {   "Dal Bootha", "Saudor", "Asteroid", "Wellon", "Quann", "Qucen'n", "Undefined"},
            {   "Empty", "Arnor", "WormholeAlpha", "Abyz", "Arinam", "Undefined", "Undefined"},
            {   "Undefined", "Lazar", "Empty", "Undefined", "Undefined", "Undefined", "Undefined"}
        };
        for(int i = 0; i < row.length; i++) {
            for(int j = 0; j < row[i].length; j++) {
                map[i][j].setSystem(row[i][j]);
            }
        }
    }

    public boolean systemAlreadySet(int x, int y) {
        return map[x][y].getSystem() != "Undefined";
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
    
    // Should only be used in the Game.addPlayer method
    public String setPlayerHomeSystem(String race, int[] coords, int owner) {
        FactionSetup setup = FactionData.setup.get(race);
        map[coords[0]][coords[1]].setSystem(setup.getHomeSystem());
        for (ShipClass s : setup.getAirforce()) {
            addShip(coords[0], coords[1], s, owner);
        }
        map[coords[0]][coords[1]].spreadForces(setup.getGroundForces(), owner);
        map[coords[0]][coords[1]].addSpacedock(owner);
        return setup.getHomeSystem();
    }
    public class InvalidMoveException extends Exception{
        String error_message;
        InvalidMoveException(String msg){
            error_message = msg;
        }
    }
}
