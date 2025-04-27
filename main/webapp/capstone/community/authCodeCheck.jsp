<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	    String inputCode = request.getParameter("inputCode");
	    String sessionCode = (String) session.getAttribute("authCode");
	
	    if (inputCode.equals(sessionCode)) {
	        out.println("<script>alert('인증이 완료되었습니다.'); history.back();</script>");
	    } else {
	        out.println("<script>alert('인증 코드가 올바르지 않습니다. 다시 시도해주세요.'); history.back();</script>");
	    }
	%>
</body>
</html>