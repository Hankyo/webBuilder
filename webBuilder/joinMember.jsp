<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>ȸ�� ���� ������</title>
	</head>
	<body>
		<form action="joinMemberProc.jsp" method="post">
		<table border="0" cellpadding="3" cellspacing="1" bgcolor="#6CAEFC" align="center">
			<tr>
				<td bgcolor="#B6CFF1" colspan="2" align="center">
					<b>ȸ�� �⺻ ����</b>
				</td>
			</tr>
			<tr>
				<td bgcolor="#EAEAEA" align="center"><b>���̵�:</b></td>
				<td bgcolor="#FFFFFF">
					<input type="text" name="id" size="15">
					4~12���� ���� ��ҹ��ڿ� ���ڷθ� �Է�
				</td>
			</tr>
			<tr>
				<td bgcolor="#EAEAEA" align="center"><b>��й�ȣ:</b></td>
				<td bgcolor="#FFFFFF">
					<input type="password" name="password" size="15">
					4~12���� ���� ��ҹ��ڿ� ���ڷθ� �Է�
				</td>
			</tr>
			<tr>
				<td bgcolor="#EAEAEA" align="center"><b>��й�ȣȮ��:</b></td>
				<td bgcolor="#FFFFFF">
					<input type="password" name="password2" size="15">
				</td>
			</tr>
		</table><br>
		<center>
			<input type="submit" value="ȸ�� ����">
			<input type="reset" value="�ٽ� �Է�">
		</center>
		</form>
	</body>
</html>