<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="adminManager" class="manager.AdminManager" scope="page" />
<jsp:useBean id="boardManager" class="manager.BoardManager" scope="page" />
<body>
<%
	    // 세션이 없으면 Login Process.
	    request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		String charset[] = {"utf-8","euc-kr", "ksc5601", "iso-8859-1", "8859_1", "ascii"};
		
		for(int k=0; k<charset.length ; k++){
            for(int l=0 ; l<charset.length ; l++){
                    if(k==l){
                            continue;
                    }else{
                            System.out.println(charset[k]+" : "+charset[l]+" :"+new String(id.getBytes(charset[k]),charset[l])+"<br>");
                    }
            }
        }

		// 아디나 페스워드가  없을 시 
		if(id.compareTo("") == 0 || password.compareTo("") == 0){
			response.sendRedirect("login.jsp");
		}
		else { // 아디 있을 시
			String psql = "select password from member where user_id = '"+ id +"'";
	    	String chkpwd = adminManager.adminExecuteQueryString(psql);
	    	
	    	// 패스워드가 일치하면 권한확인
			if(chkpwd.compareTo(password) == 0) {
				String sql = "select grade from member where user_id = '" + id + "';";
				int grade = adminManager.adminExecuteQueryNum(sql);
	
				//session.invalidate();
				session.removeAttribute("id");
				session.setAttribute("id", id);
				response.sendRedirect("index.jsp");
				
			} else {
				// 로그인페이지
				response.sendRedirect("login.jsp");
			}
		}
%>
</body>
</html>