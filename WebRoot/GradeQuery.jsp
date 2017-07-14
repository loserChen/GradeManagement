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
                <li><a href="rankQuery.jsp">排名查询</a></li>
                <li><a href="GradeQuery.jsp">总成绩查询</a></li>
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
                <li><a href="classSearch.jsp?semester=2016/2017(1)">班级课程开设查询</a></li>
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
    <%! int pageSize=10;
     	int pageCount;
     	int showPage;
     	int recordCount;
     	%>
    <%      
   				if(request.getParameter("showPage")!=null){
					showPage=Integer.parseInt(request.getParameter("showPage"));
				}
				else{
					showPage=1;
				}
   			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://localhost:1433;databasename=chenzeyuan03Mis";
			Connection conn=DriverManager.getConnection(url,"sa","root"); 
			Statement sm=conn.createStatement();
			ResultSet rs1=sm.executeQuery("select count(*) from Chenzy_gradeall where czy_sid="+(Integer)session.getAttribute("username"));
			if(rs1.next()){
				recordCount=rs1.getInt(1);
			}
			pageCount=(recordCount%pageSize==0)?(recordCount/pageSize):(recordCount/pageSize+1);
			String sql="select top 10 * from Chenzy_gradeall where czy_sid="+(Integer)session.getAttribute("username")+"and czy_lname not in (select top "+(showPage-1)*pageSize+" czy_lname from Chenzy_gradeall ) order by czy_time";
			Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
			ResultSet rs=stmt.executeQuery(sql);
			%>
	<table class="table table-condensed">
    <thead>
    <tr>
    <th>课程名</th>
    <th>老师名</th>
    <th>学分</th>
    <th>开课时间</th>
   	<th>成绩</th>
    </tr>
    </thead>
    <tbody>
    <%while(rs.next()){%>
    	<tr>
    		<td><%=rs.getString("czy_lname") %></td>
    		<td><%=rs.getString("czy_tname") %></td>
    		<td><%=rs.getString("czy_credit") %></td>
    		<td><%=rs.getString("czy_time") %></td>
    		<td><%=rs.getString("czy_grade") %></td>
    	</tr>
    <%} %>
	</tbody>
	</table>
	<ul class="pagination">

			<%if(showPage==1){%>
				<li class="disabled"><a href=#>&laquo;</a></li>
			<%}else{%>
				 <li><a href='?showPage=<%=showPage-1%>'>&laquo;</a></li>
			<%}
			for(int i=1;i<=pageCount;i++){
				if(i==showPage){%>
					<li class="active"><a href='?showPage=<%=i %>'><%=i%></a></li>
				<% }
				else{%>
					<li><a href='?showPage=<%=i %>'><%=i%></a></li>
				<%}
			}
			if(showPage==pageCount){%>
				<li class="disabled"><a href=#>&raquo;</a></li>
			<%}
			else{%>
				<li><a href='?showPage=<%=showPage+1%>'>&raquo;</a></li>
			<%}%>

	</ul>
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
