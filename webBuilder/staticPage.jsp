<%@page contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@page import="java.util.*, DataCapsuled.BoardData"%>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="boardManager" class="manager.BoardManager" scope="page" />

<%
	String selectedID = request.getParameter("selectedID");
	
	String sql = "select content from static where id = " + selectedID;
	String content = adminManager.adminExecuteQueryString(sql);
%>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="./js/HuskyEZCreator.js" charset="utf-8"></script>
<title><%=content%> Board</title></head><body>
		<%=content %>
</body></html>