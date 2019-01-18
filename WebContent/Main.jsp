<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>学生公寓管理系统 - 太原理工大学</title>
  <link rel="stylesheet" href="layui/css/layui.css" media="all">
  <script src="layui/layui.js"></script>
  <link rel="shortcut icon" href="img/favicon.ico" />
  <link rel="bookmark"href="img/favicon.ico" />
</head>
<!-- 检测是否登陆 -->
<%@include file="/IsLogin.jsp" %>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo" style="color:#FFF;"><i class="layui-icon layui-icon-home"></i>&nbsp;学生公寓管理系统</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <%
    	//获取url中的参数值
    	String pageName = "", cStu="",cApart="",cSearch="",cProperty="",cRegister="",cSystem="";
    	request.setCharacterEncoding("utf-8");
    	if (!request.getParameterMap().isEmpty()){
    		pageName = request.getParameter("page");
    		if(pageName.equals("student"))
    			cStu=" layui-this";
    		else if(pageName.equals("apart"))
    			cApart=" layui-this";
    		else if(pageName.equals("search"))
    			cSearch=" layui-this";
    		else if(pageName.equals("property"))
    			cProperty=" layui-this";
    		else if(pageName.equals("register"))
    			cRegister=" layui-this";
    		else if(pageName.equals("system"))
    			cSystem=" layui-this";
    	}
    	else{
    		pageName = "apart";
    		cApart=" layui-this";
    	}
    %>
    <ul class="layui-nav layui-layout-left">
	      <li class="layui-nav-item<%=cApart%>"><a href="Main.jsp?page=apart">寝室分配</a></li>
	      <li class="layui-nav-item<%=cStu%>"><a href="Main.jsp?page=student">学生管理</a></li>
	      <li class="layui-nav-item<%=cProperty%>"><a href="Main.jsp?page=property">财产管理</a></li>
	      <li class="layui-nav-item<%=cRegister%>"><a href="Main.jsp?page=register">出入登记</a></li>
          <li class="layui-nav-item<%=cSystem%>"><a class="" href="Main.jsp?page=system">系统管理</a></li>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
          <i class="layui-icon layui-icon-username"></i>&nbsp;${sessionScope.username}
      </li>
      <li class="layui-nav-item"><a href="/StudentApartmentMS/DoLogout">退出<span class="layui-badge-dot"></span></a></li>
    </ul>
  </div>
  
  
  <div class="layui-body" style="left:0px;">
    <!-- 内容主体区域 -->
    <iframe src="./_<%=pageName%>.jsp" frameborder="0" width="100%" height="100%" id="contentIframe"></iframe>
  </div>
  <script>
	layui.use('element', function(){
	  var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
	  
	});
</script>
  <div class="layui-footer" style="left:0px;text-align:center;">
    <!-- 底部固定区域 -->
    © TYUT - 学生公寓管理系统 2019
  </div>
</div>
</body>
</html>