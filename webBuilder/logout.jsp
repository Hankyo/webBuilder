<%@page contentType="text/html; charset=UTF-8"%>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Logout Page</title></head><body>
<%
	session.invalidate();
%>
	로그아웃 되었습니다.<p>
	
	<a href = "index.jsp">메인으로 이동</a>
	
</body></html>