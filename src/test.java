import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.sf.json.JSONObject;
import utils.JDBCUtils;

public class test
{

	public static void main(String[] args)
	{
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try
		{
			// 获得连接
			connection = JDBCUtils.getConnection();
			for (int i = 1; i <= 2; i++)
			{
				for (int ii = 1; ii <= 5; ii++)
				{
					for (int iii = 1; iii <= 18; iii++)
					{
						// 发送SQL语句
						String sql = "insert into apartinfo values (?,?,?,?,?)";
						// 获得preparedStatement对象
						preparedStatement = connection.prepareStatement(sql);
						preparedStatement.setString(1, String.valueOf(i));
						preparedStatement.setString(2, String.valueOf(ii)+String.format("%2d", iii).replace(" ", "0"));
						preparedStatement.setString(3, String.valueOf(4));
						preparedStatement.setString(4, String.valueOf(0));
						preparedStatement.setString(5, "软件");
						int result = preparedStatement.executeUpdate();
						if (result != 0)
						{
							System.out.println("插入成功");
						}
					}
				}
			}
		}
		catch (ClassNotFoundException e)
		{
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		catch (SQLException e)
		{
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		finally
		{
			JDBCUtils.release(resultSet, preparedStatement, connection);
		}
	}

}
