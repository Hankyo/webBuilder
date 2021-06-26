<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
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
		//게시 목록을 위한 배열리스트를 자바진즈를 이용하여 확보 
		ArrayList<boardEntity> list = brddb.getBoardList(i_page); 
	   	int counter = list.size();
	   	int row = 0;
	   	
	   	if (counter > 0) {
	%>
	<center>
	<table width=850 border=1 cellpadding=1 cellspacing=3>
    <tr>
       <th><font color=blue><b>번호</b></font></th>
       <th width = 500><font color=blue><b>제목</b></font></th>
       <th><font color=blue><b>작성자</b></font></th>
       <th><font color=blue><b>작성일</b></font></th>
    </tr>
	<%
		//게시 등록일을 2010-3-15 10:33:21 형태로 출력하기 위한 클래스 
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for( boardEntity brd : list ) {
			//홀짝으로 다르게 색상 지정
			String color = "papayawhip";
			if ( ++row % 2 == 0 ) color = "white"; 
	%>
    <tr bgcolor=<%=color %>>
		<!-- 수정과 삭제를 위한 링크로 id를 전송 -->
       <td align=center><%= brd.getId()%></td>
       <td align=left><a href = "./contentView.jsp?id=<%=brd.getId()%>&page=<%=i_page%>"><%= brd.getTitle() %></a></td>
       <td align=center><%= brd.getName() %></td>
		<!-- 게시 작성일을 2010-3-15 10:33:21 형태로 출력 -->
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
	<center><h2>게시물이 없습니다!!</h2></center>
<%} %>
</center><hr>
<center>
<%
if(i_page != 0){ %>
	<a href = "./ListBoard.jsp?page=<%=i_page-1 %>" >이전으로</a>
<%
}%>
<a href = "./ListBoard.jsp">처음으로</a>
<%
if(i_page < brddb.getBoardLength() / 5){
%>     
<a href = "./ListBoard.jsp?page=<%=i_page + 1 %>" >다음으로</a>
<%} %>
<form name=form method=post action="./writeForm.jsp">
      <input type=submit value="글쓰기"> 
</form>
</center>
<%@include file="Foot.jspf" %>
</html>