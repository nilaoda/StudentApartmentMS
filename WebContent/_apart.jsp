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
	<div class="layui-card">
	<!-- 原始table容器 -->
	<div id="noDisplayTable" style="display:none;">
		<table class="layui-hide" id="stuTable" lay-filter="stuTable"></table>
	</div>
    <script type="text/html" id="barDemo">
	 <a class="layui-btn layui-btn-xs" lay-event="detail"><i class="layui-icon layui-icon-tips"></i>查看住户</a>
	</script>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
	  <legend>搜索</legend>
	</fieldset>  
	<div class="layui-card">
		<div class="layui-card-body">
			<form class="layui-form layui-form-pane" lay-filter="example">
				<div class="layui-inline" style="width: auto;">
						<label class="layui-form-label">公寓号</label>
						<div class="layui-inline" style="width: auto;">
						<select name="building" lay-verify="">
						  <option value="">请选择一个公寓</option>
						  <option value="1">1</option>
						  <option value="2">2</option>
						</select>     
						</div>
						<div class="layui-inline" style="width: auto;">
						<label class="layui-form-label">关键字</label>
					    <div class="layui-input-block">
					      <input type="text" name="dormitory" required  lay-verify="required" placeholder="请输入关键字" autocomplete="off" class="layui-input">
					    </div>
					    </div>
				</div>
				<div class="layui-inline">
					      <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="demo1"><i class="layui-icon layui-icon-search"></i>搜索宿舍</button>
				</div>
				<div class="layui-inline">
					      <div class="layui-form-mid layui-word-aux">&nbsp;&nbsp;关键字可以是宿舍号、学院名</div>
				</div>
			</form>
		</div>
	</div>
	<!-- 原始table容器 -->
    <table class="layui-hide" id="apartTable" lay-filter="apartTable"></table>
	<script>
	//创建一个表格
	layui.use(['layer', 'form', 'table', 'element'], function(){
	  var layer = layui.layer
	  ,form = layui.form
	  ,table = layui.table //表格
	  ,element = layui.element; //元素操作
	  
	//表单初始赋值
	  form.val('example', {
	    "building": "1"
	  });
	  
	//监听表单提交
	  form.on('submit(demo1)', function(data){
    		table.reload('apartTable', {
    			url:'/StudentApartmentMS/GetApartJson'
      			,where: data.field
			  });
    	    return false;  //不跳转
	  });
	  
	  table.render({
		    elem: '#apartTable'
		    ,cellMinWidth: 120
		    ,url:'/StudentApartmentMS/GetApartJson'
		    ,toolbar: "true"
		    ,title: '公寓表'
		    ,cols: [[
		      {field:'_bno', title:'公寓号', fixed: 'left', sort: true}
		      ,{field:'_dno', title:'宿舍号'}
		      ,{field:'_allpeo', title:'总人数'}
		      ,{field:'_livepeo', title:'已住人数', sort: true}
		      ,{field:'_belongSchool', title:'所属学院'}
		      ,{fixed: 'right', align:'center', width:120, toolbar: '#barDemo'}
		    ]]
		  	,limit: 12
		  	,limits: [12,30,60,80,100]
		    ,page: true
		    ,response: {
		      statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
		    }
		  });
	  
	  //监听行工具事件
	  table.on('tool(apartTable)', function(obj){
	    var data = obj.data //获得当前行数据
	    ,layEvent = obj.event //获得 lay-event 对应的值
	    ,$ = layui.jquery;
	    if(layEvent === 'detail'){
	    	//显示层
	    	layer.open({
	    		  title: '查看'+data._bno+'-'+data._dno+'住户：'
	    		  ,type: 1
	    		  ,area: ['750px', '260px']
	    		  ,content: $('#noDisplayTable')
	    		  ,end: function(index, layero){ 
	    			  
	    			}  
	    		}); 
	    	
	    	//绘制表格
	    	table.render({
			    elem: '#stuTable'
			    ,cellMinWidth: 120
			    ,url:'/StudentApartmentMS/GetStudentJson?dno='+data._dno+'&bno='+data._bno
			    ,title: '学生表'
			    ,cols: [[
				      {field:'_id', title:'学号', fixed: 'left'}
				      ,{field:'_name', title:'姓名'}
				      ,{field:'_sex', title:'性别'}
				      ,{field:'_major', title:'专业'}
				      ,{field:'_college', title:'学院'}
				      ,{field:'_class', title:'班级'}
			    ]]
			    ,response: {
			      statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
			    }
			  });
	    } 
	  });
	  
	});
	</script>
	</div>
</div>
</body>
</html>