<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"	src="../easyui1.5/jquery.min.js" charset="utf-8"></script>
<script type="text/javascript"	src="../easyui1.5/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript"	src="../easyui1.5/locale/easyui-lang-zh_CN.js"	charset="utf-8"></script>
<link rel="stylesheet" type="text/css"	href="../easyui1.5/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css"	href="../easyui1.5/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="../easyui1.5/demo/demo.css">
<title>Easy-UI 用户列表展示页面</title>
</head>
<body>
	<div style="text-align: center;">
		<h2>SSM-Easy-UI框架练习 用户列表页面</h2>
		<h3><span>欢迎${sessionScope.userName}登录</span><a href="signOut" style="margin-left: 10px;">退出</a></h3><%-- ${sessionScope.user} --%>
	    <!-- <p>Click the buttons on datagrid toolbar to do crud actions.</p> -->
	    
	    <!-- <table id="userListGird"></table>
	    <div id="navigationBar">
			<a href="#" class="easyui-linkbutton" onclick="add()" data-options="iconCls:'icon-add',plain:true">添加</a>
			<a href="#" class="easyui-linkbutton" onclick="del()" data-options="iconCls:'icon-remove',plain:true">删除</a>
			<a href="#" class="easyui-linkbutton" onclick="edit()" data-options="iconCls:'icon-edit',plain:true">修改</a>
			<a href="#" class="easyui-linkbutton" onclick="refresh()" data-options="iconCls:'icon-reload',plain:true">刷新</a>
			<span>用户编号:</span>Item ID:
			<input id="itemid" style="line-height:26px;border:1px solid #ccc"/>
			<span>用户姓名:</span>Product ID:
			<input id="productid" style="line-height:26px;border:1px solid #ccc"/>
			<a href="#" class="easyui-linkbutton" onclick="doSearch()" data-options="iconCls:'icon-search',plain:true">查找</a>
		</div> -->
		
		<p>
	       	分页样式 
	        <select id="p-pos" onchange="changeP()">
	            <option>bottom</option>
	            <option>top</option>
	            <option>both</option>
	        </select>
	        Style
	        <select id="p-style" onchange="changeP()">
	            <option>manual</option>
	            <option>links</option>
	        </select>
	    </p>
	    <div id="p" class="easyui-panel" title="用户列表展示面板" style="width:700px;">
			<table id="dg" title="My Users" class="easyui-datagrid" style="width:700px;height:250px;"
		            url="userListEasyUi"
		            toolbar="#toolbar" pagination="true"
		            rownumbers="true" fitColumns="true" 
		            singleSelect="true" striped="true"
		            pagesize="5" pageList="[ 5, 10, 15, 20 ]">
		        <thead>
		            <tr>
		                <th field="id" width="50">ID</th>
		                <th field="user_name" width="50">User Name</th>
		                <th field="password" width="50">PASSWORD</th>
		                <th field="age" width="50">AGE</th>
		            </tr>
		        </thead>
		    </table>
	    </div>
	    <!-- Easy-UI-DataGird实现前端分页 -->
		<!-- <script type="text/javascript">
			function getData(){
				var rows = [];
				for(var i=1; i<=800; i++){
					var amount = Math.floor(Math.random()*1000);
					var price = Math.floor(Math.random()*1000);
					rows.push({
						inv: 'Inv No '+i,
						date: $.fn.datebox.defaults.formatter(new Date()),
						name: 'Name '+i,
						amount: amount,
						price: price,
						cost: amount*price,
						note: 'Note '+i
					});
				}
				return rows;
			}
			
			function pagerFilter(data){
				if (typeof data.length == 'number' && typeof data.splice == 'function'){	// is array
					data = {
						total: data.length,
						rows: data
					}
				}
				var dg = $(this);
				var opts = dg.datagrid('options');
				var pager = dg.datagrid('getPager');
				pager.pagination({
					onSelectPage:function(pageNum, pageSize){
						opts.pageNumber = pageNum;
						opts.pageSize = pageSize;
						pager.pagination('refresh',{
							pageNumber:pageNum,
							pageSize:pageSize
						});
						dg.datagrid('loadData',data);
					}
				});
				if (!data.originalRows){
					data.originalRows = (data.rows);
				}
				var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
				var end = start + parseInt(opts.pageSize);
				data.rows = (data.originalRows.slice(start, end));
				return data;
			}
			
			$(function(){
				$('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', getData());
			});
	    </script> -->
	    <div id="toolbar">
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">New User</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">Edit User</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">Remove User</a>
	    </div>
	    
	    <div id="dlg" class="easyui-dialog" style="width:400px"
	            closed="true" buttons="#dlg-buttons">
	        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
	            <div style="margin-bottom:20px;font-size:14px;border-bottom:1px solid #ccc">User Information</div>
	            <div style="margin-bottom:10px">
	                <input name="user_name" class="easyui-textbox" required="true" label="User Name:" style="width:100%">
	            </div>
	            <div style="margin-bottom:10px">
	                <input name="password" class="easyui-textbox" required="true" label="Password:" type="password" style="width:100%">
	            </div>
	            <div style="margin-bottom:10px">
	                <input name="age" class="easyui-textbox" required="true" label="Age:" style="width:100%">
	            </div>
	        </form>
	    </div>
	    <div id="dlg-buttons">
	        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUser()" style="width:90px">Save</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">Cancel</a>
	    </div>
	    <script type="text/javascript">
	    
		    $(document).ready(function(){
				$('#p').panel({
			        left:330,           
			        top:150
			    });
			    $('#p').panel('panel').css('position','absolute'); //获取面板对象，设置定位
			});
	    
	    	//分页样式
	    	function changeP(){
	            var dg = $('#dg');
	            dg.datagrid('loadData',[]);
	            dg.datagrid({pagePosition:$('#p-pos').val()});
	            dg.datagrid('getPager').pagination({
	                layout:['list','sep','first','prev','sep',$('#p-style').val(),'sep','next','last','sep','refresh','info']
	            });
	        }
	    	
	        var url;
	        function newUser(){
	            $('#dlg').dialog('open').dialog('center').dialog('setTitle','New User');
	            $('#fm').form('clear');
	            url = 'addUser';
	        }
	        function editUser(){
	            var row = $('#dg').datagrid('getSelected');
	            if (row){
	                $('#dlg').dialog('open').dialog('center').dialog('setTitle','Edit User');
	                $('#fm').form('load',row);
	                url = 'updateUser?id='+row.id;
	            }
	        }
	        function saveUser(){
	            $('#fm').form('submit',{
	                url: url,
	                onSubmit: function(){
	                    return $(this).form('validate');
	                },
	                success: function(result){
	                    var result = eval('('+result+')');
	                    if (result.errorMsg){
	                        $.messager.show({
	                            title: 'Error',
	                            msg: result.errorMsg
	                        });
	                    } else {
	                        $('#dlg').dialog('close');        // close the dialog
	                        $('#dg').datagrid('reload');    // reload the user data
	                    }
	                }
	            });
	        }
	        function destroyUser(){
	            var row = $('#dg').datagrid('getSelected');
	            if (row){
	                $.messager.confirm('Confirm','Are you sure you want to destroy this user?',function(r){
	                    if (r){
	                        $.post('deleteUser',{id:row.id},function(result){
	                            if (result.success){
	                                $('#dg').datagrid('reload');    // reload the user data
	                            } else {
	                                $.messager.show({    // show error message
	                                    title: 'Error',
	                                    msg: result.errorMsg
	                                });
	                            }
	                        },'json');
	                    }
	                });
	            }
	        }
	        
	        //Easy-UI-DataGird另外一种定义方式
	        /* $(function(){
			$('#userListGird').datagrid({
				title : '用户列表',
				iconCls : 'icon-ok',
				width : 400,
				height : 600,
				fit:true,
				pageSize : 5,//默认选择的分页是每页5行数据
				pageList : [ 5, 10, 15, 20 ],//可以选择的分页集合
				nowrap : true,//设置为true，当数据长度超出列宽时将会自动截取
				striped : true,//设置为true将交替显示行背景。
				collapsible : true,//显示可折叠按钮
				toolbar:"#navigationBar", // 这里是工具条div的id
				url:'userListEasyUi',//url调用Action方法
				columns:[[ 
	            	{field:'id',title:'用户编号',width:140,align:'center'},    
	            	{field:'user_name',title:'用户姓名',width:140,align:'center'}, 
	            	{field:'age',title:'用户年龄',width:100,align:'center'}
	        	]] ,
				loadMsg : '数据装载中......',
				singleSelect:false,//为true时只能选择单行
				fitColumns:false,//允许表格自动缩放，以适应父容器
				sortName : 'id',//当数据表格初始化时以哪一列来排序
				sortOrder : 'desc',//定义排序顺序，可以是'asc'或者'desc'（正序或者倒序）。
				rowStyler:function(index,record){
	               if(record.age>'22'){
	                 return 'background : #D2D2D5;';
	               }			
				},
				remoteSort : false,
	 			 frozenColumns : [ [ {
					field : 'ck',
					checkbox : true
				} ] ], 
				pagination : true,//分页
				rownumbers : true//行数
			});
		}); */
	    </script>
    </div>
</body>
</html>