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
    <script type="text/html" id="barDemo">
     <a class="layui-btn layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
     <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
	</script>
	<script type="text/html" id="barHeadDemo">
     <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添加学生</a>
	</script>
<div  style="max-width:1500px;margin:0 auto;">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
	  <legend>搜索</legend>
	</fieldset>  
	<div class="layui-card">
		<div class="layui-card-body">
			<form class="layui-form layui-form-pane" lay-filter="example">
				<div class="layui-inline" style="width: auto;">
						<label class="layui-form-label">信息查询</label>
					    <div class="layui-input-block">
					      <input type="text" name="_keyword" required  lay-verify="required" placeholder="请输入关键字" autocomplete="off" class="layui-input">
					    </div>
				</div>
				<div class="layui-inline">
					      <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="demo1"><i class="layui-icon layui-icon-search"></i>搜索学生</button>
				</div>
				<div class="layui-inline">
					      <div class="layui-form-mid layui-word-aux">&nbsp;&nbsp;关键字可以是任意列的值</div>
				</div>
			</form>
		</div>
	</div>
	<div class="layui-card">
	<!-- 原始table容器 -->
    <table class="layui-hide" id="stuTable" lay-filter="stuTable"></table>
	<script>
	//创建一个表格
	layui.use(['layer', 'form', 'table', 'element'], function(){
	  var layer = layui.layer
	  ,form = layui.form
	  ,table = layui.table //表格
	  ,element = layui.element //元素操作
	  ,$ = layui.jquery;
		
	//监听表单提交
	  form.on('submit(demo1)', function(data){
    		table.reload('stuTable', {
    			url:'/StudentApartmentMS/GetStudentJson'
      			,where: data.field
			  });
    	    return false;  //不跳转
	  });
	  
	  table.render({
		    elem: '#stuTable'
		    ,cellMinWidth: 120
		    ,url:'/StudentApartmentMS/GetStudentJson'
		    ,toolbar: '#barHeadDemo'
		    ,title: '学生表'
		    ,cols: [[
		      {field:'_id', title:'学号', fixed: 'left', sort: true}
		      ,{field:'_name', title:'姓名'}
		      ,{field:'_sex', title:'性别'}
		      ,{field:'_major', title:'专业'}
		      ,{field:'_college', title:'学院'}
		      ,{field:'_class', title:'班级', sort: true}
		      ,{field:'_bno', title:'公寓号'}
		      ,{field:'_dno', title:'宿舍号'}
		      ,{fixed: 'right', align:'center', width:160, toolbar: '#barDemo'}
		    ]]
		  	,limit: 12
		  	,limits: [12,30,60,80,100]
		    ,page: true
		    ,response: {
		      statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
		    }
		  });
	  
	  //监听行工具事件
	  table.on('tool(stuTable)', function(obj){
	    var data = obj.data //获得当前行数据
	    ,layEvent = obj.event; //获得 lay-event 对应的值
	    //删除操作
	    if(layEvent === 'del'){
	      layer.confirm('真的删除'+data._id+'么', function(index){
		      //请求服务器
	  		  $.ajax({
		              url: '/StudentApartmentMS/DoDel?id='+data._id,
		              type: 'GET',
		              async: false,
		              dataType: 'json',
		              success: function (data) {
		            	obj.del(); //删除对应行（tr）的DOM结构
		            	layer.close(index);
	                    layer.msg("删除成功", {time:3000});
		              },
		              error: function () {
	                    layer.msg("删除失败", {time:3000});
		              }
		          });
	      });
	    } 
	    //编辑操作
	    else if(layEvent === 'edit'){

  		        //赋值表单操作
				$("#addStuForm")[0].reset();
				form.render(null, 'addStuForm');
				//表单初始赋值
				form.val('addStuForm', {
				  "_major": data._major
				  ,"_college": data._college
				  ,"_id": data._id
				  ,"_name": data._name
				  ,"_class": data._class
				  ,"_sex": data._sex
				});
				
	    	layer.open({
	    		  title: '编辑：'+ data._id
		    	  ,btn: ['更改','取消']
			      ,success: function (layero, index) {
			    	    //添加form标识
		                layero.addClass('layui-form');
		                //将按钮重置为可提交按钮以触发表单验证
		                layero.find('.layui-layer-btn0').attr('lay-filter', 'formContent').attr('lay-submit', '');
		                form.render(); 
		          }
		    	  ,yes: function(index, layero){
		    		  //监听提交按钮
		    		  form.on('submit(formContent)', function (data) {
			    		  //转为json字符串
			    		  var formObject = {};
			    		  var formArray =$('#layui-layer'+index).find('form').serializeArray();
			    		  $.each(formArray,function(i,item){
			    			  formObject[item.name] = item.value;
			    			  });
			    		  var formJson = JSON.stringify(formObject);
			    		  console.log(formJson);
			    		  //请求服务器
			    		  $.ajax({
				              url: '/StudentApartmentMS/DoUpdate',
				              type: 'POST',
				              data: formJson,
				              async: false,
				              dataType: 'json',
				              success: function (data) {
			                      layer.msg("修改成功", {time:3000});
				    			  table.reload('stuTable', {
				    			  });
						    	  layer.closeAll();
				              },
				              error: function () {
			                      layer.msg("修改失败", {time:3000});
				              }
				          });
                      });
		    	  }
		    	  ,btn2: function(index, layero){
		    		    //按钮【按钮二】的回调
		    	  }
	    		  ,type: 1
	    		  ,area: ['400px', '455px']
	    		  ,content: $('#noDisplayFormAdd')
	    		  ,end: function(index, layero){ 
	    				// 清空表单
	    				$("#addStuForm")[0].reset();
	    				form.render(null, 'addStuForm');
	    				//表单初始赋值
	    				form.val('addStuForm', {
	    				  "_major": "软件工程"
	    				  ,"_college": "软件"
	    				});
	    			}   
	    		}); 
	    }
	  });
	  
	  //监听头工具栏事件
	  table.on('toolbar(stuTable)', function(obj){
	    var checkStatus = table.checkStatus(obj.config.id)
	    ,data = checkStatus.data; //获取选中的数据
	    switch(obj.event){
	      case 'add':
	    	  layer.open({
	    		  title: '添加：'
		    	  ,btn: ['添加','取消']
		    	  ,success: function (layero, index) {
		    			//添加form标识
		                layero.addClass('layui-form');
		                //将按钮重置为可提交按钮以触发表单验证
		                layero.find('.layui-layer-btn0').attr('lay-filter', 'formContent').attr('lay-submit', '');
		                form.render(); 
		          }
		    	  ,yes: function(index, layero){
		    		  //监听提交按钮
		    		  form.on('submit(formContent)', function (data) {
			    		  //转为json字符串
			    		  var formObject = {};
			    		  var formArray =$('#layui-layer'+index).find('form').serializeArray();
			    		  $.each(formArray,function(i,item){
			    			  formObject[item.name] = item.value;
			    			  });
			    		  var formJson = JSON.stringify(formObject);
			    		  console.log(formJson);
			    		  //请求服务器
			    		  $.ajax({
				              url: '/StudentApartmentMS/DoAdd',
				              type: 'POST',
				              data: formJson,
				              async: false,
				              dataType: 'json',
				              success: function (data) {
			                      layer.msg("添加学生成功，并已自动分配宿舍", {time:3000});
				    			  table.reload('stuTable', {
				    			  });
						    	  layer.closeAll();
				              },
				              error: function () {
			                      layer.msg("添加失败", {time:3000});
				              }
				          });
		    		  });
		    	  }
		    	  ,btn2: function(index, layero){
		    		    //按钮【按钮二】的回调
		    	  }
	    		  ,type: 1
	    		  ,area: ['400px', '455px']
	    		  ,content: $('#noDisplayFormAdd')
	    		  ,end: function(index, layero){ 
	    				// 清空表单
	    				$("#addStuForm")[0].reset();
	    				form.render(null, 'addStuForm');
	    				//表单初始赋值
	    				form.val('addStuForm', {
	    				  "_major": "软件工程"
	    				  ,"_college": "软件"
	    				});
	    			}   
	    		}); 
	      break;
	    };
	  });
	  
	//添加表单初始赋值
		form.val('addStuForm', {
		  "_major": "软件工程"
		  ,"_college": "软件"
		});
	
	//表单验证
		form.verify({
			stuno: [
			  /^[\S]{10}$/
			  ,'学号必须10位，且不能出现空格'
			],
			clssno: [
			  /^[\S]{4}$/
			  ,'班号必须4位，且不能出现空格'
			] 
	    });
	
	});
	
	
	</script>
	</div>
