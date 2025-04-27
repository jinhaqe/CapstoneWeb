<%@page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
		<%
			session.invalidate();		
		%>
		<script>
			location.href= '../cp_intro.jsp';
		</script>
</body>
</html>