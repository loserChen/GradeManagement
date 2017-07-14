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
        <div id="collapseOne" class="panel-collapse collapse in">
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
                <li ><a href="creditQuery.jsp">学分查询</a></li>
                <li ><a href="classSearch.jsp?time=2016/2017(1)">班级课程开设查询</a></li>
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
			String sql2="select czy_sname from Chenzy_students where  czy_sid="+(Integer)session.getAttribute("username");
			Statement stmt=conn.createStatement();
			ResultSet rs1=stmt.executeQuery(sql2);
			if(rs1.next()){
			%>
	<div class="text-primary">
	<form action="semesterGrade.jsp">
	学期：<select name="semester">
	<option value="2014/2015(1)">2014/2015(1)</option>
	<option value="2014/2015(2)">2014/2015(2)</option>
	<option value="2015/2016(1)">2015/2016(1)</option>
	<option value="2015/2016(2)">2015/2016(2)</option>
	<option selected="selected" value="2016/2017(1)">2016/2017(1)</option>
	<option value="2016/2017(2)">2016/2017(2)</option>
	<option value="2017/2018(1)">2017/2018(1)</option>
	<option value="2017/2018(2)">2017/2018(2)</option>
	<option value="2018/2019(1)">2018/2019(1)</option>
	<option value="2018/2019(2)">2018/2019(2)</option>
	<option value="2098/2099(1)">2019/2020(1)</option></select>
	<input type="submit" value="查询">
	<%=rs1.getString("czy_sname") %>的学年成绩
	</form>
	</div>
	<%} %>
	<%
	CallableStatement cstmt=conn.prepareCall("{call proc_Sid_Grade(?,?)}");
	cstmt.setInt(1,(Integer)session.getAttribute("username"));
	cstmt.setString(2,request.getParameter("semester"));
	ResultSet rs=cstmt.executeQuery();
	%>
    <table class="table table-striped">
    <thead>
    <tr>
    <th>课程名</th>
    <th>学分</th>
    <th>老师</th>
    <th>成绩</th>
    </tr>
    </thead>
    <tbody>
    <%while(rs.next()){%>
    	<tr>
    		<td><%=rs.getString("czy_lname") %></td>
    		<td><%=rs.getInt("czy_credit") %></td>
    		<td><%=rs.getString("czy_tname") %></td>
    		<td><%=rs.getInt("czy_grade") %></td>
    	</tr>
    <%} %>
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