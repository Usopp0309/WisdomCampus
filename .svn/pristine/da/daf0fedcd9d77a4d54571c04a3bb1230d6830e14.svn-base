package com.guotop.palmschool.system.thread;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.guotop.palmschool.util.PropertiesUtil;
import com.guotop.palmschool.util.StringUtil;
import com.mysql.jdbc.Connection;

/**
 * 数据库创建线程
 * @author jfy
 */
public class InitSchoolDataBaseThread extends Thread
{
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private Long schoolId;
	
	private String schoolName;
	
	private String schoolCategory;
	
	public InitSchoolDataBaseThread(Long schoolId, String schoolName, String schoolCategory)
	{
		this.schoolId = schoolId;
		this.schoolName = schoolName;
		this.schoolCategory = schoolCategory;
		this.start();
	}
	
	@Override
	public void run() 
	{
		Connection conn = null;
		Statement statement = null;
		try {
			String filePath = getClass().getResource("/").getFile().toString().replaceAll("%20", " "); 
			if (schoolCategory != null && schoolCategory.equals("0"))
			{
				filePath += "com/guotop/palmschool/db/palm_school_kindergarten.sql";
			}else
			{
				filePath += "com/guotop/palmschool/db/palm_school.sql";
			}
			
			//学校名缩写+学校编码做数据库名
			String abbreviatedName = StringUtil.getPYIndexStr(this.schoolName, true);
			String dataBseName = abbreviatedName + schoolId;
			Properties pro = PropertiesUtil.getInstance().read("../properties/jdbc.properties");
			String url = pro.getProperty("jdbc.url");  
			String driver = pro.getProperty("jdbc.driverClassName");  
			String username = pro.getProperty("jdbc.username");  
			String password = pro.getProperty("jdbc.password");  
			Class.forName(driver).newInstance();  
			conn = (Connection) DriverManager.getConnection(url, username, password);  
			conn.setAutoCommit(false);
			statement = conn.createStatement();
			String newUrl = url.replace("platform", dataBseName);
			String insertSql =  "insert into school_datasource(schoolId,userName,passWord,url,driverClass,schoolName) values('"+ this.schoolId +"','" + username + "','" + password + "','"+ newUrl +"','" + driver + "','" + this.schoolName + "');";
			statement.executeUpdate(insertSql);
			
			List<String> sqlList = new ArrayList<String>();
			//创建数据库
			sqlList.add("CREATE DATABASE /*!32312 IF NOT EXISTS*/`" + dataBseName + "` /*!40100 DEFAULT CHARACTER SET utf8 */;");
			sqlList.add("USE `" + dataBseName  + "`;");
			sqlList.addAll(loadSql(filePath));
			for (String sql : sqlList){
				try{
					statement.executeUpdate(sql);
				}catch(SQLException se){
					logger.error("错误的SQL如下："+sql);
					logger.error("初始化学校数据conn回滚的时候出错,SQL执行出错，错误信息如下："+se);
					break;
				}				
			}
			conn.commit();
			conn.setAutoCommit(true);
			
			
		} catch (Exception e) {
			if (conn != null){
				try {
					conn.rollback();
				} catch (SQLException e1) {
					logger.error("初始化学校数据conn回滚的时候出错,错误信息如下："+e1);
				}
			}
		}finally{
			if (statement != null){
				try {
					statement.close();
				} catch (SQLException e) {
					logger.error("初始化学校数据statement关闭的时候出错,错误信息如下："+e);
				}
			}
			
			if (conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					logger.error("初始化学校数据conn关闭的时候出错,错误信息如下："+e);
				}
			}
		}
		
		
	}
	
	  /** 
     * 读取 SQL 文件，获取 SQL 语句 
     * @param sqlFile SQL 脚本文件 
     * @return List<sql> 返回所有 SQL 语句的 List 
     * @throws Exception 
     */  
	private  List<String> loadSql(String sqlFile) throws Exception {  
        List<String> sqlList = new ArrayList<String>();  
  
        try {  
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(sqlFile),"utf-8"));
  
            StringBuffer sqlSb = new StringBuffer();  
            String data = null;
            while((data = br.readLine())!=null)
            {
            	sqlSb.append(data);
            }
            br.close();
            // Windows 下换行是 /r/n, Linux 下是 /n  
            String[] sqlArr = sqlSb.toString().split(";"); 
            for (int i = 0; i < sqlArr.length; i++) {  
                String sql = sqlArr[i].replaceAll("--.*", "").trim();  
                if (!sql.equals("")) {  
                    sqlList.add(sql.replaceAll("//", ";"));  
                }  
            }  
           
            return sqlList;  
        } catch (Exception ex) {  
            throw new Exception(ex.getMessage());  
        }  
    }   

	public static void main(String[] args) throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException
	{
		Connection conn = null;
		Statement statement = null;
		String url = "jdbc:mysql://192.168.0.249:3306/txqzxxx3201140001?characterEncoding=utf-8";  
		String driver = "com.mysql.jdbc.Driver";  
		String username = "palmSchool";  
		String password = "palmSchool";  
		Class.forName(driver).newInstance();  
		conn = (Connection) DriverManager.getConnection(url, username, password);  
		conn.setAutoCommit(false);
		statement = conn.createStatement();
		String sql = "";
		statement.executeUpdate(sql);
	}
}
