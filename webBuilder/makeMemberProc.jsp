<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*"%>
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="boardManager" class="manager.BoardManager" scope="page" />
<jsp:useBean id="memberManager" class="manager.MemberManager" scope="page" />
<jsp:useBean id="memberData" class="DataEntity.MemberData" scope="page" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<%@ page import="java.sql.*" %>
	<% 
	adminManager.getConnectDB();
	String dbURL = adminManager.getUrl();
	String connectID = adminManager.getID();
	String dbPassword = adminManager.getPassword();
	%>
</head>
<body>
<%
	    // 세션이 없으면 Login Process.
	    request.setCharacterEncoding("UTF-8");
		String user_id = request.getParameter("id");
		String password = request.getParameter("password");
		String password2 = request.getParameter("password2");
		String name = request.getParameter("name");
		
		Connection con = null;
		Statement stmt = null;
		String driverName = "com.mysql.jdbc.Driver";
		
		request.setCharacterEncoding("euc-kr");
		Class.forName(driverName);
		con = DriverManager.getConnection(dbURL, connectID, dbPassword);
		
		String sql = "select count(*) from member where user_id = '" + user_id + "'";
		int check = 0;
		stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next()) {
			check = rs.getInt(1);             
		}
		if( check > 0 ){
			 %> 해당 관리자 아이디가 존재합니다.  
			 <form action="makeMember.jsp" method="post">
			 	<input type="submit" value="돌아가기" name="B3"></p>
			 </form>
			 <%
		}
		else{	
			String insertUserSQL = "insert member values(?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement( insertUserSQL );
			
			sql = "select count(*) from member";
			int num = adminManager.executeQueryNum(sql);
			
			pstmt.setString(1, user_id);
			pstmt.setString(2, password);
			pstmt.setInt(3, 9);
			pstmt.executeUpdate( );
		%>
		<form name="write" method="post" action="login.jsp">
			<p>입력하신 사항으로 아디가 생성되었습니다.</p>
			<input type="submit" value="로그인페이지로 이동">
		</form>   
		<%} %> 
</body>
</html>