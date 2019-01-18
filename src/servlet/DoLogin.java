package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.PreparedStatement;

import dao.Func;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import utils.JDBCUtils;

/**
 * Servlet implementation class DoLogin
 */
@WebServlet("/DoLogin")
public class DoLogin extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DoLogin()
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
		String username = "", password = "", correctPassword = "";
		if (obj.getString("username") != null)
		{
			username = obj.getString("username");
		}
		if (obj.getString("password") != null)
		{
			password = obj.getString("password");
			password = Func.MD5(password);
		}

		PrintWriter out = response.getWriter();
		Connection connection = null;
		java.sql.PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		JSONObject jsonmain = new JSONObject();
		try
		{
			// 获得连接
			connection = JDBCUtils.getConnection();
			// 获得statement对象
			String sql = "select * from users where username=?";
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, username);
			resultSet = preparedStatement.executeQuery();

			if (resultSet.next())
			{
				correctPassword = resultSet.getString("password");
			}

			if (correctPassword.equals(password))
			{
				// 输出数据
				jsonmain.put("msg", "OK");
				HttpSession session = request.getSession();
				session.setAttribute("username", username);
			}
			else
			{
				jsonmain.put("msg", "ERROR");
			}
			out.println(jsonmain);
		}
		catch (Exception e)
		{
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
