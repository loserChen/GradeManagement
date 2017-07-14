<%@page import="javax.swing.text.StyleContext.SmallAttributeSet"%>
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
                <li ><a href="classSearch.jsp?semester=2016/2017(1)">班级课程开设查询</a></li>
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
			String sql="select ROW_NUMBER() over (order by sum(czy_grade)/count(Chenzy_study.czy_sid) desc)排名 from Chenzy_study,Chenzy_classes,Chenzy_major,Chenzy_students where Chenzy_study.czy_sid=Chenzy_students.czy_sid and Chenzy_students.czy_cid=Chenzy_classes.czy_cid  and Chenzy_classes.czy_mid=Chenzy_major.czy_mid and Chenzy_study.czy_sid= ? group by Chenzy_study.czy_sid,czy_mname,czy_sname order by sum(czy_grade)/count(Chenzy_study.czy_sid) desc";
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setInt(1,(Integer)session.getAttribute("username"));
			ResultSet rs=stmt.executeQuery();
			if(rs.next()){
			%>
	<div class="text-primary">
	你的排名是<%=rs.getString("排名")%>
	</div>
	<%} %>
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