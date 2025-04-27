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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <meta charset="UTF-8">
    <link rel=stylesheet href="../cp_intro.css">
    <link rel=stylesheet href="cp_05.css">
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
                    <h5>첫만남부터 체계적인 서비스로</h5>
                    <p>회원님과 함께합니다!</p>
                </div>
            </div> 
            <div class="sub_tab">
                <div class="sub_tab_co">
                    <div class="sub_tab_in">
                        <a href="cp_01.jsp" class="bactive">회사소개</a><!--
                    --><a href="cp_02.jsp" class="bactive">지사소개</a><!--
                    --><a href="cp_03.jsp" class="bactive">팀소개</a><!--
                    --><a href="cp_04.jsp" class="bactive">CI소개</a><!--
                    --><a href="cp_05.jsp" class="active">오시는길</a>
                    </div>
                </div>
            </div>       
        </div>
        <div class="body_Wrap">
            <p class="title02">
                오시는길
            </p>
            <div class="inner">
                <div class="img_ic">
                    <div class="img_wrap" style="background-image: url(../icon/school.jpeg);"></div>
                    <div class="text_wrap">
                        <h6 class="title_s">방문 문의</h6>
                        <h5 class="tit">
                            <a href="../Company introduction/cp_06.jsp" class="mant">다온의 상담실은 365일 회원님들을 향해 열려있습니다.</a>
                        </h5>
                        <p class="tit02">
                            언제든지 방문하시면 편안한 분위기에서 전문 매니저에게
                        </p>
                        <p class="tit02">
                            연애 / 결혼 관련 컨설팅을 받으실 수 있습니다.
                        </p>
                        <div class="s_info">
                            <p class="text_01"> 본&nbsp;&nbsp;&nbsp;사&nbsp;&nbsp;&nbsp;번&nbsp;&nbsp;&nbsp;호&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;010 - 0000 - 0000</p>
                            <p class="text_01"> 담&nbsp;&nbsp;&nbsp;당&nbsp;&nbsp;&nbsp;자&nbsp;&nbsp;&nbsp;명&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;최 혜 원</p>
                            <p class="text_01"> 전&nbsp;&nbsp;&nbsp;자&nbsp;&nbsp;&nbsp;메&nbsp;&nbsp;&nbsp;일&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;daon24@naver.com</p>
                        </div>
                        <div class="c_icon">
                            <a href="../Company introduction/cp_02.jsp"><img src="../icon/jh/Web.png" class="icon01 mr20"></a>
                            <a href="https://map.kakao.com/"><img src="../icon/jh/directions.png" class="icon01"></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="sub_com">
                <div class="comwrap">
                    <div class="tit1">지사 정보</div>
                    <div class="tit2">다온의 지사 알아보기</div>
                    <ul>
                        <li>
                            <div class="num">01</div>
                            <div class="name">대구 지사</div>
                            <div class="scom_info">담&nbsp;&nbsp;&nbsp;당&nbsp;&nbsp;&nbsp;자&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;김시은</div>
                            <div class="s_icon">
                                <a href="../Company introduction/cp_02.jsp"><img src="../icon/jh/Web.png" class="icon02 mr20"></a>
                                <a href="https://map.kakao.com/"><img src="../icon/jh/directions.png" class="icon02"></a>
                            </div>
                        </li>
                        <li>
                            <div class="num">02</div>
                            <div class="name">대전 지사</div>
                            <div class="scom_info">담&nbsp;&nbsp;&nbsp;당&nbsp;&nbsp;&nbsp;자&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;전진하</div>
                            <div class="s_icon">
                                <a href="../Company introduction/cp_02.jsp"><img src="../icon/jh/Web.png" class="icon02 mr20"></a>
                                <a href="https://map.kakao.com/"><img src="../icon/jh/directions.png" class="icon02"></a>
                            </div>
                        </li>
                        <li>
                            <div class="num">03</div>
                            <div class="name">부산 지사</div>
                            <div class="scom_info">담&nbsp;&nbsp;&nbsp;당&nbsp;&nbsp;&nbsp;자&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;진예희</div>
                            <div class="s_icon">
                                <a href="../Company introduction/cp_02.jsp"><img src="../icon/jh/Web.png" class="icon02 mr20"></a>
                                <a href="https://map.kakao.com/"><img src="../icon/jh/directions.png" class="icon02"></a>
                            </div>
                        </li>
                        <li>
                            <div class="num">04</div>
                            <div class="name">전주 지사</div>
                            <div class="scom_info">담&nbsp;&nbsp;&nbsp;당&nbsp;&nbsp;&nbsp;자&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;박예송</div>
                            <div class="s_icon">
                                <a href="../Company introduction/cp_02.jsp"><img src="../icon/jh/Web.png" class="icon02 mr20"></a>
                                <a href="https://map.kakao.com/"><img src="../icon/jh/directions.png" class="icon02"></a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <p class="title02 mt150">
                상담 방법
            </p>
            <div class="section3">
                <div class="inner2">
                    <div class="left info-box">
                        <div class="info_wrap">
                            <div class="ss_title"><b class="daon">다온 연애</b> 안내 자료</div>
                            <div class="select">
                                <a href="../Company introduction/cp_03.jsp">
                                    <div class="sel mr20">
                                        <div class="size1">
                                            <img src="../icon/jh/Contact.png" class="ss_icon">
                                            <div class="txt">담당 매니저</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="../Company introduction/cp_06.jsp">
                                    <div class="sel ml20">
                                        <div class="size1">
                                            <img src="../icon/jh/Subscription.png" class="ss_icon">
                                            <div class="txt">가입 및 절차</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="../Company introduction/cp_01.jsp">
                                    <div class="sel mr20">
                                        <div class="size1">
                                            <img src="../icon/jh/procedure.png" class="ss_icon">
                                            <div class="txt">다온 이야기</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="../Company introduction/cp_06.jsp">
                                    <div class="sel ml20">
                                        <div class="size1">
                                            <img src="../icon/jh/Concept.png" class="ss_icon">
                                            <div class="txt">이용 금액</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="../Company introduction/cp_01.jsp">
                                    <div class="sel mr20">
                                        <div class="size1">
                                            <img src="../icon/jh/Issues.png" class="ss_icon">
                                            <div class="txt">세부 규정</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="../Company introduction/cp_05.jsp">
                                    <div class="sel ml20">
                                        <div class="size1">
                                            <img src="../icon/jh/Amountuse.png" class="ss_icon">
                                            <div class="txt">오시는 길</div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="left info-box">
                    <h3 class="title_ss">전화 / 이메일 / 카카오톡 문의</h3>
                    <p class="text">
                        다온에 전화나 이메일, 카카오톡으로 문의를 주시면 전문
                        <br>
                        <strong>매니저 / 담당자가 친절하고 상세하게 안내해드립니다.</strong>
                    </p>
                    <ul class="customer-center">
                        <li>
                            <span class="tag02 tag-pink">평 일</span>
                            <span>오전 9시 ~ 오후 9시</span>
                        </li>
                        <li>
                            <span class="tag02 tag-pink">주 말</span>
                            <span>오전 10시 ~ 오후 5시</span>
                        </li>
                        <li>
                            <span class="tag02 tag-pink">공휴일</span>
                            <span>오전 10시 ~ 오후 3시</span>
                        </li>
                        <li class="last">
                            <span class="tag02 tag-p">이메일</span>
                            <span class="lett">daon24@naver.com</span>
                        </li>
                    </ul>
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
                    <a href="../Tip/Tip3.jsp" class="more_btn">+</a>
                    <ul>
                        <li>
                            <a href="../Tip/Tip_news1.jsp">
                                <span class="tle">봄맞이 봄이왔나봄 리뷰이벤트(기간연장!)</span>
                                <span class="date">2024.05.10</span>
                            </a>
                        </li>
                        <li>
                            <a href="../Tip/Tip_news2.jsp">
                                <span class="tle">24년 봄맞이 5월 다온 오프파티 소식!!</span>
                                <span class="date">2024.05.01</span>
                            </a>
                        </li>
                        <li>
                            <a href="../Tip/Tip_news3.jsp">
                                <span class="tle">두근두근 봄맞이 가든 파티 ♥</span>
                                <span class="date">2024.04.09</span>
                            </a>
                        </li>
                        <li>
                            <a href="../Tip/Tip_news4.jsp">
                                <span class="tle">가을리뷰 선물 이벤트 소식♡</span>
                                <span class="date">2024.04.03</span>
                            </a>
                        </li>
                        <li>
                            <a href="../Tip/Tip_news6.jsp">
                                <span class="tle">ෆ˙ᵕ˙ෆ다온ෆ˙ᵕ˙ෆ 사무실 이전 안내</span>
                                <span class="date">2024.03.18</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div id="tab-2" class="tab-content">
                    <a href="../community/cm_05-1a.jsp" class="more_btn">+</a>
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
                    <a href="../Tip/Tip2.jsp" class="more_btn">+</a>
                    <ul>
                        <li>
                            <a href="../Tip/Tip2.jsp">
                                <span class="tle">24년도 3월 봄맞이 두근두근 로테이션 파티</span>
                                <span class="date">2024.03.02</span>
                            </a>
                        </li>
                        <li>
                            <a href="../Tip/Tip2.jsp">
                                <span class="tle">9월 두근두근 로테이션 파티</span>
                                <span class="date">2023.09.01</span>
                            </a>
                        </li>
                        <li>
                            <a href="../Tip/Tip2.jsp">
                                <span class="tle">6월 다온 홀리데이 파티</span>
                                <span class="date">2023.06.10</span>
                            </a>
                        </li>
                        <li>
                            <a href="../Tip/Tip2.jsp">
                                <span class="tle">5월의 오프라인 로테이션 파티!</span>
                                <span class="date">2023.05.13</span>
                            </a>
                        </li>
                        <li>
                            <a href="../Tip/Tip2.jsp">
                                <span class="tle">영화시사회 '아이 스틸 빌리브' 초대</span>
                                <span class="date">2023.03.11</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div id="tab-4" class="tab-content">
                    <a href="../Tip/Tip4.jsp" class="more_btn">+</a>
                    <ul>
                        <li>
                            <a href="../Tip/Tip_info12.jsp">
                                <span class="tle">소개팅을 꼭 해야 하나요?</span>
                                <span class="date">2024.05.16</span>
                            </a>
                        </li>
                        <li>
                            <a href="../Tip/Tip_info13.jsp">
                                <span class="tle">저는 왜 아직도 싱글일까요?</span>
                                <span class="date">2024.05.09</span>
                            </a>
                        </li>
                        <li>
                            <a href="../Tip/Tip_info14.jsp">
                                <span class="tle">호감 가는 첫 인상을 만드는 7가지 법칙</span>
                                <span class="date">2024.05.02</span>
                            </a>
                        </li>
                        <li>
                            <a href="../Tip/Tip_info15.jsp">
                                <span class="tle">콩깍지가 벗겨지는 순간</span>
                                <span class="date">2023.04.26</span>
                            </a>
                        </li>
                        <li>
                            <a href="../Tip/Tip_info19.jsp">
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
                                <a href="../Tip/Tip_news1.jsp"><img src="../icon/img01.jpg" class="size"></a>
                                <label for="slide02" class="right"></label>
                                <em class="sam1">다온뉴스</em>
                            </a>
                            <span class="tlle">&nbsp;봄맞이 봄이왔나봄 리뷰이벤트(기간연장!)</span>
                        </li>
                        <li>
                            <a>
                                <label for="slide01" class="left"></label>
                                <a href="../Tip/Tip_news3.jsp"><img src="../icon/news/news03.png" class="size"></a>
                                <label for="slide03" class="right"></label>
                                <em class="sam1">다온뉴스</em>
                            </a>
                            <span class="tlle">&nbsp;두근두근 봄맞이 가든 파티 ♥</span>
                        </li>
                        <li>
                            <a>
                                <label for="slide02" class="left"></label>
                                <a href="../Tip/Tip_news6.jsp"><img src="../icon/news/news21.png" class="size"></a>
                                <label for="slide04" class="right"></label>
                                <em class="sam1">다온뉴스</em>
                            </a>
                            <span class="tlle">&nbsp;ෆ˙ᵕ˙ෆ다온ෆ˙ᵕ˙ෆ 사무실 이전 안내 </span>
                        </li>
                        <li>
                            <a>
                                <label for="slide03" class="left"></label>
                                <a href="../Tip/Tip2.jsp"><img src="../icon/img04.jpg" class="size"></a>
                                <label for="slide05" class="right"></label>
                                <em class="sam1">이벤트/파티</em>
                            </a>
                            <span class="tlle">&nbsp;다온에서 나만의 인연을! 행복한 PARTY</span>
                        </li>
                        <li>
                            <a>
                                <label for="slide04" class="left"></label>
                                <a href="../Tip/Tip_info14.jsp"><img src="../icon/img05.jpg" class="size"></a>
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