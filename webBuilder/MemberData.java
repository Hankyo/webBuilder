package DataEntity;

import java.io.*;
import java.sql.*;

public class MemberData{
	private String user_id;
    private String password;
    private int grade;

    public void setUser_id(String user_id){
        this.user_id = user_id;
    }
    public void setPassword(String password){
        this.password = password;
    }
    public void setGrade(int grade){
        this.grade = grade;
    }
    
    public String getUser_id(){
        return user_id;
    }
    public String getPassword(){
        return password;
    }
    public int getGrade(){
        return grade;
    }
}