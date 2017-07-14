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
   <form method="post" action="change.jsp">
   <table>
   <tr><td colspan="3" align="center"><div class="login">
        <div class="disabled"><a href="login.jsp"><i class="fa fa-user"></i>登录</a></div>
        <div class="disabled"><a href="register.jsp"><i class="fa fa-cog fa-spin"></i><font>修改密码</font></a></div>
</div></td></tr>
   <tr><td><input type="text" name="username" id="username" placeholder="用户名" class="text"></td><td>请输入用户名</td></tr>
   <tr><td><input type="password" name="password" id="password" placeholder="原密码" class="text"></td><td>请输入原密码</td></tr>
   <tr><td><input type="password" name="passwordcheck" id="passwordcheck" placeholder="修改密码" class="text"></td><td>请输入新密码</td></tr>
   <tr><td><button type="submit" class="btn btn-success btn-block">提交</button></td><td><button type="reset" class="btn btn-success btn-block">取消</button></td></tr>
</table>
</form>
</div>
</div>
<script src="other/particles.js"></script>
  <script src="other/app.js"></script>
</body>
</html>