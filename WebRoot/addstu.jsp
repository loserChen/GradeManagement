<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<% 			
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://localhost:1433;databasename=chenzeyuan03Mis";
			Connection conn=DriverManager.getConnection(url,"sa","root"); 
			String sql="insert into Chenzy_students values(?,?,?,?,?,0,?)";
			PreparedStatement sm=conn.prepareStatement(sql);
			sm.setInt(1,Integer.parseInt(request.getParameter("sid")));
			sm.setString(2,new String(request.getParameter("sname").getBytes("iso-8859-1"),"utf-8"));
			sm.setString(3,new String(request.getParameter("ssex").getBytes("iso-8859-1"),"utf-8"));
			sm.setInt(4,Integer.parseInt(request.getParameter("sage")));
			sm.setString(5,new String(request.getParameter("area").getBytes("iso-8859-1"),"utf-8"));
			sm.setInt(6,Integer.parseInt(request.getParameter("cid")));
			sm.executeUpdate();
			RequestDispatcher rd=request.getRequestDispatcher("addStudents.jsp");
			rd.forward(request,response);
			%>
			<%
 			sm.close();
 			conn.close();
  			%>
