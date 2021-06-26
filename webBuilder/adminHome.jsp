<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WebSite 관리자페이지</title>

<!--css폴더에 style.css를 복사해 넣을 것-->
<link href="./css/style.css" rel="stylesheet" type="text/css">
<link href="./css/settingCSS/SpryMenuBar.css" rel="stylesheet" type="text/css">
<script src="./css/settingCSS/SpryMenuBar.js" type="text/javascript"></script>
</head>

<body>
<%
	// 관리자 세션 확인
	int grade; 
    String id ="";
    String sql = "";
	if(session.getAttribute("id") == null)
		grade = 10;
	else{
		id = (String)session.getAttribute("id"); 
		sql = "select grade from member where user_id ='" + id +"'";
		grade = adminManager.adminExecuteQueryNum(sql);
	}
	// 세션이 없으면 로그인 페이지로 이동
	if ( grade != 0 ) 
		response.sendRedirect("login.jsp");
%>

<!--레이아웃 전체를 감싸주는 부분-->
<div id="container">
<b><a href = "index.jsp" >방문자 페이지로</a>


<div id="navi">
<!--메뉴박스 부분-->
<ul id="MenuBar1" class="MenuBarHorizontal">
  <li><a href="adminLayout.jsp" target="contents">스킨관리</a></li>
  <li><a href="adminCategory.jsp" target="contents">카테고리</a></li>
  <li><a href="adminMember.jsp" target="contents">회원관리</a></li>
</ul>
</div>
<!--본문 내용 부분-->
<div id="content">
<iframe class="ifcontents" name="contents" src="adminCategory.jsp" width="960px"  height="800px" frameborder="0" noresize scrolling = "no">

</iframe>
  <p><!-- 여기에 각종 게시판, 정적페이지를 보여줄 부분. <iframe> 태그로 보여주는게 적당함 링크는 새창으로 띄우게 할것 --></div>

<div id="footer" class="fstyle">
copyright@Website builder Devteam  
</div>
</div>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"./SprayAssets/SpryMenuBarDownHover.gif", imgRight:"./SprayAssets/SpryMenuBarRightHover.gif"});
</script>
</body>
</html>
