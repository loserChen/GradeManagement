<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*" %>
<html>
<head>
		<link rel="stylesheet" type="text/css" href="other/bootstrap-3.3.7-dist/css/bootstrap.min.css">
		<link rel="stylesheet" href="other/jquery-bootstrap-calendar/css/dcalendar.picker.css"/>
</head>
<style type="text/css">
a {
	text-decoration: none;
	color:#999;
}
</style>
<body>
<div class="container">
	<div class="row">
	<h1>Welcome!</h1>
	</div>
	<div class="row">
	<nav class="navbar navbar-default" role="navigation">
  <div class="container-fluid">
    <ul class="nav navbar-nav navbar-left">
      <li><a href="student.jsp"><span class="glyphicon glyphicon-user"></span>主页</a></li>
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
                                                       成绩查询
                </a>
        </div>
        </div>
        <div id="collapseOne" class="panel-collapse collapse">
            <div class="panel-body">
                <li><a href="semesterGrade.jsp?semester=2016/2017(1)">学年成绩查询</a></li>
                <li ><a href="rankQuery.jsp">排名查询</a></li>
                <li ><a href="GradeQuery.jsp">总成绩查询</a></li>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
        <div>
                <a data-toggle="collapse" data-parent="#accordion" 
                href="#collapseTwo" >
                                                       课程查询
                </a>
        </div>
        </div>
        <div id="collapseTwo" class="panel-collapse collapse">
            <div class="panel-body">
                <li><a href="lessonQuery.jsp?semester=2016/2017(1)">课程查询</a></li>
                <li><a href="creditQuery.jsp">学分查询</a></li>
                <li><a href="classSearch.jsp?time=2016/2017(1)">班级课程开设查询</a></li>
            </div>
        </div>
    </div>
     <div class="panel panel-default">
        <div class="panel-heading">
                <a href="student.jsp">
                                                       学生管理
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
			String sql="select * from Chenzy_students where czy_sid="+(Integer)session.getAttribute("username");
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()){
			%>
    <table class="table table-striped">
    <thead>
    <tr>
    <th>学号</th>
    <th>姓名</th>
    <th>性别</th>
    <th>年龄</th>
    <th>籍贯</th>
    <th>班级</th>
    </tr>
    </thead>
    <tbody>
    	<tr>
    		<td><%=rs.getInt("czy_sid") %></td>
    		<td><%=rs.getString("czy_sname") %></td>
    		<td><%=rs.getString("czy_ssex") %></td>
    		<td><%=rs.getInt("czy_sage") %></td>
    		<td><%=rs.getString("czy_area") %></td>
    		<%} %>
    		<%
    		String sql1="select czy_cname from Chenzy_classes where czy_cid="+rs.getInt("czy_cid");
    		rs=stmt.executeQuery(sql1);
    		if(rs.next()){ %>
    		<td><%=rs.getString("czy_cname") %></td>
    	</tr>
    </tbody>
    </table>
    <%} %>
    <div class="row">
    <div id="myCarousel" class="carousel slide">
	<!-- 轮播（Carousel）指标 -->
	<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>
	</ol>   
	<!-- 轮播（Carousel）项目 -->
	<div class="carousel-inner">
		<div class="item active">
			<img src="5.jpg" alt="First slide">
		</div>
		<div class="item">
			<img src="8.jpg" alt="Second slide">
		</div>
		<div class="item">
			<img src="9.jpg" alt="Third slide">
		</div>
	</div>
	<!-- 轮播（Carousel）导航 -->
	<a class="carousel-control left" href="#myCarousel" 
	   data-slide="prev">&lsaquo;</a>
	<a class="carousel-control right" href="#myCarousel" 
	   data-slide="next">&rsaquo;</a>
</div> 
    </div>
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