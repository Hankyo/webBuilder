<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>스킨관리</title>
<script src="SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<script src="SpryAssets/SpryValidationSelect.js" type="text/javascript"></script>
<link href="SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css">
<link href="SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css">
</head>

<body>
<div id="TabbedPanels1" class="TabbedPanels">
  <ul class="TabbedPanelsTabGroup">
    <li class="TabbedPanelsTab" tabindex="0">스킨선택</li>
  </ul>
  <div class="TabbedPanelsContentGroup">
    <div class="TabbedPanelsContent">
      <form name="form1" method="post" action="adminLayout.jsp">
        <span id="spryselect1">
          스킨선택 :
          <select name="skin" id="select1">
          <!--http://czar.tistory.com/64 참고해서 /skins 폴더 내의 디렉토리 목록을 가져올것-->
          <%
            String skinID = (String)request.getParameter("skin");
			if (skinID == null || skinID.compareTo("-1") == 0)
				skinID = "-1";
			int selectedID = Integer.parseInt(skinID);
			
			String[] fileList
					= {"horizontal_black_style", "horizontal_blue_style",
					"vertical_black_style", "vertical_blue_style"};
			for(int i = 0; i < fileList.length ; i++){
		  %>
		  <option value = <%=i %>><%=fileList[i] %>
		  <%} %>
		  </select><p>
          <!--http://shonm.tistory.com/category/JAVA/%ED%8F%B4%EB%8D%94%20%EB%B3%B5%EC%82%AC 에 들어가서 해당 폴더 내용 복사하게 할것-->
          <%
          if( selectedID != -1){
				 // 레이아웃 정보 파일에 저장
				 String MyFile =  "./layout.txt";  // 사용중인 디렉토리 위치에 맞게 고쳐줌
				 FileWriter writeFile = new FileWriter(MyFile); //인자가 true이면 append가 됨. 인자가 없으면 덮어씌우기
				 
				 //skin directory path
				 writeFile.write("./skin/" + fileList[selectedID] + " ");
				 //verticle horizen check
				 writeFile.write(fileList[selectedID] + " ");
				 writeFile.close();
			}%>
          <input type="submit" value="확인">
          <input type="reset" value="취소">
          <span class="selectRequiredMsg">Please select an item.</span></span>
      </form>
    </div>
    <div class="TabbedPanelsContent">
    <!--http://warmz.tistory.com/731 에 들어가서 멀티파트 업로드 참고하고-->
    <!--http://lonelycat.tistory.com/455 에 들어가서 java zip파일 압축풀기 참고-->   
    
      <form name="form2" enctype="multipart/form-data" method="post" action="upload.jsp">
        <label for="fileField"></label>
        <input type="file" name="fileField" id="fileField"><br>
        <input type="submit" value="업로드">
      </form>

    </div>
  </div>
</div>
<script type="text/javascript">
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1");
</script>
</body>
</html>
