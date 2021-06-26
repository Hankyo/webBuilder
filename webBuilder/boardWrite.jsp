<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />

<!-- 글을 수정하거나 답변의 글을 쓰는 페이지  -->
<%
	request.setCharacterEncoding("UTF-8");
	String selectedID = request.getParameter("selectedID");
	String sql = "select name from content where id = '" + selectedID +"'";
	String boardName = adminManager.adminExecuteQueryString(sql);
	String currentPage = request.getParameter("page");
	String reply = "no";
	String ref = ""; 
	String step = "" ;
	String depth = "";
	String childCount = ""; 
	String subject="";
	String content = "";
	String contentText = "";
	String replaceContent = "";

	int num=0;

	if(request.getParameter("reply") != null && request.getParameter("reply").equals("ok")) {
		num = Integer.parseInt(request.getParameter("num"));
		reply = request.getParameter("reply");
		ref = request.getParameter("ref");
		step = request.getParameter("step");
		depth = request.getParameter("depth");
		subject = "[Re] " + request.getParameter("subject");
		content = request.getParameter("content");
	  	replaceContent =  content.replace("\"", "\\\"");
	  	replaceContent =  replaceContent.replace("/", "\\/");
	  	
		contentText = ":::::::: 원문글 ::::::::\n";
	}
%>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="./js/HuskyEZCreator.js" charset="utf-8"></script>
<title><%=boardName%> Board</title></head><body>
<% 
	sql = "select wrlevel from boardadmin where id ='" + selectedID + "'";
	int wrlevel = adminManager.adminExecuteQueryNum(sql);

	// 게시판 쓰기 권한을 확인합니다.
	int grade; 
	String id ="";
	if(session.getAttribute("id") == null)
		grade = 10;
	else{
		id = (String)session.getAttribute("id"); 
		sql = "select grade from member where user_id ='" + id +"'";
		grade = adminManager.adminExecuteQueryNum(sql);
	}
	// 세션이 없으면 로그인 페이지로 이동
	if ( grade > wrlevel ){ 
		%> 권한이 없습니다.<%}
	else{%>
	
	<h3><%=boardName%> 게시판</h3>
	<form name="write" method="post" action="boardUpload.jsp?selectedID=<%=selectedID%>" style="width:770px">
		<input type="hidden" name="selectedID" value="<%=selectedID%>">
		<input type="hidden" name="page" value="<%=currentPage%>">
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="ref" value="<%=ref%>">
		<input type="hidden" name="step" value="<%=step%>">
		<input type="hidden" name="depth" value="<%=depth%>">
		<input type="hidden" name="reply" value="<%=reply%>">
		이름 : <input type="text" name="name" size="16"><br>
		비밀번호 : <input type="password" name="password"><br>
		제목 : <input type="text" name="subject"  style="width:500px" value="<%=subject%>"><br>
		<textarea name="content" id="ir1" rows="10" cols="100" style="width:766px; height:412px; display:none;"></textarea>
	    
		<input type="submit" onclick="submitContents(this);" value="글 올리기">
	</form>
<%}%>
	
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//alert("아싸!");	
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["ir1"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	try {
		elClickedObj.form.submit();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '궁서';
	var nFontSize = 24;
	oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>
</body></html>