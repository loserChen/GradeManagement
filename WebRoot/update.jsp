<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<% 			
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://localhost:1433;databasename=chenzeyuan03Mis";
			Connection conn=DriverManager.getConnection(url,"sa","root"); 
			String sql="select * from Chenzy_gradeall where czy_time = ? and czy_cname= ? and czy_lname = ? and czy_tname = ?";
			PreparedStatement sm=conn.prepareStatement(sql);
			String cname=(String)session.getAttribute("cname");
			String lesson=(String)session.getAttribute("lesson");
			String semester=(String)session.getAttribute("semester");
			sm.setString(1,semester);
			sm.setString(2,cname);
			sm.setString(3,lesson);
			sm.setString(4,(String)session.getAttribute("tname"));
			PreparedStatement sm1=null;
			ResultSet rs=sm.executeQuery();
			String[] grade=request.getParameterValues("grade");
			int i=0;
			while(rs.next()){
			String sname=rs.getString("czy_sname");
			int grade1=Integer.parseInt(grade[i]);
			i++;
			String sql1="update Chenzy_gradeall set czy_grade="+grade1+"where czy_time = ? and czy_sname= ? and czy_lname = ? and czy_tname = ?";
			sm1=conn.prepareStatement(sql1);
			sm1.setString(1,semester);
			sm1.setString(2,sname);
			sm1.setString(3,lesson);
			sm1.setString(4,(String)session.getAttribute("tname"));
			sm1.executeUpdate();
			}
			RequestDispatcher rd=request.getRequestDispatcher("registerGrade.jsp");
					rd.forward(request,response);
			%>
			<%
 			rs.close();
 			sm.close();
 			sm1.close();
 			conn.close();
 			%>