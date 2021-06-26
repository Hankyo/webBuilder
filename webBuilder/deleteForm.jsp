<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판 : 게시물 삭제</title>
</head>
<body>
	<%@include file = "./Header.jspf" %>
	<%
	
	String id = request.getParameter("id");
	if(id != null){%>
		<center><h3>게시물 삭제</h3>
		<form method = post action = "./deleteProcess.jsp">
			<input type = hidden name = id value = <%=id%>>
			<h4>비밀번호 : <input type = password name = "passwd"></h4>
			<input type = "submit" value = "삭제"><p>
			<a href = "./contentView.jsp?id=<%=id%>">돌아가기</a>
		</form>
		</center>
	<%}
	else{
		out.println("<center>잘못된 접근입니다.</center><br>");
		out.println("<center><a href = \"./ListBoard.jsp\">목록으로</a></center>");
	}
	%>
	<%@include file = "./Foot.jspf" %>
</body>
</html>