<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<title>�Խ��� : �Խù� �ۼ�</title>
	<% request.setCharacterEncoding("EUC-KR"); %>
	</head>
	<script type="text/javascript">
	function check(){
		if(document.boardForm.title.value.length == 0){
			alert("������ �Է����ּ���");
			document.boardForm.title.focus();
		}
		else if(document.boardForm.name.value.length == 0){
			alert("�̸��� �Է����ּ���");
			document.boardForm.name.focus();
		}
		else if(document.boardForm.passwd.value.length == 0){
			alert("��й�ȣ�� �Է����ּ���");
			document.boardForm.passwd.focus();
		}
		else{
			document.boardForm.content.value =trim(document.boardForm.content.value); 
			boardForm.submit();
		}
	}
	function trim(value){
		value = value.replace(/^\s+/, "");		//���� ���� ����
		value = value.replace(/^\s+$/g, "");	//���� ���� ����
		value = value.replace(/\n/g, "<br>");	//��ٲ�
		
		return value;
	}
	</script>
	<body>
<%@include file="./Header.jspf" %>
		<center><h1>�Խù� �ۼ�</h1>
		�׸��� ��ũ�� �ɾ��ּ���. JPG�� �˴ϴ�.<br>
		�� �Խ����� HTML Tag�� ����� �����ϰ� �ֽ��ϴ�.</center>
		<form name = "boardForm" method = post action = "./writeProcess.jsp"  enctype="multipart/form-data">
			<table width = 850 border = 0 align = "center" bgcolor = "orange">
				<tr><td width = 100 bgcolor = "orange"><center>����</center></td><td colspan = 4><input type = text size = 107 name = "title" maxlength = 200></td></tr>
				<tr><td width = 100 bgcolor = "orange"><center>�۾���</center></td><td width = 200><input type = text name = "name" maxlength = 15></td>
				<td width = 100 bgcolor = "orange"><center>��й�ȣ</center></td><td width = 200><input type = password name = "passwd" maxlength = 15></td>
				<td width = 300>��</td></tr>
				<tr><td width = 100 bgcolor = "orange"><center>�̹���</center></td><td colspan = 4>
					<input type = file name = "upfile" value = "���ε�"></td></tr>
				<tr><td colspan = 5><textarea name = "content" cols = 120 rows = 20></textarea></td></tr>
				<tr><td colspan = 5><center>
				<input type = "button" value = "Ȯ��" onClick = "check()">
				<input type = reset value = "���Է�">
				<input type = "button" value = "���" onClick = "location.href='./ListBoard.jsp'">
				</center></td></tr>
			</table>
		</form>
<%@include file = "./Foot.jspf"%>
</body>
</html>