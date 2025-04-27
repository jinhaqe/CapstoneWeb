<%@page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" /> 
<jsp:setProperty name = "user" property = "userID" />
<jsp:setProperty name = "user" property = "userPW" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel=stylesheet href="../cp_intro.css">
    <link rel=stylesheet href="cp_06.css">
    <script src="../cp_intro.js"></script>
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
                    <li class="li_dropdown"><a href="cp_01.jsp">회사소개</a>
                        <ul class="ul_border">
                            <li><a href="cp_01.jsp">회사소개</a></li>
                            <li><a href="cp_02.jsp">지사소개</a></li>
                            <li><a href="cp_03.jsp">팀소개</a></li>
                            <li><a href="cp_04.jsp">로고소개</a></li>
                            <li><a href="cp_05.jsp">오시는길</a></li>
                        </ul>
                    </li>
                    <li class="li_dropdown"><a href="cp_06.jsp">이용안내</a>
                        <ul class="ul_border">
                            <li><a href="cp_06.html">이용절차</a></li>
                            <li><a href="cp_07.html">이용금액</a></li>
                            <li><a href="cp_08.html">매칭이용가이드</a></li>
                            <li><a href="cp_09.html">세부규정</a></li>
                            <li><a href="cp_10.html">환불규정</a></li>
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
                    <h5>꼼꼼한 프로필 작성이</h5>
                    <p>온라인 매칭을 성공으로 이끕니다!</p>
                </div>
            </div> 
            <div class="sub_tab">
                <div class="sub_tab_co">
                    <div class="sub_tab_in">
                        <a href="cp_06.jsp" class="active">이용절차</a><!--
                    --><a href="cp_07.jspl" class="bactive">이용금액</a><!--
                    --><a href="cp_08.jsp" class="bactive">매칭이용가이드</a><!--
                    --><a href="cp_09.jsp" class="bactive">세부규정</a><!--
                    --><a href="cp_10.jsp" class="bactive">환불규졍</a>
                    </div>
                </div>
            </div>       
        </div>
        <div class="body_Wrap">
            <p class="title02">
                이용절차
            </p>
            <div class="guidewrap">
                <div class="g_box">
                    <div class="bg">
                        <img src="../icon/jh/freejoin.png"class="icon">
                    </div>
                    <div class="textbox">
                        <p class="sub_name">무료 회원가입</p>
                        <p class="subtext"> 
                            홈페이지 상단의
                            <a href="../community/cm_07join.jsp" class="linkp">회원가입</a>을 통해 다온의 회원이 되어주세요!
                        </p>
                        <p class="subtext"> 
                            휴대폰 본인 인증 및 회원가입 후 프로필을 꼼꼼하게 작성해주세요.
                        </p>
                    </div>
                </div>
                <div class="g_box">
                    <div class="bg">
                        <img src="../icon/jh/Choice.png"class="icon set">
                    </div>
                    <div class="textbox">
                        <p class="sub_name">매니저 선택 및 신청</p>
                        <p class="subtext"> 
                            원하는 매니저에게 연락을 해주세요!
                        </p>
                        <p class="subtext"> 
                            매니저가 회원님의 프로필을 확인한 후 수정 또는 보완 필요시 피드백 문자가 발송됩니다.
                        </p>
                        <p class="subtext"> 
                            만남 장소에서 직접 소개 & 개별 만남 선택 가능
                        </p>
                        <p class="subtext"> 
                            일정에 따라 매니저에 의한 매칭 진행(필요시 일정 조율)
                        </p>
                        <p class="subtext"> 
                            빠른 선택 및 매니저와의 원활한 소통을 통하면 매칭이 빠르게 진행될 가능성이 높습니다.
                        </p>
                    </div>
                </div>
                <div class="g_box">
                    <div class="bg">
                        <img src="../icon/jh/Completion.png"class="icon set01">
                    </div>
                    <div class="textbox">
                        <p class="sub_name">매칭 완료</p>
                        <p class="subtext"> 
                            매칭 완료 시 마이페이지 및 담당매니저의 카톡 연락으로 알림이 발송됩니다.
                        </p>
                        <p class="subtext"> 
                            선택 옵션 및 나의 취향을 100% 만족하여 원하는 이성과의 만남을 가질 수 있습니다.
                        </p>
                        <p class="subtext"> 
                            상대와의 매칭이 확정된 후 사진이 있는 서로의 프로필을 확인하실 수 있습니다.
                        </p>
                    </div>
                </div>
                <div class="g_box">
                    <div class="bg">
                        <img src="../icon/jh/youProfile.png"class="icon set01">
                    </div>
                    <div class="textbox">
                        <p class="sub_name">매칭 결과 확인 & 상대 프로필 확인</p>
                        <p class="subtext"> 
                            매칭 성공을 축하드립니다!
                        </p>
                        <p class="subtext"> 
                            나와의 만남을 원하는 이성 회원의 프로필을 마이페이지에서 확인해주세요.
                        </p>
                        <p class="subtext"> 
                            회원 본인이 신청 시 선별적으로 공개하실 수 있습니다.
                        </p>
                        <p class="subtext1"> 
                            매칭 결과 확인?
                        </p>
                        <p class="subtext2"> 
                            매니저 소개
                        </p>
                        <div class="subtextbox">
                            <p class="subtext"> 
                                만남 2일전 오후 1시 
                            </p>
                            <p class="subtext"> 
                                <em class="col">예)</em>&nbsp;&nbsp;금요일 사이트 일정으로 신청 & 상담 접수 → 최대 화요일 오후 3시 결과 확인
                            </p>
                        </div>
                        <p class="subtext2"> 
                            개별 만남
                        </p>
                        <div class="subtextbox">
                            <p class="subtext"> 
                                상담일 기준 최대 7일 후 오후 1시
                            </p>
                            <p class="subtext"> 
                                <em class="col">예)</em>&nbsp;&nbsp;수요일 상담 완료 → 다음주 수요일 오후 1시 결과 확인
                            </p>
                        </div>
                        <p class="subtext"> 
                            ※ 매칭 상황에 따라 더 빠른 결과 확인이 가능한 경우도 있습니다.
                        </p>
                    </div>
                </div>
                <div class="g_box">
                    <div class="bg">
                        <img src="../icon/jh/Final.png"class="icon set02">
                    </div>
                    <div class="textbox">
                        <p class="sub_name">결제</p>
                        <p class="subtext"> 
                            상대와의 만남이 확정(희망)된 후 결제를 받습니다.
                        </p>
                        <p class="subtext"> 
                            저희 다온은 선불이 아닌 회원님의 만족을 극대화하기 위한 후불제로 운영되고 있습니다.
                        </p>
                    </div>
                </div>
                <div class="g_box">
                    <div class="bg">
                        <img src="../icon/yh/After.png"class="icon set01">
                    </div>
                    <div class="textbox">
                        <p class="sub_name">만남 성사</p>
                        <p class="subtext2 pt10"> 
                            매니저 소개
                        </p>
                        <div class="subtextbox">
                            <p class="subtext"> 
                                신청한 일정과 장소에서 매니저가 참여하여 만남을 주선합니다.(신분증 지참 필수입니다.)
                            </p>
                            <p class="subtext"> 
                                이후 상대와의 상의를 통해 자리를 옮겨 만남의 시간을 갖습니다.
                            </p>
                            <p class="subtext"> 
                                연락처는 사전에 공유되지 않는 점을 미리 알려드립니다.
                            </p>
                            <p class="subtext"> 
                                만남의 시간을 가지신 후 합의하에 애프터 신청과 함께 번호를 교환사히면 됩니다.
                            </p>
                        </div>
                        <p class="subtext2 pt10"> 
                            개별 만남
                        </p>
                        <div class="subtextbox">
                            <p class="subtext"> 
                                매칭 성사 후 상대의 프로필을 확인합니다.
                            </p>
                            <p class="subtext"> 
                                의견 조율 후 연락처 교환을 합니다.
                            </p>
                            <p class="subtext"> 
                                번호 교환 후 원하시는 일정으로 조율하여 만남의 시간을 갖습니다.
                            </p>
                        </div>
                        <p class="subtext"> 
                            ※ 매칭에 대한 자세한 안내 / 두 방식의 차이는 담당 매니저에게 문의바랍니다.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer>
        <div class="footer_in">
            <div class="footer_top">
                <a href="">회사소개</a>
                <a href="">이용안내</a>
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