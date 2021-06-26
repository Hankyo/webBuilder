<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="categoryManager" class="manager.CategoryManager" scope="page" />
<jsp:useBean id="contentManager" class="manager.ContentManager" scope="page" />

<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>카테고리 컨텐츠 생성 및 삭제</title></head><body>
<%
	request.setCharacterEncoding("UTF-8");
	String menu = request.getParameter("menu");      // 메뉴버튼 클릭시 
	String step = request.getParameter("categoryList");  // 카테고리 드롭다운
	
	adminManager.getConnectDB();
	String dbURL = adminManager.getUrl();
	String connectID = adminManager.getID();
	String password = adminManager.getPassword();
	
	Connection con = null;
    Statement stmt = null;
    String driverName = "com.mysql.jdbc.Driver";
    
	request.setCharacterEncoding("UTF-8");
	Class.forName(driverName);
    con = DriverManager.getConnection(dbURL, connectID, password);
    
if( menu.compareTo("이동") == 0){	
	 String[] checkedContent = request.getParameterValues("contentMove");
	 String moveRoad = request.getParameter("moveRoad");
	
	if(request.getParameterValues("contentMove") != null){
		for(int i=0;i<checkedContent.length;i++){ 
		 System.out.println(checkedContent[i]);
		 
		String sql = "update content set category_id ='" +moveRoad+ 
		     				"' where id ='" + checkedContent[i] + "'";
		adminManager.adminExecuteUpdate(sql);
		}
	}
	response.sendRedirect("adminCategory.jsp"); 
}
	
else if( menu.compareTo("삭제") == 0){
	 String[] checkedContent = request.getParameterValues("contentMove");
	 
	 if ( request.getParameterValues("contentMove") != null){
	 for(int i=checkedContent.length-1; i>=0; i--){ 
		 int id = Integer.parseInt(checkedContent[i]);
		 String sql = "select count(*) from content where id > '" + checkedContent[i] + "'";
		 int count = adminManager.adminExecuteQueryNum(sql);
		 
		 sql = "select type from content where id =" + checkedContent[i];
		 String type = adminManager.adminExecuteQueryString(sql);
		 
		 if(type.compareTo("고정") == 0){
			 sql = "delete from static where id =" + checkedContent[i] ;
			adminManager.adminExecuteUpdate(sql);
			
			for(int r = id+1; r <= id+count; r++) {
				sql = "update static, content set id = id-1 ";
				sql += "where id = '" + Integer.toString(r) +"'";
				adminManager.adminExecuteUpdate(sql);
			}
		 }
		 else if(type.compareTo("링크") == 0){
			 sql = "delete from link where id =" + checkedContent[i] ;
			adminManager.adminExecuteUpdate(sql);
			
			for(int r = id+1; r <= id+count; r++) {
				sql = "update link set id = id-1 ";
				sql += "where id = '" + Integer.toString(r) +"'";
				adminManager.adminExecuteUpdate(sql);
			}
		 }
		 else if(type.compareTo("게시판") == 0){
			 sql = "delete from boardAdmin where id =" + checkedContent[i] ;
			adminManager.adminExecuteUpdate(sql);
			 sql = "drop table board_" + checkedContent[i];
			adminManager.adminExecuteUpdate(sql);
			
			for(int r = id+1; r <= id+count; r++) {
				sql = "update boardAdmin set id = id-1 ";
				sql += "where id = '" + Integer.toString(r) +"'";
				adminManager.adminExecuteUpdate(sql);
				sql = "rename table board_" + Integer.toString(r) + " to board_" + Integer.toString(r-1);
				adminManager.adminExecuteUpdate(sql);
			}
		 }
		sql = "delete from content where id =" + checkedContent[i] ;
		adminManager.adminExecuteUpdate(sql);
		
		for(int r = id+1; r <= id+count; r++) {
			sql = "update content set id = id-1 ";
			sql += "where id = '" + Integer.toString(r) +"'";
			adminManager.adminExecuteUpdate(sql);
		}
	  }
	 	response.sendRedirect("adminCategory.jsp");
	}
	 else{
		 response.sendRedirect("adminCategory.jsp");
	 }
}

