package manager;

import java.io.*;

public class LoginManager{
    private static LoginManager loginManager = null;
    private static AdminManager adminManager = null;
    
    //Singleton Static Block
    static {
        try{
            loginManager = LoginManager.getInstance();
            adminManager = AdminManager.getInstance();
        } catch(Exception e){
            System.out.println("Error01:static block error!!");
        }
    }
    
    public LoginManager(){}
    //Instance 생성
	public static LoginManager getInstance() throws IOException { 
	    if (loginManager == null) { 
	    	loginManager = new LoginManager(); 
	    } 
	    return loginManager; 
	} 
	public boolean chkPwd(String id, String inputpwd) {
    	// 해당 아디의 패스워드를 불러온다.
    	String sql = "select password from member where id = '"+ id +"'";
    	String ckkpwd = adminManager.executeQueryString(sql);

        if(ckkpwd.compareTo(inputpwd)!= 0){
            return true;
        }else{
            return false;
        }
    }
    // 입력받은 로그인 정보로 Grade 값을 반환한다.
    public int chkGrade(String id) {
    	int grade;
    	// 해당 아디의 등급을 불러온다.
    	String sql = "select grade from member where id = '"+ id +"'";
    	grade = adminManager.executeQueryNum(sql);

        return grade;
    }
 
    //해당하는 아이디가 관리자 권한을 가지고 있는지 확인하기 위해 디비 연결작업을 합니다.
    public boolean isAdmin(String id) {
    	int grade;
    	String sql = "select grade from member where user_id = '" + id + "'";
    	grade = adminManager.executeQueryNum(sql);
    	
    	//관리자가 맞는지 확인하여 리턴
        if(grade == 0) {
            return true;
        }else{
            return false;
        }
    }
}
