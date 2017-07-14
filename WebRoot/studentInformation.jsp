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
        <div id="collapseOne" class="panel-collapse collapse in">
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
                <li><a href="avgGrade.jsp">学生成绩查询</a></li>
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
    <div class="col-md-9">
  <%      Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://localhost:1433;databasename=chenzeyuan03Mis";
			Connection conn=DriverManager.getConnection(url,"sa","root"); 
			String sql="select * from Chenzy_students";
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			%>
    <table class="table table-striped">
    <thead>
    <tr>
    <th>学号</th>
    <th>姓名</th>
    <th>性别</th>
    <th>年龄</th>
    <th>籍贯</th>
    <th>总学分</th>
    <th>班级号</th>
    </tr>
    </thead>
    <tbody>
    <%while(rs.next()){ %>
    	<tr>
    		<td><%=rs.getInt("czy_sid") %></td>
    		<td><%=rs.getString("czy_sname") %></td>
    		<td><%=rs.getString("czy_ssex") %></td>
    		<td><%=rs.getInt("czy_sage") %></td>
    		<td><%=rs.getString("czy_area") %></td>
    		<td><%=rs.getString("czy_credits") %></td>
    		<td><%=rs.getString("czy_cid") %></td>
       		<%} %>
    	</tr>
    </tbody>
    </table>
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
<%
 rs.close();
 stmt.close();
 conn.close();
  %>