<%@ page language="java" contentType="text/html"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="profile.Profile"%>
<%@ page import="profile.ProfileDAO"%>
<%@ page import="java.io.PrintWriter"%>
<jsp:useBean id="user" class="user.User" scope="session" /> 
<jsp:useBean id="profile" class="profile.Profile" scope="session" /> 
<jsp:setProperty name = "user" property = "userID" />
<jsp:setProperty name = "user" property = "userPW" />
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<jsp:setProperty name="profile" property="p_age" param="p_age"/>
<jsp:setProperty name="profile" property="p_addr" param="p_addr"/>
<jsp:setProperty name="profile" property="p_addrDetail" param="p_addrDetail"/>
<jsp:setProperty name="profile" property="p_job" param="p_job"/>
<jsp:setProperty name="profile" property="p_jobDetail" param="p_jobDetail"/>
<jsp:setProperty name="profile" property="p_height" param="p_height"/>
<jsp:setProperty name="profile" property="p_blood" param="p_blood"/>
<jsp:setProperty name="profile" property="p_mbti" param="p_mbti"/>
<jsp:setProperty name="profile" property="p_character" param="p_character"/>

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
	        int month = Integer.parseInt(request.getParameter("month"));
	        int day = Integer.parseInt(request.getParameter("day"));
	        Calendar calendar = Calendar.getInstance();
	        calendar.set(Calendar.MONTH, month - 1);
	        calendar.set(Calendar.DAY_OF_MONTH, day);
	        Date p_birth = calendar.getTime();
	        
	        profile.setP_birth(p_birth);
	        profile.setUserID(userID);
	
	        
	            ProfileDAO profileDAO = new ProfileDAO();
	            int result = profileDAO.Pupdate(profile);
	            if (result == -1) {
	                PrintWriter script = response.getWriter();
	                script.println("<script>");
	                script.println("alert('작성에 실패하셨습니다')");
	                script.println("history.back()");
	                script.println("</script>");
	            } else {
	                PrintWriter script = response.getWriter();
	                script.println("<script>");
	                script.println("location.href = 'matchInfo3.jsp'");
	                script.println("</script>");
	            }
	        }
	    
	%>
</body>
</html>