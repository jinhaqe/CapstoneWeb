<%@page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="profile.ProfileDAO" %>
<jsp:setProperty name = "user" property = "userID" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	    String userID = (String) session.getAttribute("userID"); 
	    String matchingID = request.getParameter("matchingID");
	    System.out.println(matchingID);
	    ProfileDAO profileDAO = new ProfileDAO();
	    int result = profileDAO.addMatch(userID, matchingID);
	
	    if (result > 0) {
	    	PrintWriter script = response.getWriter();
	    	script.println("<script>");
			script.println("alert('매칭 요청이 성공적으로 전송되었습니다.');");
			script.println("location.href = 'myPage.jsp'");
			script.println("</script>");
	    } else {
	    	PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('매칭 요청에 실패했습니다.');");
			script.println("history.back()");
			script.println("</script>");
	    }
	%>
</body>
</html>