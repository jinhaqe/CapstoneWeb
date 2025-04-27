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
    <link rel=stylesheet href="cp_03.css">
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
                    <h5>다온과 함께하고 있는</h5>
                    <p>매니저를 소개합니다!</p>
                </div>
            </div> 
            <div class="sub_tab">
                <div class="sub_tab_co">
                    <div class="sub_tab_in">
                        <a href="cp_01.jsp" class="bactive">회사소개</a><!--
                    --><a href="cp_02.jsp" class="bactive">지사소개</a><!--
                    --><a href="cp_03.jsp" class="active">팀소개</a><!--
                    --><a href="cp_04.jsp" class="bactive">CI소개</a><!--
                    --><a href="cp_05.jsp" class="bactive">오시는길</a>
                    </div>
                </div>
            </div>       
        </div>
        <div class="body_Wrap">
            <p class="title02">
                팀 소개
            </p>
            <div class="manager-content">
                <div class="m_card">
                    <li>
                        <div class="manager-thumbs">
                            <img src="../icon/po.jpeg" class="thumbs">
                            <div class="manager-info">
                                <h5 class="name">전진하<b>조장&nbsp;(회사소개 / 이용안내 / TIP)</b></h5>
                                <dl>
                                    <dd>
                                        <b>연&nbsp;&nbsp;락&nbsp;&nbsp;처&nbsp;&nbsp;</b> 010-6551-8374
                                    </dd>
                                    <dd>
                                        <b>소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;속&nbsp;&nbsp;</b> 대전(지사)
                                    </dd>
                                </dl>
                                <div class="btn_box">
                                    <span class>
                                        <a href="../Company introduction/cp_01.jsp" class="si">담당</a>
                                    </span>
                                    <span class>
                                        <a href="../Company introduction/cp_06.jsp" class="si">회사소개</a>
                                    </span>
                                </div>
                                <p>
                                    게임 홈페이지를 따라 만들던 때와는 다르게 디자인부터 내용 구상까지 모든 부분을
                                    진행 해야하는 것이 어려웠습니다.<br> 아이콘(+로고) 디자인과 프론트엔트를 하나씩 만들어가면서<br>
                                    스스로의 부족한 부분을 많이 발견하고 개선할 수 있는 좋은 시간이었습니다.
                                </p>
                            </div>
                        </div>
                    </li>
                    <li class="pl50">
                        <div class="manager-thumbs">
                            <img src="../icon/akr.jpeg" class="thumbs">
                            <div class="manager-info">
                                <h5 class="name">김시은<b>조원&nbsp;(포토인터뷰 / 로그인)</b></h5>
                                <dl>
                                    <dd>
                                        <b>연&nbsp;&nbsp;락&nbsp;&nbsp;처&nbsp;&nbsp;</b> 010-9785-3131
                                    </dd>
                                    <dd>
                                        <b>소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;속&nbsp;&nbsp;</b> 대구(지사)
                                    </dd>
                                </dl>
                                <div class="btn_box">
                                    <span class>
                                        <a href="../IntLogImsi/InterviewMain.jsp" class="si">담당</a>
                                    </span>
                                    <span class>
                                        <a href="../IntLogImsi/login.jsp" class="si">포토인터뷰</a>
                                    </span>
                                </div>
                                <p>
                                    웹을 직접 만들고 찾아보면서 사용자 경험과 인터페이스 디자인의 중요성을 크게 느꼈습니다. 
                                    직관적이고 탐색이 쉬운 디자인이 사용자의 만족도를 높이며, 성공 여부에 큰 영향을 미친다는 것을 깨달았습니다. 
                                    사용자의 관점에서 늘 생각하고 피드백을 반영하여 개선해 나가는 과정이 중요하다는 것을 느꼈습니다.
                                </p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="manager-thumbs">
                            <img src="../icon/kag.jpeg" class="thumbs">
                            <div class="manager-info">
                                <h5 class="name">박예송<b>조원&nbsp;(스케치업)</b></h5>
                                <dl>
                                    <dd>
                                        <b>연&nbsp;&nbsp;락&nbsp;&nbsp;처&nbsp;&nbsp;</b> 010-1222-0920
                                    </dd>
                                    <dd>
                                        <b>소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;속&nbsp;&nbsp;</b> 전주(지사)
                                    </dd>
                                </dl>
                                <div class="btn_box">
                                    <span class>
                                        <a href="../Company introduction/cp_02.jsp" class="si">담당</a>
                                    </span>
                                    <span class>
                                        <a href="../Company introduction/cp_02.jsp" class="si">스케치업</a>
                                    </span>
                                </div>
                                <p>
                                    무언가를 창작해낸다는 것 자체가 어려운 것이라는 것을 이번 캡스톤을 통해 느끼게 되었습니다.
                                    또한 캡스톤을 진행하면서 보기만 했던 것들을 직접 만들어보니 세밀한 부분까지 깨닫고 배우게 되는
                                    좋은 시간이자 공부가 된 것 같습니다.
                                </p>
                            </div>
                        </div>
                    </li>
                    <li class="pl50">
                        <div class="manager-thumbs">
                            <img src="../icon/bk.jpeg" class="thumbs">
                            <div class="manager-info">
                                <h5 class="name">최혜원<b>조원&nbsp;(커뮤니티)</b></h5>
                                <dl>
                                    <dd>
                                        <b>연&nbsp;&nbsp;락&nbsp;&nbsp;처&nbsp;&nbsp;</b> 010-7177-0421
                                    </dd>
                                    <dd>
                                        <b>소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;속&nbsp;&nbsp;</b> 서울(본사)
                                    </dd>
                                </dl>
                                <div class="btn_box">
                                    <span class>
                                        <a href="../community/cm_01-1a.jsp" class="si">담당</a>
                                    </span>
                                    <span class>
                                        <a href="../community/cm_02-a.jsp" class="si">커뮤니티</a>
                                    </span>
                                </div>
                                <p>
                                    구현을 하는데 많이 서툴고, 부족한 부분이 많았기 때문에 걱정을 많이 했었습니다.
                                    하지만 팀원과 함께 작업하며 걱정한 부분을 이겨낼 수 있었습니다.
                                    모르는 부분도 함께 알아갈 수 있었고, 저희 팀만의 특성 있는 웹을 만들 수 있어서 좋은 경험이었습니다.
                                </p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="manager-thumbs">
                            <img src="../icon/bammanjuu.jpeg" class="thumbs">
                            <div class="manager-info">
                                <h5 class="name">진예희<b>조원 (메인페이지 / 테스트 / JSP)</b></h5>
                                <dl>
                                    <dd>
                                        <b>연&nbsp;&nbsp;락&nbsp;&nbsp;처&nbsp;&nbsp;</b> 010-2992-1825
                                    </dd>
                                    <dd>
                                        <b>소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;속&nbsp;&nbsp;</b> 부산(지사)
                                    </dd>
                                </dl>
                                <div class="btn_box">
                                    <span class>
                                        <a href="../cp_intro.jsp" class="si">담당</a>
                                    </span>
                                    <span class>
                                        <a href="../test/test1.jsp" class="si">테스트</a>
                                    </span>
                                </div>
                                <p>
                                    이번 프로젝트를 진행하며 많은 것을 배우고 경험할 수 있었습니다.
                                    웹 사이트를 구축하며 프론트 엔드 하나로만 웹을 구성할 수 없음을 깨달았으며
                                    "프론트엔드와 백엔드"의 협업이 필요하다는 것을 느꼈습니다.
                                </p>
                            </div>
                        </div>
                    </li>
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
        <!--<div class="img00">
            <img src="../Company introduction/이미지/매니저소개1.JPG" style="margin-top: 40px;"">
            <img src="../Company introduction/이미지/매니저소개2.JPG" style="margin-top: 35px; margin-bottom: 200px;">
        </div>-->
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