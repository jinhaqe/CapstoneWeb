<%@page import="user.User"%>
<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="profile_s.Profile_s"%>
<%@ page import="profile_s.Profile_sDAO"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<jsp:useBean id="profile_s" class="profile_s.Profile_s" scope="session" /> 
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="session" /> 
<jsp:setProperty name = "user" property = "userID" />
<jsp:setProperty name = "user" property = "userPW" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel=stylesheet href="../cp_intro.css">
    <link rel=stylesheet href="main.css">
    <script src="../cp_intro.js"></script>
    <link rel=stylesheet href="login.css">
    <link rel=stylesheet href="matchInfo3.css">
</head>
<body>
    <%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
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
                <li class="li_dropdown"><a href="../community/cm_01-1a.jsp">커뮤니티</a>
                    <ul class="ul_border">
                        <li><a href="../community/cm_01-1a.jsp">공지사항</a></li>
                        <li><a href="../community/cm_02-a.jsp">FAQ</a></li>
                        <li><a href="../community/cm_03-1a.jsp">Q&A</a></li>
                        <li><a href="../community/cm_04-1a.jsp">자유게시판</a></li>
                        <li><a href="../community/cm_05-1a.jsp">후기</a></li>
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
	                <a href="login.jsp">
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
	                <a href="logoutAction.jsp">
	                    <img class="img01" src="../icon/yh/Logout.png">
	                    <span>로그아웃</span>
	                </a>
	                <a href="myPage.jsp">
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
		    	<div class="DM_X" onclick="DM_X()"><img src="dmx.png"></div>
		        <div class="massIn">
		        <div id="chatMessages">
				</div>
		        </div>
		       	<form method="post" id="chatForm" action="dmPageAction.jsp"  enctype="multipart/form-data" accept-charset="UTF-8">
			        <div class="DM_go">
			            <textarea name="chatContent" id="chatContent" maxlength="50" required></textarea>
			            <input type="submit" class="next-btn" value="전송">
			        </div>
		        </form>
		    </div>
   	</div>
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
	        xhr.open('POST', 'dmPageAction.jsp', true);
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
		    xhr.open('GET', 'getMessages.jsp', true); // 메시지를 받아오는 페이지
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
	                <h5>프로필 작성</h5>
	                <p>나를 자유롭게 표현해보세요!</p>
	            </div>
	        </div>      
	    </div>
        <div class="big1">
            <div id="gage">
                    <p id="pageText">STEP 3. 나의 스타일</p>
                    <div id="circle1">1</div>
                    <hr id="line">
                    <div id="circle2">2</div>
                    <hr id="line2">
                    <div id="circle3">3</div>
                    <hr id="line3">
                    <div id="circle4">4</div>
            </div>
            <form method="post" action="matchInfoAction3.jsp">
            <div class="big3">
                <table>
                    <tr>
                        <th colspan="2" style="text-align: center; color:rgb(255, 159, 175);">&#9997;자신에 대해 자유롭게 서술해 주세요</th>
                    </tr>
                    <tr>
                        <th>당신의 취미는?</th>
                        <td><textarea name="ps_hobby" id="hobby" cols="100" rows="3" placeholder="ex. 그림을 그리는 것을 좋아하고 요리도 자주 해먹어요"></textarea>
                    </tr>
                    <tr>
                        <th>휴일을 보내는 방법은?</th>
                        <td><textarea name="ps_vacation" id="vacation" cols="100" rows="3" placeholder="ex. 친구들과 맛있는 것을 먹으러 가거나 좋아하는 영화를 보러가요"></textarea>
                    </tr>
                    <tr>
                        <th>평소 스트레스를 푸는 방법은?</th>
                        <td><textarea name="ps_stress" id="stress" cols="100" rows="3" placeholder="ex. 맛있는 것을 먹으러 가거나 잠을 푹 자요"></textarea>
                    </tr>
                    <tr>
                        <th>친구들이 말하는 본인은 어떤 사람인가요?</th>
                        <td><textarea name="ps_person" id="person" cols="100" rows="3" placeholder="ex. 활발한 성격이지만 가끔 진지하게 생각을 많이 하는 면이 있대요"></textarea>
                    </tr>
                    <tr>
                        <th>연인이 생긴다면 하고 싶은 데이트는?</th>
                        <td><textarea name="ps_date" id="date" cols="100" rows="3" placeholder="ex. 둘만의 장소에서 느긋하고 편안하게 같이 있고 싶어요"></textarea>
                    </tr>
                    <tr>
                        <th>내가 생각하는 행복한 연애란?</th>
                        <td><textarea name="ps_happy" id="happy" cols="100" rows="3" placeholder="ex. 항상 함께 있어도 지루하지 않고 편안하고 안심되는 사이"></textarea>
                    </tr>
                    <tr>
                        <th>연애를 할 때 중요하게 보는 것은?</th>
                        <td>
                                <input type="radio" name="ps_impor" value="present" id="check"><label for="present" id="Label">의미가 담긴 선물</label>
                                <input type="radio" name="ps_impor" value="forme" id="check"><label for="forme" id="Label">나를 위해 봉사</label>
                                <input type="radio" name="ps_impor" value="respect" id="check"><label for="respect" id="Label">인정하는 말</label>
                                <input type="radio" name="ps_impor" value="time" id="check"><label for="time" id="Label">함께하는 시간</label>
                                <input type="radio" name="ps_impor" value="skin" id="check"><label for="skin" id="Label">스킨십</label>
                                <input type="radio" name="ps_impor" value="story" id="check"><label for="story" id="Label">진솔한 이야기</label>
                                <input type="radio" name="ps_impor" value="call" id="check"><label for="call" id="Label">연락</label>
                        </td>
                    </tr>
                    <tr>
                        <th>나를 한 줄로 표현한다면?</th>
                        <td><textarea name="ps_single" id="single" cols="100" rows="1" placeholder="ex. 진지하고 다정한 사람"></textarea>
                    </tr>
                </table>
                <!--
                <div class="container">
                    <div class="draggable" draggable="true">
                        <span class="ico-drag"></span>
                        <p class="el">스킨십</p>
                    </div>
                    <div class="draggable" draggable="true">
                        <span class="ico-drag"></span>    
                        <div class="el">CSS</div>
                    </div>
                    <div class="draggable" draggable="true">
                        <span class="ico-drag"></span>
                        <div class="el">JavaScript</div>
                    </div>
                </div>
                -->
            </div>
            <div class="nextBack">
                <button class="before-btn" onclick="location.href='matchInfo2.jsp'">&#10094; 이전</button>
                <input type="submit" class="next-btn" value="다음">
            </div>
            </form>
        </div>
    </div>
    <script src="matchInfo3.js"></script>
</body>
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
</html>