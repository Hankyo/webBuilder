<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*" %>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="boardManager" class="manager.BoardManager" scope="page" />
<jsp:useBean id="boardData" class="DataCapsuled.BoardData" scope="page" />

<%
	int currentPage = 0;
	int ref = 0;
	int step = 0;
	int depth = 0;
	int num = 0;

	request.setCharacterEncoding("UTF-8");
	String selectedID = request.getParameter("selectedID");
	String boardName = "board_" + selectedID;
	
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String password = request.getParameter("password");
	String reply = request.getParameter("reply");

	if(reply.equals("ok")){
		currentPage = Integer.parseInt(request.getParameter("page"));
		ref = Integer.parseInt(request.getParameter("ref"));
		step = Integer.parseInt(request.getParameter("step"));
		depth = Integer.parseInt(request.getParameter("depth"));
	}
	boardData.setNum(num);
	boardData.setName(name);
	boardData.setSubject(subject);
	boardData.setContent(content);
	boardData.setPassword(password);
	boardData.setRef(ref);
	boardData.setStep(step);
	boardData.setDepth(depth);
	
	adminManager.getConnectDB();
	String dbURL = adminManager.getUrl();
	String connectID = adminManager.getID();
	String dbPassword = adminManager.getPassword();
	if(dbURL.compareTo("") == 0 || connectID.compareTo("") == 0 || password.compareTo("") == 0)
	{
		%> 디비가 올바른 설정이 아닙니다.  
		 <form action="./install/install_1.jsp" method="post">
		 	<input type="submit" value="돌아가기" name="B3"></p>
		 </form>
		 <%
	}
	
	// 답변 글일때
	if(reply.equals("ok")){
		
		Connection con = null;
	    Statement stmt = null;
	    String driverName = "com.mysql.jdbc.Driver";
	    
		request.setCharacterEncoding("UTF-8");
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, connectID, dbPassword);

	    String sql = "select min(step) from board_" + selectedID + " where ref = " + boardData.getRef();
		sql += " and depth <= " + boardData.getDepth() + " and step > " + boardData.getStep();

		int mstep = adminManager.adminExecuteQueryNum(sql);		
		int instep = 0;

		if(mstep > 0) {
			sql = "update board_" + selectedID + " set step = step + 1 where ref = ";
			sql += boardData.getRef() + " and step >= " + mstep;
			adminManager.adminExecuteUpdate(sql);
			instep = mstep;
		} else {
			sql = "select max(step) from board_" + selectedID + " where ref = " + boardData.getRef();
			instep = adminManager.adminExecuteQueryNum(sql) + 1;
		}

		int maxNum = boardManager.getMaxNum(selectedID) + 1;
		int checkDepth = boardData.getDepth();
		sql = "Insert into board_" + selectedID;
		sql += " (num, name, subject, content, writeDate, password, ";
		sql += "count, ref, step, depth, childCount)";
		sql += "values(" + maxNum + ", '" + boardData.getName() + "', '";
		sql += boardData.getSubject() + "', '" + boardData.getContent() + "', now()" + ", '" + boardData.getPassword();
		sql += "', 0, " + boardData.getRef() + ", " + instep + ", " + (++checkDepth) + ", 0)";
		
		stmt = con.createStatement();
        stmt.execute("SET CHARACTER SET euckr");
        stmt.execute("set names euckr"); 
        stmt.executeUpdate(sql);
		
		for(int r = checkDepth - 1; r >= 0; r--) {
			sql = "select max(step) from board_" + selectedID + " where ref = " + boardData.getRef();
			sql += " and depth = " + r + " and step < " + instep;
			int max_Step = adminManager.adminExecuteQueryNum(sql);
		
			sql = "update board_" + selectedID + " set childCount = childCount + 1 ";
			sql += "where ref = " + boardData.getRef() + " and depth = " + r + " and step = " + max_Step;
			
			stmt = con.createStatement();
	        stmt.execute("SET CHARACTER SET euckr");
	        stmt.execute("set names euckr"); 
	        stmt.executeUpdate(sql);
		}
		boardManager.setSuccess(true);
		// 글을 답변하는 메소드 최대한 java파일에서 처리하도록 하자 
		//boardManager.replyNotice(boardName, boardData);
		
		if(boardManager.getSuccess()){
			boardManager.setSuccess(false);
			response.sendRedirect("boardList.jsp?selectedID=" + selectedID + "&page =" + currentPage);
		}
	} else {   // 그냥 글을 업로드할 때
		Connection con = null;
	    Statement stmt = null;
	    String driverName = "com.mysql.jdbc.Driver";
	    
		request.setCharacterEncoding("UTF-8");
		Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, connectID, dbPassword);
        
        stmt = con.createStatement();
        stmt.execute("SET CHARACTER SET euckr");
        stmt.execute("set names euckr");
        
        int noticeNum = boardManager.getMaxNum(selectedID) + 1;
        String sql = "Insert into board_" + selectedID; 
        sql +=  " ";
		sql += "(num, name, subject, content, writeDate, password, ";
		sql += "count, ref, step, depth, childCount)";
		sql += " values(" + noticeNum +", '" + boardData.getName() + "', '";
		sql += boardData.getSubject() + "', '" + boardData.getContent() + "', now(), '";
		sql += boardData.getPassword() + "', 0, " + noticeNum + ", 0, 0, 0)";
		stmt.executeUpdate(sql);
		boardManager.setSuccess(true);
		
		// 글쓰기 메소드
		//boardManager.writeNotice(boardName, boardData);
		
		if(boardManager.getSuccess()) {
			boardManager.setSuccess(false);
			response.sendRedirect("boardList.jsp?selectedID=" + selectedID + "&page=1&search=&text=");
		}
	}
%>