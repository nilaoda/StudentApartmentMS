package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Func;
import net.sf.json.JSONObject;
import utils.JDBCUtils;

/**
 * Servlet implementation class DoRegUser
 */
@WebServlet("/DoRegUser")
public class DoRegUser extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DoRegUser()
	{
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// 设置响应内容类型
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/json; charset=utf-8");
		String jsonString = Func.readJSONString(request);
		JSONObject obj = JSONObject.fromObject(jsonString);
		String username = "", password = "";
		if (obj.getString("username") != null)
		{
			username = obj.getString("username");
		}
		if (obj.getString("password") != null)
		{
			password = obj.getString("password");
		}

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		JSONObject jsonmain = new JSONObject();
		PrintWriter out = response.getWriter();
		try
		{
			// 获得连接
			connection = JDBCUtils.getConnection();
			// 发送SQL语句
			String sqltemp = "select * from users where username=?";
			// 获得preparedStatement对象
			preparedStatement = connection.prepareStatement(sqltemp);
			preparedStatement.setString(1, username);
			resultSet=preparedStatement.executeQuery();
			if(resultSet.next()) {
				jsonmain.put("msg", "Dupe");
				out.println(jsonmain);
				return;
			}

			// 发送SQL语句
			String sql = "insert into users values (?,?)";
			// 获得preparedStatement对象
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, username);
			preparedStatement.setString(2, Func.MD5(password));
			int result = preparedStatement.executeUpdate();
			if (result != 0)
			{
				response.setStatus(200);
				jsonmain.put("msg", "OK");
			}
			else
			{
				response.setStatus(500);
				jsonmain.put("msg", "ERROR");
			}
			// 输出数据
			out.println(jsonmain);
		}
		catch (Exception e)
		{
			e.printStackTrace();
			jsonmain.put("msg", "ERROR");
			// 输出数据
			out.println(jsonmain);
		}
		finally
		{
			JDBCUtils.release(resultSet, preparedStatement, connection);
		}
	}

}
