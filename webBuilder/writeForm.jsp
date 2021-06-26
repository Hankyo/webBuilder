<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<title>게시판 : 게시물 작성</title>
	<% request.setCharacterEncoding("EUC-KR"); %>
	</head>
	<script type="text/javascript">
	function check(){
		if(document.boardForm.title.value.length == 0){
			alert("제목을 입력해주세요");
			document.boardForm.title.focus();
		}
		else if(document.boardForm.name.value.length == 0){
			alert("이름을 입력해주세요");
			document.boardForm.name.focus();
		}
		else if(document.boardForm.passwd.value.length == 0){
			alert("비밀번호를 입력해주세요");
			document.boardForm.passwd.focus();
		}
		else{
			document.boardForm.content.value =trim(document.boardForm.content.value); 
			boardForm.submit();
		}
	}
	function trim(value){
		value = value.replace(/^\s+/, "");		//좌측 공백 제거
		value = value.replace(/^\s+$/g, "");	//우측 공백 제거
		value = value.replace(/\n/g, "<br>");	//행바꿈
		
		return value;
	}
	</script>
	<body>
<%@include file="./Header.jspf" %>
		<center><h1>게시물 작성</h1>
		그림은 링크만 걸어주세요. JPG만 됩니다.<br>
		본 게시판은 HTML Tag의 사용을 권장하고 있습니다.</center>
		<form name = "boardForm" method = post action = "./writeProcess.jsp"  enctype="multipart/form-data">
			<table width = 850 border = 0 align = "center" bgcolor = "orange">
				<tr><td width = 100 bgcolor = "orange"><center>제목</center></td><td colspan = 4><input type = text size = 107 name = "title" maxlength = 200></td></tr>
				<tr><td width = 100 bgcolor = "orange"><center>글쓴이</center></td><td width = 200><input type = text name = "name" maxlength = 15></td>
				<td width = 100 bgcolor = "orange"><center>비밀번호</center></td><td width = 200><input type = password name = "passwd" maxlength = 15></td>
				<td width = 300>　</td></tr>
				<tr><td width = 100 bgcolor = "orange"><center>이미지</center></td><td colspan = 4>
					<input type = file name = "upfile" value = "업로드"></td></tr>
				<tr><td colspan = 5><textarea name = "content" cols = 120 rows = 20></textarea></td></tr>
				<tr><td colspan = 5><center>
				<input type = "button" value = "확인" onClick = "check()">
				<input type = reset value = "재입력">
				<input type = "button" value = "목록" onClick = "location.href='./ListBoard.jsp'">
				</center></td></tr>
			</table>
		</form>
<%@include file = "./Foot.jspf"%>
</body>
</html>