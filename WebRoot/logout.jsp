<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
	session.putValue("username",null);
	out.print("<script>alert('已注销');window.location.href='login.jsp';</script>");
	%>