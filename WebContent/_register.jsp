<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="layui/css/layui.css" media="all">
 <script src="layui/layui.js"></script>
 <script>
 //获取当前时间 格式yyyy-MM-dd HH:mm:ss
 function getNowFormatDate() {
	    var date = new Date();
	    var seperator1 = "-";
	    var seperator2 = ":";
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    var seconds = date.getSeconds();
	    if (seconds >= 0 && seconds <= 9) {
	    	seconds = "0" + seconds;
	    }
	    var minutes = date.getMinutes();
	    if (minutes >= 0 && minutes <= 9) {
	    	minutes = "0" + minutes;
	    }
	    var hours = date.getHours();
	    if (hours >= 0 && hours <= 9) {
	    	hours = "0" + hours;
	    }
	    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
	            + " " + hours + seperator2 + minutes
	            + seperator2 + seconds;
	    return currentdate;
	}
 </script>
</head>
<!-- 检测是否登陆 -->
<%@include file="/IsLogin.jsp" %>
<body>
<div  style="max-width:1500px;margin:0 auto;">
		<!-- 原始able容器 -->
		<table class="layui-hide" id="registerTable" lay-filter="registerTable"></table>
		<script type="text/html" id="barDemo">
     		<a class="layui-btn layui-btn-xs" lay-event="setout"><i class="layui-icon layui-icon-ok"></i>设置离开</a>
     		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
		</script>
		<script type="text/html" id="barHeadDemo">
     		<a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>进入登记</a>
		</script>
		
		<script>
		layui.use(['layer', 'form', 'table', 'element'], function(){
			  var layer = layui.layer
			  ,form = layui.form
			  ,table = layui.table //表格
			  ,element = layui.element //元素操作
			  ,$ = layui.jquery;
			
			//创建一个表格
			  table.render({
				    elem: '#registerTable'
				    ,cellMinWidth: 120
				    ,url:'/StudentApartmentMS/GetRegisterJson'
				    ,toolbar: "#barHeadDemo"
				    ,title: '出入登记表'
				    ,cols: [[
					  {field:'_id', title:'序号', hide: true}
				      ,{field:'_peoname', title:'人名'}
				      ,{field:'_peotype', title:'人员类型'}
				      ,{field:'_goodsname', title:'物品名'}
				      ,{field:'_in_time', title:'进入时刻'}
				      ,{field:'_out_time', title:'离开时刻'}
				      ,{field:'_count_time', title:'停留时间'}
				      ,{fixed: 'right', align:'center', width:180, toolbar: '#barDemo'}
				    ]]
				  	,limit: 12
				  	,limits: [12,30,60,80,100]
				    ,page: true
				    ,response: {
				      statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
				    }
				  });
			
			//监听头工具栏事件
			  table.on('toolbar(registerTable)', function(obj){
			    var checkStatus = table.checkStatus(obj.config.id)
			    ,data = checkStatus.data; //获取选中的数据
			    switch(obj.event){
			      case 'add':
			    	   //表单初始赋值
						form.val('addForm', {
						  "_in_time": getNowFormatDate
						});
			    	
			    	  layer.open({
			    		  title: '登记人员：'
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
						              url: '/StudentApartmentMS/DoAddRegister',
						              type: 'POST',
						              data: formJson,
						              async: false,
						              dataType: 'json',
						              success: function (data) {
					                      layer.msg("添加成功", {time:3000});
						    			  table.reload('registerTable', {
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
			    		  ,area: ['400px', '340px']
			    		  ,content: $('#noDisplayForm')
			    		  ,end: function(index, layero){ 
			    				// 清空表单
			    				$("#addForm")[0].reset();
			    				form.render(null, 'addForm');
			    			}   
			    		}); 
			      break;
			    };
			  });
			
			//监听行工具事件
			  table.on('tool(registerTable)', function(obj){
			    var data = obj.data //获得当前行数据
			    ,layEvent = obj.event; //获得 lay-event 对应的值
			    //删除操作
			    if(layEvent === 'del'){
			    	layer.confirm('真的删除本记录么', function(index){
			    	//请求服务器
		    		  $.ajax({
			              url: '/StudentApartmentMS/DoDelRegister?id='+data._id,
			              type: 'GET',
			              async: false,
			              dataType: 'json',
			              success: function (data) {
		                      layer.msg("删除成功", {time:3000});
			    			  table.reload('registerTable', {
			    			  });
					    	  layer.closeAll();
			              },
			              error: function () {
		                      layer.msg("删除失败", {time:3000});
			              }
			          });
			    	});
			    } 
			    //编辑操作
			    else if(layEvent === 'setout'){
					//请求服务器
		    		  $.ajax({
			              url: '/StudentApartmentMS/DoUpdateRegister?id='+data._id
			            		  +'&in_time='+encodeURIComponent(encodeURIComponent(data._in_time)),
			              type: 'GET',
			              async: false,
			              dataType: 'json',
			              success: function (data) {
		                      layer.msg("提交成功", {time:3000});
			    			  table.reload('registerTable', {
			    			  });
					    	  layer.closeAll();
			              },
			              error: function () {
		                      layer.msg("提交失败", {time:3000});
			              }
			          });
			    }
			  });
			
				//表单验证
				form.verify({
					peoname: function(value){ 
					    if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
						      return '用户名不能有特殊字符';
						    }
						    if(/(^\_)|(\__)|(\_+$)/.test(value)){
						      return '姓名首尾不能出现下划线\'_\'';
						    }
						    if(/^\d*$/.test(value)){
						      return '姓名不能有数字';
						    }
						 }
			    });
				
				
		});
		</script>
		
	<!-- 隐藏的表单容器 -->
	<div id="noDisplayForm" style="display:none;">
		<div class="layui-card">
		<div class="layui-card-body">
			<form class="layui-form layui-form-pane" lay-filter="addForm" id="addForm">
				<div class="layui-form-item">
					<label class="layui-form-label">人员姓名</label>
				    <div class="layui-input-block">
				      <input type="text" name="_peoname" required  lay-verify="required|peoname" autocomplete="off" class="layui-input">
				    </div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">人员类型</label>
					<div class="layui-inline">
						<select name="_peotype" lay-verify="required" style="right:0px;">
						  <option value="">请选择一个类型</option>
						  <option value="1">学生</option>
						  <option value="2">维修人员</option>
						  <option value="3">其他</option>
						</select>     
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">携带物品名</label>
				    <div class="layui-input-block">
				      <input type="text" name="_goodsname" lay-verify="" placeholder="可为空" autocomplete="off" class="layui-input">
				    </div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">进入时间</label>
				    <div class="layui-input-block">
				      <input type="text" name="_in_time" required  lay-verify="required" autocomplete="off" class="layui-input">
				    </div>
				</div>
			</form>
		</div>
		</div>
	</div>
	
</div>
</body>
</html>