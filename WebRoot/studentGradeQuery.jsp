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
    <%		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://localhost:1433;databasename=chenzeyuan03Mis";
			Connection conn=DriverManager.getConnection(url,"sa","root"); 
			Statement sm=conn.createStatement();
			String sql="select czy_mname from Chenzy_major";
			ResultSet rs1=sm.executeQuery(sql); %>
    <div class="text-primary">
	<form action="studentGradeQuery.jsp">
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
	专业:<select name="mname">
	<%while(rs1.next()){ %>
	<option value="<%=rs1.getString("czy_mname")%>"><%=rs1.getString("czy_mname")%></option>
	<%} %>
	</select>
	<input type="submit" value="查询">
	</form>
	</div>
     <%! int pageSize=10;
     	int pageCount;
     	int showPage;
     	int recordCount;
     	int mid;
     	String semester;
     	%>
    <%      
   				if(request.getParameter("showPage")!=null){
					showPage=Integer.parseInt(request.getParameter("showPage"));
				}
				else{
					showPage=1;
				}
			if(request.getParameter("mname")!=null){
			sql="select czy_mid from Chenzy_major where czy_mname="+"'"+new String(request.getParameter("mname").getBytes("iso-8859-1"),"utf-8")+"'";
			sm=conn.createStatement();
			rs1=sm.executeQuery(sql);
			if(rs1.next()){
			mid=rs1.getInt("czy_mid");
			}
			semester=request.getParameter("semester");
			}
			sql="select count(*) from Chenzy_gradeall where czy_time= ? and czy_mid=?";
			PreparedStatement psm=conn.prepareStatement(sql);
			psm.setString(1,semester);
			psm.setInt(2,mid);
			rs1=psm.executeQuery();
			if(rs1.next()){
				recordCount=rs1.getInt(1);
			}
			pageCount=(recordCount%pageSize==0)?(recordCount/pageSize):(recordCount/pageSize+1);
			if(mid>0){
			sql="select * from (select ROW_NUMBER() over (order by czy_sid,czy_lname desc) as rownum,Chenzy_gradeall.* from Chenzy_gradeall where czy_time= ? and czy_mid= ? )B where rownum >"+(showPage-1)*pageSize+"and rownum <"+showPage*pageSize;
			psm=conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			psm.setString(1,semester);
			psm.setInt(2,mid);
			rs1=psm.executeQuery();
			%>
	<table class="table table-condensed">
    <thead>
    <tr>
    <th>学号</th>
    <th>学生名</th>
    <th>班级名</th>
    <th>课程名</th>
    <th>老师名</th>
    <th>学分</th>
    <th>开课时间</th>
   	<th>成绩</th>
    </tr>
    </thead>
    <tbody>
    <%while(rs1.next()){%>
    	<tr>
    		<td><%=rs1.getInt("czy_sid") %></td>
    		<td><%=rs1.getString("czy_sname") %></td>
    		<td><%=rs1.getString("czy_cname") %></td>
    		<td><%=rs1.getString("czy_lname") %></td>
    		<td><%=rs1.getString("czy_tname") %></td>
    		<td><%=rs1.getString("czy_credit") %></td>
    		<td><%=rs1.getString("czy_time") %></td>
    		<td><%=rs1.getString("czy_grade") %></td>
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
			<%}
			}
			%>

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
 rs1.close();
 sm.close();
 conn.close();
  %>
