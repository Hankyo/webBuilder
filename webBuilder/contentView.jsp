<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판 : 게시물 조회</title>
<script type = "text/javascript">
function check(){
	if(document.comment.context.value.length == 0){
		alert("댓글을 입력해주세요");
		document.comment.context.focus();
	}
	else if(document.comment.passwd.value.length == 0){
		alert("비밀번호를 입력해주세요");
		document.comment.passwd.focus();
	}
	else{
		comment.submit();
	}
}
</script>
</head>
<body>
<%@ page import="java.util.ArrayList, board.boardEntity, board.replyEntity, java.text.SimpleDateFormat" %>
<%@include file = "Header.jspf" %>
<jsp:useBean id="boardDB" class = "board.boardDB"/>
<jsp:useBean id="brd" class = "board.boardEntity"/>
<%
	String s_id = request.getParameter("id");
	String s_page = request.getParameter("page");
	if(s_page == null){
		s_page = "0";
	}
	if(s_id != null){
		int id = Integer.parseInt(s_id);
		brd = boardDB.getBoard(id);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	%>
<table width = 850 border = 1>
	<tr bgcolor = "papayawhip">
	<td align=center width = 50><%= brd.getId()%></td>
	<td align=left width = 400><%= brd.getTitle() %></td>
	<td align=center width = 100><%= brd.getName() %></td>
	<!-- 게시 작성일을 2010-3-15 10:33:21 형태로 출력 -->
	<td align=center><%= df.format(brd.getRegdate()) %></td></tr>
	<tr><td colspan = 4 align = left>
       <%
       String linkPart = "";
       if(brd.getLink().length() >= 4 ) linkPart = brd.getLink().substring(brd.getLink().length() - 4);
       String jpg = ".jpg";
       if(jpg.compareTo(linkPart) == 0){%>
       <center><a href = <%=brd.getLink()%> target = "_blank"><img src = <%=brd.getLink() %> width = 320 height = 240></a></center><br>
       <%}
       else{%>
       <b><a href = <%=brd.getLink()%>><%=brd.getLink() %></a></b>
       <%} %>
       <%=brd.getContent() %><p>
       <div style="text-align:right">
       <h6><a href = "./ListBoard.jsp?page=<%=s_page %>">목록으로</a> 
       <a href="./deleteForm.jsp?id=<%= brd.getId()%>">삭제하기</a></h6></div>
       </td>
    </tr>
    <tr>
    <td colspan = 4>
    <form method = post name = comment action = "./reply.jsp">
    	<input type = hidden name = "id" value = <%=id %>>
    	<center><table>
    		<tr>
    		<td colspan = 2><input type = text name = context maxlength = 300 size = 80></td>
    		<td><input type=password name = passwd maxlength = 15></td>
    		<td><center><input type = button value = "댓글" onClick = "check()"></center></tr>
    	</table></center>
    </form>
    </td></tr>
    <tr>
    	<td colspan = 4>
    	<center><h4>댓글</h4>
    	<table width = 800 align = "center">
    <%
    	ArrayList<replyEntity> list = boardDB.getReplyList(id);
    	for( replyEntity rep : list ){%>
    		<tr><td align = left><i><%=rep.getRe_id()%> >> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rep.getRegdate()%><br>
    		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    		<a href = "./replyDelete.jsp?id=<%=rep.getId() %>&re_id=<%=rep.getRe_id()%>"><%=rep.getContext()%></a>
    		</i></td></tr>
    <%
    	}
    %>
    	</table>
	</center>
    </td>
    </tr>
</table>
	<%
	}
	else{%>
	<center><h1>잘못된 접근입니다</h1>
	<a href = "./ListBoard.jsp">목록으로</a></center>
	<%} %>
<%@include file = "Foot.jspf" %>
</body>
</html>