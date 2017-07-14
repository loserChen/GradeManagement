<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<% 			
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://localhost:1433;databasename=chenzeyuan03Mis";
			Connection conn=DriverManager.getConnection(url,"sa","root"); 
			String sql="update Chenzy_teachers set czy_phone ="+request.getParameter("phone")+"where czy_tid="+(Integer)session.getAttribute("username");
			Statement sm=conn.createStatement();
			sm.executeUpdate(sql);
			RequestDispatcher rd=request.getRequestDispatcher("teacherManagement.jsp");
			rd.forward(request,response);
			%>
			<%
 			sm.close();
 			conn.close();
  			%>