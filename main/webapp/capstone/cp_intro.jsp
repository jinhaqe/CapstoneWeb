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
	<link rel="stylesheet" href="cp_intro.css">
	<link rel="stylesheet" href="realmain.css?after">
	<script src="cp_intro.js"></script>
	<script src="IntLogImsi/myPage1.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
    <header>
        <a href="cp_intro.jsp"><img src="logo/진하로고3.png"class="main_logo"></a>
        <nav>
            <ul class="nav_in">
                <li class="li_dropdown"><a href="Company introduction/cp_01.jsp">회사소개</a>
                    <ul class="ul_border">
                        <li><a href="Company introduction/cp_01.jsp">회사소개</a></li>
                        <li><a href="Company introduction/cp_02.jsp">지사소개</a></li>
                        <li><a href="Company introduction/cp_03.jsp">팀소개</a></li>
                        <li><a href="Company introduction/cp_04.jsp">로고소개</a></li>
                        <li><a href="Company introduction/cp_05.jsp">오시는길</a></li>
                    </ul>
                </li>
                <li class="li_dropdown"><a href="Company introduction/cp_06.jsp">이용안내</a>
                    <ul class="ul_border">
                        <li><a href="Company introduction/cp_06.jsp">이용절차</a></li>
                        <li><a href="Company introduction/cp_07.jsp">이용금액</a></li>
                        <li><a href="Company introduction/cp_08.jsp">매칭이용가이드</a></li>
                        <li><a href="Company introduction/cp_09.jsp">세부규정</a></li>
                        <li><a href="Company introduction/cp_10.jsp">환불규정</a></li>
                    </ul>
                </li>
                <li class="li_dropdown"><a href="community/cm_01-1a.jsp">커뮤니티</a>
                    <ul class="ul_border">
                        <li><a href="community/cm_01-1a.jsp">공지사항</a></li>
                        <li><a href="community/cm_02-a.jsp">FAQ</a></li>
                        <li><a href="community/cm_03-1a.jsp">Q&A</a></li>
                        <li><a href="community/cm_04-1a.jsp">자유게시판</a></li>
                        <li><a href="community/cm_05-1a.jsp">후기</a></li>
                    </ul>
                </li>

                <li><a href="IntLogImsi/InterviewMain.jsp">포토인터뷰</a></li>

                <li class="li_dropdown"><a href="test/test1.jsp">테스트</a>
                    <ul class="ul_border">
                        <li><a href="test/test1.jsp">이상형테스트</a></li>
                        <li><a href="test/test2.jsp">성격유형</a></li>
                        <li><a href="test/test3.jsp">연애력테스트</a></li>
                        <li><a href="test/test4.jsp">연애능력고사</a></li>
                        <li><a href="test/test5.jsp">연애운세</a></li>
                    </ul>
                </li>
                <li class="li_dropdown"><a href="Tip/Tip1.jsp">Tip</a>
                    <ul class="ul_border">
                        <li><a href="Tip/Tip1.jsp">광고 모음</a></li>
                        <li><a href="Tip/Tip2.jsp">이벤트(파티)</a></li>
                        <li><a href="Tip/Tip3.jsp">다온 뉴스</a></li>
                        <li><a href="Tip/Tip4.jsp">연애 이야기</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <%if (userID == null) {%>
	        <div class="user_style">
	            <div class="user_in">
	                <a href="IntLogImsi/login.jsp">
	                    <img class="img01" src="icon/yh/Login.png">
	                    <span>로그인</span>
	                </a>
	                <a href="community/cm_06-1.jsp">
	                    <img class="img01" src="icon/yh/join.png">
	                    <span>회원가입</span>
	                </a>
	                <a href="#none" onclick="handleDMClick('<%= isAccepted %>');">
	                    <img class="img01" src="icon/yh/DM.png">
	                    <span>DM</span>
	                </a>
	            </div>
	        </div>
	        <% }  else if (userID != null) {%>
	        <div class="user_style">
	            <div class="user_in">
	                <a href="IntLogImsi/logoutAction.jsp">
	                    <img class="img01" src="icon/yh/Logout.png">
	                    <span>로그아웃</span>
	                </a>
	                <a href="IntLogImsi/myPage.jsp">
	                    <img class="img01" src="icon/yh/mypage.png">
	                    <span>마이페이지</span>
	                </a>
	                <a href="#none" onclick="handleDMClick('<%= isAccepted %>');" >
	                    <img class="img01" src="icon/yh/DM.png">
	                    <span>DM</span>
	                </a>
	            </div>
	        </div>
	        <%} %>
    </header>
   	<div id="dmSection" style="display: none;">
		    <div class="DM_nemo">
		    	<div class="DM_X" onclick="DM_X()"><img src="IntLogImsi/dmx.png"></div>
		        <div class="massIn">
		        <div id="chatMessages">
				</div>
		        </div>
		       	<form method="post" id="chatForm" action="IntLogImsi/dmPageAction.jsp"  enctype="multipart/form-data" accept-charset="UTF-8">
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
	        xhr.open('POST', 'IntLogImsi/dmPageAction.jsp', true);
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
		    xhr.open('GET', 'IntLogImsi/getMessages.jsp', true); // 메시지를 받아오는 페이지
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
    <main>
        <div class="main_slide">
            <div class="main_slide_in main_slide_in1"></div>
            <div class="main_slide_in main_slide_in2"></div>
            <div class="main_slide_in main_slide_in3"></div>
        </div>
        <div class="main_infor">
            <div class="main_infor_in">
                <div style="animation-delay: 0s;">
                    <img src="icon/yh/Anonymity.png" >
                    <h5>프로필의 익명성을 믿을 수 있는 사이트를 찾으시는 분</h5>
                    <p>철저한 블라인드로 매칭이 될 때까지 익명을 보장</p>
                </div>
                <div style="animation-delay: 0.2s;">
                    <img src="icon/yh/lovestory.png">
                    <h5>여러가지 연애이야기들을 많은 사람과 나누고 싶은 분</h5>
                    <p>커뮤니티에서 소개팅 후기와 성공 이야기를 확인</p>
                </div> 
                <div style="animation-delay: 0.4s;">
                    <img src="icon/yh/After2.png">
                    <h5>소개팅 후 애프터 연락을 애타게 기다렸던 분</h5>
                    <p>확실한 만남 성사 스케줄 관리 도입</p>
                </div>
                <div style="animation-delay: 0.6s;">
                    <img src="icon/yh//acquaintance.png">
                    <h5>마음이 맞는 사람이 없어 지인 소개에 한계를 느낀 분</h5>
                    <p>프로필 작성을 통해 성격과 가치관이 중심이 되는 매칭</p>
                </div>
                <div style="animation-delay: 0.8s;">
                    <img src="icon/yh/Event.png">
                    <h5>주변에서 마음이 맞는 사람을 만날 기회가 부족한 분</h5>
                    <p>정기 온&오프라인 만남의 기회</p>
                </div>
            </div>
        </div>
        <div class="main_interview">
            <div class="main_tit">
                <h4>Photo Interview</h4>
                <h6>더보기를 클릭하면 더 많은 회원을 볼 수 있어요</h6>
            </div>
            <ul>
                <li class="interview_W">
                    <a href="IntLogImsi/InterviewMain.jsp">
                        <div class="thum">
                            <img src="icon/jh/Woman.png">
                        </div>
                        <div class="interview_in">
                            <h5>
                                채**
                                <b>
                                    (만) 32세
                                </b>
                            </h5>
                            <p>다정다감한 사람</p>
                            <span class="tag">
                                <b>#사무직</b>
                                <b>#서울 하남시</b>
                            </span>
                        </div>
                    </a>
                    
                </li>
                <li class="interview_M">
                    <a href="IntLogImsi/InterviewMain.jsp">
                        <div class="thum">
                            <img src="icon/jh/Man.png">
                        </div>
                        <div class="interview_in">
                            <h5>
                                정**
                                <b>
                                    (만) 31세
                                </b>
                            </h5>
                            <p>성실한 사람</p>
                            <span class="tag">
                                <b>#서비스 종사자</b>
                                <b>#경상북도 구미시</b>
                            </span>
                        </div>
                    </a>
                </li>
                <li class="interview_M">
                    <a href="IntLogImsi/InterviewMain.jsp">
                        <div class="thum">
                            <img src="icon/jh/Man.png">
                        </div>
                        <div class="interview_in">
                            <h5>
                                김**
                                <b>
                                    (만) 29세
                                </b>
                            </h5>
                            <p>긍정적이고 밝은 사람</p>
                            <span class="tag">
                                <b>#서비스 종사자</b>
                                <b>#전라북도 군산시</b>
                            </span>
                        </div>
                    </a>
                </li>
                <li class="interview_W">
                    <a href="IntLogImsi/InterviewMain.jsp">
                        <div class="thum">
                            <img src="icon/jh/Woman.png">
                        </div>
                        <div class="interview_in">
                            <h5>
                                고**
                                <b>
                                    (만) 25세
                                </b>
                            </h5>
                            <p>정이 많은 사람</p>
                            <span class="tag">
                                <b>#어린이집 교사</b>
                                <b>#서울특별시 중랑구</b>
                            </span>
                        </div>
                    </a>
                </li>
            </ul>
            <div class="main_interview_btn">
                <span class="btn_in">
                    <a href="IntLogImsi/InterviewMain.jsp">더보기</a>
                </span>
            </div>
        </div>
        <div class="main_news">
            <div class="main_news_in">
                <div class="main_tit">
                    <h4>Community</h4>
                    <h6>커뮤니티</h6>
                </div>
                <a href="community/cm_05-1a.jsp" style="animation-delay: 0s;">
                    <div class="main_news_in_bg"></div>
                    <div class="main_news_in_img news_img1"></div>
                    <h5> <img src="../capstone/icon/yh/After2.png" class="imgg"> Real 후기</h5>
                    <p>실제 매칭이 성사된 회원님들의 생생한 후기</p>
                    <span class="go_btn">
                        <div></div>
                    </span>
                </a>
                <a href="community/cm_01-1a.jsp" style="animation-delay: 0.4s;">
                    <div class="main_news_in_bg"></div>
                    <div class="main_news_in_img news_img2"></div>
                    <h5> <img src="../capstone/icon/hw/Application.png" class="imgg"> 공지사항</h5>
                    <p>중요한 소식들이 가득 <br> &nbsp;</p>
                    <span class="go_btn">
                        <div></div>
                    </span>
                </a>
                <a href="community/cm_03-1a.jsp" style="animation-delay: 0.2s;">
                    <div class="main_news_in_bg"></div>
                    <div class="main_news_in_img news_img3"></div>
                    <h5> <img src="../capstone/icon/jh/QA.png" class="imgg"> Q&A</h5>
                    <p>자주 하는 질문 <br> &nbsp;</p>
                    <span class="go_btn">
                        <div></div>
                    </span>
                </a>
                <a href="community/cm_04-1a.jsp" style="animation-delay: 0.6s;">
                    <div class="main_news_in_bg"></div>
                    <div class="main_news_in_img news_img4"></div>
                    <h5> <img src="../capstone/icon/hw/Join.png" class="imgg"> 자유게시판</h5>
                    <p>여러가지 이야기들을 자유롭게 게시</p>
                    <span class="go_btn">
                        <div></div>
                    </span>
                </a>
            </div>
        </div>
        <div class="main_state">
            <div class="main_state_in">
                <div class="online">
                    <img src="mo01.png">
                    <div class="online_txt">
                        <h3>온라인 매칭
                            <em>철저한 심사 및 관리를 통한 보안 시스템</em>
                        </h3>
                        <p><b>1. 철저한 익명 보장 시스템</b>
                            <br>
                            무분별한 프로필 노출을 피하고, 이상형에 부합되는 회원에게만 공개
                        </p>
                        <p><b>2. 맞춤형 매칭 시스템</b>
                            <br>
                            프로필 작성부터 매칭까지 매니저의 직접관리
                            <br>
                        </p>
                        <p>* 이용 방법 : 회원가입 → 매니저 매칭 → 프로필 작성 → 이상형 매칭 → 결제 후 연락처교환</p>
                    </div>
                </div>
                <div class="statess">
                    <div class="MW_status1">
                        <div class="MW_status1_txt">
                            <h3>다온 회원 현황
                                <em>Member Status</em>
                            </h3>
                            <p><b>남성 60% 여성 40%</b>
                                <br>
                                남성 최대 비율 30~34세
                                <br>
                                여성 최대 비율 25~29세
                            </p>
                            <p>
                                <b>전연령이 고르게 분포되어있는 다온</b>
                                <br>
                                당신도 이 비율에 뛰어들어 보세요!
                            </p>
                        </div>
                    </div>
                    <div class="MW_status2">
                        <table>
                            <thead>
                                <tr>
                                    <th>구분</th>
                                    <th class="man">
                                        <div class="M_img"></div>
                                        남성
                                        <br>
                                    </th>
                                    <th class="woman">
                                        <div class="W_img"></div>
                                        여성
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th>20~24세</th>
                                    <td>18%</td>
                                    <td>19%</td>
                                </tr>
                                <tr>
                                    <th>25~29세</th>
                                    <td>29%</td>
                                    <td>38%</td>
                                </tr>
                                <tr>
                                    <th>30~34세</th>
                                    <td>32%</td>
                                    <td>23%</td>
                                </tr>
                                <tr>
                                    <th>35~39세</th>
                                    <td>21%</td>
                                    <td>20%</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="main_party">
            <div class="main_tit">
                <h4>OffLine Party</h4>
                <h6>설레임이 함께하는 파티</h6>
            </div>
            <div class="main_party_in">
                <div class="main_party_con">
                    <div class="main_offline_tit">
                        <h4>
                            <em>2024.05.20 월요일 오후 13시 00분</em>
                            24년도 5월 초여름 두근두근 로테이션 파티
                        </h4>
                        <p>영진전문대학교 본관</p>
                        <div class="main_offline_btn">
                            <span class="btn_clear">
                                <a href="">모집중</a>
                            </span>
                            <span class="btn_detail">
                                <a href="Tip/Tip2.jsp">자세히보기</a>
                            </span>
                        </div>
                    </div>
                    <div class="main_offline_info">
                        <p>
                            <span>일시</span>
                            2024.05.20 월요일 오후 13시 00분
                        </p>
                        <p>
                            <span>연령</span>
                            <em class="m">남</em>
                            225~39세
                            <em class="w">여</em>
                            22~39세
                        </p>
                        <p>
                            <span>비용</span>
                            <em class="m">남</em>
                            30,000원
                            <em class="w">여</em>
                            30,000원
                        </p>
                        <p>
                            <span>현황</span>
                            <em class="m">남</em>
                            모집중
                            <em class="w">여</em>
                            모집중
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="foot_container">
                    <div class="foot_list">
                        <ul class="tabs">
                            <li class="tab-link current" data-tab="tab-1">NEWS</li>
                            <li class="tab-link" data-tab="tab-2">REAL후기</li>
                            <li class="tab-link" data-tab="tab-3">이벤트/파티 <span class="new">N</span></li>
                            <li class="tab-link" data-tab="tab-4">연애이야기 <span class="new">N</span></li>
                        </ul>
                        <div id="tab-1" class="tab-content current">
                            <a href="Tip/Tip3.jsp" class="more_btn">+</a>
                            <ul>
                                <li>
                                    <a href="Tip/Tip_news1.jsp">
                                        <span class="tle">봄맞이 봄이왔나봄 리뷰이벤트(기간연장!)</span>
                                        <span class="date">2024.05.10</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip/Tip_news2.jsp">
                                        <span class="tle">24년 봄맞이 5월 다온 오프파티 소식!!</span>
                                        <span class="date">2024.05.01</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip/Tip_news3.jsp">
                                        <span class="tle">두근두근 봄맞이 가든 파티 ♥</span>
                                        <span class="date">2024.04.09</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip/Tip_news4.jsp">
                                        <span class="tle">가을리뷰 선물 이벤트 소식♡</span>
                                        <span class="date">2024.04.03</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip/Tip_news6.jsp">
                                        <span class="tle">ෆ˙ᵕ˙ෆ다온ෆ˙ᵕ˙ෆ 사무실 이전 안내</span>
                                        <span class="date">2024.03.18</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div id="tab-2" class="tab-content">
                            <a href="community/cm_05-1a.jsp" class="more_btn">+</a>
                            <ul>
                                <li>
                                    <a href="">
                                        <span class="tle">기적같은 만남 다온은 후회없는 선택이었어요</span>
                                        <span class="date">2024.05.14</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <span class="tle">교제를 하게 되면서 후기입니다!</span>
                                        <span class="date">2024.05.03</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <span class="tle">좋은 인연을 만나게 되어 감사합니다.</span>
                                        <span class="date">2024.05.02</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <span class="tle">만남을 가질수 있게 주선해주신 매니저님께 감사를 표합니다.</span>
                                        <span class="date">2024.04.22</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <span class="tle">하루 또 하루가 늘 행복합니다 :)</span>
                                        <span class="date">2024.04.22</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div id="tab-3" class="tab-content">
                            <a href="Tip/Tip2.jsp" class="more_btn">+</a>
                            <ul>
                                <li>
                                    <a href="Tip/Tip2.jsp">
                                        <span class="tle">24년도 3월 봄맞이 두근두근 로테이션 파티</span>
                                        <span class="date">2024.03.02</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip/Tip2.jsp">
                                        <span class="tle">9월 두근두근 로테이션 파티</span>
                                        <span class="date">2023.09.01</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip/Tip2.jsp">
                                        <span class="tle">6월 다온 홀리데이 파티</span>
                                        <span class="date">2023.06.10</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip/Tip2.jsp">
                                        <span class="tle">5월의 오프라인 로테이션 파티!</span>
                                        <span class="date">2023.05.13</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip/Tip2.jsp">
                                        <span class="tle">영화시사회 '아이 스틸 빌리브' 초대</span>
                                        <span class="date">2023.03.11</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div id="tab-4" class="tab-content">
                            <a href="Tip/Tip4.jsp" class="more_btn">+</a>
                            <ul>
                                <li>
                                    <a href="Tip/Tip_info12.jsp">
                                        <span class="tle">소개팅을 꼭 해야 하나요?</span>
                                        <span class="date">2024.05.16</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip/Tip_info13.jsp">
                                        <span class="tle">저는 왜 아직도 싱글일까요?</span>
                                        <span class="date">2024.05.09</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip/Tip_info14.jsp">
                                        <span class="tle">호감 가는 첫 인상을 만드는 7가지 법칙</span>
                                        <span class="date">2024.05.02</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip/Tip_info15.jsp">
                                        <span class="tle">콩깍지가 벗겨지는 순간</span>
                                        <span class="date">2023.04.26</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip/Tip_info19.jsp">
                                        <span class="tle">3초 쉬고 1+1으로 질문하기</span>
                                        <span class="date">2024.02.21</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <script>
                        $(document).ready(function(){
    
                            $('ul.tabs li').click(function(){
                                var tab_id = $(this).attr('data-tab');
    
                                $('ul.tabs li').removeClass('current');
                                $('.tab-content').removeClass('current');
    
                                $(this).addClass('current');
                                $("#"+tab_id).addClass('current');
                            })
                        })
                    </script>
                    <div class="section">
                        <input type="radio" name="slide" id="slide01" checked>
                        <input type="radio" name="slide" id="slide02">
                        <input type="radio" name="slide" id="slide03">
                        <input type="radio" name="slide" id="slide04">
                        <input type="radio" name="slide" id="slide05">
        
                        <div class="slidewrap">
                            <ul class="slidelist">
                                <li>
                                    <a>                                    
                                        <label for="slide05" class="left"></label>
                                        <a href="Tip/Tip_news1.jsp"><img src="../icon/img01.jpg" class="size"></a>
                                        <label for="slide02" class="right"></label>
                                        <em class="sam1">다온뉴스</em>
                                    </a>
                                    <span class="tlle">&nbsp;봄맞이 봄이왔나봄 리뷰이벤트(기간연장!)</span>
                                </li>
                                <li>
                                    <a>
                                        <label for="slide01" class="left"></label>
                                        <a href="Tip/Tip_news3.jsp"><img src="../icon/news/news03.png" class="size"></a>
                                        <label for="slide03" class="right"></label>
                                        <em class="sam1">다온뉴스</em>
                                    </a>
                                    <span class="tlle">&nbsp;두근두근 봄맞이 가든 파티 ♥</span>
                                </li>
                                <li>
                                    <a>
                                        <label for="slide02" class="left"></label>
                                        <a href="Tip/Tip_news6.jsp"><img src="../icon/news/news21.png" class="size"></a>
                                        <label for="slide04" class="right"></label>
                                        <em class="sam1">다온뉴스</em>
                                    </a>
                                    <span class="tlle">&nbsp;ෆ˙ᵕ˙ෆ다온ෆ˙ᵕ˙ෆ 사무실 이전 안내 </span>
                                </li>
                                <li>
                                    <a>
                                        <label for="slide03" class="left"></label>
                                        <a href="Tip/Tip2.jsp"><img src="../icon/img04.jpg" class="size"></a>
                                        <label for="slide05" class="right"></label>
                                        <em class="sam1">이벤트/파티</em>
                                    </a>
                                    <span class="tlle">&nbsp;다온에서 나만의 인연을! 행복한 PARTY</span>
                                </li>
                                <li>
                                    <a>
                                        <label for="slide04" class="left"></label>
                                        <a href="Tip/Tip_info14.jsp"><img src="../icon/img05.jpg" class="size"></a>
                                        <label for="slide01" class="right"></label>
                                        <em class="sam1">연애이야기</em>
                                    </a>
                                    <span class="tlle">&nbsp;호감 가는 첫 인상을 만드는 7가지 법칙</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        <div class="wrap">
            <footer>
                <div class="footer_in">
                    <div class="footer_top">
                        <a href="Company introduction/cp_01.jsp">회사소개</a>
                        <a href="Company introduction/cp_06.jsp">이용안내</a>
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
        </div>
    </main>
</body>
<script src="anim.js"></script>

</html>