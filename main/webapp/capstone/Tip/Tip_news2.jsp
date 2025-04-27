<%@page import="user.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<jsp:useBean id="user" class="user.User" scope="page" /> 
<jsp:setProperty name = "user" property = "userID" />
<jsp:setProperty name = "user" property = "userPW" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel=stylesheet href="Tip_info1.css">
    <link rel=stylesheet href="../Tip/main.css">
    <link rel=stylesheet href="../cp_intro.css">
    <script src="../cp_intro.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
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
                            <li><a href="Tip1.jsp">광고 모음</a></li>
                            <li><a href="Tip2.jsp">이벤트(파티)</a></li>
                            <li><a href="Tip3.jsp">다온 뉴스</a></li>
                            <li><a href="Tip4.jsp">연애 이야기</a></li>
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
                    <h5>연애이야기</h5>
                    <p>다온에서 사랑을 이뤄보세요!</p>
                </div>
            </div> 
            <div class="sub_tab">
                <div class="sub_tab_co">
                    <div class="sub_tab_in">
                        <a href="Tip1.jsp" class="bactive">광고 모음</a><!--
                    --><a href="Tip2.jsp" class="bactive">이벤트(파티)</a><!--
                    --><a href="Tip3.jsp" class="bactive">다온 뉴스</a><!--
                    --><a href="Tip4.jsp" class="active">연애 이야기</a>
                    </div>
                </div>
            </div>
            <div class="sub_content">
                <div class="container user_board">
                    <div class="view_top">
                        <h3 class="nm">
                            2023년도 5월 16일 두근두근 로테이션파티 파티 스케치 ♥
                        </h3>
                        <div class="view_info">
                            <span>2024.05.01 10:27</span> &nbsp;&nbsp; <span>다온 D A O N</span>
                        </div>
                    </div>
                    <div class="view_body">
                        <div class="user_contents">
                            <div alige style>
                                <div align style>
                                    <br>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <img src="../icon/news/news02.png">
                                            <br style="clear:both;">
                                            <br>
                                            <br>
                                            <br>
                                        </span>
                                    </p>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <img src="../icon/news/news202.jpg">
                                            <br style="clear:both;">
                                            <br>
                                            <br>
                                        </span>
                                    </p>
                                    
                                </div>
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
                            <a href="../Tip/Tip3.jsp" class="more_btn">+</a>
                            <ul>
                                <li>
                                    <a href="Tip_news1.jsp">
                                        <span class="tle">봄맞이 봄이왔나봄 리뷰이벤트(기간연장!)</span>
                                        <span class="date">2024.05.10</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip_news2.jsp">
                                        <span class="tle">24년 봄맞이 5월 다온 오프파티 소식!!</span>
                                        <span class="date">2024.05.01</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip_news3.jsp">
                                        <span class="tle">두근두근 봄맞이 가든 파티 ♥</span>
                                        <span class="date">2024.04.09</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip_news4.jsp">
                                        <span class="tle">가을리뷰 선물 이벤트 소식♡</span>
                                        <span class="date">2024.04.03</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip_news6.jsp">
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
                                    <a href="Tip_info12.jsp">
                                        <span class="tle">소개팅을 꼭 해야 하나요?</span>
                                        <span class="date">2024.05.16</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip_info13.jsp">
                                        <span class="tle">저는 왜 아직도 싱글일까요?</span>
                                        <span class="date">2024.05.09</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip_info14.jsp">
                                        <span class="tle">호감 가는 첫 인상을 만드는 7가지 법칙</span>
                                        <span class="date">2024.05.02</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip_info15.jsp">
                                        <span class="tle">콩깍지가 벗겨지는 순간</span>
                                        <span class="date">2023.04.26</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="Tip_info19.jsp">
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
                                        <a href="Tip_news1.jsp"><img src="../icon/img01.jpg" class="size"></a>
                                        <label for="slide02" class="right"></label>
                                        <em class="sam1">다온뉴스</em>
                                    </a>
                                    <span class="tlle">&nbsp;봄맞이 봄이왔나봄 리뷰이벤트(기간연장!)</span>
                                </li>
                                <li>
                                    <a>
                                        <label for="slide01" class="left"></label>
                                        <a href="Tip_news3.jsp"><img src="../icon/news/news03.png" class="size"></a>
                                        <label for="slide03" class="right"></label>
                                        <em class="sam1">다온뉴스</em>
                                    </a>
                                    <span class="tlle">&nbsp;두근두근 봄맞이 가든 파티 ♥</span>
                                </li>
                                <li>
                                    <a>
                                        <label for="slide02" class="left"></label>
                                        <a href="Tip_news6.jsp"><img src="../icon/news/news21.png" class="size"></a>
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
                                        <a href="Tip_info14.jsp"><img src="../icon/img05.jpg" class="size"></a>
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