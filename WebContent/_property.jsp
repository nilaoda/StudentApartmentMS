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
	<!-- 隐藏table容器 -->
	<div id="noDisplayTable" style="display:none;">
		<table class="layui-hide" id="stuTable" lay-filter="stuTable"></table>
	</div>
	<!-- 原始table容器 -->
    <table class="layui-hide" id="propertyTable" lay-filter="propertyTable"></table>
    <script type="text/html" id="barDemo">
     <a class="layui-btn layui-btn-xs" lay-event="extract"><i class="layui-icon layui-icon-form"></i>提取物品</a>
	</script>
	<script type="text/html" id="barHeadDemo">
     <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添加或修改物品</a>
	 <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="detail"><i class="layui-icon layui-icon-log"></i>查看详情</a>
	</script>
    <script>
	layui.use(['layer', 'form', 'table', 'element'], function(){
	  var layer = layui.layer
	  ,form = layui.form
	  ,table = layui.table //表格
	  ,element = layui.element //元素操作
	  ,$ = layui.jquery;
	  
	  
	//监听表单提交
	  form.on('submit(demo1)', function(data){
    		layer.msg('Hello');
    	    return false;  //不跳转
	  });

	  //创建一个表格
	  table.render({
		    elem: '#propertyTable'
		    ,cellMinWidth: 120
		    ,url:'/StudentApartmentMS/GetPropertyJson'
		    ,toolbar: "#barHeadDemo"
		    ,title: '财产表'
		    ,cols: [[
		      {field:'_pname', title:'物品名'}
		      ,{field:'_price', title:'价格(元)', sort:true}
		      ,{field:'_ptotal', title:'数量', sort:true}
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
	  table.on('tool(propertyTable)', function(obj){
	    var data = obj.data //获得当前行数据
	    ,layEvent = obj.event; //获得 lay-event 对应的值
	    //删除操作
	    if(layEvent === 'del'){
	    } 
	    //编辑操作
	    else if(layEvent === 'extract'){
			//表单初始赋值
			form.val('extractForm', {
			  "_pname": data._pname
			});
			
	    	layer.open({
	    		  title: '提取物品：'+data._pname
	    		  ,shade: 0
	    		  ,type: 1
	    		  ,area: ['400px', '350px']
	    		  ,content: $('#noDisplayForm')
		    	  ,btn: ['确认','取消']
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
				              url: '/StudentApartmentMS/DoAddPropHistory',
				              type: 'POST',
				              data: formJson,
				              async: false,
				              dataType: 'json',
				              success: function (data) {
			                      layer.msg("添加成功", {time:3000});
				    			  table.reload('propertyTable', {
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
				  	,end: function(index, layero){ 
	    				// 清空表单
	    				$("#extractForm")[0].reset();
	    			}  
	    		}); 
	    }
	  });
	
	//监听头工具栏事件
	  table.on('toolbar(propertyTable)', function(obj){
	    var checkStatus = table.checkStatus(obj.config.id)
	    ,data = checkStatus.data; //获取选中的数据
	    switch(obj.event){
	      case 'add':
	    	  layer.open({
	    		  title: '添加或修改物品：'
		    	  ,btn: ['提交','取消']
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
				              url: '/StudentApartmentMS/DoUptateProperty',
				              type: 'POST',
				              data: formJson,
				              async: false,
				              dataType: 'json',
				              success: function (data) {
			                      layer.msg("添加成功", {time:3000});
				    			  table.reload('propertyTable', {
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
	    		  ,area: ['400px', '280px']
	    		  ,content: $('#noDisplayForm2')
	    		  ,end: function(index, layero){ 
	    				// 清空表单
	    				$("#addForm")[0].reset();
	    				form.render(null, 'addForm');
	    			}   
	    		}); 
	      break;
	      case 'detail':
	    	    //显示层
		    	layer.open({
		    		  title: '查看详情'
		    		  ,type: 1
		    		  ,maxmin: true //开启最大化最小化按钮
		    		  ,area: ['750px', '260px']
		    		  ,content: $('#noDisplayTable')
		    		  ,end: function(index, layero){ 
		    			  
		    			}  
		    	      ,full:function(index, layero){
		    	    	  table.reload('stuTable', {
		    			  });
		    	      }
		    	      ,restore:function(index, layero){
		    	    	  table.reload('stuTable', {
		    			  });
		    	      }
		    		}); 
	    	
	    	    //绘制表格
		    	table.render({
				    elem: '#stuTable'
				    ,url:'/StudentApartmentMS/GetPropertyHistoryJson'
				    ,title: '详情表'
				    ,cols: [[
					      {field:'_date', title:'日期', width:180}
					      ,{field:'_bno', title:'公寓号'}
					      ,{field:'_pname', title:'物品名'}
					      ,{field:'_pcount', title:'数量'}
					      ,{field:'_name', title:'提取人姓名'}
				    ]]
				    ,response: {
				      statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
				    }
				  });
	      break;
	    };
	  });

	});
	</script>
</div>
	<script>
	layui.use(['layer', 'form', 'table', 'element'], function(){
		  var layer = layui.layer
		  ,form = layui.form
		  ,table = layui.table //表格
		  ,element = layui.element //元素操作
		  ,$ = layui.jquery;
		  
		  //表单验证
		  form.verify({
			  v_pname: function(value){ 
			    if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
			      return '不能有特殊字符';
			    }
			  }
			});
		  
	});
	</script>
	<!-- 隐藏的表单容器 -->
	<div id="noDisplayForm" style="display:none;">
		<div class="layui-card">
		<div class="layui-card-body">
			<form class="layui-form layui-form-pane" lay-filter="extractForm" id="extractForm">
				<div class="layui-form-item">
					<label class="layui-form-label">公寓号</label>
					<div class="layui-inline">
						<select name="_bno" lay-verify="required" style="right:0px;">
						  <option value="">请选择一个公寓</option>
						  <option value="1">1</option>
						  <option value="2">2</option>
						</select>     
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">物品名</label>
				    <div class="layui-input-block">
				      <input type="text" name="_pname" required  lay-verify="required" autocomplete="off" class="layui-input">
				    </div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">数量</label>
				    <div class="layui-input-block">
				      <input type="text" name="_pcount" required  lay-verify="required|number" autocomplete="off" class="layui-input">
				    </div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">提取人姓名</label>
				    <div class="layui-input-block">
				      <input type="text" name="_name" required  lay-verify="required" autocomplete="off" class="layui-input">
				    </div>
				</div>
			</form>
		</div>
		</div>
	</div>
	
	<!-- 隐藏的表单容器 -->
	<div id="noDisplayForm2" style="display:none;">
		<div class="layui-card">
		<div class="layui-card-body">
			<form class="layui-form layui-form-pane" lay-filter="addForm" id="addForm">
				<div class="layui-form-item">
					<label class="layui-form-label">物品名</label>
				    <div class="layui-input-block">
				      <input type="text" name="_pname" required  lay-verify="required|v_pname" placeholder="请输入物品名" autocomplete="off" class="layui-input">
				    </div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">价格</label>
				    <div class="layui-input-block">
				      <input type="text" name="_price" required  lay-verify="required|number" placeholder="￥" autocomplete="off" class="layui-input">
				    </div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">数量</label>
				    <div class="layui-input-block">
				      <input type="text" name="_ptotal" required  lay-verify="required|number" placeholder="请输入数量" autocomplete="off" class="layui-input">
				    </div>
				</div>
			</form>
		</div>
		</div>
	</div>
</body>
</html>