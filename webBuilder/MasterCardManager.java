package manager;

import java.util.*;
import java.io.UnsupportedEncodingException;
import java.sql.*;

import DBConnector.ConnectionPool;
import DataEntity.MasterCardData;

public class MasterCardManager {
	private static MasterCardManager masterCardManager = null;
	private static ConnectionPool connectionPool = null;
	private static AdminManager adminManager = null;
	
	//Singleton Block
    static {
        try{
        	masterCardManager = MasterCardManager.getInstance();
        	connectionPool = ConnectionPool.getConnectionPool();
        	adminManager = AdminManager.getInstance();
        } catch(Exception e){
            System.out.println("Error01:static block error!!");
        }
    }
    public static MasterCardManager getInstance()
    {
    	if(masterCardManager == null){
    		masterCardManager = new MasterCardManager();
    	}
    	return masterCardManager;
    }
    
    // 마스터카드의 모든 데이터를 반환 메서드
 	public ArrayList<MasterCardData> getMasterCardList() throws Exception {	
 		ArrayList<MasterCardData> list = new ArrayList<MasterCardData>();
 		Connection conn = null;
     	Statement stmt = null;
     	
     	try{
     		conn = connectionPool.getConnection();
     		stmt = conn.createStatement();
     		
 			String SQL = "select * from mastercard";
 			ResultSet rs = stmt.executeQuery(SQL);
 			while (rs.next()) {
 				MasterCardData masterCardData = new MasterCardData();
 				masterCardData.setNumber(rs.getInt("number"));
 				masterCardData.setName(new String(rs.getString("name").getBytes("8859_1"),"euc-kr"));
 				masterCardData.setAxis(new String(rs.getString("axis").getBytes("8859_1"),"euc-kr"));
 				masterCardData.setIllust(new String(rs.getString("illust").getBytes("8859_1"),"euc-kr"));
 				masterCardData.setPreceding(new String(rs.getString("preceding").getBytes("8859_1"),"euc-kr"));
 				masterCardData.setTrailing(new String(rs.getString("trailing").getBytes("8859_1"),"euc-kr"));
 				list.add(masterCardData);
 			}
 			rs.close();
 			stmt.close();
 		}catch(Exception e) {
 			e.printStackTrace();
 		}finally{
 			if(conn != null)
 				connectionPool.releaseConnection(conn);
 		}
 		return list;
 	}
}
