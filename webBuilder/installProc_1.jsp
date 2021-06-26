<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
    
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
//전 페이지에서 정보 받음
String id = request.getParameter("id");
String password = request.getParameter("password");
String name = request.getParameter("name");
String url = null;
String port = request.getParameter("port");
String host = request.getParameter("host");
String sql = null;

if(id == null || password == null)
{
	%> 데이터베이스 설정이 올바르지 않습니다.  
	 <form action="install_1.jsp" method="post">
	 	<input type="submit" value="돌아가기" name="B3"></p>
	 </form>
	 <%
}

if( host == null){
    url = "jdbc:mysql://localhost:3306"+ "/"+ name;
}
else{	
	url = "jdbc:mysql://"+ host + ":"+ port + "/"+ name;
}
 
// 웹사이트 빌더 기초 테이블 생성

String dbURL = url;
String connectID = id;
String dbPassword = password;

//Database 설정정보 파일에 저장
File path = new File("");
String MyFile =  "./dbConfig.txt";  // 사용중인 디렉토리 위치에 맞게 고쳐줌
FileWriter writeFile = new FileWriter(MyFile); //인자가 true이면 append가 됨. 인자가 없으면 덮어씌우기

writeFile.write(url + " ");
writeFile.write(id + " ");
writeFile.write(password + " ");
writeFile.close();

//Layout 기초설정 파일에 저장
path = new File("");
MyFile =  "./layout.txt";
writeFile = new FileWriter(MyFile); //인자가 true이면 append가 됨. 인자가 없으면 덮어씌우기

//skin directory path
writeFile.write("./skin/" + "horizontal_black_style" + " ");
//verticle horizen check
writeFile.write("horizontal_black_style" + " ");
writeFile.close();

adminManager.getConnectDB();

sql = "CREATE  TABLE `category` (" ;          
	sql += " `name` VARCHAR(45) NOT NULL ,";
	sql += " `step` INT NOT NULL ,";
	sql += "  PRIMARY KEY (`name`) ";
	sql += ")DEFAULT CHARSET=euckr";
adminManager.adminExecuteUpdate(sql);
sql = " CREATE  TABLE `content` (" ;          
	sql += " `id` INT NOT NULL ,";
	sql += " `category_id` INT NOT NULL,";
	sql += " `name` VARCHAR(45) NULL ,";
	sql += "  `descriptor` TEXT NULL ,";
	sql += "  `type` TEXT NULL ,";
	sql += "  PRIMARY KEY (`id`) ";
	sql += ")DEFAULT CHARSET=euckr";
adminManager.adminExecuteUpdate(sql);
sql = " CREATE  TABLE `BoardAdmin` (" ;          
	sql += "  `id` INT NOT NULL ,";
	sql += "  `rdlevel` INT NULL ,";
	sql += "  `wrlevel` INT NULL ,";
	sql += " `lstlevel` INT NULL ,";
	sql += " PRIMARY KEY (`id`)";
	sql += ")DEFAULT CHARSET=euckr";
adminManager.adminExecuteUpdate(sql);
sql = " CREATE  TABLE `link` (" ;          
	sql += "  `id` 	     INT NOT NULL ,";
	sql += "  `url`     TEXT NULL ,";
	sql += "  PRIMARY KEY (`id`)";
	sql += ")DEFAULT CHARSET=euckr";
adminManager.adminExecuteUpdate(sql);
sql = " CREATE  TABLE `static` (" ;          
	sql += "  `id`      INT NOT NULL ,";
	sql += "  `content` TEXT NULL ,";
	sql += "  PRIMARY KEY (`id`) ";
	sql += ")DEFAULT CHARSET=euckr";
adminManager.adminExecuteUpdate(sql);	 
sql = " CREATE  TABLE `member` (" ;          
	sql += " `user_id` VARCHAR(10) NOT NULL ,";
	sql += " `password` TEXT NOT NULL ,";
	sql += "  `grade` INT NULL ";
	sql += ")DEFAULT CHARSET=euckr";
adminManager.adminExecuteUpdate(sql);

// 모든 install_1의 설정이 끝난후 2단계
response.sendRedirect("install_2.jsp");
%>

</body>
</html>