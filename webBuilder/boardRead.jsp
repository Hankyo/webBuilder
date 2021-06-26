<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*, DataCapsuled.BoardData"%>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="boardManager" class="manager.BoardManager" scope="page" />

<%
	String search ="";
	String text ="";
	//게시판 글 목록 보여주기
	String currentPage = request.getParameter("page");
	String boardName = request.getParameter("boardName");
	StringTokenizer tokens = new StringTokenizer(boardName,"_");
	tokens.nextToken();
	String selectedID = tokens.nextToken();
	String sql = "select name from content where id ='" + selectedID + "'";
	String contentName = adminManager.adminExecuteQueryString(sql);
	
	int num = Integer.parseInt(request.getParameter("num"));
	if(request.getParameter("text") != null ) {
		search = request.getParameter("search");
		text = request.getParameter("text");
	}

	BoardData boardData = boardManager.getNotice(boardName, num);
	int[] MaxMin = boardManager.getNextPrevNum(boardName, num);

	//이전/다음페이지 저장했다가 다음이나 이전버튼 누르면 해당 목록 보여주기
	BoardData pre_data;
	BoardData next_data;

	//이전/다음 페이지 보여주는 분기문
	if(MaxMin[0] <= 0 && MaxMin[1] <= 0) {
		pre_data = null;
		next_data = null;
	} else if(MaxMin[0] <= 0) {
		pre_data = boardManager.getNotice(boardName,MaxMin[1]);
		next_data = null;
	} else if(MaxMin[1] <= 0) {
		pre_data = null;
		next_data = boardManager.getNotice(boardName,MaxMin[0]);
	} else {
		pre_data = boardManager.getNotice(boardName,MaxMin[1]);
		next_data = boardManager.getNotice(boardName,MaxMin[0]);
	}
	
	//이전/이후페이지 갯수보여주는 부분
	boardManager.increaseCnt(boardName, num);
	
	String content = boardData.getContent();
	String replaceContent =  content.replace("\"", "\\\"");
	replaceContent =  replaceContent.replace("/", "\\/");
%>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="./js/HuskyEZCreator.js" charset="utf-8"></script>
<title><%=contentName%> Board</title></head><body>

<% 
	sql = "select rdlevel from boardadmin where id ='" + selectedID + "'";
	int rdlevel = adminManager.adminExecuteQueryNum(sql);
	// 세션 확인
	int grade; 
	String id ="";
	if(session.getAttribute("id") == null)
		grade = 10;
	else{
		id = (String)session.getAttribute("id"); 
		sql = "select grade from member where user_id ='" + id +"'";
		grade = adminManager.adminExecuteQueryNum(sql);
	}
	// 읽기권한 확인
	if ( grade > rdlevel ){ 
		%> 권한이 없습니다.<%}
	else{%>
	
	<h3><%=contentName%> 게시판</h3><hr>

	<form name="replyForm" method="post" action="boardWrite.jsp?boardName=<%=boardName%>" >
	
	<table width=800 border=0 cellpadding=1 cellspacing=3 >
	<tr> 
		<td align=left><input type="hidden" name="subject" value="<%=boardData.getSubject()%>">
		<input type="hidden" name="num" value="<%=boardData.getNum()%>">
		<input type="hidden" name="page" value="<%=currentPage%>">
		<input type="hidden" name="reply" value="ok">
		<input type="hidden" name="ref" value="<%=boardData.getRef()%>">
		<input type="hidden" name="step" value="<%=boardData.getStep()%>">
		<input type="hidden" name="depth" value="<%=boardData.getDepth()%>">
		제목 : <%=boardData.getSubject()%><br>
		작성자 : <%=boardData.getName()%><br>
		조회수 : <%=boardData.getCount()%><br>
		작성일 : <%=boardData.getDate()%><br>
		<%=content %>
	</tr></table>
	<br><hr>
    
<%
	if(MaxMin[1] != 0) {
%>
		이전 글 : <a href="boardRead.jsp?boardName=<%=boardName%>&num=<%=MaxMin[1]%>&page=<%=currentPage%>"><%=pre_data.getSubject()%></a><br>
<%
	} else {
%>
		이전 글이 없습니다.<br>
<%
	}
	if(MaxMin[0] != 0) {
%>
		다음 글 : <a href="boardRead.jsp?boardName=<%=boardName%>&num=<%=MaxMin[0]%>&page=<%=currentPage%>"><%=next_data.getSubject()%></a><br>
<%
	} else {
%>
		다음 글이 없습니다.<br>
<%
	}
%>
		<hr><a href="javascript:document.replyForm.submit()">답변</a> | 
		<a href="boardUpdate.jsp?boardName=<%=boardName%>&num=<%=boardData.getNum()%>&page=<%=currentPage%>">수정</a> | 
		<a href="boardDelete.jsp?boardName=<%=boardName%>&num=<%=boardData.getNum()%>&page=<%=currentPage%>">삭제</a> | 
		<a href="boardList.jsp?selectedID=<%=selectedID%>&page=<%=currentPage%>&search=<%=search%>&text=<%=text%>">목록</a> | 
		<a href="boardWrite.jsp?selectedID=<%=selectedID%>">글쓰기</a>
		</form>
<% }%>
		
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
		var content = "<%=replaceContent%>";
		oEditors.getById["ir1"].exec("PASTE_HTML", [content]);
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
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
	
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