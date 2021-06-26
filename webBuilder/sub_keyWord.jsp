<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="DataEntity.BoardData,java.text.SimpleDateFormat" %>
<%@page import="java.util.*"%>
<jsp:useBean id="boardManager" class="manager.BoardManager" scope="page"/>

<!DOCTYPE HTML>
<html>
 <head>
  <title>***** Frontiers Story *****</title>
  <script src = "./common/common.js"></script>
  <meta charset="UTF-8" /> 
  <link rel="stylesheet" type="text/css" href="./common/reset.css" />
  <link rel="stylesheet" type="text/css" href="./common/boardTable.css" />
  <link rel="stylesheet" type="text/css" href="./common/layout_l.css" />
  <!--[if gte IE 7]>
  		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
 </head>
 
 <%@ include file = "./Header.jspf" %>
    <!-- contentsMain Start -->
    <div id="contentsMain" >
    	서비스 준비 중입니다.
    </div>
    <!-- contentsMain End --> 

 <%@ include file = "./Foot.jspf" %>
</html>