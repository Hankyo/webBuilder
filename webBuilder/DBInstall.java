package install;

import manager.AdminManager;
import DBConnector.*;

public class DBInstall{
	private static AdminManager adminManager = AdminManager.getInstance();
	private static ConnectionFactory connFact = ConnectionFactory.getDefaultFactory();	
	
	public DBInstall(){}
	
	public void connectorReload() throws Exception{
		connFact.setConnectionFromFile("./dbConfig.txt");
		ConnectionPool.initConnectionPool();
	}
	private void installCategoryTable(){
		String sql;
		
		sql = "CREATE TABLE category (";          
        sql += "name VARCHAR(45) NOT NULL PRIMARY KEY,";
        sql += "step INT NOT NULL";
        sql += ");";
        adminManager.executeUpdate(sql);
	}
	private void installContentTable(){
		String	sql = " CREATE  TABLE content (" ;          
		sql += " id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,";
		sql += " category VARCHAR(45) NOT NULL,";
		sql += " name VARCHAR(45) NULL ,";
		sql += " descriptor TEXT NULL ,";
		sql += " type VARCHAR(45) NULL ,";
		sql += " FOREIGN KEY (category) REFERENCES category(name) ON UPDATE CASCADE ON DELETE CASCADE";
		sql += ");";
		adminManager.executeUpdate(sql);
	}
	private void installBoardAdminTable(){
		String sql = " CREATE  TABLE `BoardAdmin` (" ;          
		sql += "  `id` INT NOT NULL PRIMARY KEY ,";
		sql += "  `rdlevel` INT NULL ,";
		sql += "  `wrlevel` INT NULL ,";
		sql += " `lstlevel` INT NULL ,";
		sql += " FOREIGN KEY (id) REFERENCES content(id)";
		sql += ");";
		adminManager.executeUpdate(sql);
	}
	private void installLinkTable(){
		String sql = "CREATE  TABLE link (" ;          
		sql += "  id INT NOT NULL PRIMARY KEY,";
		sql += "  url TEXT NULL ,";
		sql += "  FOREIGN KEY (id) REFERENCES content(id)";
		sql += ");";
		adminManager.executeUpdate(sql);
	}
	private void installStaticTable(){
		String sql = " CREATE  TABLE static (" ;          
		sql += "  id INT NOT NULL PRIMARY KEY,";
		sql += "  content TEXT NULL ,";
		sql += "  FOREIGN KEY (id) REFERENCES content(id)";
		sql += ")";
		adminManager.executeUpdate(sql);	
	}
	private void installMemberTable(){ 
		String sql = " CREATE  TABLE `member` (" ;          
		sql += " `user_id` VARCHAR(10) NOT NULL ,";
		sql += " `password` TEXT NOT NULL ,";
		sql += "  `grade` INT NULL ";
		sql += ")";
		adminManager.executeUpdate(sql);
	}
	public void installTables(){
		this.installCategoryTable();
		this.installContentTable();
		this.installBoardAdminTable();
		this.installLinkTable();
		this.installStaticTable();
		this.installMemberTable();
	}
}
