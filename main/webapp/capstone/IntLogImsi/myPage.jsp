<%@page import="user.User"%>
<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="profile.Profile"%>
<%@ page import="profile.ProfileDAO"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="chat.Chat"%>
<%@ page import="chat.ChatDAO"%>
<%@ page import="java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="session" />
<jsp:useBean id="profile" class="profile.Profile" scope="session" /> 
<jsp:setProperty name = "user" property = "userID" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="InterviewMain.css">
    <script src="InterviewMain.js"></script>
    <link rel=stylesheet href="../cp_intro.css">
    <link rel=stylesheet href="../Company introduction/main.css">
    <link rel="stylesheet" href="myPage.css?after">
    <script src="../cp_intro.js"></script>
</head>
<body>
	<%	 
		boolean admin = false;
	    String userID = null;
	    int age = 0;
	    String job = null;
	    String addr = null;
	    String character = null;
	    String imagePath = null;
	    int month = 0;
	    int day = 0;
	    if (session.getAttribute("userID") != null)
	    {
	        userID = (String)session.getAttribute("userID");
	        Profile profile1 = new ProfileDAO().getProfileByUserID(userID);
	        if (profile1 != null) {
	            age = profile1.getP_age();
	            Date birth = profile1.getP_birth(); 
	            job = profile1.getP_jobDetail();
	            addr = profile1.getP_addr();
	            character = profile1.getP_character();
	            String profileImage = profile1.getP_picture();
	            
	            Calendar cal = Calendar.getInstance();
	            cal.setTime(birth);
	            month = cal.get(Calendar.MONTH) + 1;
	            day = cal.get(Calendar.DAY_OF_MONTH);
	    		
	    	    if (profileImage != null && !profileImage.isEmpty()) {
	    	        imagePath = "profileImage/" + profileImage; 
	    	    } else {
	    	        imagePath = "profileImage/default.png"; 
	    	    }
	        } else {
	            out.println("프로필 정보를 찾을 수 없습니다.");
	        }
	    }
	    if (userID != null) {
	        try {
	            UserDAO userDAO = new UserDAO();
	            admin = userDAO.isAdmin(userID);
	        } catch(Exception e){
	    		e.printStackTrace();
	    	}
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
        <div class="body_Wrap">
            <div class="top">
                <span class="side-bar">
                    <div style="height:40px;"></div>
                    <p id="Ptitle"><b>MY PAGE</b></p>
                    <hr id="hr">
                    <div style="height:10px;"></div>
                    <a href=""><p id="update">회원정보 수정</p></a>
                    <a href="matchInfo.jsp"><p id="update">프로필 수정</p></a>
                    <a href=""><p id="update">로그아웃</p></a>
                    <a href=""><p id="update">회원탈퇴</p></a>
                    <div style="height:10px;"></div>
                    <hr>
                    <div style="height:10px;"></div>
                    <a href=""><p id="fq"><b>F&Q</b></p></a>
                </span>
                <span class="page">
                    <table class="pageTable">
                        <tr>
                            <td colspan="2">
                                <div id="picture">
                                	<img id="picture_img" src="<%= imagePath %>" alt="">	
                                </div>
                                <div id="username">
                                    <p id="username2"><%= userID %></p>
                                    <br>
                                    <p id="username3">나이 : <%= age %></p>
                                    <br>
                                    <p id="username3">생일 : <%= month %>월 <%= day %>일</p>
                                    <br>
                                    <p id="username3">직업 : <%= job %></p>
                                    <br>
                                    <p id="username3">위치 : <%= addr %></p>
                                    <br>
                                    <p id="username3">저는 <%= character %>사람입니다.</p>
                                </div>
                            </td>
                            <td>
                                <div id="personIcon">
                                    <img src="person.png" alt="" style="width:100%; height:100%;">
                                </div>
                                <div id="btn_house"><button id="page_btn"><a href="matchSystem.jsp">매칭 신청</a></button></div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="td_title">오프라인 파티</div>
                                <div id="td_in">신청 리스트</div>
                                <div id="btn_house2"><button id="page_btn2"><a href="../Tip/Tip2.jsp">파티 공고 보기</a></button></div>
                            </td>
                            <td>
                                <div id="td_title">가입 정보</div>
                                <div id="td_in">프로필 작성 완료</div>
                                <div id="btn_house"><button id="page_btn" onclick="location.href='matchInfo.jsp'">프로필 작성</button></div>
                            </td>
                            <td>
                                <div id="book"><img src="book.png" alt=""></div>
                                <div id="btn_house3"><button id="page_btn3"><a href="../Company introduction/cp_08.jsp"><p id="big">매칭 가이드</p><p style="margin:0px;">바로가기</p></a></button></div>
                            </td>
                        </tr>
                    </table>
                    
                    <%
	                    String matchingID = (String) session.getAttribute("userID");
	                    
	                    ProfileDAO profileDAO = new ProfileDAO();
	                    Profile profileHeart = profileDAO.getHeartComing(matchingID);
	                    
	                    String MmatchingID = null; // 초기화
	                    String matchStatus = null; // 초기화
	                    String imagePathHeart = "profileImage/default.png"; // 기본 이미지 경로
	                    
	                    // profileHeart가 null인지 체크
	                    if (profileHeart != null) {
	                        MmatchingID = profileHeart.getUserID();
	                        matchStatus = profileHeart.getMatchStatus();
	                        imagePathHeart = "profileImage/" + profileHeart.getP_picture(); // 프로필 사진 경로 설정
	                    }
	                    System.out.println(matchStatus);
					%>
                    <%
					    String userID1 = (String) session.getAttribute("userID"); // 세션에서 로그인된 사용자 ID를 가져옴
					    ProfileDAO profileDAO1 = new ProfileDAO();
					    Profile profileStop = profileDAO1.getHeartRead(userID1);
					    String matchStatus1 = null;
					    if (profileStop != null) {
					        matchStatus1 = profileStop.getMatchStatus();
					    } else {
					        // profileStop이 null일 경우의 처리
					        matchStatus1 = "정보 없음"; // 적절한 기본 값 설정
					    }
					    String imagePathStop = (profileStop != null) ? "profileImage/" + profileStop.getP_picture() : "profileImage/default.png";
					    //System.out.println(profileStop.getP_picture());
					    System.out.println(imagePathStop);
					    System.out.println(userID1);
					    System.out.println(matchStatus1);
					%>
                    <div class="pro">
                        <div id="matching"><p style="font-size: 20px;">&#10084; 당신에게 매칭 희망</p></div>
                        
                        <div class="matching_profile">
                        	<%
                        		if(profileHeart != null) {
                        	%>
                            <div id="opponent" class="box1_choose"><img id="picture_img1" src="<%= imagePathHeart %>" alt="Profile Picture">
                            <%
                            	if(matchStatus.equals("accepted")) {
                            %>
                            	<div class="darkWin">매칭 성공</div>
                            <%
                            	}
                            %>
                            <%
                            	if(matchStatus.equals("rejected")) {
                            %>
                            	<div class="darkWin">매칭 실패</div>
                            <%
                            	}
                            %>
                            <%
                            	if(matchStatus.equals("pending")) {
                            %>
                            	<div class="darkWin">매칭 중</div>
                            <%
                            	}
                            %>
                            </div>
                            <%
	                        	}
	                        %>
                        </div>
                        
                        <div id="matching"><p style="font-size: 20px;">매칭 대기 중 &#10084;</p></div>
                        
                        <div class="matching_profile">
                        	<%
	                        	if(profileStop != null) {
	                        %>
                            <div id="opponent" class="box1_choose1"><img id="picture_img1" src="<%= imagePathStop %>" alt="Profile Picture">
                            <%
                            	if(matchStatus1.equals("pending")) {
                            %>
                            	<div class="darkWin">매칭 중</div>
                            <%
                            	}
                            %>
                            <%
                            	if(matchStatus1.equals("accepted")) {
                            %>
                            	<div class="darkWin">매칭 성공</div>
                            <%
                            	}
                            %>
                            <%
                            	if(matchStatus1.equals("rejected")) {
                            %>
                            	<div class="darkWin">매칭 실패</div>
                            <%
                            	}
                            %>
                            </div>
                            <%
	                        	}
	                        %>
                        </div>
                        
                        <form method="post" action="updateMatchStatus.jsp">
                        <div class="modal-overlay" id="modal">
						    <div class="modal-box">
						        <p>매칭 수락 하시겠습니까?</p>
						        <button type="submit" value="accepted" class="heart" id="heart" name="action">수락</button>
						        <button type="submit" value="rejected" class="modal-button" id="closeModal" name="action">거절</button>
						        <input type="hidden" name="MuserID" value="<%= userID1 %>">  
    							<input type="hidden" name="MmatchingID" value="<%= MmatchingID %>">
    							<%System.out.println(matchingID); %>
						    </div>
						</div>
						</form>
                        
                        <script>
					        // 선택 버튼 클릭 시 팝업 띄우기
					        document.querySelector('.box1_choose').addEventListener('click', function() {
					            document.getElementById('modal').style.display = 'flex'; // 팝업을 보이게 함
					        });
					
					        // 닫기 버튼 클릭 시 팝업 닫기
					        document.getElementById('closeModal').addEventListener('click', function() {
					            document.getElementById('modal').style.display = 'none'; // 팝업을 숨김
					        });
					    </script>
                    </div>
                </span>
                <span class="user_change"></span>
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