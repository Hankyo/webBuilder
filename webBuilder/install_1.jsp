<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Web site Builder Application 설치</title>
<link href="./style.css" rel="stylesheet" type="text/css">
<link href="./SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css">
<link href="./SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css">
<link href="./SpryAssets/SpryValidationPassword.css" rel="stylesheet" type="text/css">
<link href="./SpryAssets/SpryValidationConfirm.css" rel="stylesheet" type="text/css">
<script src="./SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<script src="./SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<script src="./SpryAssets/SpryValidationPassword.js" type="text/javascript"></script>
<script src="./SpryAssets/SpryValidationConfirm.js" type="text/javascript"></script>

</head>
<body bgcolor="#DDDDDD">
 
<div id="container">
<!--배너 부분-->
<p><font size="6" color = "#000099">Web site Builder Application 설치</font></p>

<div class="menu">


</div>

<!--왼쪽 부분-->
<div id="leftSide" class="leftBanner">
  <!--왼쪽 타이틀 부분-->
  <div id="title">설치마법사</div>

  <div id="info">
    <ul >
    <li id="step_1"><A><font size="5" color = "#000099">DB 설정</font></A></li>
    <li id="step_2">관리자 설정</li>
    <li id="step_3">완료</li>
    </ul>
  </div>
</div>


<div id="content">

	설치하려는 PC에 DB가 함께 설치되어 있다면 첫 번째 탭을,<br>
	다른 PC에 설치되어 있다면 두 번째 탭을 선택하여 진행하시기 바랍니다.<br><br>
	<div id="TabbedPanels1" class="TabbedPanels">
    <ul class="TabbedPanelsTabGroup">
      <li class="TabbedPanelsTab" tabindex="0"><font size="3" color = "#000099">같은 PC에 DB 설치</font></li>
      <li class="TabbedPanelsTab" tabindex="0"><font size="3" color = "#000099">다른 PC에 DB 설치</font></li>
    </ul>
    <div class="TabbedPanelsContentGroup">
      <div class="TabbedPanelsContent">
      
        <form name="form1" method="post" action="./installProc_1.jsp">
          <span id="sprytextfield1">
          <label for="id">DB계정 </label>
          <input type="text" name="id" id="id" value = "root">
          <span class="textfieldRequiredMsg">A value is required.</span></span><br>
          <span id="sprypassword1">
          <label for="pwd">비밀번호</label>
          <input type="password" name="password" id="password">
          <span class="passwordRequiredMsg">A value is required.</span></span><br>
          
          <span id="sprytextfield3">
          <label for="db_name">DB이름</label>
          <input type="text" name="name" id="name" value ="webbuilder">
          <span class="textfieldRequiredMsg">A value is required.</span></span><br>
          <input name="stp_1" type="submit" value="확인">
           <input name="" type="reset" value="취소">
        </form>
      </div>
      <div class="TabbedPanelsContent">
      	<form name="form1" method="post" action="./installProc_1.jsp">
        	<div style="width: 270px; text-align: right;">
              <span id="sprytextfield4">
              <label for="a">DB계정</label>
              <input type="text" name="id2" id="id2">
            <span class="textfieldRequiredMsg">A value is required.</span></span> <br>
            <span id="sprypassword2">
            <label for="b">비밀번호</label>
            <input type="password" name="password2" id="password2">
            <span class="passwordRequiredMsg">A value is required.</span></span><br>
            <span id="sprytextfield5">
            <label for="c">DB서버 주소</label>
            <input type="text" name="host" id="host">
            <span class="textfieldRequiredMsg">A value is required.</span></span><br>
            <span id="sprytextfield6">
            <label for="d">DB서버 포트</label>
            <input type="text" name="port" id="port">
            <span class="textfieldRequiredMsg">A value is required.</span></span><br>
            <span id="sprytextfield7">
            <label for="e">DB이름</label>
            <input type="text" name="name2" id="name2">
            <span class="textfieldRequiredMsg">A value is required.</span></span><br>
            <input name="stp_1" type="submit" value="확인">
            <input id="" type="reset" value="취소">
            </div>
      	</form>
      </div>
    </div>
  </div>
   
</div>

<div id="footer" class="fstyle" >copyright@Web Site Builder Devteam.</div>
</div>
<script type="text/javascript">
//위에 주석처리 된 부분 잘 보고 아래 스프라이 위젯을 분류할것
//분류 잘못하면 예외처리 적용안됨
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
var sprytextfield2 = new Spry.Widget.ValidationTextField("sprytextfield2");
var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1");
var sprypassword1 = new Spry.Widget.ValidationPassword("sprypassword1");
var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3");
var sprytextfield4 = new Spry.Widget.ValidationTextField("sprytextfield4");
var sprypassword2 = new Spry.Widget.ValidationPassword("sprypassword2");
var sprytextfield5 = new Spry.Widget.ValidationTextField("sprytextfield5");
var sprytextfield6 = new Spry.Widget.ValidationTextField("sprytextfield6");
var sprytextfield7 = new Spry.Widget.ValidationTextField("sprytextfield7");
var sprytextfield8 = new Spry.Widget.ValidationTextField("sprytextfield8");
var sprypassword3 = new Spry.Widget.ValidationPassword("sprypassword3");
</script>

</body>
</html>
