
package manager;
import java.util.*;
import java.io.IOException;
import java.sql.*;

import manager.AdminManager;
import DataCapsuled.MemberData;

public class MemberManager extends AdminManager{
	private static  String dbURL = "";
	private static  String connectID = "";
	private static  String password = "";
	
	private static  Connection con = null;
	private static  Statement stmt = null;
	private static  PreparedStatement pstmt = null;
	private static  String driverName = "com.mysql.jdbc.Driver";

	// 데이터베이스 연결 메소드
	public void connect() {
		try {
			// 데이터베이스에 연결, Connection 객체 저장 
			AdminManager adminManager = new AdminManager();
			adminManager = adminManager.getInstance();
			adminManager.getConnectDB();
			dbURL = adminManager.getUrl();
			connectID = adminManager.getID();
			password = adminManager.getPassword();
			
			Class.forName(driverName);
			con = DriverManager.getConnection(dbURL, connectID, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 데이터베이스 연결 해제 메소드 
	public void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 맴버 리스트 반환
	public ArrayList<MemberData> getMemberList(int page) {	
		connect();
		ArrayList<MemberData> list = new ArrayList<MemberData>();
		
		String SQL = "select * from member order by user_id DESC";
		try {
			pstmt = con.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			int count = 0;
			while (rs.next()) {
				MemberData member = new MemberData();
				member.setUser_id ( rs.getString("user_id") );
				member.setPassword ( rs.getString("password") );
				member.setGrade ( rs.getInt("grade") );
				
				if((count >= page *5) && (count < (page+1)*5)){
					//리스트에 추가
					list.add(member);
				}
				else if(count > (page+1)*5){
					break;
				}
				count++;
			}
			rs.close();			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		finally {
			disconnect();
		}
		return list;
	}
	
	// 해당하는 이름의 회원가 존재하는지 유무를 검사하기 위한 메소드
    public boolean existMember(String user_id) {
        String sql = "select count(name) from member where user_id='" + user_id + "'";
        int num = this.adminExecuteQueryNum(sql);
        // 한글 쿼리문깨져서 작동 안됨
        if(num == 0){
            return false;
        } else {
            return true;
        }
    }
	
	// 레코드 수를 반환하기 위한 메소드
	public int getMemberLength() {
		String sql = null;

		sql = "select count(*) from member";
				
		int recNum = adminExecuteQueryNum(sql);
		return recNum;
	}
}
