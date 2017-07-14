<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*" %>
<html>
<head>
		<link rel="stylesheet" type="text/css" href="other/bootstrap-3.3.7-dist/css/bootstrap.min.css">
		<link rel="stylesheet" href="other/jquery-bootstrap-calendar/css/dcalendar.picker.css"/>
		  <script type="text/javascript" language="JavaScript">
    function Check(){
     var checkArry = document.getElementsByName("grade");
            for (var i = 0; i < checkArry.length; i++) { 
                if(checkArry[i].value==""){
                    alert("选项不能为空!");
    				return false;
                }
            }
    }
    </script>
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
        <div id="collapseOne" class="panel-collapse collapse in">
            <div class="panel-body">
                <li><a href="registerGrade.jsp?semester=2016/2017(1)">成绩录入及查询</a></li>
                <li><a href="avgGrade.jsp">平均成绩</a></li>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
        <div>
                <a href="tlessonQuery.jsp?semester=2016/2017(1)" >
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
		<div class="col-md-1">
		</div>
    <div class="col-md-6">
    <%! String tname;
    	String cname;
    	String lesson;
    	String semester;
    	int i=0;
    	%>
  <%      Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://localhost:1433;databasename=chenzeyuan03Mis";
			Connection conn=DriverManager.getConnection(url,"sa","root"); 
			String sql="select * from Chenzy_teachers where czy_tid="+(Integer)session.getAttribute("username");
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			if(rs.next()){
			tname=rs.getString("czy_tname");
			session.setAttribute("tname", tname);
			}
			sql="select czy_cname from Chenzy_gradeall where czy_tname = ? and czy_time = ?"+" group by czy_cname";
			PreparedStatement sm=conn.prepareStatement(sql);
			sm.setString(1,tname);
			sm.setString(2, request.getParameter("semester"));
			semester=request.getParameter("semester");
			session.setAttribute("semester", semester);
			ResultSet rs1=sm.executeQuery();
			%>
	<form action="update.jsp" method="post" name="fm" onSubmit="return Check()">
    <div class="text-primary">
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
	<option value="2098/2099(1)">2019/2020(1)</option>
	</select>
	班级:<select name="cname">
	<%while(rs1.next()){%>
	<option value="<%=rs1.getString("czy_cname")%>"><%=rs1.getString("czy_cname")%></option>
	<%} %>
	</select>
	课程:<select name="lesson">
	<%
	sql="select czy_cname,czy_lname from Chenzy_gradeall where czy_tname = ? and czy_time = ?"+" group by czy_cname , czy_lname";
	sm=conn.prepareStatement(sql);
	semester=request.getParameter("semester");
	sm.setString(1,tname);
	sm.setString(2, request.getParameter("semester"));
	rs1=sm.executeQuery();
	while(rs1.next()){ %>
	<option value="<%=rs1.getString("czy_lname")%>"><%=rs1.getString("czy_lname")%></option>
	<%} %>
	</select>
	<input type="button" name="Button1" value="查询" onclick="document.fm.action='registerGrade.jsp';document.fm.submit();"/>
	</div>
	<% 		if(request.getParameter("cname")!=null&&request.getParameter("lesson")!=null){
			cname=new String(request.getParameter("cname").getBytes("iso-8859-1"),"utf-8");
			lesson=new String(request.getParameter("lesson").getBytes("iso-8859-1"),"utf-8");
			session.setAttribute("cname", cname);
			session.setAttribute("lesson", lesson);
			sql="select * from Chenzy_gradeall where czy_time = ? and czy_cname= ? and czy_lname = ? and czy_tname = ?";
			sm=conn.prepareStatement(sql);
			sm.setString(1,request.getParameter("semester"));
			sm.setString(2,cname);
			sm.setString(3,lesson);
			sm.setString(4,tname);
			rs1=sm.executeQuery();
			%>
	 <table class="table table-striped">
    <thead>
    <tr>
    <th>姓名</th>
    <th>学分</th>
    <th>成绩</th>
    </tr>
    </thead>
    <tbody>
    <%while(rs1.next()){
    	if(rs1.getInt("czy_grade")>0){%>
    	<tr>
    		<td><%=rs1.getString("czy_sname") %></td>
    		<td><%=rs1.getInt("czy_credit") %></td>
    		<td><%=rs1.getInt("czy_grade") %></td>
    	</tr>
    	<%}else{
    	i=1;%>
    	<tr>
    		<td><%=rs1.getString("czy_sname") %></td>
    		<td><%=rs1.getInt("czy_credit") %></td>
    		<td><input type="text" name="grade"></td>
    	</tr>
    <%}
    } 
    }%>
    </tbody>
    </table>
    <%if(i==1){ %>
    <input type="submit" value="提交" onclick="return confirm('你确定要登记？')"  class="btn btn-success btn-block">
    <%} %>
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
 rs1.close();
 stmt.close();
 conn.close();
  %>