else if( menu.compareTo("목록삭제") == 0){	
	String category_id = request.getParameter("categoryList");
	
	if (category_id.compareTo("-1") == 0){     // 카테고리가 선택되지 않을 시
		%>
		전체 카테로리는 삭제할 수 없습니다.
		<form method="POST" action="adminCategory.jsp">
	    <input type="submit" value="확인" name="B3"></p>
		</form>
		<%
	}
	else {	
		String sql = "select name from category where step =" + step;
		String categoryName = adminManager.adminExecuteQueryString(sql);
		
		categoryManager.deleteCategory(categoryName, Integer.parseInt(step));
		%>
		<%=categoryName%> 카테고리가 삭제되었습니다.
			
		<form method="POST" action="adminCategory.jsp">
	    <input type="submit" value="확인" name="B3"></p>
		</form>
		<%
	}
}

else if( menu.compareTo("검색") == 0){
	String sql = "select name from category where step =" + step;
	String categoryName = adminManager.adminExecuteQueryString(sql);
	
	 %><input type="text" value=step name="findContent"></p> <% 
			 
	 response.sendRedirect("adminCategory.jsp?findContent="+step); 
}

else if(menu.compareTo("추가") == 0){
	String category = ""; 
	request.setCharacterEncoding("UTF-8");
	category =  request.getParameter("txt_category"); 
	
	if (category.compareTo("전체") == 0){     // 카테고리가 선택되지 않을 시
		%>
		전체 카테로리는 추가할 수 없습니다.
		<form method="POST" action="adminCategory.jsp">
	    <input type="submit" value="확인" name="B3"></p>
		</form>
		<%
	}
	else{
	if(category == "") {
		%>
		카테고리 이름은 필수 항목입니다.<br>
		
		<form method="POST" action="adminCategory.jsp">
		<input type="submit" value="확인" name="B3"></p>
		</form>
		<%
	} else {
		int existCheck = 0;
		String sql = "select count(name) from category where name='" + category + "'";
		stmt = con.createStatement();
        stmt.execute("SET CHARACTER SET euckr");
        stmt.execute("set names euckr"); 
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()) {
        	existCheck = rs.getInt(1);             
        }
		if(existCheck == 0) {
	        String insertBoardSQL = "insert category values(?, ?)";
	        PreparedStatement pstmt = con.prepareStatement( insertBoardSQL );
	        
	        pstmt.execute("SET CHARACTER SET euckr");
	        pstmt.execute("set names euckr");  
	        
	        sql = "select count(*) from category";
			int num = adminManager.adminExecuteQueryNum(sql); 
			
	        pstmt.setString(1, category);
	        pstmt.setString(2, Integer.toString(num));
	        pstmt.executeUpdate( );

			response.sendRedirect("adminCategory.jsp"); 
		} else {
			%>
			동일한 이름의 카테고리가 존재합니다.<br>
			다른 이름을 입력하세요.<br>
			<%
		}
	}
	}
}

else if(menu.compareTo("수정") == 0){
	String inputCategory = ""; 
	request.setCharacterEncoding("UTF-8");
	inputCategory =  request.getParameter("txt_category"); 
	String category_id = request.getParameter("categoryList");
	
	if (inputCategory.compareTo("전체") == 0){     // 전체이름으로 수정시
		%>
		전체 이름으로 카테고리 수정이 불가합니다. 
		<form method="POST" action="adminCategory.jsp">
	    <input type="submit" value="확인" name="B3"></p>
		</form>
		<%
	}
	else if (category_id.compareTo("-1") == 0){     // 카테고리가 선택되지 않을 시
		%>
		전체 카테로리는 변경할 수 없습니다.
		<form method="POST" action="adminCategory.jsp">
	    <input type="submit" value="확인" name="B3"></p>
		</form>
		<%
	}
	else{
	if(category_id == "") {
		%>
		카테고리 이름은 필수 항목입니다.<br>
		
		<form method="POST" action="adminCategory.jsp">
		<input type="submit" value="확인" name="B3"></p>
		</form>
		<%
	} else {
		int existCheck = 0;
		String sql = "select count(name) from category where name='" + inputCategory + "'";
		stmt = con.createStatement();
        stmt.execute("SET CHARACTER SET euckr");
        stmt.execute("set names euckr"); 
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()) {
        	existCheck = rs.getInt(1);             
        }
		if(existCheck == 0) {
			sql = "update category set name ='" +inputCategory+ "' where step =" + category_id ;
	        
	        stmt = con.createStatement();
	        stmt.execute("SET CHARACTER SET euckr");
	        stmt.execute("set names euckr"); 
	        stmt.executeUpdate(sql);
		        
			response.sendRedirect("adminCategory.jsp"); 
		} else {
	%>
			동일한 이름의 카테고리가 존재합니다.<br>
			다른 이름을 입력하세요.<br>
	<%
		}
	}
	}
}

