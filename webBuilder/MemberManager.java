
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

	// �����ͺ��̽� ���� �޼ҵ�
	public void connect() {
		try {
			// �����ͺ��̽��� ����, Connection ��ü ���� 
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
	// �����ͺ��̽� ���� ���� �޼ҵ� 
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
	
	// �ɹ� ����Ʈ ��ȯ
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
					//����Ʈ�� �߰�
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
	
	// �ش��ϴ� �̸��� ȸ���� �����ϴ��� ������ �˻��ϱ� ���� �޼ҵ�
    public boolean existMember(String user_id) {
        String sql = "select count(name) from member where user_id='" + user_id + "'";
        int num = this.adminExecuteQueryNum(sql);
        // �ѱ� ������������ �۵� �ȵ�
        if(num == 0){
            return false;
        } else {
            return true;
        }
    }
	
	// ���ڵ� ���� ��ȯ�ϱ� ���� �޼ҵ�
	public int getMemberLength() {
		String sql = null;

		sql = "select count(*) from member";
				
		int recNum = adminExecuteQueryNum(sql);
		return recNum;
	}
}
