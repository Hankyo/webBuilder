<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ��� : �Խù� ����</title>
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
		out.println("�Խù��� ���������� �����Ͽ����ϴ�.");
	}
	else{
		out.println("�Խù��� �������� ���Ͽ����ϴ�.");
	}%>
	<a href = "./ListBoard.jsp"><h3>�������</h3></a></center>
</body>
</html>