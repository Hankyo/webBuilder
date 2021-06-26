package board;

import java.sql.*; 
import java.util.ArrayList;

public class boardDB {
	// 데이터베이스 연결 관련 상수 선언
	private static final String JDBC_DRIVER = "org.gjt.mm.mysql.Driver";
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/project";
	private static final String USER = "root";
	private static final String PASSWD = "mysql";

	// 데이터베이스 연결 관련 변수 선언
	private Connection con = null;
	private PreparedStatement pstmt = null;

	// JDBC 드라이버를 로드하는 생성자
	public boardDB() {
		// JDBC 드라이버 로드
		try {
			Class.forName(JDBC_DRIVER);
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	// 데이터베이스 연결 메소드
	public void connect() {
		try {
			// 데이터베이스에 연결, Connection 객체 저장 
			con = DriverManager.getConnection(JDBC_URL, USER, PASSWD);
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
	
	// 게시물 등록 메서드
	public boolean insertDB(boardEntity board) {
		boolean success = false; 
		connect();
		String sql ="insert into board values(0, ?, ?, ?, sysdate(), ?, ?)";		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getName());
			pstmt.setString(3, board.getPasswd());
			pstmt.setString(4, board.getContent());
			pstmt.setString(5, board.getLink());
			
			pstmt.executeUpdate();
			success = true; 
		} catch (SQLException e) {
			e.printStackTrace();
			return success;
		}
		finally {
			disconnect();
		}
		return success;
	}
	
	//게시물 삭제 Method
	public boolean deleteDB(int id, String passwd)
	{
		boolean success = false;
		connect();
		String sql = "delete from board where id = ? and passwd = ?";
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setString(2, passwd);
			
			if(pstmt.executeUpdate() != 0)
				success = true;		
		}
		catch(SQLException e){
			e.printStackTrace();
			return success;
		}
		finally{
			disconnect();
		}		
		return success;
	}
	
	public int getBoardLength(){
		connect();
		String SQL = "select count(id) from board";
		int id = 10;
		try{
			pstmt = con.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next())
				id = rs.getInt("count(id)");
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		finally{
			disconnect();
		}
		return id;
	}
	
	// 게시판의 모든 레코드를 반환 메서드
	public ArrayList<boardEntity> getBoardList(int page) {	
		connect();
		ArrayList<boardEntity> list = new ArrayList<boardEntity>();
		
		String SQL = "select * from board order by regdate DESC";
		try {
			pstmt = con.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			int count = 0;
			while (rs.next()) {
				boardEntity brd = new boardEntity();
				brd.setId ( rs.getInt("id") );
				brd.setName ( rs.getString("name") );
				brd.setPasswd ( rs.getString("passwd") );
				brd.setTitle ( rs.getString("title") );
				brd.setLink ( rs.getString("link") );
				brd.setRegdate ( rs.getTimestamp("regdate") );
				brd.setContent ( rs.getString("content") );
				if((count >= page *5) && (count < (page+1)*5)){
					//리스트에 추가
					list.add(brd);
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
	//해장 ID의 게시물을 반환받음
	public boardEntity getBoard(int id) {	
		connect();
		String SQL = "select * from board where id = ?";
		boardEntity brd = new boardEntity();
		
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();			
			rs.next();
			brd.setId ( rs.getInt("id") );
			brd.setName ( rs.getString("name") );
			brd.setPasswd ( rs.getString("passwd") );
			brd.setTitle ( rs.getString("title") );
			brd.setLink ( rs.getString("link") );
			brd.setRegdate ( rs.getTimestamp("regdate") );
			brd.setContent ( rs.getString("content") );
			rs.close();			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		finally {
			disconnect();
		}
		return brd;
	}
	//해당 ID를 가진 게시물의 댓글을 가져옴
	public ArrayList<replyEntity> getReplyList(int id)
	{
		connect();
		String sql = "select * from reply where id = ? order by re_id desc";
		ArrayList<replyEntity> list = new ArrayList<replyEntity>();
		
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				replyEntity rep = new replyEntity();
				rep.setId(rs.getInt("id"));
				rep.setRe_id(rs.getInt("re_id"));
				rep.setPasswd(rs.getString("passwd"));
				rep.setContext(rs.getString("context"));
				rep.setRegdate(rs.getDate("regdate"));
				list.add(rep);
			}
			rs.close();
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		finally{
			disconnect();
		}
		return list;
	}
	//댓글 등록
	public boolean insertReply(replyEntity rep)
	{
		boolean success = false;
		connect();
		String sql = "insert into reply value(?, 0, ?, ?, sysdate())";
		String sql2 = "UPDATE board SET regdate = sysdate() where id = ?"; 
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rep.getId());
			pstmt.setString(2, rep.getPasswd());
			pstmt.setString(3, rep.getContext());
			
			pstmt.executeUpdate();
			success = true;
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		finally{
			disconnect();
		}
		
		connect();
		try{
			pstmt = con.prepareStatement(sql2);
			pstmt.setInt(1, rep.getId());
			
			pstmt.executeUpdate();
			success = true;
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		finally{
			disconnect();
		}
		
		return success;
	}
	//게시물 삭제 Method
	public boolean deleteReply(int id, String passwd)
	{
		boolean success = false;
		connect();
		String sql = "delete from reply where re_id = ? and passwd = ?";
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setString(2, passwd);
			
			if(pstmt.executeUpdate() != 0)
				success = true;		
		}
		catch(SQLException e){
			e.printStackTrace();
			return success;
		}
		finally{
			disconnect();
		}		
		return success;
	}
	
	public ArrayList<replyEntity> latelyReply()
	{
		ArrayList<replyEntity> list = new ArrayList<replyEntity>();
		int count = 0;
		
		connect();
		String sql = "select * from reply order by re_id desc";
		try{
			pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next() && count < 10){
				replyEntity rep = new replyEntity();
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
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		finally{
			disconnect();
		}
		return list;
	}
}
