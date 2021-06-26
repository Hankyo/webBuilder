<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="DataEntity.MemberData,java.text.SimpleDateFormat" %>

<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="memberManager" class="manager.MemberManager" scope="page" />
<jsp:useBean id="memberData" class="DataEntity.MemberData" scope="page" />
<link href="./css/settingCSS/setting_style.css" rel="stylesheet" type="text/css">
<%
	String requestGrade = "0";

	adminManager.getConnectDB();
	String dbURL = adminManager.getUrl();
	String connectID = adminManager.getID();
	String password = adminManager.getPassword();
	
	Connection con = null;
    Statement stmt = null;
    String driverName = "com.mysql.jdbc.Driver";
    
	try{
    	request.setCharacterEncoding("UTF-8");
    	Class.forName(driverName);
        con = DriverManager.getConnection(dbURL, connectID, password);
        stmt = con.createStatement();
    } catch(Exception e){
        response.sendRedirect("./install/install_1.jsp");
    }
%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>admin Category</title></head>
<body>
	<h4> 회원 관리  </h4>
	<br>

<!-- ================================  회원 리스트 ====================================== -->
<form action="adminMemberProc.jsp" method="post" name="menu">
	
	<table id = "table_1">
	<tr>
		<th width="130"><Strong>회원 아이디</Strong></th>
	    <th width="140"><Strong>등급</Strong></th>
    </tr> <hr>
    </table>
	<% 
		String sql = "select * from member"; 
	
		String s_page = request.getParameter("page");
		int i_page;
		if(s_page != null)
			i_page = Integer.parseInt(s_page);
		else
			i_page = 0;
		
		//memberManager.connect();
		ArrayList<MemberData> list = new ArrayList<MemberData>();
		
		String SQL = "select * from member order by user_id DESC";
		
        PreparedStatement pstmt = con.prepareStatement(SQL);
		ResultSet rs = pstmt.executeQuery();
		int count = 0;
		while (rs.next()) {
			MemberData member = new MemberData();
			member.setUser_id ( rs.getString("user_id") );
			member.setPassword ( rs.getString("password") );
			member.setGrade ( rs.getInt("grade") );
				
			if((count >= i_page *5) && (count < (i_page+1)*5)){
				//리스트에 추가
				list.add(member);
			}
			else if(count > (i_page+1)*5){
				break;
			}
		count++;
		}
		rs.close();		

	   	int counter = list.size();
	   	int row = 0;
	   	
	   	if (counter > 0) {
	        stmt = con.createStatement();
	        rs = stmt.executeQuery(sql);
        	while(rs.next()) {
		%>
	
	<table id = "table_2">
	<tr> 
		<%  
		request.setCharacterEncoding("UTF-8");
		int rsGrade = rs.getInt("grade");	
		requestGrade = request.getParameter("selectedGrade");
		if (requestGrade == null || requestGrade.compareTo("0") == 0) {
			requestGrade = ""; 
			String getID = rs.getString("user_id");
			sql = "select grade from member where user_id = '" + getID + "'";
			int memberGrade = adminManager.executeQueryNum(sql);
			
			if(memberGrade != 0){ %>
			<td width="30"> <input type="checkbox" name="contentMove" value=<%=getID%>></td>
			<td width="150"> <%=rs.getString("user_id")%><br> </td>
	        <td width="150"> <%=rs.getInt("grade")%><br> </td>
	       <br>
	       <%
	       } 
		}
		String strGrade = Integer.toString(rsGrade);
		if(strGrade.compareTo(requestGrade) == 0) {    // 검색된 등급이 검출시
			String getID = rs.getString("user_id");
			%>
			<td width="30"><input type="checkbox" name="contentMove" value=<%=getID%>></td>
			<td width="150"> <%=rs.getString("user_id")%><br> </td>
			<% 	
				sql = "select grade from member where user_id = '" + getID + "'";
				int memberGrade = adminManager.executeQueryNum(sql);
	        %><td width="150"> <%=rs.getInt("grade")%><br> </td>
	       <br>
       <%}%>
    </tr>
    </table>
    <% } %>
<% 
	} else {
%>
		회원이 없습니다.<br>
<%
	}
%>
		<input type="hidden" name="kor" value="ok">
<!-- ================================ 회원  삭제  ====================================== -->
		선택한 항목을  
		<input type="submit" name="menu" value="삭제" onClick='sub();'>
<!-- ================================ 회원 권한관리  ====================================== -->
		<input type="submit" name="menu" value="등급상향" onClick='sub();'>
		<input type="submit" name="menu" value="등급하향" onClick='sub();'><br><br>
	</form>
	
	<%if(i_page != 0){ %>
	<a href = "./adminMember.jsp?page=<%=i_page-1 %>" >이전으로</a>
	<%
	}%>
	<a href = "./adminMember.jsp">처음으로</a>
	<%
	if(i_page < memberManager.getMemberLength() / 5){
	%>     
	<a href = "./adminMember.jsp?page=<%=i_page + 1 %>" >다음으로</a>
	<%} %>

	<form method = post action="adminMember.jsp" name="ser">
		<input type="hidden" name="kor" value="ok">
		<% 
			requestGrade = request.getParameter("selectedGrade");
			if (requestGrade == null || requestGrade.compareTo("0") == 0)
				requestGrade = "0";
			int selectedGrade = Integer.parseInt(requestGrade);
		%>
		등급 :
		<select name="selectedGrade" onChange="" align="center">
		<option value=0>전체</option>
		<% for(int i=1; i<10; i++){ %>
			<%if(selectedGrade == i){%>
					<option value=<%=i%> selected><%=i%></option>
			<%}
			else { %>
					<option value=<%=i%>><%=i%></option>
			<%}
		}%>
		</select>
		<input type="submit" name="search" value="검색">
	</form>
</body>
</html>