<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DataEntity.UserData,java.text.SimpleDateFormat" %>
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="userManager" class="manager.UserManager" scope="page" />
<%
	// User ID 값 받기
	String userid = adminManager.checkNull(request.getParameter("userid"));
	
	boolean existCheck = false; 	// 해당 레코드 카운트
	existCheck = userManager.existUser(userid);
%>

<!DOCTYPE HTML>
<html>
<head>
	<title>아이디 중복검사</title>
	<script src = "./common/registerMember.js"></script>
	<meta charset="UTF-8" />  
    <link rel="stylesheet" type="text/css" href="common/registerMember.css" />
</head>
<body>
	<!-- FORM 태크 시작 -->
	<form name="id_check" method="post" action="./userid_check.jsp">
		<input type="hidden" name="existCheck" id="existCheck" value="<%=existCheck%>">
		<h2 class="titleBg" align="center"><span>원하는 아이디를 입력하세요.</span></h2>
		
		<table width="300">
			<tr>
				<td align="center">
					<input type="text" name="userid" id="userid" value="<%=userid%>" size="16" maxlength="10">
					<input type="button" id="btnOriginal" value="중복확인" onClick="doCheck()">
				</td>
			</tr>
			<tr>
				<td>
				<% if(existCheck) {%>
					<p align="center"> ▶[<%=userid%>]은 등록되어있는 아이디입니다.<br>▷ 다시 시도해주십시오. </p>
				<%} else { %>
					<p align="center"> ▷[<%=userid%>]은 사용 가능합니다. </p>
					<table width="100%">
						<tr>
							<td align="center">
								<p class="btnRow">
									<input type="button" id="btnSubmit" value="확인" onClick="checkEnd();" style="cursor:pointer">
								</p>
							</td>
						</tr>
					</table>
				<%}%>
				</td>
			</tr>
		</table>
	</form>
	<!-- FORM 태크 끝 -->
</body>
</html>