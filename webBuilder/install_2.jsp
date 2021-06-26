<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
    
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" /> 

 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>웹사이트 빌더 관리자 정보</title>
<link href="style.css" rel="stylesheet" type="text/css">
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
    <li id="step_1">DB 설정</li>
    <li id="step_2"><A><font size="5" color = "#000099">관리자 설정</font></A></li>
    <li id="step_3">완료</li>
    </ul>
  </div>
</div>

<div id="content">

<p><font size="5">관리자 생성하기</font></p>
<p>관리자 페이지를 &nbsp; 사 용하기 위해서 계정를 생성하여야합니다.</p>
<p>( 생성 입력사항은 아래와 같습니다. )</p>

  <div id="TabbedPanels1" class="TabbedPanels">
    <ul class="TabbedPanelsTabGroup">
      <li class="TabbedPanelsTab" tabindex="0"> <font size="3" color = "#000099">기본 ID</font></li>
      <li class="TabbedPanelsTab" tabindex="0"> <font size="3" color = "#000099">직접 입력</font></li>
    </ul>
    <div class="TabbedPanelsContentGroup">
      <div class="TabbedPanelsContent">
        <form name="form1" method="post" action="installProc_2.jsp">
		<div style="width:300px; text-align: right; ">
		  <span id="sprytextfield8">
		  <label for="id">관리자 ID</label>
		  <input type="text" name="id" id="id" value = "admin">
		  <span class="textfieldRequiredMsg">A value is required.</span></span><br>
		  <span id="sprypassword3">
		  <label for="pwd">관리자 비밀번호</label>
		  <input type="password" name="password" id="password">
		  <span class="passwordRequiredMsg">A value is required.</span></span><br>
		  <span id="spryconfirm1">
		  <label for="conf">비밀번호 재입력</label>
		  <input type="password" name="password_2" id="password_2">
		  <span class="confirmRequiredMsg">A value is required.</span><span class="confirmInvalidMsg">The values don't match.</span></span><br>
		  <input name="" type="submit" value="확인">
		  <input name="" type="reset" value="취소">
		  </div>
		</form>
      </div>
      <div class="TabbedPanelsContent">
      	<form name="form1" method="post" action="installProc_2.jsp">
		<div style="width:300px; text-align: right; ">
		  <span id="sprytextfield8">
		  <label for="id">관리자 ID</label>
		  <input type="text" name="id" id="id">
		  <span class="textfieldRequiredMsg">A value is required.</span></span><br>
		  <span id="sprypassword3">
		  <label for="pwd">관리자 비밀번호</label>
		  <input type="password" name="password2" id="password2">
		  <span class="passwordRequiredMsg">A value is required.</span></span><br>
		  <span id="spryconfirm1">
		  <label for="conf">비밀번호 재입력</label>
		  <input type="password" name="password2_2" id="password2_2">
		  <span class="confirmRequiredMsg">A value is required.</span><span class="confirmInvalidMsg">The values don't match.</span></span><br>
		  <input name="" type="submit" value="확인">
		  <input name="" type="reset" value="취소">
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