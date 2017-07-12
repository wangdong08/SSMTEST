<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../easyui1.5/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../easyui1.5/themes/icon.css">
<link rel="stylesheet" type="text/css" href="../easyui1.5/demo/demo.css">
<script type="text/javascript" src="../easyui1.5/jquery.min.js"></script>
<script type="text/javascript" src="../easyui1.5/jquery.easyui.min.js"></script>
<title>Easy-UI 用户登录页面</title>
</head>
<body>
	<div style="text-align: center;">
		<h2>SSM-Easy-UI框架练习 用户登录页面</h2>
	    <div id="p" class="easyui-panel" title="登录面板" style="width:500px; padding:30px 60px;">
	        <form id="loginFrom" action="login" method="post"><!-- action="userLogin" -->
	            <div style="margin-bottom:20px">
	                <input class="easyui-textbox" name="user_name" style="width:100%" data-options="label:'用户名:',required:true">
	            </div>
	            <div style="margin-bottom:20px">
	                <input class="easyui-textbox" name="password" style="width:100%" data-options="label:'密码:',required:true" type="password">
	            </div>
	            <div style="border:0px solid red;">
	            	<input class="easyui-textbox" name="verificationCode" style="width:50%" data-options="label:'验证码:',required:true">
			    	<!-- 验证码 -->
					<img id="img" src="<%=request.getContextPath()%>/authImage" style="vertical-align:center;"/>
					<a href='#' onclick="javascript:changeImg()" style="color:white;"><label style="color:black;">看不清？</label></a>
					<!-- 触发JS刷新-->
					<script type="text/javascript">
						function changeImg(){
						    var img = document.getElementById("img"); 
						    img.src = "<%=request.getContextPath()%>/authImage?date=" + new Date();;
						}
					</script>
			    </div>
	        </form>
	        <div style="text-align:center;padding:20px 0">
	            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">登 录</a>
	            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()" style="width:80px">取 消</a>
	        </div>
	        <h4>${error}</h4>
	    </div>
	
	<!-- easy-ui layout布局 -->
	<!-- <body class="easyui-layout">
	    <div data-options="region:'north',title:'North Title',split:true" style="height:100px;"></div>
	    <div data-options="region:'south',title:'South Title',split:true" style="height:100px;"></div>
	    <div data-options="region:'east',title:'East',split:true" style="width:100px;"></div>
	    <div data-options="region:'west',title:'West',split:true" style="width:100px;"></div>
	    <div data-options="region:'center',title:'center title'" style="padding:5px;background:#eee;"></div>
	</body> -->
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#p').panel({
		        left:430,           
		        top:100
		    });
		    $('#p').panel('panel').css('position','absolute'); //获取面板对象，设置定位
		});
		
	    function submitForm(){
	    	if($('#loginFrom').form('validate')){
	    		$('#loginFrom').submit();
	    	}
	    }
	    function clearForm(){
	        $('#loginFrom').form('clear');
	    }
	</script>
</body>
</html>