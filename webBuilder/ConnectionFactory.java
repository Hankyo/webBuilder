package DBConnector;

import java.io.*;
import java.sql.*;

import DBConnector.ConnectionFactory;
 
public class ConnectionFactory implements Serializable{
   private static final long serialVersionUID = 1L;
   private String id = "";
   private String password = "";
   private String url = "";
    
    private static ConnectionFactory connectionFactory = new ConnectionFactory();
     
    private ConnectionFactory() {
    	setConnectionFromFile("./dbConfig.txt");
    }
    public void setConnectionFromFile(String filePath){ 	
    	id = "";
    	password = "";
    	url ="";		
    	
    	File f = new File(filePath);
        // ���� ���� ���� �Ǵ�
        if (f.isFile()) {
        	 FileReader readFile = null;
     		try {
     			readFile = new FileReader(filePath);
     		} catch (FileNotFoundException e) {
     			e.printStackTrace();
     		} 
             
             int index = 0;
             do {
     	          int tempChar = -1;
     			try {
     				tempChar = readFile.read();
     			} catch (IOException e) {
     				e.printStackTrace();
     			}
     			
     	          if (tempChar == -1) //���� ���� �����ϸ� -1�� �����ϱ� ����
     	            break;
     	          if(tempChar == ' ') 
     	        	  index++;
     		      if(index == 0 && tempChar != ' ') url = url + (char)tempChar;
     		      else if (index == 1 && tempChar != ' ')id = id + (char)tempChar;
     		      else if (index == 2 && tempChar != ' ')password = password + (char)tempChar; 
             } while(true);
        }   
    }
    public void setConnectionInformation(String id, String password, String url){
    	this.id = id;
    	this.password = password;
    	this.url  = url;
    }
    public static ConnectionFactory getDefaultFactory(){
        if(connectionFactory == null){
            connectionFactory = new ConnectionFactory();
        }
         
        return connectionFactory;
    }
     
    public Connection createConnection() throws Exception {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(url, id, password);
        } catch(Exception e) {
            System.out.println(e);
        }
        return connection;
    }
}
