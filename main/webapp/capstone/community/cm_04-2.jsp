<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="comment.Comment"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<!DOCTYPE html>
<html lang="en">
<link rel=stylesheet href="cm_04-2.css?after">
<link rel=stylesheet href="../Company introduction/main.css">
<link rel="stylesheet" href="../cp_intro.css">
<script src="../cp_intro.js"></script>
<head>
	<meta charset="UTF-8">
</head>
<body>
<%
		String userID = null;
		String bbsCategory = "FREE";
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int bbsID = 0;
		int bbsNum = 0;
		if (request.getParameter("bbsNum") != null) {
			String bbsIDParam = request.getParameter("bbsID");
			bbsID = Integer.parseInt(bbsIDParam);
			bbsNum = Integer.parseInt(request.getParameter("bbsNum"));
			session.setAttribute("bbsID", bbsID);
			session.setAttribute("bbsNum", bbsNum);
			session.setAttribute("bbsCategory", bbsCategory);
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID, bbsCategory);
		if (bbsNum == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'cm_04-1a.jsp'");
			script.println("</script>");
		}
		
		
%>
<%
	    
	    String chatID = null;
	    String ChatStatus = null;
	    boolean isAccepted = false;
	
	    if (userID != null) {
	        try {
	            String SQL = "SELECT matchingID, matchStatus, userID FROM matching WHERE userID = ? OR matchingID = ?";
	            String dbURL = "jdbc:mysql://localhost:3306/cap?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
	            String dbID = "root";
	            String dbPW = "1234";
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            Connection conn = DriverManager.getConnection(dbURL, dbID, dbPW);
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            pstmt.setString(1, userID);
	            pstmt.setString(2, userID);
	            ResultSet rs = pstmt.executeQuery();

	            if (rs.next()) {
	                String dbUserID = rs.getString("userID");
	                String dbMatchingID = rs.getString("matchingID");
	                ChatStatus = rs.getString("matchStatus");
	                isAccepted = "accepted".equalsIgnoreCase(ChatStatus);

	                if (userID.equals(dbUserID)) {
	                    chatID = dbMatchingID;
	                } else if (userID.equals(dbMatchingID)) {
	                    chatID = dbUserID;
	                }

	                // chatID를 세션에 저장
	                session.setAttribute("chatID", chatID);

	                System.out.println("chatID: " + chatID); // 디버깅용 출력
	            } else {
	                System.out.println("No matching data found for userID: " + userID);
	            }

	            rs.close();
	            pstmt.close();
	            conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	%>
<div class="wrap">
    <header>
        <a href="../cp_intro.jsp"><img src="../logo/진하로고3.png"class="main_logo"></a>
        <nav>
            <ul class="nav_in">
                <li class="li_dropdown"><a href="../Company introduction/cp_01.jsp">회사소개</a>
                    <ul class="ul_border">
                        <li><a href="../Company introduction/cp_01.jsp">회사소개</a></li>
                        <li><a href="../Company introduction/cp_02.jsp">지사소개</a></li>
                        <li><a href="../Company introduction/cp_03.jsp">팀소개</a></li>
                        <li><a href="../Company introduction/cp_04.jsp">로고소개</a></li>
                        <li><a href="../Company introduction/cp_05.jsp">오시는길</a></li>
                    </ul>
                </li>
                <li class="li_dropdown"><a href="../Company introduction/cp_06.jsp">이용안내</a>
                    <ul class="ul_border">
                        <li><a href="../Company introduction/cp_06.jsp">이용절차</a></li>
                        <li><a href="../Company introduction/cp_07.jsp">이용금액</a></li>
                        <li><a href="../Company introduction/cp_08.jsp">매칭이용가이드</a></li>
                        <li><a href="../Company introduction/cp_09.jsp">세부규정</a></li>
                        <li><a href="../Company introduction/cp_10.jsp">환불규정</a></li>
                    </ul>
                </li>
                <li class="li_dropdown"><a href="cm_01-1a.jsp">커뮤니티</a>
                    <ul class="ul_border">
                        <li><a href="cm_01-1a.jsp">공지사항</a></li>
                        <li><a href="cm_02-a.jsp">FAQ</a></li>
                        <li><a href="cm_03-1a.jsp">Q&A</a></li>
                        <li><a href="cm_04-1a.jsp">자유게시판</a></li>
                        <li><a href="cm_05-1a.jsp">후기</a></li>
                    </ul>
                </li>

                <li><a href="../IntLogImsi/InterviewMain.jsp">포토인터뷰</a></li>

                <li class="li_dropdown"><a href="../test/test1.jsp">테스트</a>
                    <ul class="ul_border">
                        <li><a href="../test/test1.jsp">이상형테스트</a></li>
                        <li><a href="../test/test2.jsp">성격유형</a></li>
                        <li><a href="../test/test3.jsp">연애력테스트</a></li>
                        <li><a href="../test/test4.jsp">연애능력고사</a></li>
                        <li><a href="../test/test5.jsp">연애운세</a></li>
                    </ul>
                </li>
                <li class="li_dropdown"><a href="../Tip/Tip1.jsp">Tip</a>
                    <ul class="ul_border">
                        <li><a href="../Tip/Tip1.jsp">광고 모음</a></li>
                        <li><a href="../Tip/Tip2.jsp">이벤트(파티)</a></li>
                        <li><a href="../Tip/Tip3.jsp">다온 뉴스</a></li>
                        <li><a href="../Tip/Tip4.jsp">연애 이야기</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <%if (userID == null) {%>
	        <div class="user_style">
	            <div class="user_in">
	                <a href="../IntLogImsi/login.jsp">
	                    <img class="img01" src="../icon/yh/Login.png">
	                    <span>로그인</span>
	                </a>
	                <a href="../community/cm_06-1.jsp">
	                    <img class="img01" src="../icon/yh/join.png">
	                    <span>회원가입</span>
	                </a>
	                <a href="#none" onclick="handleDMClick('<%= isAccepted %>');">
	                    <img class="img01" src="../icon/yh/DM.png">
	                    <span>DM</span>
	                </a>
	            </div>
	        </div>
	        <% }  else if (userID != null) {%>
	        <div class="user_style">
	            <div class="user_in">
	                <a href="../IntLogImsi/logoutAction.jsp">
	                    <img class="img01" src="../icon/yh/Logout.png">
	                    <span>로그아웃</span>
	                </a>
	                <a href="../IntLogImsi/myPage.jsp">
	                    <img class="img01" src="../icon/yh/mypage.png">
	                    <span>마이페이지</span>
	                </a>
	                <a href="#none" onclick="handleDMClick('<%= isAccepted %>');" >
	                    <img class="img01" src="../icon/yh/DM.png">
	                    <span>DM</span>
	                </a>
	            </div>
	        </div>
	        <%} %>
    </header>
   	<div id="dmSection" style="display: none;">
		    <div class="DM_nemo">
		    	<div class="DM_X" onclick="DM_X()"><img src="../IntLogImsi/dmx.png"></div>
		        <div class="massIn">
		        <div id="chatMessages">
				</div>
		        </div>
		       	<form method="post" id="chatForm" action="../IntLogImsi/dmPageAction.jsp"  enctype="multipart/form-data" accept-charset="UTF-8">
			        <div class="DM_go">
			            <textarea name="chatContent" id="chatContent" maxlength="50" required></textarea>
			            <input type="submit" class="next-btn" value="전송">
			        </div>
		        </form>
		    </div>
   	</div>
   	<script>
	    function handleDMClick(isAccepted) {
	        if (isAccepted === "true") {
	            document.getElementById("dmSection").style.display = "block";
	        } else {
	            alert("매칭된 상대가 없습니다.");
	        }
	    }
	    
	    function DM_X() {
	    	document.getElementById("dmSection").style.display = "none";
	    }
	</script>
   	<script>
	    // 전송 버튼 클릭 시 AJAX로 메시지 전송
	    document.getElementById('chatForm').addEventListener('submit', function(event) {
	        event.preventDefault();  // 페이지 새로고침 방지
	
	        var chatContent = document.getElementById('chatContent').value;
	
	        if (chatContent.trim() === '') {
	            alert('내용을 입력하세요.');
	            return;
	        }
	
	        // AJAX 요청 보내기
	        var xhr = new XMLHttpRequest();
	        xhr.open('POST', '../IntLogImsi/dmPageAction.jsp', true);
	        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	        xhr.onload = function() {
	            if (xhr.status == 200) {
	                // 메시지 전송 후 화면 갱신
	                loadMessages();
	                document.getElementById('chatContent').value = '';  // 입력창 비우기
	            } else {
	                alert('DM 보내기 실패');
	            }
	        };
	        xhr.send('chatContent=' + encodeURIComponent(chatContent));
	    });
	
	    // 메시지 목록을 서버에서 받아와 갱신하는 함수
	    function loadMessages() {
		    var xhr = new XMLHttpRequest();
		    xhr.open('GET', '../IntLogImsi/getMessages.jsp', true); // 메시지를 받아오는 페이지
		    xhr.onload = function() {
		        if (xhr.status == 200) {
		            document.getElementById('chatMessages').innerHTML = xhr.responseText;
		            
		            // 최신 메시지가 보이도록 스크롤
		            var chatMessages = document.getElementById('chatMessages');
		            chatMessages.scrollTop = chatMessages.scrollHeight;
		        }
		    };
		    xhr.send();
		}
	    
	    window.onload = loadMessages;
	</script>
    <div>
        <div class="bg1 bg1_deep">
            <div class="title">
                <h5>자유게시판</h5>
                
            </div>
        </div> 
        <div class="sub_tab">
            <div class="sub_tab_co">
                <div class="sub_tab_in">
                    <a href="cm_01-1a.jsp" class="bactive">공지사항</a><!--
                    --><a href="cm_02-a.jsp" class="bactive">FAQ</a><!--
                    --><a href="cm_03-1a.jsp" class="bactive">Q&A</a><!--
                    --><a href="cm_04-1a.jsp" class="active">자유게시판</a><!--
                    --><a href="cm_05-1a.jsp" class="bactive">후기</a>
                </div>
            </div>
        </div>         
    </div>
    <div class="content">
        <div class="notice_title">
            <p>자유게시판</p>
        </div>
        <div class="board_view_wrap">
            <div class="board_view">
		        <% if (bbs != null) { %>
		            <div class="title"><%= bbs.getBbsTitle() %></div>
		            <div class="info">
		                <dl>
		                    <dt>작성자</dt>
		                    <dd><%= bbs.getUserID() %></dd>
		                </dl>
		                <dl>
		                    <dt>작성일</dt>
		                    <input type="hidden" name="bbsCategory" value="FREE">
		                    <% if (bbs.getBbsDate() != null && bbs.getBbsDate().length() >= 11) { %>
		                        <dd><%= bbs.getBbsDate().substring(0, 11) %></dd>
		                    <% } else { %>
		                        <dd></dd>
		                    <% } %>
		                </dl>
		            </div>
		            <div class="cont">
		                <p>
		                    <% 
		                    if (bbs.getBbsContent() != null) {
		                        out.println(bbs.getBbsContent().replaceAll(" ", "&nbsp;")
		                                .replaceAll("<", "&lt;").replaceAll(">", "&gt;")
		                                .replaceAll("\n", "<br>"));
		                    } else {
		                        out.println("게시물 내용을 찾을 수 없습니다."); // 게시물 내용에 대한 오류 처리
		                    }
		                    %>
		                </p>
		                <p class="comCount">개의 댓글</p>
			        </div>
			            <%
				            CommentDAO commentDAO = new CommentDAO();
				            ArrayList<Comment> list = commentDAO.getList(bbsNum);
				            for(int i = 0; i < list.size(); i++)
				            {
			            %>
			            <div class="comment">
			            	<p class="comT"><%=list.get(i).getUserID() %></p>
			            	<p class="comDate"><%=list.get(i).getComDate().substring(0, 10) %></p>
			            	<p class="comCon">
			            		<% 
			                    if (list.get(i).getComContent() != null) {
			                        out.println(list.get(i).getComContent().replaceAll(" ", "&nbsp;")
			                                .replaceAll("<", "&lt;").replaceAll(">", "&gt;")
			                                .replaceAll("\n", "<br>"));
			                    } else {
			                        out.println("게시물 내용을 찾을 수 없습니다."); 
			                    }
			                    %>
			            	</p>
			            </div>
			            <% } %>
			            <form action="commentWriteAction.jsp" method="post">
				            <div class="commentW">
				            	<textarea class="textarea" name="comContent" maxlength="500" required></textarea>
				            	<input type="submit" value="작성">
				            </div>
				        </form>
		            </div>
		            <div class="bt_wrap_in">
		            <% if(userID != null && userID.equals(bbs.getUserID())) { %>
				         	<div class="bt_wrap">
				                    <a href="update.jsp?bbsID=<%= bbsID %>&bbsCategory=<%= bbs.getBbsCategory() %>" style="color: white;">수정</a>
				                </div>
				                <div class="bt_wrap">
				                    <a onclick="return confirm('정말 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>&bbsCategory=<%= bbs.getBbsCategory() %>" style="color: white;">삭제</a>
				                </div>
				            <% } %>
				            <div class="bt_wrap">
				                <a href="cm_04-1a.jsp" style="color: white;">목록</a>
			            </div>
		        <% } else { %>
		            <p>해당 글을 찾을 수 없습니다.</p> <!-- bbs가 null일 때 처리 -->
		        <% } %>
		        </div>
		    </div>
		</div>
    </div>
</div>
    <footer>
        <div class="footer_in">
            <div class="footer_top">
                <a href="../Company introduction/cp_01.jsp">회사소개</a>
                <a href="../Company introduction/cp_06.jsp">이용안내</a>
                <a href="">개인정보처리방침</a>
                <a href="">손해배상청구절차</a>
            </div>
            <div class="footer_bottom">
                <div class="footer_logo"></div>
                <p>
                    상호명 : (주)다온 
                    <span class="ml10"></span>
                    대표 : 최혜원
                    <span class="ml10"></span>
                    사업자등록번호 : 000-00-0000
                    <br>
                    주소 : 대구광역시 북구 복현로 35
                    <span class="ml10"></span>
                    통신판매신고 : 2023-대구북구-00000
                    <br>
                    TEL : 00-000-0000
                    <span class="ml10"></span>
                    FAX : 00-000-0000
                    <span class="ml10"></span>
                    E-mail : ounnms@daon.com
                    <br>
                    개인정보보호책임자 : 진예희 (ounnms@daon.com)
                    <br>
                    2024 다온, All Right Reserved.				
                </p>
            </div>
        </div>
    </footer>
</body>
</html>