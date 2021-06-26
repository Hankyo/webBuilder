<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판 : 댓글 등록</title>
</head>
<body>
	<%@include file = "./Header.jspf" %>
	<% request.setCharacterEncoding("EUC-KR"); %>
	<jsp:useBean id = "info" class = "board.replyEntity" />
	<jsp:useBean id = "process" class = "board.boardDB" />
	<jsp:setProperty property="*" name="info"/>
	<center>
	<% if(process.insertReply(info)){
		out.println("댓글을 성공적으로 등재하였습니다.");
	}
	else{
		out.println("댓글을 등재하지 못하였습니다.");
	}%>
	<a href = "./contentView.jsp?id=<%=info.getId()%>"><h3>게시물로</h3></a></center>
<%@include file = "./Foot.jspf" %>
</body>
</html>