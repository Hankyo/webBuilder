package manager;

import java.util.*;
import java.util.zip.*;
import java.io.*;
import java.sql.*;
 
import DBConn.*;
import DataCapsuled.*;
 
public class AdminManager {
    private static ConnectionPool connectionPool = null;
    private static AdminManager adminManager = null; 
    private String id = "admin";
    private String password = null;
    private String dbID = "";
    private String dbPassword = "";
    private String dbURL = "";
    private String skinPath = "";
    private String hvCheck = "";

    public String getID () { return this.dbID;}
    public String getPassword () { return this.dbPassword;}
    public String getUrl () { return this.dbURL;}
    public String getSkinPath () { return this.skinPath;}
    public String getHvCheck () { return this.hvCheck;}
    
    static {
        try{
            connectionPool = connectionPool.getConnectionPool();
            adminManager = adminManager.getInstance();
        } catch(Exception e){
            System.out.println("Error01:static block error!!");
        }
    }
    
    public AdminManager(){}
	public static AdminManager getInstance() throws IOException { 
	    if (adminManager == null) { 
	    	adminManager = new AdminManager(); 
	    } 
	    return adminManager; 
	} 

	// 디비 설정 불러오기
    public void getConnectDB() throws IOException{
    	// 디비설정사항 파일 Read
        String MyFile =  "./dbConfig.txt";
        FileReader readFile = new FileReader(MyFile); //FileReader 객체를 readFile이라는 이름으로 생성하고 MyFile에 적어준 파일을 생성한 객체에 넣는다.
        
        int index = 0;
        do {
          int tempChar = readFile.read();
          if (tempChar == -1) //파일 끝에 도달하면 -1을 리턴하기 때문
            break;
          if(tempChar == ' ') 
        	  index++;
	      if(index == 0 && tempChar != ' ') dbURL = dbURL + (char)tempChar;
	      else if (index == 1 && tempChar != ' ')dbID = dbID + (char)tempChar;
	      else if (index == 2 && tempChar != ' ')dbPassword = dbPassword + (char)tempChar;
	      
        } while(true);
        
        // url 주소 인코딩 톰켓에서는 불필요
        dbURL = dbURL + "?useUnicode=true&characterEncoding=euc-kr";
    }
    
    // 레이아웃 설정 정보  불러오기
    public void getLayout() throws IOException{
    	 File path = new File("");
    	    String MyFile =  "./layout.txt";
    	    FileReader readFile = new FileReader(MyFile); //FileReader 객체를 readFile이라는 이름으로 생성하고 MyFile에 적어준 파일을 생성한 객체에 넣는다.
    	    
    	    int index = 0;
    	    do {
    	      int tempChar = readFile.read();
    	      if (tempChar == -1) //파일 끝에 도달하면 -1을 리턴하기 때문
    	        break;
    	      if(tempChar == ' ') 
    	    	  index++;
    	      if(index == 0 && tempChar != ' ') skinPath = skinPath + (char)tempChar;
    	      else if (index == 1 && tempChar != ' ') {
    	    	  if(tempChar != '_') index ++;
    	    	  hvCheck = hvCheck + (char)tempChar;
    	      }
    	}while(true);
    }

    // 해당하는 이름의 게시판이 존재하는지 유무를 검사하기 위한 메소드
    public boolean existBoard(String boardName) {
        String sql = "select count(boardName) from BoardAdmin where boardName='" + boardName + "'";
        int num = this.adminExecuteQueryNum(sql);
        if(num == 0){
            return false;
        } else {
            return true;
        }
    }
 
    // 새로운 게시판을 만들기 위한 메소드
    public void makeBoard(String boardName, String boardSubject) {
    	System.out.println(boardName + boardSubject);
        String insertBoardSQL = "insert BoardAdmin values('" + boardName + "', '" + boardSubject + "')";
         
        String makeBoardSQL = "create table " + boardName + " (" ;          
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
         
        this.adminExecuteUpdate(insertBoardSQL);
        this.adminExecuteUpdate(makeBoardSQL);
    }
 
    // 입력받은 로그인 정보를 디비를 통해  패스워드 확인
    public boolean chkPwd(String id, String inputpwd) {
    	// 해당 아디의 패스워드를 불러온다.
    	String sql = "select password from member where id = '"+ id +"'";
    	String ckkpwd = adminExecuteQueryString(sql);
    	
    	System.out.println(this.id);
    	System.out.println(ckkpwd + " 여기테스트");

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
    	grade = adminExecuteQueryNum(sql);

        return grade;
    }
 
    //해당하는 아이디가 관리자 권한을 가지고 있!는!지! 확인하기 위해 디비 연결작업을 합니다.
    public boolean isAdmin(String id) {
    	int grade;
    	String sql = "select grade from member where user_id = '" + id + "'";
    	grade = adminExecuteQueryNum(sql);
    	
    	//관리자가 맞는지 확인하여 리턴
        if(grade == 0) {
            return true;
        }else{
            return false;
        }
    }
     
