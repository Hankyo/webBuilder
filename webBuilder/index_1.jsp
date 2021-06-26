<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="DataEntity.BoardData,java.text.SimpleDateFormat" %>
<%@page import="java.util.*"%>
<jsp:useBean id="boardManager" class="manager.BoardManager" scope="page"/>

<!DOCTYPE HTML>
<html>
 <head>
  <title>***** Frontiers Story *****</title>
  <script src = "./common/common.js"></script>
  <meta charset="UTF-8" /> 
  <link rel="stylesheet" type="text/css" href="./common/reset.css" />
  <link rel="stylesheet" type="text/css" href="./common/boardTable.css" />
  <link rel="stylesheet" type="text/css" href="./common/layout_l.css" />
  <!--[if gte IE 7]>
  		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
 </head>
 
 <%@ include file = "./Header.jspf" %>
    <!-- contentsMain Start -->
    <div id="contentsMain" >
    	<% 
    		String typeTab = "1";
    		String type = "free";
    	%>
    	<h1><img src="./images/board/txt_frontiers.gif"></h1><hr>
		<div class = "tab">
    		<ul>
    			<li>
    				<a href="./index.jsp"><img src="./images/board/noticeBtn.gif"></a>
    			</li>	
    			<li>
    				<a href="./index_1.jsp"><img src="./images/board/freeBtn_off.gif"></a>
    			</li>	
    		</ul>
    	</div>

    	<!-- 게시판 시작  -->
	        <h2 class="titleBg"><span><%=type%> Board</span></h2>
		    <%
				String s_page = request.getParameter("page");
				int i_page;
				if(s_page != null)
					i_page = Integer.parseInt(s_page);
				else
					i_page = 0;
				//게시 목록을 위한 배열리스트를 자바진즈를 이용하여 확보 
				ArrayList<BoardData> list = boardManager.getBoardList(type,i_page); 
				int counter = list.size();
				int row = 0;
				   	
				if (counter > 0) {
			%>
				<table>
					<tr>
					    <td class="Board" width="70" >번호</td>
					    <td class="Board" width="300" >제목</td>
					    <td class="Board" width="100" >등록자</td>
					    <td class="Board" width="120" >등록일</td>
					    <td class="Board" width="70" >조회</td>
				    </tr> 
					<%
						for( BoardData brd : list ) {
							//홀짝으로 다르게 색상 지정
							String color = "papayawhip";
							if ( ++row % 2 == 0 ) color = "white"; 
					%>
						    <tr bgcolor=<%=color %>>
								<!-- 수정과 삭제를 위한 링크로 id를 전송 -->
						       <td class="listBoard"><%= brd.getId()%></td>
						       <td class="listBoard"><a href = "./contentView.jsp?typeTab=<%=typeTab%>&id=<%=brd.getId()%>&page=<%=i_page%>"><%= brd.getTitle() %></a></td>
						       <td class="listBoard"><%= brd.getName() %></td>
						       <td class="listBoard"><%= brd.getRegdate() %></td>
						       <td class="listBoard"><%= brd.getCount() %></td>
						    </tr>
					<%
					    }
					%>
				</table>
			<% 	} 
			if(counter == 0){ %>
				<h2>게시물이 없습니다!!</h2>
			<%}%>
			<hr>
			<form name=form method=post action="./writeForm.jsp">
			<%
			if(i_page != 0){ %>
				<a href = "./index_1.jsp?page=<%=i_page-1 %>" >이전으로</a>
			<%
			}%>
			<a href = "./index_1.jsp">처음으로</a>
			
			<% if(i_page < boardManager.getBoardLength(type) / 5){ %>     
				<a href = "./index_1.jsp?page=<%=i_page + 1 %>" >다음으로</a>
			<%} %>
				<input type = hidden name= "typeTab" value =<%=typeTab%>>
			    <input type = submit value="글쓰기"> 
		    </form>
        <!-- 게시판 끝  -->
        
    </div>
    <!-- contentsMain End --> 

 <%@ include file = "./Foot.jspf" %>
</html>