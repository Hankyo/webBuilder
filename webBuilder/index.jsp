<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />

<% 
	Connection con = null;
    Statement stmt = null;
    String driverName = "com.mysql.jdbc.Driver";
    
    adminManager.getConnectDB();
	String dbURL = adminManager.getUrl();
	String connectID = adminManager.getID();
	String password = adminManager.getPassword();
    
	request.setCharacterEncoding("UTF-8");
	Class.forName(driverName);
    con = DriverManager.getConnection(dbURL, connectID, password);
    
    stmt = con.createStatement();
    stmt.execute("SET CHARACTER SET euckr");
    stmt.execute("set names euckr"); 
    
    String selectedID = request.getParameter("selectedID");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WebSiteBulder</title>

<!--css폴더에 style.css를 복사해 넣을 것-->
<link href="./css/style.css" rel="stylesheet" type="text/css">
<link href="./SpryAssets/SpryMenuBarBlack.css" rel="stylesheet" type="text/css">
<script src="./SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
</head>

<body>
<!--레이아웃 전체를 감싸주는 부분-->
<div id="container">

<div id="banner">
<!--배너이미지 뿌려주는 부분 이미지 가로크기는 컨테이너 가로크기만큼이 적당한듯
	<img src="../길벗 예제파일/드림위버/Sample/02/top2.png">
    -->    
<div align = left><b><a href = "login.html" >로그인</a>
<a href="makeMember.jsp">회원가입</a></b></div>
    
</div>


<div id="navi">
<!--메뉴박스 부분-->
<ul id="MenuBar1" class="MenuBarHorizontal">
 <!--첫번째 아이템 메뉴박스-->
 	<% 
  		String sql = "select count(*) from category";
		int num = adminManager.adminExecuteQueryNum(sql) - 1; 
  			if(num >= 0){
				for(int i=num; i>=0; i--){
  					sql = "select name from category where step = " + i ;
					String name = adminManager.adminExecuteQueryString(sql); 
				%>	
			  <li><a class="MenuBarItemSubmenu" href="#"><%=name%></a>
			    <ul><%
			    sql = "select count(*) from content";
				int contentNum = adminManager.adminExecuteQueryNum(sql) - 1;
				for(int j=contentNum; j>=0; j--){
					sql = "select category_id from content where id = " + j ;
					int category_id = adminManager.adminExecuteQueryNum(sql); 
					if( category_id == i){
						sql = "select name from content where id = " + j ;
						name = adminManager.adminExecuteQueryString(sql); 
						sql = "select type from content where id = " + j ;
						String type = adminManager.adminExecuteQueryString(sql);
						if(type.compareTo("게시판") == 0){
							%><li><a href = "index.jsp?selectedID=<%=j%>" ><%=name%></a></li><% 
						}
						else if(type.compareTo("고정") == 0){
							%><li><a href = "index.jsp?selectedID=<%=j%>" ><%=name%></a></li><% 
						}
						else if(type.compareTo("링크") == 0){
							%><li><a href = "index.jsp?selectedID=<%=j%>" ><%=name%></a></li><% 
						}
					%>
			     <% }
				}%>
			    </ul>
			  </li>
			<%
			} 
		}%>
</ul>
</div>
<!--본문 내용 부분-->
<div id="content">
  <p><!-- 여기에 각종 게시판, 정적페이지를 보여줄 부분. <iframe> 태그로 보여주는게 적당함 링크는 새창으로 띄우게 할것 -->
  <% 
  	sql = "select type from content where id = " + selectedID ;
  	String type = adminManager.adminExecuteQueryString(sql);
	if(type.compareTo("게시판") == 0){
		%><iframe src= "boardList.jsp?selectedID=<%=selectedID%>" name="menu" width="960px"  height="800px" frameborder="0" noresize scrolling = "no"></iframe><% 
	}
	else if(type.compareTo("고정") == 0){
		%><iframe src= "staticPage.jsp?selectedID=<%=selectedID%>" name="menu" width="960px"  height="800px" frameborder="0" noresize scrolling = "no"></iframe><% 
	}
	else if(type.compareTo("링크") == 0){
		sql = "select url from link where id = " + selectedID ;
	  	String url = adminManager.adminExecuteQueryString(sql);
		%><iframe src= "<%=url%>" name="menu" width="960px"  height="800px" frameborder="0" noresize scrolling = "no"></iframe><% 
	}
	else{
		%><iframe src= "boardList.jsp?selectedID=0" name="menu" width="960px"  height="800px" frameborder="0" noresize scrolling = "no"></iframe><%
	}
  %>
</div>

<div id="footer" class="fstyle">
    <!--여기에 footer 내용이 들어갈 것. (저작권 문구 등등)-->  
<div id="footer" class="fstyle" >copyright@Web Site Builder Devteam.</div>
</div>
</div>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"./SpryAssets/SpryMenuBarDownHover.gif", imgRight:"./SpryAssets/SpryMenuBarRightHover.gif"});
</script>
</body>
</html>

