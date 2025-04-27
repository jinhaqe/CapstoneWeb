<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="profile_s.Profile_s"%>
<%@ page import="profile_s.Profile_sDAO"%>
<%@ page import="java.io.PrintWriter"%>
<jsp:useBean id="user" class="user.User" scope="session" /> 
<jsp:useBean id="profile_s" class="profile_s.Profile_s" scope="session" /> 
<jsp:setProperty name = "user" property = "userID" />
<jsp:setProperty name = "user" property = "userPW" />
<jsp:setProperty name="profile_s" property="ps_sign" param="ps_sign"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	    String userID = null;
	    if (session.getAttribute("userID") != null) {
	        userID = (String) session.getAttribute("userID");
	    }
	    if (userID == null) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('로그인을 하세요.')");
	        script.println("location.href = '../IntLogImsi/login.jsp'");
	        script.println("</script>");
	    } else {
	        profile_s.setUserID(userID);
	            Profile_sDAO profile_sDAO = new Profile_sDAO();
	            int result = profile_sDAO.PSupdate(profile_s);
	            if (result == -1) {
	                PrintWriter script = response.getWriter();
	                script.println("<script>");
	                script.println("alert('작성에 실패하셨습니다')");
	                script.println("history.back()");
	                script.println("</script>");
	            } else {
	                PrintWriter script = response.getWriter();
	                script.println("<script>");
	                script.println("location.href = 'matchInfoEnd.jsp'");
	                script.println("</script>");
	            }
	        }
	%>
</body>
</html>