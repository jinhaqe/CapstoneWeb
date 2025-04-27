<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<jsp:setProperty name="bbs" property="bbsCategory" />
<jsp:setProperty name="bbs" property="bbsSecret" />
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
		} else {
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				BbsDAO BbsDAO = new BbsDAO();
				int result = BbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent(), bbs.getBbsCategory(), bbs.getBbsSecret());
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다')");
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
		}
	%>
</body>
</html>