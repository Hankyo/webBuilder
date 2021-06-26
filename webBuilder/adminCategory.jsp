<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<link href="./css/settingCSS/setting_style.css" rel="stylesheet" type="text/css">

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="categoryManager" class="manager.CategoryManager" scope="page" />
<jsp:useBean id="contentManager" class="manager.ContentManager" scope="page" />
<%
	request.setCharacterEncoding("UTF-8");
	adminManager.getConnectDB();
	String dbURL = adminManager.getUrl();
	String connectID = adminManager.getID();
	String password = adminManager.getPassword();
	
	// try catch 문으로 db접속 확인
	Connection con = null;
    Statement stmt = null;
    String driverName = "com.mysql.jdbc.Driver";
    
	request.setCharacterEncoding("UTF-8");
	Class.forName(driverName);
    con = DriverManager.getConnection(dbURL, connectID, password);
%>

<link href= "./css/settingCSS/setting_style.css." rel="stylesheet" type="text/css">

<html><head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>admin Category</title></head>
<body>
	<h4> 카테고리 관리  </h4>
	<br>
<!-- ================================ 카테고리 추가 삭제  ====================================== -->

<table>
<td>
 <form action="makeCategory.jsp" method="post" name="menu">
  	<% 
  		String sql = "select count(*) from category";
		int catagory_num = adminManager.adminExecuteQueryNum(sql); 
	%>
		<b> 생성된 컨텐츠 < 목록 > :</b>
  		<select name=categoryList id=categoryList style="width:120;font-size:12px;"> 
  		<% 
  			// 카테고리가 있을 경우
  			if(catagory_num >= 0){
  				sql = "select name from category where step = " + catagory_num ;
				String name = adminManager.adminExecuteQueryString(sql); 
				request.setCharacterEncoding("UTF-8");
				String category_id = (String)request.getParameter("findContent");
				if (category_id == null || category_id.compareTo("-1") == 0)
					category_id = "-1";
				int selectedID = Integer.parseInt(category_id);
				%> <option value="-1">전체 <%
				for(int i=catagory_num-1; i>=0; i--){
  					sql = "select name from category where step = " + i ;
					name = adminManager.adminExecuteQueryString(sql); 
					%>	
					<%if(selectedID == i){%>
						<option value=<%=i%> selected><%=name%>
					<%}
					 else { %>
						<option value=<%=i%> ><%=name%>
					<%}
				} 
			}%>
		</select>
		<input type="submit" name="menu" value="검색">
	    <input type="submit" value="목록삭제" id="menu" name="menu">
	  	&nbsp;&nbsp;&nbsp;&nbsp;
	  	<input type="text"  name="txt_category" size="20">
		<input type="submit" value="추가" id="menu" name="menu">
		<input type="submit" value="수정" id="menu" name="menu">
</td>
</table>

