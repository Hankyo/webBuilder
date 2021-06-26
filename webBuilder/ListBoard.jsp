<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
</head>

<%@include file="Header.jspf" %>
<%@ page import="java.util.ArrayList, board.boardEntity, java.text.SimpleDateFormat" %>
	<jsp:useBean id="brddb" class="board.boardDB" scope="page" />
	<% 
		String s_page = request.getParameter("page");
		int i_page;
		if(s_page != null)
			i_page = Integer.parseInt(s_page);
		else
			i_page = 0;
		//�Խ� ����� ���� �迭����Ʈ�� �ڹ���� �̿��Ͽ� Ȯ�� 
		ArrayList<boardEntity> list = brddb.getBoardList(i_page); 
	   	int counter = list.size();
	   	int row = 0;
	   	
	   	if (counter > 0) {
	%>
	<center>
	<table width=850 border=1 cellpadding=1 cellspacing=3>
    <tr>
       <th><font color=blue><b>��ȣ</b></font></th>
       <th width = 500><font color=blue><b>����</b></font></th>
       <th><font color=blue><b>�ۼ���</b></font></th>
       <th><font color=blue><b>�ۼ���</b></font></th>
    </tr>
	<%
		//�Խ� ������� 2010-3-15 10:33:21 ���·� ����ϱ� ���� Ŭ���� 
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for( boardEntity brd : list ) {
			//Ȧ¦���� �ٸ��� ���� ����
			String color = "papayawhip";
			if ( ++row % 2 == 0 ) color = "white"; 
	%>
    <tr bgcolor=<%=color %>>
		<!-- ������ ������ ���� ��ũ�� id�� ���� -->
       <td align=center><%= brd.getId()%></td>
       <td align=left><a href = "./contentView.jsp?id=<%=brd.getId()%>&page=<%=i_page%>"><%= brd.getTitle() %></a></td>
       <td align=center><%= brd.getName() %></td>
		<!-- �Խ� �ۼ����� 2010-3-15 10:33:21 ���·� ��� -->
       <td align=center><%= df.format(brd.getRegdate()) %></td>
    </tr>
       <tr bgcolor=<%=color %> >
       <td colspan = 4 align = left>
       <%=brd.getContent() %><p>
       </td>
    </tr>
	<%
	    }
	%>
	</table>
<% 	}
%>
<%if(counter == 0){ %>
	<center><h2>�Խù��� �����ϴ�!!</h2></center>
<%} %>
</center><hr>
<center>
<%
if(i_page != 0){ %>
	<a href = "./ListBoard.jsp?page=<%=i_page-1 %>" >��������</a>
<%
}%>
<a href = "./ListBoard.jsp">ó������</a>
<%
if(i_page < brddb.getBoardLength() / 5){
%>     
<a href = "./ListBoard.jsp?page=<%=i_page + 1 %>" >��������</a>
<%} %>
<form name=form method=post action="./writeForm.jsp">
      <input type=submit value="�۾���"> 
</form>
</center>
<%@include file="Foot.jspf" %>
</html>