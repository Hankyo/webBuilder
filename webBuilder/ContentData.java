package DataCapsuled;

import java.io.*;
import java.sql.*;

public class ContentData implements Serializable {
    private int id;
	private String category;
    private String name;
    private String descriptor;
    private String type;

    public void setID(int id){
        this.id = id;
    }
    public void setCategory(String category){
        this.category = category;
    }
    public void setName(String name){
        this.name = name;
    }
    public void setDescriptor(String descripotr){
        this.descriptor = descripotr;
    }
    public void setType(String type){
        this.name = type;
    }
    
    public int getID(){
        return id;
    }
    public String getCategory(){
        return category;
    }
    public String getName(){
        return name;
    }
    public String getDescriptor(){
        return descriptor;
    }
    public String getType(){
        return type;
    }
}