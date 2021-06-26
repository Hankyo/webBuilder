<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="contentManager" class="manager.ContentManager" scope="page" />

<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String selectedID = request.getParameter("selectedID");
	if(selectedID == null || selectedID.compareTo("") == 0)
		response.sendRedirect("./adminCategory.jsp");
	
	int id = Integer.parseInt(selectedID);
	String boardName = "board_" + selectedID; 
	String sql = "select name from content where id ='" + selectedID + "'";
	String contentName = adminManager.adminExecuteQueryString(sql);
	sql = "select type from content where id ='" + selectedID + "'";
	String type = adminManager.adminExecuteQueryString(sql);
	
	adminManager.getConnectDB();
	String dbURL = adminManager.getUrl();
	String connectID = adminManager.getID();
	String password = adminManager.getPassword();
	
	Connection con = null;
	Statement stmt = null;
	String driverName = "com.mysql.jdbc.Driver";
	try{
    	request.setCharacterEncoding("UTF-8");
    	Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, connectID, password);
        stmt = con.createStatement();
    } catch(Exception e){
        response.sendRedirect("./install/install_1.jsp");
    }
		    
	stmt = con.createStatement();
	stmt.execute("SET CHARACTER SET euckr");
    stmt.execute("set names euckr");  
%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title></head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String desc = request.getParameter("desc");

	// 이름 설정 update
	sql = "update content set name = '" + name + "' where id =" + selectedID;
	stmt.executeUpdate(sql);
	sql = "update content set descriptor = '" + desc + "' where id =" + selectedID;
	stmt.executeUpdate(sql);
	    
	if(type.compareTo("고정") == 0) { 
    	request.setCharacterEncoding("UTF-8");
        String content = request.getParameter("ir1");  
        System.out.println (content);
        sql = "update static set content = '" + content + "' where id ='" + selectedID + "'";
    	stmt.executeUpdate(sql);

        response.sendRedirect("adminCategory.jsp");
    }
    else if(type.compareTo("링크") == 0) { 
            String url = request.getParameter("url");  
        	sql = "update link set url = '" + url + "' where id ='" + selectedID + "'";
        	stmt = con.createStatement();
            stmt.executeUpdate(sql);
      		response.sendRedirect("adminCategory.jsp");}
    else if(type.compareTo("게시판") == 0) {
            String rdLevel = request.getParameter("rdLevel");
            String wrLevel = request.getParameter("wrLevel");
            String lstLevel = request.getParameter("lstLevel");
    	    
        	sql = "update boardadmin set rdlevel = '" + rdLevel + "'  where id = '" + selectedID + "'";
        	adminManager.adminExecuteUpdate(sql);
        	sql = "update boardadmin set wrlevel = '" + wrLevel + "'  where id = '" + selectedID + "'";
        	adminManager.adminExecuteUpdate(sql);
        	sql = "update boardadmin set lstLevel = '" + lstLevel + "'  where id = '" + selectedID + "'";
        	adminManager.adminExecuteUpdate(sql);
       		response.sendRedirect("adminCategory.jsp");
       }
    %>

</body>
</html>