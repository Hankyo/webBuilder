package DataEntity;

import java.sql.*;

public class UserData {
	private String id;
    private String password;
    private String email;
    private String force;
    private int masterCard;
    private int rating;
    private int win;
    private int lose;
    private int gold;
    private Timestamp recent_battle;
    
    public void setID(String id){
        this.id = id;
    }
    public void setPassword(String password){
        this.password = password;
    }
    public void setEmail(String email){
        this.email = email;
    }
    public void setForce(String force){
        this.force = force;
    }
    public void setMasterCard(int masterCard){
        this.masterCard = masterCard;
    }
    public void setRating(int rating){
        this.rating = rating;
    }
    public void setWin(int win){
        this.win = win;
    }
    public void setLose(int lose){
        this.lose = lose;
    }
    public void setGold(int gold){
        this.gold = gold;
    }
    public void setRecent_battle(Timestamp recent_battle){
        this.recent_battle = recent_battle;
    }
    // get Method
    public String getID(){
        return id;
    }
    public String getPassword(){
        return password;
    }
    public String getEmail(){
        return email;
    }
    public String getForce(){
        return force;
    }
    public int getMasterCard(){
        return masterCard;
    }
    public int getRating(){
        return rating;
    }
    public int getWin(){
        return win;
    }
    public int getLose(){
        return lose;
    }
    public int getGold(){
        return gold;
    }
    public Timestamp getRecent_battle(){
        return recent_battle;
    }
}
