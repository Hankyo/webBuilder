package DataEntity;

import java.io.*;
import java.sql.*;
public class CategoryData {
    private String name;
    private int step;

    public void setName(String name){
        this.name = name;
    }
    public void setStep(int step){
        this.step = step;
    }
    public String getName(){
        return name;
    }
    public int getStep(){
        return step;
    }
}