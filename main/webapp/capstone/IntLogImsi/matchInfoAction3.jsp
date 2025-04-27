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
<jsp:setProperty name="profile_s" property="ps_hobby" param="ps_hobby"/>
<jsp:setProperty name="profile_s" property="ps_vacation" param="ps_vacation"/>
<jsp:setProperty name="profile_s" property="ps_stress" param="ps_stress"/>
<jsp:setProperty name="profile_s" property="ps_person" param="ps_person"/>
<jsp:setProperty name="profile_s" property="ps_date" param="ps_date"/>
<jsp:setProperty name="profile_s" property="ps_happy" param="ps_happy"/>
<jsp:setProperty name="profile_s" property="ps_impor" param="ps_impor"/>
<jsp:setProperty name="profile_s" property="ps_single" param= "ps_single"/>
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
	            int result = profile_sDAO.PSwrite(profile_s);
	            if (result == -1) {
	                PrintWriter script = response.getWriter();
	                script.println("<script>");
	                script.println("alert('작성에 실패하셨습니다')");
	                script.println("history.back()");
	                script.println("</script>");
	            } else {
	                PrintWriter script = response.getWriter();
	                script.println("<script>");
	                script.println("location.href = 'matchInfo4.jsp'");
	                script.println("</script>");
	            }
	        }
	%>
</body>
</html>