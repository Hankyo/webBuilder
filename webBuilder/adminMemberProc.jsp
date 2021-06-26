<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="categoryManager" class="manager.CategoryManager" scope="page" />
<jsp:useBean id="contentManager" class="manager.ContentManager" scope="page" />

<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Make New Board</title></head><body>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String menu = request.getParameter("menu");      // 메뉴버튼 클릭시 
	String step = request.getParameter("dropdown");  // 카테고리 드롭다운
	
	adminManager.getConnectDB();
	String dbURL = adminManager.getUrl();
	String connectID = adminManager.getID();
	String password = adminManager.getPassword();
	if(dbURL.compareTo("") == 0 || connectID.compareTo("") == 0 || password.compareTo("") == 0)
	{
		 %> 디비가 올바른 설정이 아닙니다.  
		 <form action="./install/install_1.jsp" method="post">
		 	<input type="submit" value="돌아가기" name="B3"></p>
		 </form>
		 <%
	}

if( menu.compareTo("등급상향") == 0){	
	 String[] checkedContent = request.getParameterValues("contentMove");
	%>
	<%if(checkedContent[0] != null){
		for(int i=0;i<checkedContent.length;i++){ 
		System.out.println(checkedContent[i]);

		String sql = "update member set grade = grade -1 where user_id ='" + checkedContent[i] + "' && grade > '1'";
		adminManager.adminExecuteUpdate(sql);
		}
	}
	response.sendRedirect("adminMember.jsp"); 
}

else if( menu.compareTo("등급하향") == 0){	
	 String[] checkedContent = request.getParameterValues("contentMove");
	%>
	<%if(checkedContent[0] != null){
		for(int i=0;i<checkedContent.length;i++){ 
		System.out.println(checkedContent[i]);

		String sql = "update member set grade = grade +1 where user_id ='" + checkedContent[i] + "' && grade < '9'";
		adminManager.adminExecuteUpdate(sql);
		}
	}
	response.sendRedirect("adminMember.jsp"); 
}
	
else if( menu.compareTo("삭제") == 0){
	 String[] checkedContent = request.getParameterValues("contentMove");
	%>
	<%for(int i=0;i<checkedContent.length;i++){ 
		String sql = "delete from member where user_id ='" + checkedContent[i] +"'";
		adminManager.adminExecuteUpdate(sql);
	}
	response.sendRedirect("adminMember.jsp"); 
}

%>
</body></html>