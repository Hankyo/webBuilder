<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" /> 
<jsp:useBean id="memberManager" class="manager.MemberManager" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	//전 페이지에서 정보 받음
	request.setCharacterEncoding("UTF-8");
	String password = "";
	String password2 = "";
	String id = request.getParameter("id");
	password = request.getParameter("password");
	password2 = request.getParameter("password_2");
	if( password.compareTo(password2) != 0){
		 %> 패스워드와 패스워드확인과 일치하지 않습니다.  
		 <form action="install_2.jsp" method="post">
		 	<input type="submit" value="돌아가기" name="B3"></p>
		 </form>
		 <%
	}	
	
	String sql = "select count(*) from member where user_id = '" + id + "'";
	int check = adminManager.executeQueryNum(sql);
	
	if( check > 0 ){  // 해당 아디가 존재할 때
		 %> 해당 관리자 아이디가 존재합니다.  
		 <form action="./install_2.jsp" method="post">
		 	<input type="submit" value="돌아가기" name="B3"></p>
		 </form>
		 <%
	}
	else{   // 아디 생성 후 다음 단계
		String insertUserSQL = "insert member values( '" + id + "', '" + password + "', 0)";
	
		adminManager.executeUpdate(insertUserSQL);
		response.sendRedirect("./install_3.jsp");
	}
%>	
</body>
</html>