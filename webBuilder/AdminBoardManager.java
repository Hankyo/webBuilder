package manager;

import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.*;

import DBConnector.ConnectionPool;
import DataEntity.BoardData;
import DataEntity.ContentData;

public class AdminBoardManager{
	private static AdminBoardManager adminBoardManager = null;
	private static AdminManager adminManager = null;
	private static ConnectionPool connectionPool = null;
	public static final int LINE_PER_PAGE = 10;		// 한페이지에 나타날 글의 수
	public static final int PAGES_PER_GROUP = 10;	// 한 화면에 나타낼 페이지수
	private int recNum = 0;							// 전체 레코드 수
	private int totalPage = 0;						// 총페이지 수 
	private int currentPage = 0;					// 현재페이지
	private String search = "";						// 검색값을 위한 변수
	private String text = "";						// 검색결과를 위한 변수
	private boolean success;						// 작업이 성공적으로 끝났는지를 확인하는 변수

	//Singleton Block
    static {
        try{
        	adminManager = AdminManager.getInstance();
            adminBoardManager = AdminBoardManager.getInstance();
            connectionPool = connectionPool.getConnectionPool();
        } catch(Exception e){
            System.out.println("Error01:static block error!!");
        }
    }
    
    public static AdminBoardManager getInstance()
    {
    	if(adminBoardManager == null){
    		adminBoardManager = new AdminBoardManager();
    	}
    	return adminBoardManager;
    }
    
    // 해당하는 이름의 게시판이 존재하는지 유무를 검사하기 위한 메소드
    public boolean existBoard(String boardName) {
        String sql = "select count(boardName) from BoardAdmin where boardName='" + boardName + "'";
        int num = adminManager.executeQueryNum(sql);
        if(num == 0){
            return false;
        } else {
            return true;
        }
    }
    
	// 글의 비밀번호를 리턴하는 메소드
	public String getPassword(String boardName, int num) {
		String sql = "select password from " + boardName + " where num=" + num;
		String password = adminManager.executeQueryString(sql);
		return password;
	}
 
	// 게시판 관리 권환 생성
	public void writeBoardAdmin(int id,int rdlevel, int wrlevel, int lstlevel) {
		String sql = "Insert into boardadmin ";
		sql += "(id , rdlevel, wrlevel, lstlevel) ";
		sql += " values(" + id +", " + rdlevel +
				", " +  wrlevel + ", " + lstlevel +')';
		adminManager.executeUpdate(sql);
	}
		
    // 새로운 게시판을 만들기 위한 메소드
    public void makeBoard(String boardName) {
    	String makeBoardSQL = "create table " + boardName + " (" ;          
        makeBoardSQL += "num int NOT NULL AUTO_INCREMENT PRIMARY KEY,";
        makeBoardSQL += "name varchar(20) NOT NULL,";
        makeBoardSQL += "subject varchar(100) NOT NULL,";
        makeBoardSQL += "content text NULL,";
        makeBoardSQL += "writeDate datetime,";
        makeBoardSQL += "password varchar(20) NOT NULL,";
        makeBoardSQL += "count int NOT NULL,";
        makeBoardSQL += "ref int NOT NULL,";
        makeBoardSQL += "step int NOT NULL,";
        makeBoardSQL += "depth int NOT NULL,";
        makeBoardSQL += "childCount int NOT NULL";
        makeBoardSQL += ")";
        
        adminManager.executeUpdate(makeBoardSQL);
    }
    
