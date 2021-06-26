<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>

<%
	String boardName = request.getParameter("boardName");
%>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=boardName%> Board</title></head><body>
	<h3><%=boardName%> 게시판</h3>
	<form name="write" method="post" action="boardUpload_old.jsp?boardName=<%=boardName%>">
		이름 : <input type="text" name="name" size="16"><br>
		비밀번호 : <input type="password" name="password"><br>
		제목 : <input type="text" name="subject" size="50"><br>
		내용 : <textarea name="content" cols="50" rows="10" scroll="auto"></textarea><br>
		<input type="submit" value="글 올리기">
	</form>
</body></html>