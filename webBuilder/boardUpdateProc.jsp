<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*, DataCapsuled.BoardData"%>
<%@page import="java.sql.*" %>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="boardManager" class="manager.BoardManager" scope="page" />
<jsp:useBean id="editData" class="DataCapsuled.BoardData" scope="page" />

<%
	
	
	adminManager.getConnectDB();
	String dbURL = adminManager.getUrl();
	String connectID = adminManager.getID();
	String dbPassword = adminManager.getPassword();
	if(dbURL.compareTo("") == 0 || connectID.compareTo("") == 0 || dbPassword.compareTo("") == 0)
	{
		%> 디비가 올바른 설정이 아닙니다.  
		 <form action="./install/install_1.jsp" method="post">
		 	<input type="submit" value="돌아가기" name="B3"></p>
		 </form>
		 <%
	}
	
	String replaceContent = "";
	Connection con = null;
    Statement stmt = null;
    String driverName = "com.mysql.jdbc.Driver";
    
	request.setCharacterEncoding("UTF-8");
	Class.forName(driverName);
    con = DriverManager.getConnection(dbURL, connectID, dbPassword);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
		request.setCharacterEncoding("UTF-8");
		String num = request.getParameter("num");
		String boardName = request.getParameter("boardName");
		String currentPage = request.getParameter("page");
		String selectedID = request.getParameter("selectedID");
		editData.setNum(Integer.parseInt(num));				
		editData.setName(request.getParameter("name"));
		editData.setSubject(request.getParameter("subject"));
		editData.setContent(request.getParameter("updateContent"));
		
			
		String sql = "update " + boardName + " set name='" + editData.getName();
		sql += "', subject='" + editData.getSubject() + "', content='" + editData.getContent();
		sql += "' where num=" + editData.getNum();
		
		stmt = con.createStatement();
		stmt.execute("SET CHARACTER SET euckr");
		stmt.execute("set names euckr");
		stmt.executeUpdate(sql);
		boardManager.setSuccess(true);
		
		if(boardManager.getSuccess()) {
			boardManager.setSuccess(false);
			response.sendRedirect("boardList.jsp?selectedID=" + selectedID + "&page=" + currentPage);
		} else {
			out.println("<script>alert('글이 수정되지않았습니다');</script>");
			response.sendRedirect("boardRead.jsp?boardName=" + boardName + "&page=" + currentPage + "&num=" + ((String)request.getParameter("num")));
		}
%>
</body>
</html>