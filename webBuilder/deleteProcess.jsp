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
	<% request.setCharacterEncoding("EUC-KR");
	int id = Integer.parseInt(request.getParameter("id"));
	String passwd = request.getParameter("passwd");
	%>
	
	<jsp:useBean id = "process" class = "board.boardDB" />
	<center>
	<% if(process.deleteDB(id, passwd)){
		out.println("게시물을 성공적으로 삭제하였습니다.");
	}
	else{
		out.println("게시물을 삭제하지 못하였습니다.");
	}%>
	<a href = "./ListBoard.jsp"><h3>목록으로</h3></a></center>
</body>
</html>