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
                <a href="teacherManagement.jsp">
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
			String sql="select czy_mid from Chenzy_major";
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			%>
	<div class="text-primary">
	<form action="stuRank.jsp">
	专业号:<select name="mid">
	<%while(rs.next()){%>
	<option value="<%=rs.getString("czy_mid")%>"><%=rs.getString("czy_mid")%></option>
	<%} %>
	</select>
	<input type="submit" value="查询">
	<%
	sql="select czy_mname from Chenzy_major where czy_mid="+request.getParameter("mid");
	rs=stmt.executeQuery(sql);
	if(rs.next()){
		 %>
	<%=rs.getString("czy_mname")%>的专业排名
	<%} %>
	</form>
	</div>
    <table class="table table-striped">
    <thead>
    <tr>
    <th>学号</th>
     <th>姓名</th>
    <th>名次</th>
    </tr>
    </thead>
    <tbody>
    <%
    if(request.getParameter("mid")!=null){
   	sql="select Chenzy_study.czy_sid,czy_sname,ROW_NUMBER() over (order by sum(czy_grade)/count(Chenzy_study.czy_sid) desc)排名 from Chenzy_study,Chenzy_classes,Chenzy_major,Chenzy_students where Chenzy_study.czy_sid=Chenzy_students.czy_sid and Chenzy_students.czy_cid=Chenzy_classes.czy_cid  and Chenzy_classes.czy_mid=Chenzy_major.czy_mid and Chenzy_major.czy_mid= ? group by Chenzy_study.czy_sid,czy_mname,czy_sname order by sum(czy_grade)/count(Chenzy_study.czy_sid) desc";
   	PreparedStatement sm=conn.prepareStatement(sql);
   	sm.setString(1,request.getParameter("mid"));
   	rs=sm.executeQuery();
	while(rs.next()){%>
    	<tr>
    		<td><%=rs.getInt("czy_sid") %></td>
    		<td><%=rs.getString("czy_sname") %></td>
    		<td><%=rs.getString("排名") %></td>
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
