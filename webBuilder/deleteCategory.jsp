<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="boardManager" class="manager.BoardManager" scope="page" />
<jsp:useBean id="categoryManager" class="manager.CategoryManager" scope="page" />

<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delete Board</title></head><body>

<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	String step = request.getParameter("dropdown");
	adminManager.getConnectDB();
	String dbURL = adminManager.getUrl();
	String connectID = adminManager.getID();
	String password = adminManager.getPassword();
	
	String sql = "select name from category where step =" + step;
	String categoryName = adminManager.adminExecuteQueryString(sql);
	System.out.println(categoryName);
	
	sql = "select count(*) from category where step>" + step;
	int count = adminManager.adminExecuteQueryNum(sql);
	
	// 해당 카테고리 삭제
    sql = "delete from category where step = " + step;
    adminManager.adminExecuteUpdate(sql);
     
    int intStep =  Integer.parseInt(step);
	// 카테고리 step 재배열
	for(int r =intStep+1; r <= intStep+count; r++) {
		sql = "update category set step = step-1 ";
		sql += "where step = " + r;
		adminManager.adminExecuteUpdate(sql);
	}		
	//categoryManager.deleteCategory(categoryName, Integer.parseInt(step));
%>
	<%=categoryName%> 카테고리가 삭제되었습니다.
	
	<form method="POST" action="adminCategory.jsp">
    <input type="submit" value="확인" name="B3"></p>
</form>
	
</body></html>