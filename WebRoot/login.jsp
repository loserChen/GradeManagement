<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
		<link rel="stylesheet" type="text/css" href="other/font-awesome-4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="css/login.css">
		<link rel="stylesheet" type="text/css" href="other/bootstrap-3.3.7-dist/css/bootstrap.min.css">
		<link rel="stylesheet" media="screen" href="css/style.css">
</head>
<body>
<div id="particles-js">
<div class="a"> 
<form action="logincheck" method="post">
<table>
<tr><td class="h1" colspan="2" align="center">欢迎来到成绩管理系统</td></tr>
<tr><td colspan="2" align="center"><div class="login">
				<div class="nav-menu-current"><a href="login.jsp"><i class="fa fa-user"></i><font>登录</font></a></div>
				<div class="disabled"><a href="changePassword.jsp"><i class="fa fa-terminal" aria-hidden="true"></i>修改密码</a></div>
</div></td></tr>
<tr><td align="right">请选择权限:</td><td align="left"><select name="limit"><option value="1">学生</option><option value="2">老师</option><option value="3">管理员</option></select>
<tr><td align="center" colspan="2"><input type="text" name="username" placeholder="用户名" class="text"></td></tr>
<tr><td align="center" colspan="2"><input type="password" name="password" placeholder="密码" class="text"></td></tr>
<tr><td><button type="submit" class="btn btn-success btn-block">登录</button></td><td><button type="reset" class="btn btn-success btn-block">取消</button></td></tr>
</table>
</form>
</div>
</div>
<script src="other/particles.js"></script>
  <script src="other/app.js"></script>
</body>
</html>