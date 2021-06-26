<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>회원 가입 페이지</title>
	</head>
	<body>
		<form action="joinMemberProc.jsp" method="post">
		<table border="0" cellpadding="3" cellspacing="1" bgcolor="#6CAEFC" align="center">
			<tr>
				<td bgcolor="#B6CFF1" colspan="2" align="center">
					<b>회원 기본 정보</b>
				</td>
			</tr>
			<tr>
				<td bgcolor="#EAEAEA" align="center"><b>아이디:</b></td>
				<td bgcolor="#FFFFFF">
					<input type="text" name="id" size="15">
					4~12자의 영문 대소문자와 숫자로만 입력
				</td>
			</tr>
			<tr>
				<td bgcolor="#EAEAEA" align="center"><b>비밀번호:</b></td>
				<td bgcolor="#FFFFFF">
					<input type="password" name="password" size="15">
					4~12자의 영문 대소문자와 숫자로만 입력
				</td>
			</tr>
			<tr>
				<td bgcolor="#EAEAEA" align="center"><b>비밀번호확인:</b></td>
				<td bgcolor="#FFFFFF">
					<input type="password" name="password2" size="15">
				</td>
			</tr>
		</table><br>
		<center>
			<input type="submit" value="회원 가입">
			<input type="reset" value="다시 입력">
		</center>
		</form>
	</body>
</html>