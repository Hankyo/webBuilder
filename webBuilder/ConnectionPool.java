package DBConnector;

import java.io.IOException;
import java.sql.*;
import java.util.*;

class ConnectionInfo{
	public Connection connection = null;
	public long time = 0;
	public ConnectionInfo(Connection connection, long time){
		this.connection = connection;
		this.time = time;
	}
};

public class ConnectionPool{
	private static int MAX_CONNECTION = 5;

	private Vector buffer = new Vector();
	private int wait_count = 0;
	private static ConnectionPool connectionPool = new ConnectionPool();

	static{
		try{
			initConnectionPool();
		}catch(SQLException e){
			System.out.println("---Connection Create Error---");
			e.printStackTrace();
		}catch(ClassNotFoundException e2){
			System.out.println("---Driver Calss Not Found Error--");
			e2.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private ConnectionPool(){ }
	
	public synchronized static void initConnectionPool() throws Exception{
		ConnectionPool.getConnectionPool();
		ConnectionPool.destroyConnectionPool();
		Vector temp = ConnectionPool.getConnectionPool().getConnectionPoolBuffer();
		ConnectionFactory connectionFactory = ConnectionFactory.getDefaultFactory();
		for(int i = 0; i < MAX_CONNECTION; i++){
			Connection connection = connectionFactory.createConnection();
			temp.addElement(new ConnectionInfo(connection, System.currentTimeMillis()));
			System.out.println("New Connection Created.." + connection);
		}
	}
	
	public synchronized static void destroyConnectionPool(){
		Vector temp = ConnectionPool.getConnectionPool().getConnectionPoolBuffer();
		int t = temp.size();
		for(int i = 0; i < t; i++){
			ConnectionInfo connectionInfo = (ConnectionInfo)temp.remove(0);
			if(connectionInfo.connection != null){
				try{
					connectionInfo.connection.close();
					System.out.println("Connnection Closed.." + connectionInfo.connection);
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
		}
	}
	
	public static ConnectionPool getConnectionPool(){
		if(connectionPool == null){
			connectionPool = new ConnectionPool();
		}
		return connectionPool;
	}
	
	public synchronized Connection getConnection() throws Exception{
		ConnectionInfo connectionInfo = null;
		if(wait_count > MAX_CONNECTION){
			return null;
		}
		try{
			while(buffer.size() == 0){
				wait_count++;
				this.wait();
				wait_count--;
			}
			connectionInfo = (ConnectionInfo)this.buffer.elementAt(0);
			long interval = System.currentTimeMillis() - connectionInfo.time;
			if(interval > 1000*60*30){
				try{
					System.out.print((interval/1000) + "초를 경과 Connection Close");
					connectionInfo.connection.close();
				}catch(SQLException e1){
					e1.printStackTrace();
					System.out.println("Connection Close Err");
				}
				ConnectionFactory connectionFactory = ConnectionFactory.getDefaultFactory();
				connectionInfo.connection = connectionFactory.createConnection();
				System.out.println(new java.util.Date().toString() + " Connection Open");
			}
		}catch(InterruptedException e2){
			e2.printStackTrace();
		}finally{
			connectionInfo = (ConnectionInfo)this.buffer.remove(0);
		}
		return connectionInfo.connection;
	}
	
	public synchronized void releaseConnection(Connection Connection){
		this.buffer.addElement(new ConnectionInfo(Connection, System.currentTimeMillis()));
		this.notifyAll();
	}
	
	public Vector getConnectionPoolBuffer(){
		return this.buffer;
	}
}