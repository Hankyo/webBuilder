package manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import DataEntity.ReplyData;
import DBConnector.ConnectionPool;
import DataEntity.BoardData;

public class ReplyManager {
	private static ReplyManager replyManager = null;
	private static ConnectionPool connectionPool = null;
	private static AdminManager adminManager = null;

	//Singleton Block
    static {
        try{
        	replyManager = ReplyManager.getInstance();
        	ConnectionPool.initConnectionPool();
        	connectionPool = ConnectionPool.getConnectionPool();
        	adminManager = AdminManager.getInstance();
        } catch(Exception e){
            System.out.println("Error01:static block error!!");
        }
    }
    public static ReplyManager getInstance()
    {
    	if(replyManager == null){
    		replyManager = new ReplyManager();
    	}
    	return replyManager;
    }
    // 댓글 목록 반환
  	public ArrayList<ReplyData> getReplyList(String type, int id) throws Exception
  	{
  		String SQL = "select * from " +type+ "reply where id =" +id+" order by re_id desc";
  		ArrayList<ReplyData> list = new ArrayList<ReplyData>();
  		Connection conn = connectionPool.getConnection();
		Statement stmt = conn.createStatement();
  		
  		try{
  			ResultSet rs = stmt.executeQuery(SQL);
  			while(rs.next()){
  				ReplyData rep = new ReplyData();
  				rep.setId(rs.getInt("id"));
  				rep.setRe_id(rs.getInt("re_id"));
  				rep.setPasswd(rs.getString("passwd"));
  				rep.setContext(rs.getString("context"));
  				rep.setRegdate(rs.getDate("regdate"));
  				list.add(rep);
  			}
  			rs.close();
  			stmt.close();
  		}
  		catch(SQLException e){
  			e.printStackTrace();
  		}
  		finally{
 			if (conn != null)
				connectionPool.releaseConnection(conn);
 		}
  		return list;
  	}
  	// 댓글 삭제
  	public boolean deleteReply(String type, int id, String passwd)
  	{
  		String sql = "delete from "+type+"reply where re_id ="+id+" and passwd = "+passwd;
  		
  		boolean success = adminManager.executeUpdate(sql);
  		return success;
  	}
  	
  	// 최근 댓글 반환
  	public ArrayList<ReplyData> latelyReply(String type) throws Exception
  	{
  		ArrayList<ReplyData> list = new ArrayList<ReplyData>();
  		Connection conn = connectionPool.getConnection();
		Statement stmt = conn.createStatement();
  		int count = 0;
  		
  		String SQL = "select * from "+type+"reply order by re_id desc";
  		try{
  			ResultSet rs = stmt.executeQuery(SQL);
  			while(rs.next() && count < 10){
  				ReplyData rep = new ReplyData();
  				rep.setId(rs.getInt("id"));
  				rep.setRe_id(rs.getInt("re_id"));
  				rep.setPasswd(rs.getString("passwd"));
  				rep.setContext(rs.getString("context"));
  				if(rep.getContext().length() > 30){
  					rep.setContext(rep.getContext().substring(0, 25) + "...");
  				}
  				rep.setRegdate(rs.getDate("regdate"));
  				list.add(rep);
  				count++;
  			}
  			rs.close();
  			stmt.close();
  		}
  		catch(SQLException e){
  			e.printStackTrace();
  		}
  		finally{
 			if (conn != null)
				connectionPool.releaseConnection(conn);
 		}
  		return list;
  	}
    // 댓글 등록
   	public boolean insertReply(String type, ReplyData rep) throws Exception
   	{
   		String sql ="insert into "+type+"Reply values(0, ?, ?, ?, sysdate())";	
		Connection conn = connectionPool.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.execute("SET CHARACTER SET utf8");
		try {
			pstmt.setInt(1, rep.getId());
			pstmt.setString(2, rep.getPasswd());
			pstmt.setString(3, rep.getContext());
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