<!-- ================================  컨텐츠 리스트 ====================================== -->
	<jsp:useBean id="ContentData" class="DataCapsuled.ContentData" scope="page" />
	<table id="table_1">
	<tr>
		<th width="150"><strong>Category</strong></th>
	    <th width="150"><strong>Name</strong></th>
	    <th width="150"><strong>Descriptor</strong></th>
	    <th width="100"><strong>Type</strong></th>
	    <th width="150"><strong> </strong></th>
    </tr> <hr>
    </table>
    <%
	if(contentManager.getRecNum() >= 0) {
        stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from content");
         
        while(rs.next()) { 
	%>
	
	<table id="table_2">
	<tr> 
		<%  
		// ===========================  전체  카테고리의 컨텐츠 목록   =====================================
		request.setCharacterEncoding("UTF-8");
		String id = rs.getString("category_id");	
		String category_id = (String)request.getParameter("findContent");
		if (category_id == null || category_id.compareTo("-1") == 0) {
			category_id = ""; 
			String getID = rs.getString("id");
			sql = "select url from link where id = '" + getID + "'";
			String url = adminManager.adminExecuteQueryString(sql);
			%>
			<td width="30"> <input type="checkbox" name="contentMove" value=<%=getID%>></td>
			<% 	sql = " select name from category where step ='" + rs.getString("category_id") +"'";
				String categoryName = adminManager.adminExecuteQueryString(sql); %>
	        <td width="80"> <%=categoryName%><br> </td>
	        <%if(rs.getString("type").compareTo("게시판") == 0){ %>
	       	<td width="80"><a href="boardList.jsp?selectedID=<%=getID%>"> <%=rs.getString("name")%> </a><br> </td>
	       	<%}
	        else if(rs.getString("type").compareTo("링크") == 0){ %>
	       	<td width="80"><a href="<%=url%>"> <%=rs.getString("name")%> </a><br> </td>
	       	<%}
	        else if(rs.getString("type").compareTo("고정") == 0){ %>
	       	<td width="80"><a href="staticPage.jsp?selectedID=<%=getID%>"> <%=rs.getString("name")%> </a><br> </td>
	       	<%}%>
	       	<td width="80"> <%= rs.getString("descriptor")%><br> </td>
			<td width="60"> <%= rs.getString("type")%><br> </td>
			
			<td width="60"><a href="Content_Config.jsp?selectedID=<%=getID%>"> 설정  </a><br> </td>
	       <br>
	       <%
		}
		// ===========================  검색된 카테고리가 검출시  =====================================
		if(id.compareTo(category_id) == 0) {    
			String getID = rs.getString("id");
		%>
		<td width="30"><input type="checkbox" name="contentMove" value=<%=getID%>></td>
		<% 	sql = " select name from category where step ='" + rs.getString("category_id") +"'";
			String categoryName = adminManager.adminExecuteQueryString(sql); %>
        <td width="80"> <%=categoryName%><br> </td>
       	<td width="80"> <a href="boardList.jsp?selectedID=<%=getID%>"> <%=rs.getString("name")%> </a> <br> </td>
       	<td width="80"> <%= rs.getString("descriptor")%><br> </td>
		<td width="60"> <%= rs.getString("type")%><br> </td>
		<td width="60"><a href="Content_Config.jsp?selectedID=<%=getID%>"> 설정 </a> <br> </td>
       <br>
       <% } %>
    </tr>
    </table>
    <% } %>
<% } %>
<!-- ================================ 카테고리  이동  ====================================== -->
		선택한 항목을  
		<select name=moveRoad id=moveRoad style="width:120;font-size:12px;"> 
  		<% 
  			if(catagory_num >= 0){
  				sql = "select name from category where step = " + catagory_num ;
				String name = adminManager.adminExecuteQueryString(sql); 
		%>
  		<% 		for(int i=catagory_num - 1; i>=0; i--){
  					sql = "select name from category where step = " + i ;
					name = adminManager.adminExecuteQueryString(sql); 
		%>
		    		<option value=<%=i%>><%=name%>
		<% 		} 
			}%>
		</select>
		<input type="submit" name="menu" value="이동" onClick='sub();'>
		<input type="submit" name="menu" value="삭제" onClick='sub();'><br><br>
<!-- ================================ 컨텐츠 생성  ====================================== -->
		<b> < 생성 > :</b>
		<select name=categoryList2 id=categoryList2 style="width:120;font-size:12px;"> 
  		<% 
  			if(catagory_num >= 0){
  				sql = "select name from category where step = " + catagory_num ;
				String name = adminManager.adminExecuteQueryString(sql); 
		%>
  		<% 		for(int i=catagory_num -1; i>=0; i--){
  					sql = "select name from category where step = " + i ;
					name = adminManager.adminExecuteQueryString(sql); 
		%>
		    		<option value=<%=i%>><%=name%>
		<% 		} 
			}%>
		</select>
  		<select name=type id=type >
  				<option value="게시판" selected>게시판
		    	<option value="고정">고정
		    	<option value="링크">링크
		</select>
		
		
		<input type="text"  name="name" size="20">
	  	<input type="text"  name="descriptor" size="20">
		<input type="submit" value="Content생성" id="menu" name="menu" onClick="AlertBox();">
	</form>
</body>
</html>