else if(menu.compareTo("Content생성") == 0){
	request.setCharacterEncoding("UTF-8");
	String category_id = request.getParameter("categoryList2");
	String name = request.getParameter("name");
	String descriptor =  request.getParameter("Descriptor"); 
	String type = request.getParameter("type");
		
	if(name == "" || descriptor == "" || category_id == "") {
	%>
		카테고리와 콘텐츠 이름은 필수 항목입니다.<br>
		<%=name%>
	<%
	} else {
			int existCheck = 0;
			String sql = "select count(name) from content where name='" + name + "'";
			stmt = con.createStatement();
	        stmt.execute("SET CHARACTER SET euckr");
	        stmt.execute("set names euckr"); 
	        ResultSet rs = stmt.executeQuery(sql);
	        while(rs.next()) {
	        	existCheck = rs.getInt(1);             
	        }
			if(existCheck == 0) {
				
				sql = "select count(*) from content ";
			    int num = adminManager.adminExecuteQueryNum(sql); 
			     
				contentManager.writeContent(num, request.getParameter("categoryList2"),
											request.getParameter("name"),
											request.getParameter("descriptor"),
						 					request.getParameter("type"));
		        // 타입 별로 디비생성
		        if(type.compareTo("고정") == 0){
		        	    contentManager.makeStatic(num);
		        }
		        else if(type.compareTo("링크") == 0){
	        	    String insertBoardSQL = "insert link values(?, ?)";
	        	    PreparedStatement pstmt = con.prepareStatement( insertBoardSQL );
			        pstmt.execute("SET CHARACTER SET euckr");
			        pstmt.execute("set names euckr");  
			        
			        pstmt.setString(1, Integer.toString(num));
			        pstmt.setString(2, "");   
			        pstmt.executeUpdate( );
	        	}
		        else if(type.compareTo("게시판") == 0){
		        	String insertBoardSQL = "insert boardadmin values(?, ?, ?, ?)";
		        	PreparedStatement pstmt = con.prepareStatement( insertBoardSQL );
			        pstmt.execute("SET CHARACTER SET euckr");
			        pstmt.execute("set names euckr");  
			        
			        pstmt.setString(1, Integer.toString(num));
			        pstmt.setString(2, "9");   
			        pstmt.setString(3, "9");   
			        pstmt.setString(4, "9");   
			        pstmt.executeUpdate( );

			        String makeBoardSQL = "create table board_" + num + " (" ;          
			        makeBoardSQL += "num int NOT NULL PRIMARY KEY,";
			        makeBoardSQL += "name varchar(20) NOT NULL,";
			        makeBoardSQL += "subject varchar(100) NOT NULL,";
			        makeBoardSQL += "content text NULL,";
			        makeBoardSQL += "writeDate datetime,";
			        makeBoardSQL += "password varchar(20) NOT NULL,";
			        makeBoardSQL += "count int NOT NULL,";
			        makeBoardSQL += "ref int NOT NULL,";
			        makeBoardSQL += "step int NOT NULL,";
			        makeBoardSQL += "depth int NOT NULL,";
			        makeBoardSQL += "childCount int NOT NULL";
			        makeBoardSQL += ")";
			        
			        stmt = con.createStatement();
			        stmt.execute("SET CHARACTER SET euckr");
			        stmt.execute("set names euckr"); 
			        stmt.executeUpdate(makeBoardSQL);
	        	}
				response.sendRedirect("adminCategory.jsp"); 
			} else {
	%>
				동일한 이름의 컨텐츠가 존재합니다.<br>
				다른 이름을 입력하세요.<br>
	<%
			}
		}
	}
%>
</body></html>