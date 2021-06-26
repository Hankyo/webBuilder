<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판 : 댓글 삭제</title>
</head>
<body>
	<%@include file = "./Header.jspf" %>
	<%
	String id = request.getParameter("id");
	String re_id = request.getParameter("re_id");
	if(re_id != null || id != null){%>
		<center><h4>댓글 삭제</h4>
		<form method = post action = "./re_deleteProcess.jsp">
			<input type = hidden name = id value = <%=id%>>
			<input type = hidden name = re_id value = <%=re_id%>>
			<h5>비밀번호 : <input type = password name = "passwd"></h5>
			<input type = "submit" value = "삭제"><p>
			<a href = "./contentView.jsp?id=<%=id%>">게시물로</a>
		</form>
		</center>
	<%}
	else{%>
		<center>잘못된 접근입니다.</center><br>
		<center><a href = "./contentView.jsp?id=<%=id%>">목록으로</a></center>
	<%}
	%>
	<%@include file = "./Foot.jspf" %>
</body>
</html>