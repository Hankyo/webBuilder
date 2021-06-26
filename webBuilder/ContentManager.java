
package manager;
import java.util.*;
import java.io.IOException;
import java.sql.*;

import DataCapsuled.ContentData;

public class ContentManager extends AdminManager{
	private static AdminManager adminManager = null;
	private int recNum = 0;	
	private String search = "";						// �˻����� ���� ����
	private String text = "";						// �˻������ ���� ����
	private boolean success;	
	
	//Singleton Block
	static{
		try{
			adminManager = AdminManager.getInstance();
		} catch (Exception e) {
			System.out.println("Error01:static block error!!");
		}
	}

	// �����ͺ��̽����� ���� ū �� ��ȣ�� �������� �޼ҵ�
	public int getMaxNum(String categoryName){
		String sql = "select max(Num) from " + categoryName;
		int maxNum = adminExecuteQueryNum(sql);
		return maxNum;
	}
	
	// �ش��ϴ� �̸��� �������� �����ϴ��� ������ �˻��ϱ� ���� �޼ҵ�
    public boolean existContent(String name) {
        String sql = "select count(name) from content where name='" + name + "'";
        int num = this.adminExecuteQueryNum(sql);
        // �ѱ� ������������ �۵� �ȵ�
        if(num == 0){
            return false;
        } else {
            return true;
        }
    }
	// �ϳ��� �������� ��ȯ�ϴ� �޼ҵ�
	public ContentData getContent(String categoryName, int step) {
		String sql = "select * from " + categoryName + " where step=" + step;
		Vector v = adminExecuteQuery(sql);
		ContentData data = (ContentData)v.elementAt(0);
		return data;
	}

	// �������� �����ϱ� ���� �޼ҵ�
	public void updateContent(String ContentName, ContentData data) {
		String sql = "update " + ContentName + " set name='" + data.getName();
		sql += "', step='" + data.getID();
		sql += "' where step=" + data.getName();
		adminExecuteUpdate(sql);
		this.setSuccess(true);
	}

	// �˻��� ���� ���� ����	
	public void setSearch(String search) {
		this.search = search;
	}
	public void setText(String text) {
		this.text = text;
	}

	// �������� �����ϱ� ���� �޼ҵ�
	public String deleteContent(String contentName, int step){
		String msg = new String();
		
		String sql = "select count(*) from content where step>" + step;
		int count = adminExecuteQueryNum(sql);
		System.out.println(count);
		
		// �ش� ������ ����
	    sql = "delete from content where step = " + step;
	    adminExecuteUpdate(sql);

		// ������ step ��迭
		for(int r =step+1; r <= step+count; r++) {
			sql = "update content set step = step-1 ";
			sql += "where step = " + r;
			adminExecuteUpdate(sql);
		}
		msg = "OK";
		this.setSuccess(true);		
		
		return msg;
	}

	// ���� �۰� ���� ���� ��ȣ�� ���ϱ� ���� �޼ҵ�
	public int[] getNextPrevNum(String categoryName,int num) {
		int[] nums = new int[2];
		String sql = "select num from " + categoryName;
		sql += " where num > " + num + " order by Num desc";
		nums[0] = adminExecuteQueryNum(sql);
		sql = "select num from " + categoryName + " where num < " + num;
		nums[1] = adminExecuteQueryNum(sql);
		return nums;
	}

	// �۾� ������ ����� ����
	public boolean getSuccess(){ 
		return success;	
	}

	// �۾� ������ ����� ����
	public void setSuccess(boolean success){ 
		this.success = success;	
	}
	
	// ���ڵ� ���� ��ȯ�ϱ� ���� �޼ҵ�
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
	
	// ���ο� ������ ������ ���� �޼ҵ�
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