    // 게시판의 리스트를 해쉬테이블로 반환하는 메소드
    public Hashtable getBoardList() throws Exception {
        Hashtable ht = new Hashtable();
        Connection conn = null;
        try{
            conn = connectionPool.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from BoardAdmin");
             
            while(rs.next()) {
                String boardName = rs.getString("boardName");
                String boardSubject = rs.getString("boardSubject");
                ht.put(boardName, boardSubject);
            }
             
            rs.close();
            stmt.close();   
        }catch(Exception e){ 
            e.printStackTrace();
        } finally {
        	if (conn != null)
        		connectionPool.releaseConnection(conn);
        }
        return ht;
    }
 
    // 게시판의 제목을 수정하는 메소드
    public void updateBoard(String boardName, String boardSubject) {
        String sql = "update BoardAdmin set boardSubject='" + boardSubject + "' where boardName='" + boardName + "'";
        this.adminExecuteUpdate(sql);
    }
 
    // 게시판 삭제 메소드
    public void deleteBoard(String boardName) {
        String deleteRecordSQL = "delete from BoardAdmin where boardName ='" + boardName + "'";
        String dropBoardSQL = "Drop Table " + boardName;
        this.adminExecuteUpdate(deleteRecordSQL);
        this.adminExecuteUpdate(dropBoardSQL);
    }
 
    // 리턴 값이 없는 SQL 실행 메소드
    public void adminExecuteUpdate(String sql) {
        Connection conn = null;
        try {
            conn = connectionPool.getConnection();
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            stmt.close();
        } catch(Exception e) { 
            e.printStackTrace();
        } finally {
        	if (conn != null)
        		connectionPool.releaseConnection(conn);
        }
    }
 
    // 게시판의 전체 내용을 Vector로 반환하는 메소드
    public Vector adminExecuteQuery(String sql) {
        Vector v = new Vector();
        Connection conn = null;
        try{
            conn =  connectionPool.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()) {
                BoardData data = new BoardData();
                data.setNum(rs.getInt(1));
                data.setName(rs.getString(2));
                data.setSubject(rs.getString(3));
                data.setContent(rs.getString(4));
                data.setDate(rs.getDate(5));
                data.setPassword(rs.getString(6));
                data.setCount(rs.getInt(7));
                data.setRef(rs.getInt(8));
                data.setStep(rs.getInt(9));
                data.setDepth(rs.getInt(10));
                data.setChildCount(rs.getInt(11));
                v.addElement(data);
            }
            rs.close();
            stmt.close();   
        }catch(Exception e){ 
            e.printStackTrace();
        } finally {
        	if (conn != null)
        		connectionPool.releaseConnection(conn);
        }
        return v;
    }
     
    // 질의문의 결과가 하나의 bool형일 경우를 위한 메소드
    public boolean adminExecuteQueryBool(String sql) {
        boolean bl = false;
        Connection conn = null;
        try{
            conn =  connectionPool.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            rs.close();
            stmt.close();
            bl = true;
            
        }catch(Exception e){ 
            e.printStackTrace();
        } finally {
        	if (conn != null)
        		connectionPool.releaseConnection(conn);
        }
        return bl;
    }
    
   
    public int adminExecuteQueryNum(String sql) {
        int num = 0;
        Connection conn = null;
        try{
            conn =  connectionPool.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()) {
                num = rs.getInt(1);             
            }
            rs.close();
            stmt.close();   
        }catch(Exception e){ 
            e.printStackTrace();
        } finally {
        	if (conn != null)
        		connectionPool.releaseConnection(conn);
        }
        return num;
    }
 
     // 질의문의 결과가 하나의 String형일 경우를 위한 메소드
    public String adminExecuteQueryString(String sql) {
        String str = "";
        Connection conn = null;
        try{
            conn =  connectionPool.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()) {
                str = rs.getString(1);
            }
            rs.close();
            stmt.close();   
        }catch(Exception e){ 
            e.printStackTrace();
        } finally {
        	if (conn != null)
        		connectionPool.releaseConnection(conn);
        }
        return str;
    }
    
    public void copyDirectory(File sourceLocation, File targetLocation) throws IOException {
	 	   if(sourceLocation.isDirectory()){
	 	    
	 	    if(!targetLocation.isDirectory()){
	 	     targetLocation.mkdir();
	 	    }//if
	 	    String[] children  = sourceLocation.list();
	 	    for(int i=0;i<children.length;i++){
	 	     copyDirectory(new File(sourceLocation, children[i]),new File(targetLocation, children[i]));
	 	    }//for
	 	   }else{
	 	    InputStream in  = new FileInputStream(sourceLocation);
	 	    OutputStream out = new FileOutputStream(targetLocation);
	 	    
	 	    byte[] buf   = new byte[1024];
	 	    int len    = 0;
	 	    while((len = in.read(buf)) > 0){
	 	     out.write(buf, 0, len);
	 	    }//while
	 	    in.close();
	 	    out.close();
	 	   }//else
	 }//copyDirectory
	 
	 // 현재 클래스의 절대 경로를 가져온다.
	 public String getPath(){
	 	String path = AdminManager.class.getResource("").getPath(); 
	 	return path;
	 }
}