    // 게시판의 전체 내용을 Vector로 반환하는 메소드
   	public ArrayList<BoardData> executeQueryToVector(String sql) throws SQLException, UnsupportedEncodingException {
   		ArrayList<BoardData> list = new ArrayList<BoardData>();
   		Connection conn = null;
    	Statement stmt = null;
   		try{
   			conn = connectionPool.getConnection();
    		stmt = conn.createStatement();
    		
    		ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				 BoardData data = new BoardData();
                 data.setNum(rs.getInt(1));
                 data.setName(new String(rs.getString(2).getBytes("8859_1"),"euc-kr"));
                 data.setSubject(new String(rs.getString(3).getBytes("8859_1"),"euc-kr"));
                 data.setContent(new String(rs.getString(4).getBytes("8859_1"),"euc-kr"));
                 data.setDate(rs.getDate(5));
                 data.setPassword(new String(rs.getString(6).getBytes("8859_1"),"euc-kr"));
                 data.setCount(rs.getInt(7));
                 data.setRef(rs.getInt(8));
                 data.setStep(rs.getInt(9));
                 data.setDepth(rs.getInt(10));
                 data.setChildCount(rs.getInt(11));
                 list.add(data);
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
   	
    // 하나의 글을 반환하는 메소드
  	public BoardData getNotice(String boardName, int num) throws UnsupportedEncodingException, SQLException {
  		String sql = "select * from " + boardName + " where num=" + num;
  		ArrayList<BoardData> list = adminBoardManager.executeQueryToVector(sql);
  		BoardData data = (BoardData)list.get(0);
  		return data;
  	}
  	
    // 한 페이지의 글목록을 Vector로 반환하는 메소드
 	public ArrayList<BoardData> getPage(String boardName, int currentPage) throws UnsupportedEncodingException, SQLException {
 		String sql = null;

 		if(!(text.trim()).equals("")){ //제목을 찾는 sql문
 			sql = "select * from " + boardName;
 			sql += " where upper(" + search + ") like upper('%" + text + "%')";
 			sql += " order by ref desc, step limit " + LINE_PER_PAGE * (currentPage - 1) + ", " + LINE_PER_PAGE;
 		}else {
 			sql = "select * from " + boardName;
 			sql += " order by ref desc, step limit " + LINE_PER_PAGE * (currentPage - 1) + ", " + LINE_PER_PAGE;
 		}
 		return adminBoardManager.executeQueryToVector(sql);
 	}
    // 페이징을 위한 메소드
 	public String getPaging(String selectedID, int currentPage) {
 		this.currentPage = currentPage;
 		int recNum = this.getRecNum(selectedID);
 		this.totalPage =((recNum - 1) / 10) + 1;
 		
 		String boardLink = "boardList.jsp?selectedID=" + selectedID;
 		int startPage;
 		int endPage;
 		int linkPage;
 		String strList = "";

 		startPage = ((currentPage - 1) / PAGES_PER_GROUP) * PAGES_PER_GROUP + 1;
 		endPage = (((startPage - 1) + PAGES_PER_GROUP) / PAGES_PER_GROUP) * PAGES_PER_GROUP;

 		if(totalPage <= endPage) {
 			endPage = totalPage;
 		}
 		
 		if(currentPage > PAGES_PER_GROUP) {
 			linkPage = startPage - 1;
 			strList += "<a href='" + boardLink + "&page=" + linkPage + "'>[이전]</a>";
 		}else{
 			strList += "[이전]";
 		}
 		strList += "..";
 		
 		linkPage = startPage;
 		while(linkPage <= endPage) {
 			if(linkPage == currentPage){
 				strList += "&nbsp;" + currentPage + "&nbsp;";
 			} else {
 				strList += "<a href='" + boardLink + "&page=" + linkPage + "'>[" + linkPage + "]</a>";
 			}
 			linkPage++;
 		}
 		strList += "..";
 		
 		if(totalPage > endPage) {
 			linkPage = endPage + 1;
 			strList += "<a href='" + boardLink + "&page=" + linkPage + "'>[이후]</a>";
 		}else{
 			strList += "[이후]";
 		}
 		
 		return strList;
 	}
    
    // 새로운 글을 입력하기 위한 메소드
 	public void writeNotice(String boardName, BoardData data) throws UnsupportedEncodingException {
 		int noticeNum = this.getMaxNum(boardName) + 1;
 		String sql = "Insert into " + boardName + " ";
 		sql += "(name, subject, content, writeDate, password, ";
 		sql += "count, ref, step, depth, childCount)";
 		sql += " values('" + data.getName() + "', '";
 		sql += data.getSubject() + "', '" + data.getContent() + "', now(), '";
 		sql += data.getPassword() + "', 0, " + noticeNum + ", 0, 0, 0)";
 		adminManager.executeUpdate(sql);
 		
 		this.setSuccess(true);
 	}
 	
    // 답변글을 달기 위한 메소드
 	public void replyNotice(String boardName, BoardData data) {
 		String sql = "select min(step) from " + boardName + " where ref = " + data.getRef();
 		sql += " and depth <= " + data.getDepth() + " and step > " + data.getStep();
 		int mstep = adminManager.executeQueryNum(sql);		
 		int instep = 0;

 		if(mstep > 0) {
 			sql = "update " + boardName + " set step = step + 1 where ref = ";
 			sql += data.getRef() + " and step >= " + mstep;
 			adminManager.executeUpdate(sql);
 			instep = mstep;
 		} else {
 			sql = "select max(step) from " + boardName + " where ref = " + data.getRef();
 			instep = adminManager.executeQueryNum(sql) + 1;
 		}

 		int depth = data.getDepth();
 		sql = "Insert into " + boardName;
 		sql += " (name, subject, content, writeDate, password, ";
 		sql += "count, ref, step, depth, childCount)";
 		sql += "values(" + data.getName() + "', '";
 		sql += data.getSubject() + "', '" + data.getContent() + "', now()" + ", '" + data.getPassword();
 		sql += "', 0, " + data.getRef() + ", " + instep + ", " + (++depth) + ", 0)";
 		adminManager.executeUpdate(sql);
 		
 		for(int r = depth - 1; r >= 0; r--) {
 			sql = "select max(step) from " + boardName + " where ref = " + data.getRef();
 			sql += " and depth = " + r + " and step < " + instep;
 			int max_Step = adminManager.executeQueryNum(sql);
 		
 			sql = "update " + boardName + " set childCount = childCount + 1 ";
 			sql += "where ref = " + data.getRef() + " and depth = " + r + " and step = " + max_Step;
 			adminManager.executeUpdate(sql);
 		}
 		
 		this.setSuccess(true);
 	}
    // 글을 삭제하기 위한 메소드
 	public String deleteNotice(String boardName, int num) throws UnsupportedEncodingException, SQLException{
 		String msg = new String(); 
 		BoardData data = adminBoardManager.getNotice(boardName,num);
 		int ref = data.getRef();
 		int step = data.getStep();
 		int depth = data.getDepth();
 		int childCount = data.getChildCount();

 		if(childCount == 0) {
 			String sql = "delete from " + boardName + " where num =" + num;
 			adminManager.executeUpdate(sql);

 			for(int r = depth - 1; r >= 0; r--) {
 				sql = "select max(Step) from " + boardName + " where ref = " + ref ;
 				sql += " and depth = " + r + " and step < " + step;
 				int max_Step = adminManager.executeQueryNum(sql);
 				sql = "update " + boardName + " set childCount = childCount-1 ";
 				sql += "where ref = " + ref + " and depth = " + r + " and step =" + max_Step;
 				adminManager.executeUpdate(sql);
 			}		
 			msg = "OK";
 			this.setSuccess(true);
 		} else {
 			msg = "답변이 있는 글은 삭제할 수 없습니다";
 			this.setSuccess(false);
 		}			
 		return msg;
 	}
 	
    // 검색을 위한 변수 설정	
 	public void setSearch(String search) { this.search = search; }
 	public void setText(String text) { this.text = text; }
 	
    // 작업 수행의 결과를 리턴
 	public boolean getSuccess(){ return success; }
 	// 작업 수행의 결과를 설정
 	public void setSuccess(boolean success){ this.success = success; }
 	
    // 레코드 수를 반환하기 위한 메소드
  	public int getRecNum(String selectedID) {
  		String sql = null;
  		if(!(text.trim()).equals("")){
  			sql = "select count(*) from board_" + selectedID;
  			sql += " where upper(" + search + ") like upper('%" + text + "%')";
  		} else {
  			sql = "select count(*) from board_" + selectedID;
  		}
  		this.recNum = adminManager.executeQueryNum(sql);
  		return this.recNum;
  	}
    // 데이터베이스에서 가장 큰 글 번호를 가져오는 메소드
 	public int getMaxNum(String boardName){
 		String sql = "select max(Num) from " + boardName;
 		int maxNum = adminManager.executeQueryNum(sql);
 		return maxNum;
 	}
}
