package servlet.student;

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

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import utils.JDBCUtils;

/**
 * 获取学生表内容 返回json
 */
@WebServlet("/GetStudentJson")
public class GetStudentJson extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetStudentJson()
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
		// 设置响应内容类型
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/json; charset=utf-8");
		String keyword = "";
		String key_bno = "", key_dno = "";
		int page = 0, limit = 0;
		if (request.getParameter("_keyword") != null)
		{
			// 两次解码 先用ISO-8859-1解码，后用UTF-8
			keyword = new String(request.getParameter("_keyword").getBytes("ISO-8859-1"), "UTF-8");
			System.out.println(keyword);
		}
		// 用于指定公寓和宿舍号查询学生情况
		if (request.getParameter("bno") != null)
			key_bno = request.getParameter("bno");
		if (request.getParameter("dno") != null)
			key_dno = request.getParameter("dno");
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		if (request.getParameter("limit") != null)
			limit = Integer.parseInt(request.getParameter("limit"));
		int count = 0; // 已输出行数
		int percount = 0; // 每页已输出行数
		PrintWriter out = response.getWriter();
		// 验证权限
		HttpSession session = request.getSession();
		if (session.getAttribute("username") == null || session.getAttribute("username").toString().equals(""))
		{
			response.setStatus(403);
			out.println("403 Forbidden");
			return;
		}
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		try
		{
			// 获得连接
			connection = JDBCUtils.getConnection();
			// 获得statement对象
			statement = connection.createStatement();
			// 发送SQL语句
			String sqltemp = "select count(*) totalCount from student";
			if (keyword != "")
			{
				sqltemp += (" where no Like '%{key}%' OR name Like '%{key}%' OR sex Like '%{key}%' OR college Like '%{key}%' OR major Like '%{key}%' OR class Like '%{key}%' OR Bno Like '%{key}%' OR Dno Like '%{key}%'")
						.replace("{key}", keyword);
			}
			if (key_bno != "" && key_dno != "")
				sqltemp += " where Bno='" + key_bno + "' AND Dno='" + key_dno + "'";
			ResultSet rset = statement.executeQuery(sqltemp);
			int rowCount = 0;
			if (rset.next())
			{
				rowCount = rset.getInt("totalCount");
			}

			String sql = "select * from student";
			if (keyword != "")
			{
				sql += (" where no Like '%{key}%' OR name Like '%{key}%' OR sex Like '%{key}%' OR college Like '%{key}%' OR major Like '%{key}%' OR class Like '%{key}%' OR Bno Like '%{key}%' OR Dno Like '%{key}%'")
						.replace("{key}", keyword);
			}
			if (key_bno != "" && key_dno != "")
				sql += " where Bno='" + key_bno + "' AND Dno='" + key_dno + "'";
			resultSet = statement.executeQuery(sql);
			JSONObject jsonmain = new JSONObject();
			jsonmain.put("code", "200");
			jsonmain.put("msg", "none");
			jsonmain.put("count", rowCount);
			JSONArray jsonarray = new JSONArray();
			JSONObject jsonobj = new JSONObject();
			// 展开结果集数据库
			while (resultSet.next())
			{
				if (count++ < (page - 1) * limit)
					continue;
				if (percount > limit)
					break;
				// 通过字段检索
				jsonobj.put("_id", resultSet.getString("no"));
				jsonobj.put("_name", resultSet.getString("name"));
				jsonobj.put("_sex", resultSet.getString("sex"));
				jsonobj.put("_class", resultSet.getString("class"));
				jsonobj.put("_major", resultSet.getString("major"));
				jsonobj.put("_college", resultSet.getString("college"));
				jsonobj.put("_bno", resultSet.getString("Bno"));
				jsonobj.put("_dno", resultSet.getString("Dno"));

				jsonarray.add(jsonobj);
				count++;
				percount++;
			}
			// 输出数据
			jsonmain.put("data", jsonarray);
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
			JDBCUtils.release(resultSet, statement, connection);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
