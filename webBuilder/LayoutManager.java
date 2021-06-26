package manager;

import java.io.*;

public class LayoutManager {
	private String skinPath = "";
    private String hvCheck = "";

    public void setSkinPath(String path){ this.skinPath = path; }
    public void setHvCheck(String check){this.hvCheck = check; } 
    public String getSkinPath () { return this.skinPath;}
    public String getHvCheck () { return this.hvCheck;}
    
    // 레이아웃 설정 정보  불러오기
    public void setLayout() throws IOException{
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
    
    public void outputLayout() throws Exception{
    	File path = new File("");
    	String MyFile =  "./layout.txt";
    	FileWriter writeFile = new FileWriter(MyFile); //인자가 true이면 append가 됨. 인자가 없으면 덮어씌우기
    	writeFile = new FileWriter(MyFile); //인자가 true이면 append가 됨. 인자가 없으면 덮어씌우기

    	//skin directory path
    	writeFile.write(skinPath + " ");
    	//verticle horizen check
    	writeFile.write(hvCheck + " ");
    	writeFile.close();
    }
    
    public void initLayout(){
    	this.skinPath = "./skin/horizontal_black_style";
    	this.hvCheck = "horizontal_black_style";
    }
}
