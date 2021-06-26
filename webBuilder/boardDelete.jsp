<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />

<%
	String currentPage = request.getParameter("page");
	String boardName = request.getParameter("boardName");
	StringTokenizer tokens = new StringTokenizer(boardName,"_");
	tokens.nextToken();
	String selectedID = tokens.nextToken();
	String sql = "select name from content where id ='" + selectedID + "'";
	String contentName = adminManager.adminExecuteQueryString(sql);
	
	int num = Integer.parseInt(request.getParameter("num"));
	String password = request.getParameter("password");
%>

<jsp:useBean id="boardManager" class="manager.BoardManager" scope="page" />

<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=contentName%> Board</title></head><body>
	<h3><%=contentName%> 게시판</h3><hr>
	<form name="chkPass" method="post" action="boardDelete.jsp?boardName=<%=boardName%>&num=<%=num%>&page=<%=currentPage%>">
<%
	if(request.getParameter("password") != null) {
		String noticePassword = boardManager.getPassword(boardName, num);
		if(!noticePassword.equals(password)) {
			out.print("<script>alert('비밀번호가 맞지 않습니다.');</script>");
		} else {
			String msg = boardManager.deleteNotice(boardName, num);
			
			if(boardManager.getSuccess()) {
				boardManager.setSuccess(false);
				response.sendRedirect("boardList.jsp?selectedID=" + selectedID + "&page=" + currentPage);
			} else {
				out.println("<script>alert('" + msg + "');</script>");
			}
		}
	}
%>
		글을 삭제하려면 비밀번호 확인이 필요합니다.<br>
		<input type="password" name="password">	<input type="submit" value="삭제">
	</form>
</body></html>