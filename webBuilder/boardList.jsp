<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="boardManager" class="manager.BoardManager" scope="page" />
<jsp:useBean id="boardData" class="DataCapsuled.BoardData" scope="page" />
<!--  Admin 게시판에서  보기를 클릭한   해당 게시판 리스트  -->
<%
	request.setCharacterEncoding("UTF-8");
	String selectedID = request.getParameter("selectedID");
	String boardName = "board_" + selectedID; 
	String sql = "select name from content where id ='" + selectedID + "'";
	String contentName = adminManager.adminExecuteQueryString(sql);
	String search = "";
	String text = "";
	
	if(request.getParameter("text") != null ) {
		search = (String)request.getParameter("search");
		if(request.getParameter("kor") != null) {
			text = request.getParameter("text");
		}else {
			text = request.getParameter("text");
		}
	}
	boardManager.setSearch(search);
	boardManager.setText(text);

	int currentPage = 1;
	if(request.getParameter("page") != null)
		currentPage = Integer.parseInt(request.getParameter("page"));
	String paging = boardManager.getPaging(selectedID, currentPage);
	Vector v = boardManager.getPage(boardName, currentPage); 
	
	// 레이아웃 설정 데이터 Get
	File f = new File("./layout.txt");
	String skinPath = "";
	String hvCheck = "";
	String style = "";
	if( f.isFile() ) 
	{
	    // 레이아웃 기초 설정
	    adminManager.getLayout();
	    skinPath = adminManager.getSkinPath();
	    style = skinPath + "/style.css";
    }
%>
<!--아래 CSS파일 링크를 레이아웃에 맞게 동적으로 바꾸어 주게 할 것-->
<!--전체적으로 디자인에 통일성을 주게 하기 위함임-->
<link href= "<%=style%>" rel="stylesheet" type="text/css">

<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=contentName%> Board</title></head><body>
<%
	sql = "select lstlevel from boardadmin where id ='" + selectedID + "'";
	int lstlevel = adminManager.adminExecuteQueryNum(sql);

	// 세션 확인
	int grade; 
	String id ="";
	if(session.getAttribute("id") == null)
		grade = 10;
	else{
		id = (String)session.getAttribute("id"); 
		sql = "select grade from member where user_id ='" + id +"'";
		grade = adminManager.adminExecuteQueryNum(sql);
	}
	// 게시판 리스트 권한을 확인합니다.
	if ( grade > lstlevel ){ 
		%> 권한이 없습니다.<%}
	else{%>
   
	<h3><%=contentName%> 게시판</h3>
	
	<table id="blist_title">
	<tr>
	    <th width="140"><b>게시물 제목</b></font></th>
	    <th width="140"><b>작성자</b></font></th>
	    <th width="140"><b>작성일</b></font></th>
	    <th width="140"><b>조회수</b></font></th>
    </tr> <hr>
    </table>
<%
	//BoardData boardData = null;
	if(v.size() > 0) {
		int depth = 0;
		for(int i = 0; i < v.size(); i++) {
			boardData = (DataCapsuled.BoardData)v.elementAt(i);		//현재 Vector 내용 대입
			//이전 코드 : boardData = (BoardData)v.elementAt(i);
%>
	<table id="blist_list">
		<tr> 
<%
			depth = boardData.getDepth();
			while(depth > 0) {
				depth--;
				out.println("&nbsp;&nbsp;");
			}
%>
       	<td width="150"><a href="boardRead.jsp?boardName=<%=boardName%>
		&page=<%=currentPage%>&num=<%=boardData.getNum()%>&search=<%=search%> 
		&text=<%=text%>"><%=boardData.getSubject()%></a><br> </td>
		<td width="170"><%=boardData.getName()%><br> </td>
		<td width="190"><%=boardData.getDate()%><br>  </td>
		<td width="140"><%=boardData.getCount()%><br>  </td>
       <br>
    </tr>

    </table>

	<hr>
<%
		}
	} else {
%>
	글이 없습니다.<br>
<%
	}
%>
	<p><%=paging%></p>
	<form method = post action="boardList.jsp?selectedID=<%=selectedID%>" name="ser">
		<input type="hidden" name="kor" value="ok">
		<select name="search" onChange="" align="center">
			<option selected value="subject">제목</option>
			<option value="content">내용</option>
			<option value="name">작성자</option>
		</select>
		<input type="text" name="text">
		<input type="submit" name="search" value="검색">
	</form>
	<a href="boardList.jsp?selectedID=<%=selectedID%>">처음목록</a> | 
	<a href="boardWrite.jsp?selectedID=<%=selectedID%>">글쓰기</a>
	<%} %>
</body></html>