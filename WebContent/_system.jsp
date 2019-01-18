<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="layui/css/layui.css" media="all">
 <script src="layui/layui.js"></script>
</head>
<!-- 检测是否登陆 -->
<%@include file="/IsLogin.jsp" %>
<body>
<div  style="max-width:1500px;margin:0 auto;">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;margin-left: 10px;padding:10px;">
	  <legend>数据库备份</legend>
		  <a href="/StudentApartmentMS/DBMS?action=download" class="layui-btn"><i class="layui-icon layui-icon-download-circle"></i>下载.sql文件</a>
		  <div class="layui-inline">
			  <div class="layui-form-mid layui-word-aux">&nbsp;&nbsp;点击一次即可，等待服务器响应</div>
		  </div>
	</fieldset>
	
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;margin-left: 10px;padding:10px;">
	  <legend>数据库恢复</legend>
	  <div class="layui-upload">
		  <button type="button" class="layui-btn layui-btn-normal" id="uploadSelect">选择.sql文件</button>
		  <button type="button" class="layui-btn" id="uploadSql" name="uploadSql"><i class="layui-icon layui-icon-upload"></i>开始上传</button>
		</div>
	</fieldset>
	
	
	<script>
	layui.use('upload', function(){
		  var $ = layui.jquery
		  ,upload = layui.upload;
		  
		//选完文件后不自动上传
		  upload.render({
		    elem: '#uploadSelect'
		    ,url: '/StudentApartmentMS/DBMS?action=upload'
		    ,auto: false
		    //,multiple: true
		    ,bindAction: '#uploadSql'
		    ,exts: 'sql' //只允许上传sql文件
		    ,done: function(res){
		    	layui.layer.msg('数据库恢复成功');
		    }
		  });
	});
	</script>
</div>
</body>
</html>