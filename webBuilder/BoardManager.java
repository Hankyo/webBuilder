/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package manager;
import java.util.*;
import java.sql.*;
import DataCapsuled.BoardData;

public class BoardManager extends AdminManager{
	public static final int LINE_PER_PAGE = 10;		// 한페이지에 나타날 글의 수
	public static final int PAGES_PER_GROUP = 10;	// 한 화면에 나타낼 페이지수
	private int recNum = 0;							// 전체 레코드 수
	private int totalPage = 0;						// 총페이지 수 
	private int currentPage = 0;					// 현재페이지
	private String search = "";						// 검색값을 위한 변수
	private String text = "";						// 검색결과를 위한 변수
	private boolean success;						// 작업이 성공적으로 끝났는지를 확인하는 변수

	// 데이터베이스에서 가장 큰 글 번호를 가져오는 메소드
	public int getMaxNum(String selectedID){
		String sql = "select max(Num) from board_" + selectedID;
		int maxNum = adminExecuteQueryNum(sql);
		return maxNum;
	}

	// 새로운 글을 입력하기 위한 메소드
	public void writeNotice(String boardName, BoardData data) {
		int noticeNum = this.getMaxNum(boardName) + 1;
		String sql = "Insert into " + boardName + " ";
		sql += "(num, name, subject, content, writeDate, password, ";
		sql += "count, ref, step, depth, childCount)";
		sql += " values(" + noticeNum +", '" + data.getName() + "', '";
		sql += data.getSubject() + "', '" + data.getContent() + "', now(), '";
		sql += data.getPassword() + "', 0, " + noticeNum + ", 0, 0, 0)";
		adminExecuteUpdate(sql);
		this.setSuccess(true);
	}

	// 하나의 글을 반환하는 메소드
	public BoardData getNotice(String boardName, int num) {
		String sql = "select * from " + boardName + " where num=" + num;
		Vector v = adminExecuteQuery(sql);
		BoardData data = (BoardData)v.elementAt(0);
		return data;
	}
	
	// 글의 비밀번호를 리턴하는 메소드
	public String getPassword(String boardName, int num) {
		String sql = "select password from " + boardName + " where num=" + num;
		String password = adminExecuteQueryString(sql);
		return password;
	}

	// 글을 수정하기 위한 메소드
	public void updateNotice(String boardName, BoardData data) {
		String sql = "update " + boardName + " set name='" + data.getName();
		sql += "', subject='" + data.getSubject() + "', content='" + data.getContent();
		sql += "' where num=" + data.getNum();
		adminExecuteUpdate(sql);
		this.setSuccess(true);
	}

	// 답변글을 달기 위한 메소드
	public void replyNotice(String boardName, BoardData data) {
		String sql = "select min(step) from " + boardName + " where ref = " + data.getRef();
		sql += " and depth <= " + data.getDepth() + " and step > " + data.getStep();
		int mstep = adminExecuteQueryNum(sql);		
		int instep = 0;

		if(mstep > 0) {
			sql = "update " + boardName + " set step = step + 1 where ref = ";
			sql += data.getRef() + " and step >= " + mstep;
			adminExecuteUpdate(sql);
			instep = mstep;
		} else {
			sql = "select max(step) from " + boardName + " where ref = " + data.getRef();
			instep = adminExecuteQueryNum(sql) + 1;
		}

		int maxNum = getMaxNum(boardName) + 1;
		int depth = data.getDepth();
		sql = "Insert into " + boardName;
		sql += " (num, name, subject, content, writeDate, password, ";
		sql += "count, ref, step, depth, childCount)";
		sql += "values(" + maxNum + ", '" + data.getName() + "', '";
		sql += data.getSubject() + "', '" + data.getContent() + "', now()" + ", '" + data.getPassword();
		sql += "', 0, " + data.getRef() + ", " + instep + ", " + (++depth) + ", 0)";
		adminExecuteUpdate(sql);
		
		for(int r = depth - 1; r >= 0; r--) {
			sql = "select max(step) from " + boardName + " where ref = " + data.getRef();
			sql += " and depth = " + r + " and step < " + instep;
			int max_Step = adminExecuteQueryNum(sql);
		
			sql = "update " + boardName + " set childCount = childCount + 1 ";
			sql += "where ref = " + data.getRef() + " and depth = " + r + " and step = " + max_Step;
			adminExecuteUpdate(sql);
		}
		
		this.setSuccess(true);
	}
	
	// 한 페이지의 글목록을 Vector로 반환하는 메소드
	public Vector getPage(String boardName, int currentPage) {
		String sql = null;
		
		if(!(text.trim()).equals("")){ //제목을 찾는 sql문
			sql = "select * from " + boardName;
			sql += " where upper(" + search + ") like upper('%" + text + "%')";
			sql += " order by ref desc, step limit " + LINE_PER_PAGE * (currentPage - 1) + ", " + LINE_PER_PAGE;
		}else {
			sql = "select * from " + boardName;
			sql += " order by ref desc, step limit " + LINE_PER_PAGE * (currentPage - 1) + ", " + LINE_PER_PAGE;
		}
		return adminExecuteQuery(sql);
	}	
	
