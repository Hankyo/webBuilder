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
	<%
	
	String id = request.getParameter("id");
	if(id != null){%>
		<center><h3>�Խù� ����</h3>
		<form method = post action = "./deleteProcess.jsp">
			<input type = hidden name = id value = <%=id%>>
			<h4>��й�ȣ : <input type = password name = "passwd"></h4>
			<input type = "submit" value = "����"><p>
			<a href = "./contentView.jsp?id=<%=id%>">���ư���</a>
		</form>
		</center>
	<%}
	else{
		out.println("<center>�߸��� �����Դϴ�.</center><br>");
		out.println("<center><a href = \"./ListBoard.jsp\">�������</a></center>");
	}
	%>
	<%@include file = "./Foot.jspf" %>
</body>
</html>