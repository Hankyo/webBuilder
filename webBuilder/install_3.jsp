<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Web site Builder Application 설치</title>
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
    <li id="step_2">관리자 설정</li>
    <li id="step_3"><A><font size="5" color = "#000099">완료</A></li>
    </ul>
  </div>
</div>

<div id="content">

<form name="write" method="post" action="../login.jsp">
	<p>입력하신 사항으로 관리자가 생성되었습니다.</p>
	<input type="submit" value="로그인 페이지 이동">
</form>   

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