<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图片验证码测试页面</title>
</head>
<body>
	<!-- 验证码 -->
	<img id="img" src="<%=request.getContextPath()%>/authImage" />
	<a href='#' onclick="javascript:changeImg()" style="color:white;"><label style="color:white;">看不清？</label></a>
	<!-- 触发JS刷新-->
	<script type="text/javascript">
		function changeImg(){
		    var img = document.getElementById("img"); 
		    img.src = "<%=request.getContextPath()%>/authImage?date=" + new Date();;
		}
	</script>
</body>
</html>