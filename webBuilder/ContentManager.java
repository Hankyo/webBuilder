
package manager;
import java.util.*;
import java.io.IOException;
import java.sql.*;

import DataCapsuled.ContentData;

public class ContentManager extends AdminManager{
	private static AdminManager adminManager = null;
	private int recNum = 0;	
	private String search = "";						// 검색값을 위한 변수
	private String text = "";						// 검색결과를 위한 변수
	private boolean success;	
	
	//Singleton Block
	static{
		try{
			adminManager = AdminManager.getInstance();
		} catch (Exception e) {
			System.out.println("Error01:static block error!!");
		}
	}

	// 데이터베이스에서 가장 큰 글 번호를 가져오는 메소드
	public int getMaxNum(String categoryName){
		String sql = "select max(Num) from " + categoryName;
		int maxNum = adminExecuteQueryNum(sql);
		return maxNum;
	}
	
	// 해당하는 이름의 컨텐츠가 존재하는지 유무를 검사하기 위한 메소드
    public boolean existContent(String name) {
        String sql = "select count(name) from content where name='" + name + "'";
        int num = this.adminExecuteQueryNum(sql);
        // 한글 쿼리문깨져서 작동 안됨
        if(num == 0){
            return false;
        } else {
            return true;
        }
    }
	// 하나의 컨텐츠를 반환하는 메소드
	public ContentData getContent(String categoryName, int step) {
		String sql = "select * from " + categoryName + " where step=" + step;
		Vector v = adminExecuteQuery(sql);
		ContentData data = (ContentData)v.elementAt(0);
		return data;
	}

	// 콘텐츠를 수정하기 위한 메소드
	public void updateContent(String ContentName, ContentData data) {
		String sql = "update " + ContentName + " set name='" + data.getName();
		sql += "', step='" + data.getID();
		sql += "' where step=" + data.getName();
		adminExecuteUpdate(sql);
		this.setSuccess(true);
	}

	// 검색을 위한 변수 설정	
	public void setSearch(String search) {
		this.search = search;
	}
	public void setText(String text) {
		this.text = text;
	}

	// 컨텐츠를 삭제하기 위한 메소드
	public String deleteContent(String contentName, int step){
		String msg = new String();
		
		String sql = "select count(*) from content where step>" + step;
		int count = adminExecuteQueryNum(sql);
		System.out.println(count);
		
		// 해당 컨텐츠 삭제
	    sql = "delete from content where step = " + step;
	    adminExecuteUpdate(sql);

		// 컨텐츠 step 재배열
		for(int r =step+1; r <= step+count; r++) {
			sql = "update content set step = step-1 ";
			sql += "where step = " + r;
			adminExecuteUpdate(sql);
		}
		msg = "OK";
		this.setSuccess(true);		
		
		return msg;
	}

	// 이전 글과 다음 글의 번호를 구하기 위한 메소드
	public int[] getNextPrevNum(String categoryName,int num) {
		int[] nums = new int[2];
		String sql = "select num from " + categoryName;
		sql += " where num > " + num + " order by Num desc";
		nums[0] = adminExecuteQueryNum(sql);
		sql = "select num from " + categoryName + " where num < " + num;
		nums[1] = adminExecuteQueryNum(sql);
		return nums;
	}

	// 작업 수행의 결과를 리턴
	public boolean getSuccess(){ 
		return success;	
	}

	// 작업 수행의 결과를 설정
	public void setSuccess(boolean success){ 
		this.success = success;	
	}
	
	// 레코드 수를 반환하기 위한 메소드
	public int getRecNum() {
		String sql = null;
		if(!(text.trim()).equals("")){
			sql = "select count(*) from content";
		} else {
			sql = "select count(*) from content";
		}
		this.recNum = adminExecuteQueryNum(sql);
		return this.recNum;
	}
	
	public void makeStatic(int num) throws SQLException, ClassNotFoundException, IOException{
		adminManager.getConnectDB();
		String dbURL = adminManager.getUrl();
		String connectID = adminManager.getID();
		String password = adminManager.getPassword();
		
		Connection con = null;
		PreparedStatement pstmt = null;
	    String driverName = "com.mysql.jdbc.Driver";

		Class.forName(driverName);
	    con = DriverManager.getConnection(dbURL, connectID, password);
	    
		String insertBoardSQL = "insert static values(?, ?)";
	    pstmt = con.prepareStatement( insertBoardSQL );
	    pstmt.execute("SET CHARACTER SET euckr");
	    pstmt.execute("set names euckr");  
	    
	    pstmt.setString(1, Integer.toString(num));
	    pstmt.setString(2, "");   
	    pstmt.executeUpdate( );
	}
	
	// 새로운 컨텐츠 생성을 위한 메소드
	public void writeContent(int num, String category, String name, String descriptor, String type) throws IOException, ClassNotFoundException, SQLException {
		 adminManager.getConnectDB();
		 String dbURL = adminManager.getUrl();
		 String connectID = adminManager.getID();
		 String password = adminManager.getPassword();
		
		 Connection con = null;
	     String driverName = "com.mysql.jdbc.Driver";

		 Class.forName(driverName);
	     con = DriverManager.getConnection(dbURL, connectID, password);
	    
		 String insertBoardSQL = "insert content values(?, ?, ?, ?, ?)";
	     PreparedStatement pstmt = con.prepareStatement( insertBoardSQL );
	        
	     pstmt.execute("SET CHARACTER SET euckr");
	     pstmt.execute("set names euckr");  

	     pstmt.setString(1, Integer.toString(num));
	     pstmt.setString(2, category);
	     pstmt.setString(3, name);
	     pstmt.setString(4, descriptor);
	     pstmt.setString(5, type);
	       
	     pstmt.executeUpdate( );
		 this.setSuccess(true);
	}
}
