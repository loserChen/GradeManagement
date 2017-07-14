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
.title{
	font: bold 38px/1.12 "Times New Roman", Georgia, Times, sans-serif;;
	color: #999;
}
</style>
<body>
<div class="container">
	<div class="row">
	<font class="title">Hello!</font>
	</div>
	<div class="row">
	<nav class="navbar navbar-default" role="navigation">
  <div class="container-fluid">
    <ul class="nav navbar-nav navbar-left">
      <li><a href="teacher.jsp"><span class="glyphicon glyphicon-user"></span>主页</a></li>
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
                                                       成绩管理
                </a>
        </div>
        </div>
        <div id="collapseOne" class="panel-collapse collapse">
            <div class="panel-body">
                <li><a href="registerGrade.jsp?semester=2016/2017(1)">成绩录入及查询</a></li>
                <li ><a href="avgGrade.jsp">平均成绩</a></li>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
        <div>
                <a href="tlessonQuery.jsp?semester=2016/2017(1)">
                                                       任课查询
                </a>
        </div>
        </div>
    </div>
     <div class="panel panel-default">
        <div class="panel-heading">
                <a href="teacherManagement.jsp">
                                                       教师管理
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
			String sql="select * from Chenzy_teachers where czy_tid="+(Integer)session.getAttribute("username");
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()){
			%>
	<form action="updateTeacher.jsp" method="post">
    <table class="table table-striped">
    <thead>
    <tr>
    <th>老师号</th>
    <th>姓名</th>
    <th>性别</th>
    <th>年龄</th>
    <th>职称</th>
    <th>联系电话</th>
    </tr>
    </thead>
    <tbody>
    	<tr>
    		<td><%=rs.getInt("czy_tid") %></td>
    		<td><%=rs.getString("czy_tname") %></td>
    		<td><%=rs.getString("czy_tsex") %></td>
    		<td><%=rs.getInt("czy_tage") %></td>
    		<td><%=rs.getString("czy_title") %></td>
    		<td><input type="text" name="phone" value="<%=rs.getString("czy_phone")%>"></td>
    		<%} %>
    	</tr>
    </tbody>
    </table>
    <input type="submit" value="更新" onclick="return confirm('你确定要更改？')">
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
<%
 rs.close();
 stmt.close();
 conn.close();
  %>