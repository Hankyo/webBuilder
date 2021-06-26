
package manager;
import java.util.*;
import java.sql.*;

import DataCapsuled.BoardData;
import DataCapsuled.CategoryData;

public class CategoryManager extends AdminManager{
	private int recNum = 0;							// ��ü ���ڵ� ��

	public int getMaxNum(String categoryName){
		String sql = "select max(Num) from " + categoryName;
		int maxNum = adminExecuteQueryNum(sql);
		return maxNum;
	}
	
	public boolean existCategory(String name) {
        String sql = "select count(name) from category where name='" + name + "'";
        int num = this.adminExecuteQueryNum(sql);
        
        if(num == 0){
            return false;
        } else {
            return true;
        }
    }
	public CategoryData getCategory(String categoryName, int step) {
		String sql = "select * from " + categoryName + " where step=" + step;
		Vector v = adminExecuteQuery(sql);
		CategoryData data = (CategoryData)v.elementAt(0);
		return data;
	}

	public void updateCategory(String categoryName, CategoryData data) {
		String sql = "update " + categoryName + " set name='" + data.getName();
		sql += "', step='" + data.getStep();
		sql += "' where step=" + data.getStep();
		adminExecuteUpdate(sql);
	}

	public String deleteCategory(String categoryName, int step){
		String msg = new String();
		
		String sql = "select count(*) from category where step>" + step;
		int count = adminExecuteQueryNum(sql);
		System.out.println(count);
		
		sql = "delete from category where step = " + step;
	    adminExecuteUpdate(sql);

		for(int r =step+1; r <= step+count; r++) {
			sql = "update category set step = step-1 ";
			sql += "where step = " + r;
			adminExecuteUpdate(sql);
			
			sql = "update content set category_id = category_id -1 ";
			sql += "where category_id = " + r;
			adminExecuteUpdate(sql);
		}
		msg = "OK";		
		
		return msg;
	}
	
	// 카테고리 생성
	public void writeCategory(String categoryName, CategoryData data) {
		String sql = "Insert into " + categoryName + " ";
		sql += "(name , step ) ";
		sql += " values(" + data.getName() +", " + data.getStep() +')';
		
		adminExecuteUpdate(sql);
	}
}
