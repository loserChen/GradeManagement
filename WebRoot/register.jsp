<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*" %>
<html>
<head>
		<link rel="stylesheet" type="text/css" href="other/bootstrap-3.3.7-dist/css/bootstrap.min.css">
		<link rel="stylesheet" href="other/jquery-bootstrap-calendar/css/dcalendar.picker.css"/>
		<link rel="stylesheet" type="text/css" href="other/font-awesome-4.7.0/css/font-awesome.min.css">
</head>
<style type="text/css">
a {
	text-decoration: none;
	color:#999;
}
.title{
	font: bold 38px/1.12 "Times New Roman", Georgia, Times, sans-serif;;
	color: #999;
}
</style>
<body>
<div class="container">
	<div class="row">
	<font class="title">Hello Administrator!</font>
	</div>
	<div class="row">
	<nav class="navbar navbar-default" role="navigation">
  <div class="container-fluid">
    <ul class="nav navbar-nav navbar-left">
      <li><a href="administrator.jsp"><span class="glyphicon glyphicon-user"></span>主页</a></li>
      <li><a href="logout.jsp"onclick="return confirm('你确定要注销？')"><span class="glyphicon glyphicon-log-in"></span>注销</a></li>
    </ul>
  </div>
</nav>
	</div>
	<div class="row">
	<div class="col-md-3">
	<div class="panel-group" id="accordion">
    <div class="panel panel-default">
        <div class="panel-heading">
        <div>
                <a data-toggle="collapse" data-parent="#accordion" 
                href="#collapseOne" >
                                                       信息管理
                </a>
        </div>
        </div>
        <div id="collapseOne" class="panel-collapse collapse">
            <div class="panel-body">
                <li><a href="teacherInformation.jsp">教师信息管理</a></li>
                <li ><a href="studentInformation.jsp">学生信息管理</a></li>
                <li ><a href="addStudents.jsp">添加学生</a></li>
                <li ><a href="addTeachers.jsp">添加教师</a></li>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
        <div>
                <a  data-toggle="collapse" data-parent="#accordion" 
                href="#collapseTwo" >
                                                       各类查询
                </a>
        </div>
        </div>
        <div id="collapseTwo" class="panel-collapse collapse">
            <div class="panel-body">
                <li><a href="teacherQuery.jsp?semester=2016/2017(1)">教师任课查询</a></li>
                <li><a href="classLessonQuery.jsp?semester=2016/2017(1)">班级开课查询</a></li>
                <li><a href="studentGradeQuery.jsp?semester=2016/2017(1)">学生成绩查询</a></li>
                <li><a href="stuRank.jsp">学生名次查询</a></li>
                <li><a href="stuNum.jsp">生源地学生数查询</a></li>
            </div>
        </div>
    </div>
     <div class="panel panel-default">
        <div class="panel-heading">
                <a href="register.jsp">
                                                       用户注册
                </a>
        </div>
    </div>
    </div>
    <h3></h3>
				<table id='mycalendar' class='calendar'></table>
		</div>
    <div class="col-md-5">
  	<%	
  	if(request.getParameter("username")!=null){
  	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://localhost:1433;databasename=chenzeyuan03Mis";
			Connection conn=DriverManager.getConnection(url,"sa","root");	
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	String passwordcheck=request.getParameter("passwordcheck");
	String limit=request.getParameter("limit");
	int len=password.length();
	if(len<6||len>16){
	out.print("<script>alert('你的密码格式不正确');history.go(-1)</script>");}
	else if(!password.equals(passwordcheck)){
	out.print("<script>alert('请确认两次输入的密码一样');history.go(-1)</script>");}
	else{
	String sql="select * from Chenzy_login where czy_username="+"'"+username+"'";
	Statement stmt=conn.createStatement();
	ResultSet rs=stmt.executeQuery(sql);
	if(rs.next()){
	out.print("<script>alert('用户名已经存在');history.go(-1)</script>");
	}
	else{
	sql="insert into Chenzy_login (czy_username,czy_pwd,czy_limit) values(?,?,?)";
	PreparedStatement sm=conn.prepareStatement(sql);
	sm.setString(1,username);
	sm.setString(2,password);
	sm.setInt(3,Integer.parseInt(limit));
	sm.executeUpdate();
	out.print("<script>alert('注册成功');location.href='register.jsp'</script>");
	}
	}
	}
			
			  %>
	<form action="register.jsp" method="post">
	<table class="table table-condensed">
    <tbody>
   	<tr><td><input type="text" name="username" placeholder="请输入对应编号"></td></tr>
   	<tr><td><input type="text" name="password" placeholder="请输入密码"></td><td>*&nbsp;6-16个字符(数字字母下划线)</td></tr>
   	<tr><td><input type="text" name="passwordcheck" placeholder="请确认密码"></td></tr>
   	<tr><td><select name="limit"><option value="1">1</option><option value="2">2</option><option value="3">3</option></select></td><td>*&nbsp;1代表学生,2代表老师,3代表管理员</td></tr>
   	<tr><td><button type="submit" class="btn btn-success btn-block">注册</button><button type="reset" class="btn btn-success btn-block">取消</button></td></tr>
	</tbody>
	</table>
	</form>  
    </div>
    </div>
</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="other/jquery-3.2.1.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="other/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="other/jquery-bootstrap-calendar/js/dcalendar.picker.js"></script>
    <script type="text/javascript">
	$('#mycalendar').dcalendar();
</script>
</body>
</html>

