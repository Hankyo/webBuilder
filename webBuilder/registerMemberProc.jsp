<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DataEntity.UserData,java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*"%>
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="userManager" class="manager.UserManager" scope="page" />

<!DOCTYPE HTML>
<html>
 <head>
  <meta charset="UTF-8" />
  <title>***** Frontiers Story *****</title>
  <script src = "./common/common.js"></script>
  <script src = "./common/registerMember.js"></script>
  <link rel="stylesheet" type="text/css" href="common/reset.css" />
  <link rel="stylesheet" type="text/css" href="common/layout_l.css" /> 
  <!--[if gte IE 7]>
  		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
  		<script src="js/IE8.js"></script>
  <![endif]-->
 </head>
  <%@ include file = "./Header.jspf" %>  
  
      <!-- contentsMain Start -->
      <div id="contentsMain" >
        <h2 class="titleBg"><span>회원 가입 페이지</span></h2>
        <%
	    // 세션이 없으면 Login Process.
	    request.setCharacterEncoding("UTF-8");
		String user_id = request.getParameter("userid");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String force = request.getParameter("axis");
		String master = request.getParameter("master");
		
		boolean check = userManager.existUser(user_id);
		if( check ){
			 %> 해당 아이디가 존재합니다.  
			 <form action="index.jsp" method="post">
			 	<input type="submit" value="돌아가기" name="B3"></p>
			 </form>
			 <%
		}
		else{	
			UserData userData = new UserData();
			userData.setID(user_id);
			userData.setPassword(password);
			userData.setEmail(email);
			userData.setForce(force);
			userData.setMasterCard(Integer.parseInt(master));
			userData.setRating(100);
			userData.setWin(0);
			userData.setLose(0);
			userData.setGold(5000);
			userData.setRecent_battle(new Timestamp(System.currentTimeMillis()));
			
			boolean success = userManager.insertUser(userData);
			if(!success){
				%> 해당 아이디 생성에 실패하였습니다.
				<form action="index.jsp" method="post">
				 	<input type="submit" value="돌아가기" name="B3"></p>
				</form>
				<%
			}
			
			// 신규소지카드를 등록
			boolean success2 = userManager.insertCardOwning(user_id, 15);
			if(!success2){
				%> 신규 소지카드 등록에 실패하였습니다.
				<form action="index.jsp" method="post">
				 	<input type="submit" value="돌아가기" name="B3"></p>
				</form>
				<%
			}
				
			if(success && success2){
			%>
			<form name="write" method="post" action="index.jsp">
				<p>입력하신 사항으로 아디가 생성되었습니다.</p>
				<input type="submit" value="메인으로">
			</form>   
			<%} 
			
		}%> 
      </div>
      <!-- contentsMain End --> 
      
  <%@ include file = "./Foot.jspf" %>
</html>