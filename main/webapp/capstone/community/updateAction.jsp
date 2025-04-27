<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
		} 
		int bbsID = 0;
        String bbsCategory = " ";
        if (request.getParameter("bbsID") != null) {
            bbsID = Integer.parseInt(request.getParameter("bbsID"));
        }
        if (request.getParameter("bbsCategory") != null) {
            bbsCategory = request.getParameter("bbsCategory");
        }
        
		Bbs bbs = new BbsDAO().getBbs(bbsID, bbsCategory);
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
					|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID ,request.getParameter("bbsTitle"), request.getParameter("bbsContent"), request.getParameter("bbsCategory"), request.getParameter("bbsSecret"));
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					if ("notice".equals(bbs.getBbsCategory())) {
						response.sendRedirect("cm_01-1a.jsp");
					} else if ("Q".equals(bbs.getBbsCategory())) {
						response.sendRedirect("cm_03-1a.jsp");
					} else if ("FREE".equals(bbs.getBbsCategory())) {
						response.sendRedirect("cm_04-1a.jsp");
					} else if ("LATTER".equals(bbs.getBbsCategory())) {
						response.sendRedirect("cm_05-1a.jsp");
					} else {
						// 기본적으로 공지사항 페이지로 이동
						response.sendRedirect("cm_01-1a.jsp");
					}
				}
			}
	%>
</body>
</html>