<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/Js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/Js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
    $(function(){  
	  $('#findUserBtn').on('click',function(){
		  var findId = $("#findUserById").val();
		  var findName = $("#findUserByName").val();
		  if((findId != "" && findId != null) && (findName == "" || findName == null)){
			  location.href = "findUserByID?id=" + findId;
		  }
		  if((findId == "" || findId == null) && (findName != "" && findName != null)){
			  location.href = "findUserByName?name=" + findName;
		  }
		  /* if((findId != "" && findId != null) && (findName != "" && findName != null)){
			  alert(findId);
			  alert(findName);
			  alert(findId+findName);
			  //location.href = "#";
		  } */
	  })  
	})
	
	function updateConfirm(userId){
		if(confirm("是否确认修改？")){
		    updateUser(userId);
		}else{
			location.href = "userList";
		}
	}
	
	function updateUser(userId){
	    $('#userList tr').each(function(i){
	      if($(this).index() != "0"){
	    	  var id = $(this).children('td').eq(0).text();
	    	  if(id == userId){
	    		  var name = $(this).children('td').eq(1).find("input").val();   
			      var age = $(this).children('td').eq(2).find("input").val();
			      location.href = "updateUser?id=" + userId + "&user_name=" + name + "&age=" + age;
	    	  }
	      }	
	    }) 
	} 
</script>
</head>
<body>
	<div>
	<!-- <button id="btn">更新</button>  -->
		<div style="border: 1px solid blue; text-align: center; margin:auto; width: 500px; height: 200px;">
			<h3 style="color: #4C8CF5;">新增用户</h3>
			<%-- <form action="<%=request.getContextPath()%>/user/addUser" method="post"> --%>
			<form action="addUser" method="post">
			          姓    名:<input type="text" name="user_name"><br /> 
				密    码:<input type="password" name="password"><br />
			          年    龄:<input type="text" name="age"><br /><br />
			    <input type="submit" value="新增" />
			    <input type="reset" value="取消" />
			</form>
		</div>
		<div style="border: 1px solid blue; margin-top: 20px; width: 500px; text-align: center; margin:auto;">
			<h3 style="color: #4C8CF5;">用户列表</h3>
			<div>
				<input id="findUserById" type="text" placeholder="find user by id" /><br/>
				<input id="findUserByName" type="text" placeholder="find user by name" /><br/>
				<button id="findUserBtn">查询</button><br/>
				<a href="userList">刷新</a>
			</div>
			<table id="userList" align="center" border="1" width="300" cellspacing="0" style="text-align: center;">
				<tr>
					<td style="color: red">编号</td>
					<td style="color: green">姓名</td>
					<td style="color: pink">年龄</td>
					<td style="color: gray">操作</td>
				</tr>
				<c:forEach items="${userList}" var="ulist">
					<c:if test="${ulist.id != null}">
						<tr>
							<td style="color: red">${ulist.id}</td>
							<td style="color: green"><input type="text" style="width: 50px; height: 20px;" name="name" value="${ulist.user_name}" /></td>
							<td style="color: pink"><input type="text" style="width: 50px; height: 20px;" name="age" value="${ulist.age}" /></td>
							<td style="color: gray">
							<%-- <a href="updateUser?id=${ulist.id}&user_name=${ulist.user_name}&age=${ulist.age}">修改</a>| --%>
							<a href="#" onclick="updateConfirm(${ulist.id})">修改</a>|
							<a href="deleteUser?id=${ulist.id}">删除</a>
							</td>
						</tr>
					</c:if>
					<c:if test="${ulist.id == null}">
						<tr><td colspan="4">No Data Found</td></tr>
					</c:if>
				</c:forEach>
				<c:if test="${empty userList}">
					<tr><td colspan="4">No Data Found</td></tr>
				</c:if>
			</table>
		</div>
		<!-- 分页功能 start -->  
    <div align="center">  
        <font size="2">共 ${page.totalPageCount} 页</font> <font size="2">第  
            ${page.pageNow} 页</font> <a href="userListPage?pageNow=1">首页</a>  
        <c:choose>  
            <c:when test="${page.pageNow - 1 > 0}">  
                <a href="userListPage?pageNow=${page.pageNow - 1}">上一页</a>  
            </c:when>  
            <c:when test="${page.pageNow - 1 <= 0}">  
                <a href="userListPage?pageNow=1">上一页</a>  
            </c:when>  
        </c:choose>  
        <c:choose>  
            <c:when test="${page.totalPageCount==0}">  
                <a href="userListPage?pageNow=${page.pageNow}">下一页</a>  
            </c:when>  
            <c:when test="${page.pageNow + 1 < page.totalPageCount}">  
                <a href="userListPage?pageNow=${page.pageNow + 1}">下一页</a>  
            </c:when>  
            <c:when test="${page.pageNow + 1 >= page.totalPageCount}">  
                <a href="userListPage?pageNow=${page.totalPageCount}">下一页</a>  
            </c:when>  
        </c:choose>  
        <c:choose>  
            <c:when test="${page.totalPageCount==0}">  
                <a href="userListPage?pageNow=${page.pageNow}">尾页</a>  
            </c:when>  
            <c:otherwise>  
                <a href="userListPage?pageNow=${page.totalPageCount}">尾页</a>  
            </c:otherwise>  
        </c:choose>  
    </div>  
    <!-- 分页功能 End -->  
	</div>
</body>
</html>