	// 페이징을 위한 메소드
	public String getPaging(String selectedID, int currentPage) {
		this.currentPage = currentPage;
		int recNum = this.getRecNum(selectedID);
		this.totalPage =((recNum - 1) / 10) + 1;
		
		String boardLink = "boardList.jsp?selectedID=" + selectedID;
		int startPage;
		int endPage;
		int linkPage;
		String strList = "";

		startPage = ((currentPage - 1) / PAGES_PER_GROUP) * PAGES_PER_GROUP + 1;
		endPage = (((startPage - 1) + PAGES_PER_GROUP) / PAGES_PER_GROUP) * PAGES_PER_GROUP;

		if(totalPage <= endPage) {
			endPage = totalPage;
		}
		
		if(currentPage > PAGES_PER_GROUP) {
			linkPage = startPage - 1;
			strList += "<a href='" + boardLink + "&page=" + linkPage + "'>[이전]</a>";
		}else{
			strList += "[이전]";
		}
		strList += "..";
		
		linkPage = startPage;
		while(linkPage <= endPage) {
			if(linkPage == currentPage){
				strList += "&nbsp;" + currentPage + "&nbsp;";
			} else {
				strList += "<a href='" + boardLink + "&page=" + linkPage + "'>[" + linkPage + "]</a>";
			}
			linkPage++;
		}
		strList += "..";
		
		if(totalPage > endPage) {
			linkPage = endPage + 1;
			strList += "<a href='" + boardLink + "&page=" + linkPage + "'>[이후]</a>";
		}else{
			strList += "[이후]";
		}
		
		return strList;
	}

	// 검색을 위한 변수 설정	
	public void setSearch(String search) {
		this.search = search;
	}
	public void setText(String text) {
		this.text = text;
	}

	// 글을 삭제하기 위한 메소드
	public String deleteNotice(String boardName, int num){
		String msg = new String();
		String sql = "select * from " + boardName + " where num=" + num;
		Vector v = adminExecuteQuery(sql);
		BoardData data = (BoardData)v.elementAt(0);
		int ref = data.getRef();
		int step = data.getStep();
		int depth = data.getDepth();
		int childCount = data.getChildCount();

		if(childCount == 0) {
			sql = "delete from " + boardName + " where num =" + num;
			adminExecuteUpdate(sql);
			
			sql = "select count(*) from " + boardName +" where num > '" + num + "'";
			int count = adminExecuteQueryNum(sql);

			for(int r = num+1; r <= num+count; r++) {
				sql = "update " + boardName + " set num = num-1 ";
				sql += "where num = " + Integer.toString(r);
				adminExecuteUpdate(sql);
			}

			for(int r = depth - 1; r >= 0; r--) {
				sql = "select max(Step) from " + boardName + " where ref = " + ref ;
				sql += " and depth = " + r + " and step < " + step;
				int max_Step = adminExecuteQueryNum(sql);
				sql = "update " + boardName + " set childCount = childCount-1 ";
				sql += "where ref = " + ref + " and depth = " + r + " and step =" + max_Step;
				adminExecuteUpdate(sql);
			}		
			msg = "OK";
			this.setSuccess(true);
		} else {
			msg = "답변이 있는 글은 삭제할 수 없습니다";
			this.setSuccess(false);
		}			
		return msg;
	}

	// 글의 조회수를 증가시키기 위한 메소드
	public void increaseCnt(String boardName, int num) {
		String sql = "update " + boardName;
		sql += " set count = count + 1 where num=" + num; 
		adminExecuteUpdate(sql);
	}


	// 이전 글과 다음 글의 번호를 구하기 위한 메소드
	public int[] getNextPrevNum(String boardName,int num) {
		int[] nums = new int[2];
		String sql = "select num from " + boardName;
		sql += " where num > " + num + " order by Num desc";
		nums[0] = adminExecuteQueryNum(sql);
		sql = "select num from " + boardName + " where num < " + num;
		nums[1] = adminExecuteQueryNum(sql);
		return nums;
	}

	// 작업 수행의 결과를 리턴
	public boolean getSuccess(){ 
		return success;	
	}

	// 작업 수행의 결과를 설정
	public void setSuccess(boolean success){ 
		this.success = success;	
	}
	
	// 레코드 수를 반환하기 위한 메소드
	public int getRecNum(String selectedID) {
		String sql = null;
		if(!(text.trim()).equals("")){
			sql = "select count(*) from board_" + selectedID;
			sql += " where upper(" + search + ") like upper('%" + text + "%')";
		} else {
			sql = "select count(*) from board_" + selectedID;
		}
		this.recNum = adminExecuteQueryNum(sql);
		return this.recNum;
	}
}
