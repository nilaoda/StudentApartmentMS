package servlet.system;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.Func;
import net.sf.json.JSONObject;
import utils.DBMSUtils;

/**
 * 数据库的备份与恢复
 */
@WebServlet("/DBMS")
public class DBMS extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DBMS()
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
		response.setContentType("text/json; charset=utf-8");
		String actionType = request.getParameter("action");
		System.out.println(actionType);
		// 验证权限
		HttpSession session = request.getSession();
		if (session.getAttribute("username") == null || session.getAttribute("username").toString().equals(""))
		{
			response.setStatus(403);
			response.getWriter().println("403 Forbidden");
			return;
		}
		if (actionType.equals("download"))
		{
			try
			{
				String command = "mysqldump -hlocalhost -uroot -proot xsgy";// 参数依次是IP、账号、密码、数据库名
				String savePath = Func.combine(getServletContext().getRealPath("/WEB-INF/sqls"),
						"sql-" + new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss").format(new Date()) + ".sql");
				System.out.println(savePath);
				JSONObject resObj = new JSONObject();
				// 执行操作
				boolean result = DBMSUtils.backup(command, savePath);
				if (result)
				{
					resObj.put("msg", "OK");
				}
				else
				{
					resObj.put("msg", "Error");
				}
				// 执行文件下载操作

				// 获取文件名
				String fileName = new File(savePath.trim()).getName();
				response.setCharacterEncoding("utf-8");
				response.setContentType("multipart/form-data");
				// 处理下载弹出框名字的编码问题
				response.setHeader("Content-Disposition",
						"attachment;fileName=" + new String(fileName.getBytes("gb2312"), "ISO8859-1"));
				// 获取文件的下载路径
				String path = savePath;
				System.out.println(path);
				// 利用输入输出流对文件进行下载
				InputStream inputStream = new FileInputStream(new File(path));

				OutputStream os = response.getOutputStream();
				byte[] b = new byte[2048];
				int length;
				while ((length = inputStream.read(b)) > 0)
				{
					os.write(b, 0, length);
				}
				os.close();
				inputStream.close();

				// 输出json
				System.out.println(resObj);
			}
			catch (FileNotFoundException e)
			{
				e.printStackTrace();
			}
			catch (IOException e)
			{
				e.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// 设置响应内容类型
		response.setContentType("text/json; charset=utf-8");
		// 验证权限
		HttpSession session = request.getSession();
		if (session.getAttribute("username") == null || session.getAttribute("username").toString().equals(""))
		{
			response.setStatus(403);
			response.getWriter().println("403 Forbidden");
			return;
		}
		try
		{
			// 工厂
			FileItemFactory fileItemFactory = new DiskFileItemFactory();
			// 核心类
			ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
			// 解析request ,List存放 FileItem
			List<FileItem> list = servletFileUpload.parseRequest(request);
			// 遍历集合获得数据
			for (FileItem fileItem : list)
			{
				if (fileItem.isFormField())
				{
					// 是否为表单字段（普通表单元素）
					String fieldName = fileItem.getFieldName();
					System.out.println(fieldName);
					String fieldValue = fileItem.getString();
					System.out.println(fieldValue);
				}
				else
				{
					// 上传字段（上传表单元素）
					String fileName = fileItem.getName();
					fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
					// 上传内容
					InputStream is = fileItem.getInputStream(); // 获得输入流，
					String parentDir = this.getServletContext().getRealPath("/WEB-INF/upload");
					File file = new File(parentDir, fileName);
					if (!file.getParentFile().exists())
					{ // 父目录不存在
						file.getParentFile().mkdirs();
					}
					FileOutputStream out = new FileOutputStream(file);
					byte[] buf = new byte[1024];
					int len1 = -1;
					while ((len1 = is.read(buf)) != -1)
					{
						out.write(buf, 0, len1);
					}

					// 关闭
					out.close();
					is.close();

					String command = "mysql.exe -hlocalhost -uroot -proot --default-character-set=utf8 xsgy";// 参数依次是IP、账号、密码、数据库名
					String savePath = Func.combine(parentDir, fileName);
					JSONObject resObj = new JSONObject();
					// 执行操作
					boolean result = DBMSUtils.recover(command, savePath);
					if (result)
					{
						resObj.put("msg", "OK");
					}
					else
					{
						resObj.put("msg", "Error");
					}

					// 输出json
					response.getWriter().println(resObj);
				}
			}

		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}

}
