package manager;
import java.util.*;
import java.io.IOException;
import java.sql.*;

import manager.AdminManager;

import DBConnector.ConnectionPool;
import DataEntity.BoardData;
import DataEntity.UserData;

public class UserManager {
	private static ConnectionPool connectionPool = null;
	private static UserManager userManager = null;
	private static AdminManager adminManager = null;

	//Singleton Block
    static {
        try{
        	ConnectionPool.initConnectionPool();
        	connectionPool = ConnectionPool.getConnectionPool();
        	adminManager = AdminManager.getInstance();
        	userManager = UserManager.getInstance();
        } catch(Exception e){
            System.out.println("Error01:static block error!!");
        }
    }
    
    public static UserManager getInstance()
    {
    	if(userManager == null){
    		userManager = new UserManager();
    	}
    	return userManager;
    }
	
    // 해당하는 아이디 중복 검사하기 위한 메소드
    public boolean existUser(String id) {
    	String query = "select count(*) from user where id = '"+ id +"'";
        int num = adminManager.executeQueryNum(query);
        
        if(num == 0){
            return false;
        } else {
            return true;
        }
    }
    
	// 해당하는 아이디 세션 중복 검사하기 위한 메소드
    public boolean existSession(String id) {
    	String query = "select count(*) from session where user_id = '"+ id +"'";
        int num = adminManager.executeQueryNum(query);
        
        if(num == 0){
            return false;
        } else {
            return true;
        }
    }
    
    // 해당하는 아이디와 비밀번호의 로그인 검사하기 위한 메소드
    public boolean loginCheck(String id, String password) throws Exception {
    	String query = "select * from user where id = ? ";
		Connection conn = connectionPool.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(query);
	 	pstmt.execute("SET CHARACTER SET utf8");
	 	
	 	try {
 			pstmt.setString(1, id);
 			ResultSet rs = pstmt.executeQuery();
 			while(rs.next()) {
 				String p_id = rs.getString("id"); 
 				String p_wd = rs.getString("password");
 				
 				if(id.equals(p_id)){
 					if(password.equals(p_wd))
 						return true;
 					else 
 						return false;
 				}
            }
 			rs.close();
 			pstmt.close();
 		} catch (SQLException e) {
 			e.printStackTrace();
 		}
	 	finally{
 			if (conn != null)
				connectionPool.releaseConnection(conn);
 		}
		return false;
    }
    
    // 해당 유저 등록
 	public boolean insertUser(UserData userData) throws Exception {
 		String sql ="insert into user values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";	
 		Connection conn = connectionPool.getConnection();
 		PreparedStatement pstmt = conn.prepareStatement(sql);
 		pstmt.execute("SET CHARACTER SET utf8");

 		try {
 			pstmt.setString(1, userData.getID());
 			pstmt.setString(2, userData.getPassword());
 			pstmt.setString(3, userData.getEmail());
 			pstmt.setString(4, userData.getForce());
 			pstmt.setInt(5, userData.getMasterCard());
 			pstmt.setInt(6, userData.getRating());
 			pstmt.setInt(7, userData.getWin());
 			pstmt.setInt(8, userData.getLose());
 			pstmt.setTimestamp(9,  userData.getRecent_battle());
 			pstmt.setInt(10, userData.getGold());
 			
 			pstmt.executeUpdate();
 			pstmt.close();
 		} catch (SQLException e) {
 			e.printStackTrace();
 			return false;
 		}
 		finally{
 			if (conn != null)
				connectionPool.releaseConnection(conn);
 		}
 		return true;
 	}
 	// 해당 유저 신규 소지카드 등록
  	public boolean insertCardOwning(String user_id, int cardCount) throws Exception {
  		String deckList = "";
  		Connection conn = connectionPool.getConnection();
		Statement stmt = conn.createStatement();
  		try {
			for(int i=1; i<=cardCount; i++ ){
				// 소지카드 초기 유닛카드 레벨 1
				stmt.executeUpdate("insert into cardOwning values('"+user_id+"',"+i+", 1);");
				// 덱 추가
				deckList += i;
				if(i != cardCount){
					deckList += ",";
				}
  			}
			stmt.executeUpdate("insert into deck values('"+user_id+"','"+deckList+"');");
			stmt.close();
  		} catch (SQLException e) {
  			e.printStackTrace();
  			return false;
  		}
  		finally{
 			if (conn != null)
				connectionPool.releaseConnection(conn);
 		}
  		return true;
  	}
  	// 해당 유저 세션 등록
   	public boolean insertSession(String user_id) throws Exception {
   		String sql ="insert IGNORE into session values(?)";	
 		Connection conn = connectionPool.getConnection();
 		PreparedStatement pstmt = conn.prepareStatement(sql);
 		pstmt.execute("SET CHARACTER SET utf8");

 		try {
 			pstmt.setString(1, user_id);
			pstmt.executeUpdate();
			pstmt.close();
 		} catch (SQLException e) {
 			e.printStackTrace();
 			return false;
 		}
 		finally{
 			if (conn != null)
				connectionPool.releaseConnection(conn);
 		}
 		
 		return true;
   	}
   	// 해당 유저 세션기간 이벤트 등록
   	public boolean insertSessionEvent(String user_id) throws Exception {
   		// Event가 존재시 기존 이벤트 삭제
   		String dropEvent = "drop event IF EXISTS "+user_id;
   		adminManager.executeUpdate(dropEvent);
   		
   		// 세션 이벤트 insert
   		String sql = "create event "+user_id;
   		sql += " ON SCHEDULE";
 		sql += " AT CURRENT_TIMESTAMP + INTERVAL 30 MINUTE";
 		sql += " DO delete from session where user_id = ?";
 		Connection conn = connectionPool.getConnection();
 		PreparedStatement pstmt = conn.prepareStatement(sql);
 		pstmt.execute("SET CHARACTER SET utf8");

 		try {
 			pstmt.setString(1, user_id);
 			pstmt.executeUpdate();
 			pstmt.close();
 		} catch (SQLException e) {
 			e.printStackTrace();
 			return false;
 		}
 		finally{
 			if (conn != null)
				connectionPool.releaseConnection(conn);
 		}
 		return true;
   	}
   	// 해당 유저 세션 삭제
   	public boolean deleteSession(String user_id) throws Exception {
   		String sql ="delete from session where user_id = ?";
 		Connection conn = connectionPool.getConnection();
 		PreparedStatement pstmt = conn.prepareStatement(sql);
 		pstmt.execute("SET CHARACTER SET utf8");

 		try {
 			pstmt.setString(1, user_id);
			pstmt.executeUpdate();
			pstmt.close();
 		} catch (SQLException e) {
 			e.printStackTrace();
 			return false;
 		}
 		finally{
 			if (conn != null)
				connectionPool.releaseConnection(conn);
 		}
 		return true;
   	}
}
