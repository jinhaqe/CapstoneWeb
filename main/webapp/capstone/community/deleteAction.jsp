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
        String bbsCategory = "";
        if (request.getParameter("bbsID") != null) {
            bbsID = Integer.parseInt(request.getParameter("bbsID"));
        }
        if (request.getParameter("bbsCategory") != null) {
            bbsCategory = request.getParameter("bbsCategory");
        }
        if (bbsID == 0 || bbsCategory.equals("")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('유효하지 않은 글 입니다.')");
            script.println("location.href = 'cm_01-1a.jsp'");
            script.println("</script>");
        }

        // Debugging output
        System.out.println("bbsID: " + bbsID);
        System.out.println("bbsCategory: " + bbsCategory);

        Bbs bbs = new BbsDAO().getBbs(bbsID, bbsCategory);
        if (bbs == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('글이 존재하지 않습니다.')");
            script.println("location.href = 'cm_01-1a.jsp'");
            script.println("</script>");
        } else if (!userID.equals(bbs.getUserID())) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('권한이 없습니다.')");
            script.println("location.href = 'cm_01-1a.jsp'");
            script.println("</script>");
        } else {
            BbsDAO bbsDAO = new BbsDAO();
            int result = bbsDAO.delete(bbsID, bbsCategory);
            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('글 삭제에 실패했습니다')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                String redirectUrl = "";
                if (bbsCategory.equalsIgnoreCase("notice")) {
                    redirectUrl = "cm_01-1a.jsp";
                } else if (bbsCategory.equalsIgnoreCase("Q")) {
                    redirectUrl = "cm_03-1a.jsp";
                } else if (bbsCategory.equalsIgnoreCase("FREE")) {
                    redirectUrl = "cm_04-1a.jsp";
                } else if (bbsCategory.equalsIgnoreCase("LATTER")) {
                    redirectUrl = "cm_05-1a.jsp";
                }
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href='" + redirectUrl + "'");
                script.println("</script>");
            }
        }
    %>
</body>
</html>