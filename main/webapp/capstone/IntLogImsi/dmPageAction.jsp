<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="chat.ChatDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");

    String chatContent = request.getParameter("chatContent");
    String userID = (String) session.getAttribute("userID");
    String chatID = (String) session.getAttribute("chatID");

    if (userID != null && chatContent != null && !chatContent.trim().isEmpty()) {
        ChatDAO chatDAO = new ChatDAO();
        int result = chatDAO.sendMessage(userID, chatID, chatContent);

        if (result == -1) {
            response.getWriter().println("Error sending message.");
        } else {
            response.getWriter().println("Message sent successfully.");
        }
    } else {
        response.getWriter().println("Invalid message content.");
    }
%>