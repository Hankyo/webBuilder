<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.*, com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판 : 게시물 작성</title>
</head>
<body>
<%@include file = "./Header.jspf" %>
	<% request.setCharacterEncoding("EUC-KR"); %>
	<jsp:useBean id = "info" class = "board.boardEntity" />
	<jsp:useBean id = "process" class = "board.boardDB" />
	<%
		String path= getServletContext().getRealPath("/file"); 
	 	int fileSize= 5 * 1024 * 1024 ;  
	 	String message = null; 
		try{
	 	    MultipartRequest multi=new MultipartRequest(request, path, fileSize, "euc-kr", new DefaultFileRenamePolicy());
			Enumeration formNames=multi.getFileNames();  
			String formName=(String)formNames.nextElement(); 
			String fileName=multi.getFilesystemName(formName); 
	 	    
			info.setTitle(multi.getParameter("title"));
			info.setName(multi.getParameter("name"));
			info.setPasswd(multi.getParameter("passwd"));
			info.setName(multi.getParameter("name"));
			info.setContent(multi.getParameter("content"));
	 	   
	 	    if(fileName != null) {   
	 	        message = fileName;
				info.setLink("./file/" + message);
	 	    } else { 
	 	        message = " ";
	 	       info.setLink(message);
	 	    } 
	 	 }
	 	 catch(Exception e) {
			message = " ";
			info.setLink(message);
	 	    e.printStackTrace();
	 	 }
	%>
	<center>
	<% 	if(process.insertDB(info)){
			out.println("게시물을 성공적으로 등재하였습니다.");
		}
		else{
			out.println("게시물을 등재하지 못하였습니다.");
		}
		%>
	<a href = "./ListBoard.jsp"><h3>목록으로</h3></a></center>
<%@include file = "./Foot.jspf" %>
</html>
