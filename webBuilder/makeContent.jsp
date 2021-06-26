<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="adminBoardManager" class="manager.AdminBoardManager" scope="page" />
<jsp:useBean id="categoryManager" class="manager.CategoryManager" scope="page" />
<jsp:useBean id="contentManager" class="manager.ContentManager" scope="page" />

<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Make New Board</title></head><body>
<%
	request.setCharacterEncoding("UTF-8");
	String menu = request.getParameter("menu2");      // 메뉴버튼 클릭시 
	String[] checkedContent = request.getParameterValues("checkContent");  // 체크된 컨텐츠
	String moveRoad = request.getParameter("moveRoad");   // 이동할 컨텐츠 경로
    
if( menu.compareTo("이동") == 0){	
	%>
	<%if(moveRoad.compareTo("0") != 0){
		for(int i=0;i<checkedContent.length;i++){ 
			String sql = "update content set category ='" +moveRoad+ 
			     				"' where id ='" + checkedContent[i] + "'";
			adminManager.executeUpdate(sql);
		}
	}%>
	 <%response.sendRedirect("adminCategory.jsp"); %>
	<%
}
	
/*  컨텐츠 삭제 부분  */
else if( menu.compareTo("삭제") == 0){
	 for(int i=0; i<checkedContent.length; i++){ 
		 int id = Integer.parseInt(checkedContent[i]);
		 
		 String sql = "select count(*) from content where id > '" + checkedContent[i] + "'";
		 int count = adminManager.executeQueryNum(sql);
		 
		 sql = "select type from content where id =" + checkedContent[i];
		 String type = adminManager.executeQueryString(sql);
		 
		 if(type.compareTo("고정") == 0){
			sql = "delete from static where id =" + checkedContent[i] ;
			adminManager.executeUpdate(sql);
		 }
		 else if(type.compareTo("링크") == 0){
			 sql = "delete from link where id =" + checkedContent[i] ;
			adminManager.executeUpdate(sql);
		 }
		 else if(type.compareTo("게시판") == 0){
			 sql = "delete from boardAdmin where id =" + checkedContent[i] ;
			adminManager.executeUpdate(sql);
			 sql = "drop table board_" + checkedContent[i];
			adminManager.executeUpdate(sql);
		 }
		 
		sql = "delete from content where id =" + checkedContent[i] ;
		adminManager.executeUpdate(sql);
	 }
	 response.sendRedirect("adminCategory.jsp");
}

/* ================= 컨텐츠 생성   ========================================*/
else if(menu.compareTo("Content생성") == 0){
	request.setCharacterEncoding("UTF-8");
	String category = request.getParameter("category");
	String name = request.getParameter("name");
	String descriptor =  request.getParameter("descriptor"); 
	String type = request.getParameter("type");
		
	if(name == "" || descriptor == "") {
		%>콘텐츠 이름은 필수 항목입니다.<br>
		<%=name%><%
	}
	else if(category.compareTo("0") == 0) {
		%>카테고리 선택은 필수 항목입니다.<br><%
	} 
	 else {
			String sql = "select count(name) from content where name='" + name + "'";
	        int existCheck = adminManager.executeQueryNum(sql);

			if(existCheck == 0) {
				//  content 생성
				contentManager.writeContent(category, name ,descriptor, type);
		        
				String insertBoardSQL = null;
				
		        // 타입 별로 디비생성
		        int num = contentManager.getMaxNum();
		        String content = "";
		        if(type.compareTo("고정") == 0){
		        	insertBoardSQL = "insert into static (id, content) ";
		        	insertBoardSQL += " values(" + num + ",'" + content + "')";
				    adminManager.executeUpdate(insertBoardSQL);
		        }
		        else if(type.compareTo("링크") == 0){
		        	insertBoardSQL = "insert into link (id, url) ";
		        	insertBoardSQL += " values(" + num + ",'" + content + "')";
				    adminManager.executeUpdate(insertBoardSQL);
	        	}
		        else if(type.compareTo("게시판") == 0){
		        	adminBoardManager.writeBoardAdmin(num, 9, 9, 9);
			        adminBoardManager.makeBoard("board_" + num);
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