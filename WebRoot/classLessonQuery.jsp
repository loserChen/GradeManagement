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
        <div id="collapseTwo" class="panel-collapse collapse in">
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
    <div class="col-md-9">
      <%! String tname; %>
  <%      Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://localhost:1433;databasename=chenzeyuan03Mis";
			Connection conn=DriverManager.getConnection(url,"sa","root"); 
			String sql="select czy_cid from Chenzy_classsearch group by czy_cid";
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			%>
	<div class="text-primary">
	<form action="classLessonQuery.jsp">
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
	班级:<select name="cid">
	<%while(rs.next()){%>
	<option value="<%=rs.getString("czy_cid")%>"><%=rs.getString("czy_cid")%></option>
	<%} %>
	</select>
	<input type="submit" value="查询">
	</form>
	</div>
    <table class="table table-striped">
    <thead>
    <tr>
    <th>班级名</th>
     <th>课程号</th>
    <th>课程名</th>
    <th>学时</th>
    <th>学分</th>
    <th>开课学期</th>
    <th>老师名</th>
    </tr>
    </thead>
    <tbody>
    <%
    if(request.getParameter("cid")!=null){
   	sql="select czy_cname,czy_lid,czy_lname,czy_period,czy_credit,czy_time,czy_tname from Chenzy_classsearch where czy_time= ? and czy_cid= ?";
   	PreparedStatement sm=conn.prepareStatement(sql);
   	sm.setString(1,request.getParameter("semester"));
   	sm.setInt(2,Integer.parseInt(request.getParameter("cid")));
   	rs=sm.executeQuery();
	while(rs.next()){%>
    	<tr>
    		<td><%=rs.getString("czy_cname") %></td>
    		<td><%=rs.getInt("czy_lid") %></td>
    		<td><%=rs.getString("czy_lname") %></td>
    		<td><%=rs.getInt("czy_period") %></td>
    		<td><%=rs.getInt("czy_credit") %></td>
    		<td><%=rs.getString("czy_time") %></td>
    		<td><%=rs.getString("czy_tname") %></td>
    		<%} 
    		}
    		%>
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
