<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="manager.AdminManager"%>

<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delete Board</title></head><body>

<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	String boardName = request.getParameter("boardName"); 
	AdminManager adminManager = AdminManager.getInstance();
	adminManager.deleteBoard(boardName);
%>
	<%=boardName%> 게시판이 삭제되었습니다.
	
	<form method="POST" action="boardAdmin.jsp">
    <input type="submit" value="확인" name="B3"></p>
    
</form>
	
</body></html>