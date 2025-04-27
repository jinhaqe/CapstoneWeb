<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="mail.EmailUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	    String userEmail = request.getParameter("userEmail");
	    String authCode = String.valueOf((int)(Math.random() * 1000000)); // 6자리 랜덤 인증 코드
	    System.out.println("받은 이메일: " + userEmail);
	    // 세션에 인증 코드 저장
	    session.setAttribute("authCode", authCode);
	
	    // 메일 전송
	    try {
	        EmailUtil.sendEmail(userEmail, "인증 코드", "인증 코드: " + authCode);
	        out.println("<script>alert('인증 메일이 발송되었습니다. 메일함을 확인해주세요.'); history.back();</script>");
	    } catch (Exception e) {
	        out.println("<script>alert('메일 발송에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
	        e.printStackTrace();
	    }
	%>
</body>
</html>