</div>
	<!-- 以下是隐藏的表单容器 -->
	<div id="noDisplayFormAdd" style="display:none;">
		<div class="layui-card">
		<div class="layui-card-body">
			<form class="layui-form layui-form-pane" lay-filter="addStuForm" id="addStuForm">
				<div class="layui-form-item">
					<label class="layui-form-label">学号</label>
				    <div class="layui-input-block">
				      <input type="text" name="_id" required  lay-verify="required|number|stuno" placeholder="请输入学号" autocomplete="off" class="layui-input">
				    </div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">姓名</label>
				    <div class="layui-input-block">
				      <input type="text" name="_name" required  lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
				    </div>
				</div>
				<div class="layui-form-item"  pane="">
					<label class="layui-form-label">性别</label>
				    <div class="layui-input-block">
				      <input type="radio" name="_sex" value="男" title="男" checked>
     			 	  <input type="radio" name="_sex" value="女" title="女">
				    </div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">专业</label>
				    <div class="layui-input-block">
				      <input type="text" name="_major" required  lay-verify="required" placeholder="请输入专业" autocomplete="off" class="layui-input">
				    </div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">学院</label>
				    <div class="layui-input-block">
				      <input type="text" name="_college" required  lay-verify="required" placeholder="请输入学院" autocomplete="off" class="layui-input">
				    </div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">班级</label>
				    <div class="layui-input-block">
				      <input type="text" name="_class" required  lay-verify="required|number|clssno" placeholder="请输入班级" autocomplete="off" class="layui-input">
				    </div>
				</div>
			</form>
		</div>
		</div>
	</div>
</body>
</html>