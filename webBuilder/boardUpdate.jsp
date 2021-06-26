<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*, DataCapsuled.BoardData"%>
<%@page import="java.sql.*" %>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="boardManager" class="manager.BoardManager" scope="page" />
<jsp:useBean id="editData" class="DataCapsuled.BoardData" scope="page" />

<%
	String boardName = (String)request.getParameter("boardName");
	StringTokenizer tokens = new StringTokenizer(boardName,"_");
	tokens.nextToken();
	String selectedID = tokens.nextToken();
	String sql = "select name from content where id ='" + selectedID + "'";
	String contentName = adminManager.adminExecuteQueryString(sql);

	int num = Integer.parseInt((String)request.getParameter("num"));
	String currentPage = (String)request.getParameter("page");

	String flag = "false";
	flag = (request.getParameter("flag") == null) ? "false" : request.getParameter("flag");
	if(flag.equals("true")) {
		boardManager.setSuccess(true);
	}

	String password = new String();
	password = request.getParameter("password");
	String noticePassword = boardManager.getPassword(boardName, num);
	if(password != null && (password.trim()).equals(noticePassword))
		boardManager.setSuccess(true);
	
	adminManager.getConnectDB();
	String dbURL = adminManager.getUrl();
	String connectID = adminManager.getID();
	String dbPassword = adminManager.getPassword();
	if(dbURL.compareTo("") == 0 || connectID.compareTo("") == 0 || dbPassword.compareTo("") == 0)
	{
		%> 디비가 올바른 설정이 아닙니다.  
		 <form action="./install/install_1.jsp" method="post">
		 	<input type="submit" value="돌아가기" name="B3"></p>
		 </form>
		 <%
	}
	
	String replaceContent = "";
	Connection con = null;
    Statement stmt = null;
    String driverName = "com.mysql.jdbc.Driver";
    
	request.setCharacterEncoding("UTF-8");
	Class.forName(driverName);
    con = DriverManager.getConnection(dbURL, connectID, dbPassword);
%>
<html><head><title><%=contentName%> Board</title>
<script type="text/javascript" src="./js/HuskyEZCreator.js" charset="UTF-8"></script>
</head><body>
	<h3><%=contentName%> 게시판</h3><hr>
<%
	if(boardManager.getSuccess()) {
		boardManager.setSuccess(false);
		BoardData boardData = boardManager.getNotice(boardName, num);
		// 여기가 받는부분
		String content =  boardData.getContent();
		replaceContent =  content.replace("\"", "\\\"");
		replaceContent =  replaceContent.replace("/", "\\/");
%>
	<form name="write" method="post" action="boardUpdateProc.jsp?boardName=<%=boardName%>">
		<input type="hidden" name="flag" value="true">
		<input type="hidden" name="num" value="<%=boardData.getNum()%>">
		<input type="hidden" name="page" value="<%=currentPage%>">
		<input type="hidden" name="selectedID" value="<%=selectedID%>">
		이름 : <input type="text" name="name" size="16" value="<%=boardData.getName()%>"><br>
		비밀번호 : <input type="password" name="password" value="<%=boardData.getPassword()%>"><br>
		제목 : <input type="text" name="subject" size="50" value="<%=boardData.getSubject()%>"><br>
		내용 : <textarea name="updateContent" id="ir1" rows="10" cols="100" style="width:766px; height:412px; display:none;"></textarea><br>
		<input type="submit" onclick="submitContents(this);" value="수정하기">
	</form>
<%
		request.setCharacterEncoding("UTF-8");
		editData.setNum(num);				
		editData.setName(request.getParameter("name"));
		editData.setSubject(request.getParameter("subject"));
		editData.setContent(request.getParameter("updateContent"));
		if(flag.equals("true")){
			sql = "update " + boardName + " set name='" + editData.getName();
			sql += "', subject='" + editData.getSubject() + "', content='" + editData.getContent();
			sql += "' where num=" + editData.getNum();
			
			stmt = con.createStatement();
			stmt.execute("SET CHARACTER SET euckr");
			stmt.execute("set names euckr");
			stmt.executeUpdate(sql);
			boardManager.setSuccess(true);
			
			if(boardManager.getSuccess()) {
				boardManager.setSuccess(false);
				response.sendRedirect("boardList.jsp?selectedID=" + selectedID + "&page=" + currentPage);
			} else {
				out.println("<script>alert('글이 수정되지않았습니다');</script>");
				response.sendRedirect("boardRead.jsp?boardName=" + boardName + "&page=" + currentPage + "&num=" + ((String)request.getParameter("num")));
			}
		}
	} else {
%>
	<form name="chkPass" method="post" action="boardUpdate.jsp?boardName=<%=boardName%>&num=<%=num%>&page=<%=currentPage%>">
		글을 수정하려면 비밀번호 확인이 필요합니다.<br>
		<input type="password" name="password"><input type="submit" value="확인">
	</form>
<%
	}
%>

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