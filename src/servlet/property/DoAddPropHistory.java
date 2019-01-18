package servlet.property;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.Func;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import utils.JDBCUtils;

/**
 * 操作数据库更新财产提取记录
 */
@WebServlet("/DoAddPropHistory")
public class DoAddPropHistory extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DoAddPropHistory()
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
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();

		// 获取url中的参数值
		String pname = "", name = "", bno = "", pcount = "";
		String jsonString = Func.readJSONString(request);
		JSONObject obj = JSONObject.fromObject(jsonString);
		pname = obj.get("_pname").toString();
		name = obj.get("_name").toString();
		bno = obj.get("_bno").toString();
		pcount = obj.get("_pcount").toString();
		// 验证权限
		HttpSession session = request.getSession();
		if (session.getAttribute("username") == null || session.getAttribute("username").toString().equals(""))
		{
			response.setStatus(403);
			out.println("403 Forbidden");
			return;
		}
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try
		{
			// 获得连接
			connection = JDBCUtils.getConnection();
			// 发送SQL语句
			String sql = "insert into asset_history values (?,?,?,?,?)";
			// 获得preparedStatement对象
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			preparedStatement.setString(2, bno);
			preparedStatement.setString(3, pname);
			preparedStatement.setString(4, pcount);
			preparedStatement.setString(5, name);
			int result = preparedStatement.executeUpdate();
			JSONObject jsonmain = new JSONObject();
			if (result != 0)
			{
				response.setStatus(200);
				jsonmain.put("code", "200");
				jsonmain.put("msg", "updated");
			}
			else
			{
				response.setStatus(500);
				jsonmain.put("code", "500");
				jsonmain.put("msg", "Error");
			}
			// 输出数据
			out.println(jsonmain);
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
