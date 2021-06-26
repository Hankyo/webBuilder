<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<%
	request.setCharacterEncoding("UTF-8");
	String selectedID = request.getParameter("selectedID");
	if(selectedID == null || selectedID.compareTo("") == 0)
		response.sendRedirect("./adminCategory.jsp");
	
	String boardName = "board_" + selectedID; 
	String sql = "select name from content where id ='" + selectedID + "'";
	String contentName = adminManager.adminExecuteQueryString(sql);
	sql = "select descriptor from content where id ='" + selectedID + "'";
	String descriptor = adminManager.adminExecuteQueryString(sql);
	sql = "select type from content where id ='" + selectedID + "'";
	String type = adminManager.adminExecuteQueryString(sql);
	
	sql = "select content from static where id ='" + selectedID + "'";
  	String content = adminManager.adminExecuteQueryString(sql); 
  	String replaceContent =  content.replace("\"", "\\\"");
  	replaceContent =  replaceContent.replace("/", "\\/");
%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>Untitled Document</title>
<script src="SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<script type="text/javascript" src="./js/HuskyEZCreator.js" charset="utf-8"></script>
<link href="SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css">

<title>Insert title here</title>
</head><body>
<p><%=contentName%>수정</p>
<p>&nbsp;</p>
<form name="form1" method="post" action="Config_Proc.jsp">
  <span id="sprytextfield1">
  <label for="name">이름 : </label>
  <input type="text" name="name" id="name" value = <%=contentName%>>
  
  <span class="textfieldRequiredMsg">A value is required.</span></span>
  <p><span id="sprytextfield2">
    <label for="desc">설명 : </label>
    <input type="text" name="desc" id="desc" value = <%=descriptor%>>
    
    <span class="textfieldRequiredMsg">A value is required.</span></span></p>
    <p>
    <input type="hidden" name="selectedID" value="<%=selectedID%>">
    <input type="hidden" name="type" value="<%=type%>">
    
    <% if(type.compareTo("고정") == 0) { %>
    	<textarea name="ir1" id="ir1" rows="10" cols="100" style="width:766px; height:412px; display:none;"></textarea><br/>
        <input name="submit" value="수정" type="submit" onClick="submitContents(this)">
    <%}
    else if(type.compareTo("링크") == 0) { %>
    <%
        sql = "select url from link where id ='" + selectedID + "'";
	  	String url = adminManager.adminExecuteQueryString(sql);
	%>
      <span id="sprytextfield3">
      <label for="url">외부URL : </label>
      <input type="text" name="url" id="url" value = <%=url%>>
      <span class="textfieldRequiredMsg">A value is required.</span></span></p>
    <p>
      <input name="submit" value="수정" type="submit">
    <%}
    else if(type.compareTo("게시판") == 0) { %>
	  <% 
	  	sql = "select wrlevel from boardadmin where id ='" + selectedID + "'";
	  	String wrlevel = adminManager.adminExecuteQueryString(sql);
	  	sql = "select rdlevel from boardadmin where id ='" + selectedID + "'";
		String rdlevel = adminManager.adminExecuteQueryString(sql);
		sql = "select lstlevel from boardadmin where id ='" + selectedID + "'";
		String lstlevel = adminManager.adminExecuteQueryString(sql);
		int i_wrlevel = Integer.parseInt(wrlevel);
		int i_rdlevel = Integer.parseInt(rdlevel);
		int i_lstlevel = Integer.parseInt(lstlevel);
	  %>
				
      <label for="url">쓰기 권한 : </label>
      <select name=wrLevel id=type >
      <% for (int i = 0; i< 10; i ++) {
      		if(i_wrlevel == i){ %>
  				<option value=<%=i%> selected><%=i%>
  			<%}else 
  			{%>
  				<option value=<%=i%>><%=i%>
  			<%}
	  }%>
	  </select>
      <label for="url">읽기 권한 : </label>
      <select name=rdLevel id=type >
      <% for (int i = 0; i< 10; i ++) {
      		if(i_rdlevel == i){ %>
  				<option value=<%=i%> selected><%=i%>
  			<%}else 
  			{%>
  				<option value=<%=i%>><%=i%>
  			<%}
	  }%>
	  </select>
      <label for="url">목록 권한 : </label>
      <select name=lstLevel id=type >
      <% for (int i = 0; i< 10; i ++) {
      		if(i_lstlevel == i){ %>
  				<option value=<%=i%> selected><%=i%>
  			<%}else 
  			{%>
  				<option value=<%=i%>><%=i%>
  			<%}
	  }%>
	    	 </select>
      <p>
      <input name="submit" value="수정" type="submit">
      </p>
<%}%>
 
</form>

<script type="text/javascript">
var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1");
var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2");
</script>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
		}
	}, //boolean
	fOnAppLoad : function(){
		var content = "<%=replaceContent%>";
		oEditors.getById["ir1"].exec("PASTE_HTML", [content]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "";
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
var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3");
</script>

</body>
</html>