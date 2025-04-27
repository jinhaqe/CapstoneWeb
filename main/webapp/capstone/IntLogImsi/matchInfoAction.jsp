<%@ page import="java.io.*" %>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="profile.Profile"%>
<%@ page import="profile.ProfileDAO"%>
<jsp:useBean id="user" class="user.User" scope="session" /> 
<jsp:useBean id="profile" class="profile.Profile" scope="session" /> 
<jsp:setProperty name="profile" property="p_picture" param="p_picture"/>
<jsp:setProperty name = "user" property = "userID" />
<% request.setCharacterEncoding("UTF-8"); %>
<%
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	int size = 10*1024*1024;
	try{
		// 생성자 업로드
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
				String savePath = "C:/JSP/capstone/capstone/src/main/webapp/capstone/IntLogImsi/profileImage/";
				MultipartRequest multi = new MultipartRequest(request, savePath , size, "utf-8", policy);
				String originalFileName = multi.getOriginalFileName("p_picture");
				String fileExtension = "";
				if (originalFileName != null && originalFileName.contains(".")) {
				    fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				}
	
				String newFileName = userID + fileExtension;
				File oldFile = new File(savePath + multi.getFilesystemName("p_picture"));
				File newFile = new File(savePath + newFileName);
	
				if (oldFile.renameTo(newFile)) {
				    String p_picture = newFileName;  // 변경된 파일명을 p_picture로 설정
				    profile.setP_picture(p_picture);
				 
				    ProfileDAO ProfileDAO = new ProfileDAO();
				    int result = ProfileDAO.Pwrite(userID, newFileName);
				    
				    if (result == -1) {
				        PrintWriter script = response.getWriter();
				        script.println("<script>");
				        script.println("alert('작성에 실패하셨습니다')");
				        script.println("history.back()");
				        script.println("</script>");
				    } else {
				        PrintWriter script = response.getWriter();
				        script.println("<script>");
				        script.println("location.href = 'matchInfo2.jsp'");
				        script.println("</script>");
				    }
				} else {
				    PrintWriter script = response.getWriter();
				    script.println("<script>");
				    script.println("alert('파일명 변경에 실패했습니다')");
				    script.println("history.back()");
				    script.println("</script>");
					}
				}	

	}catch(Exception e){
		e.printStackTrace();
	}
%>