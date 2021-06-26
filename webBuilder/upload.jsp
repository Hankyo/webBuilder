<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,
                 com.oreilly.servlet.multipart.DefaultFileRenamePolicy,
                 java.util.*" %>
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<% 
 MultipartRequest up = null;
 String path = "";
 try{
	//String appRoot = "/"; 
	//appRoot = pageContext.getServletContext().getRealPath(appRoot);
	//File file = new File("");
	//String path = file.getAbsolutePath();
	//adminManager.getLayout();
	//path = adminManager.getSkinPath();
	path = request.getRealPath("")+"/skin";
	System.out.println(path);
	String replacePath =  path.replace("\\", "/");
	
    int    size = 5*1024*1024 ; // 5메가까지 제한 넘어서면 예외발생
    up=new MultipartRequest(request, path, size, "euc-kr", new DefaultFileRenamePolicy());
    Enumeration e=up.getFileNames();  // 폼의 이름 반환
    if(e == null)        // 파일이 업로드 되지 않았을때
       response.sendRedirect("UploadFail.jsp");
  } catch(Exception e) {
       response.sendRedirect("UploadFail.jsp");
  } 
 	Enumeration  e = up.getFileNames(); e.hasMoreElements() ;
 	String strName = (String) e.nextElement();
 	 String fileName= up.getFilesystemName(strName);
	 int i = -1;
	       i = fileName.lastIndexOf("."); // 파일 확장자 위치
	       String realFileName = "banner" + fileName.substring(i, fileName.length());  //현재시간과 확장자 합치기
	       
	 File f = new File(path + "/" + realFileName); 
	 if (f.exists() && f.isFile()) f.delete(); 

	 File oldFile = new File(path + "/" + fileName);
	 File newFile = new File(path + "/" + realFileName); 
	 
	 oldFile.renameTo(newFile); // 파일명 변경 
	 f = new File(path + "/" + fileName); 
	 if (f.exists() && f.isFile()) f.delete(); 
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파일 업로드 결과</title>
</head>
<body>

<div align="center"><H1>다중파일 업로드 결과</H1>
<br>

<TABLE align=center border=1>
   <TR><td>파일명</td>
       <td>
<%  
    fileName = "";
    for ( e = up.getFileNames(); e.hasMoreElements() ;) {
         strName = (String) e.nextElement();
         fileName= up.getFilesystemName(strName);
         
         StringTokenizer tokenizer = new StringTokenizer(fileName, "."); // 구분자를 공백으로 설정
         tokenizer.nextToken();
		 String fileType = tokenizer.nextToken();
         
         if (fileName != null) {
             out.print  (new String (fileName.getBytes("8859_1"),"euc-kr" ) );
             out.println("<br>");
         }
    }
%>
     </td></TR>
</TABLE>

</body>
</html>