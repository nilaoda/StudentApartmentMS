package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCUtils
{
	// 全局常量
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/xsgy";// 数据库连接地址
	private static final String UNAME = "root";// 数据库用户名
	private static final String UPSW = "root";
	private static final String DRIVER = "com.mysql.jdbc.Driver";

	public static Connection getConnection() throws SQLException, ClassNotFoundException
	{
		Class.forName(DRIVER);
		Connection connection = null;
		try
		{
			connection = DriverManager.getConnection(URL, UNAME, UPSW);
		}
		catch (SQLException e)
		{
			System.out.println("数据库连接失败");
		}
		return connection;
	}

	public static void release(Statement stmt, Connection conn)
	{
		if (stmt != null)
		{
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
		if (conn != null)
		{
			try
			{
				conn.close();
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
	}

	public static void release(ResultSet rs, Statement stmt, Connection conn)
	{
		if (rs != null)
		{
			try
			{
				rs.close();
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
			rs = null;
		}
		release(stmt, conn);
	}
}
