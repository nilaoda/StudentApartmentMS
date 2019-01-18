<%@ page contentType="text/html; charset=utf-8"%>
<%
	if (session.getAttribute("username") == null || session.getAttribute("username").toString().equals(""))
	{
		response.sendRedirect(request.getContextPath() + "/LoginNew.jsp");
		return;
	}
%>