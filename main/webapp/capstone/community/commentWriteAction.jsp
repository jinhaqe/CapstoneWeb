<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:useBean id="comment" class="comment.Comment" scope="page" />
<jsp:setProperty name="bbs" property="bbsNum" />
<jsp:setProperty name="comment" property="comContent" />
<jsp:setProperty name="bbs" property="bbsCategory" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<%
		String userID = null;
		String bbsCategory = null;
		int bbsNum = 0;
		int bbsID = 0;
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
			if (comment.getComContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글 내용을 적으세요')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				bbsID = Integer.parseInt(session.getAttribute("bbsID").toString());
				bbsNum = Integer.parseInt(session.getAttribute("bbsNum").toString());
				bbsCategory = (String) session.getAttribute("bbsCategory");
				CommentDAO CommentDAO = new CommentDAO();
				int result = CommentDAO.write(userID, bbsNum, comment.getComContent(), bbsCategory);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 작성에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					System.out.println("bbsNum: " + bbsNum + ", bbsCategory: " + bbsCategory + ", bbsID: "+ bbsID );
					PrintWriter script = response.getWriter();
					script.println("<script>");
	                script.println("alert('댓글이 성공적으로 작성되었습니다.')");
	                script.println("</script>");
	                if ("Q".equals(bbsCategory)) {
	                	response.sendRedirect("cm_03-2.jsp?bbsID=" + bbsID + "&bbsNum=" + bbsNum);
					} 
	                if ("FREE".equals(bbsCategory)) {
						response.sendRedirect("cm_04-2.jsp?bbsID=" + bbsID + "&bbsNum=" + bbsNum);
					}
	                if ("LATTER".equals(bbsCategory)) {
						response.sendRedirect("cm_05-2.jsp?bbsID=" + bbsID + "&bbsNum=" + bbsNum);
					}
				}
			}
		}
	%>
</body>
</html>