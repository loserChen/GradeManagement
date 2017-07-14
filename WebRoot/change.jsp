<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<%Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://localhost:1433;databasename=chenzeyuan03Mis";
			Connection conn=DriverManager.getConnection(url,"sa","root");	
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	String passwordcheck=request.getParameter("passwordcheck");
	String limit=request.getParameter("limit");
	int len=password.length();
	String sql="select * from Chenzy_login where czy_username="+"'"+username+"'"+"and czy_pwd="+"'"+password+"'";
	Statement stmt=conn.createStatement();
	ResultSet rs=stmt.executeQuery(sql);
	if(!rs.next()){
	out.print("<script>alert('你的用户名或密码不正确');history.go(-1)</script>");
	}
	else{
	if(len<6||len>16){
	out.print("<script>alert('你的密码格式不正确');history.go(-1)</script>");}
	else{
	sql="update Chenzy_login set czy_pwd="+passwordcheck+"where czy_username="+"'"+username+"'";
	stmt.executeUpdate(sql);
	out.print("<script>alert('更改成功');location.href='changePassword.jsp'</script>");
	}
	}
	%>