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
	    String action = request.getParameter("action");  
	    String matchingID = (String) session.getAttribute("userID"); 
	    String userID = request.getParameter("MmatchingID");
	    System.out.println(action);
	    System.out.println(userID);
	    System.out.println(matchingID);
	    ProfileDAO profileDAO = new ProfileDAO();
	    int result = profileDAO.updateMatchStatus(userID, matchingID, action);
	
	    PrintWriter script = response.getWriter();
	    script.println("<script>");

	    if (result > 0) {
	    	if(action.equals("accepted")) {
	    		script.println("alert('매칭되었습니다! 메세지를 보내실 수 있습니다.');");
		        script.println("window.location.href = 'myPage.jsp';");
	    	} else if(action.equals("rejected")) {
	    		script.println("alert('매칭 거절하였습니다.');");
		        script.println("window.location.href = 'myPage.jsp';");
	    	}
	    } else {
	    	script.println("alert('매칭 실패');");
	    }

	    script.println("</script>");
	%>
</body>
</html>