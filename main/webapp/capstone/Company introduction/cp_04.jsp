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
    <link rel=stylesheet href="cp_04.css">
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
                    <h5>다온의 상징인 CI를</h5>
                    <p>소개합니다!</p>
                </div>
            </div> 
            <div class="sub_tab">
                <div class="sub_tab_co">
                    <div class="sub_tab_in">
                        <a href="cp_01.jsp" class="bactive">회사소개</a><!--
                    --><a href="cp_02.jsp" class="bactive">지사소개</a><!--
                    --><a href="cp_03.jspl" class="bactive">팀소개</a><!--
                    --><a href="cp_04.jsp" class="active">CI소개</a><!--
                    --><a href="cp_05.jsp" class="bactive">오시는길</a>
                    </div>
                </div>
            </div>       
        </div>
        <div class="body_Wrap">
            <p class="title02">
                CI 소개
            </p>
            <div class="container_01">
                <div class="img_00">
                    <img src="../logo/진하로고3.png" class="img_01">
                </div>
                <div class="CI_info">
                    <h6>CI의 의미</h6>
                    <p class="info">다온의 심볼마크는 선남선녀가 다온의 이름 안에서</p>
                    <p class="info">하나의 사랑을 완성시켜나간다는 의미를 내포하고 있습니다.</p>
                    <p class="info">이는 다온의 이념이자 사회적 목표를 의미합니다.</p>
                </div>
                <div class="img_00 ml50">
                    <img src="../logo/logo_daon.png" class="img_02">
                    <img src="../logo/logo_love.png" class="img_02">
                </div>
                <div class="img_00">
                    <p class="info_s ml110">[선남선녀]</p>
                    <p class="info_s ml130">[사랑의 완성]</p>
                </div>
            </div>
            <div class="container_02">
                <div class="img_00">
                    <img src="../logo/진하로고3.png" class="img_03">
                </div>
                <div class="CI_info1">
                    <h6 class="title_s">Color System</h6>
                    <p class="info">기본 색상은 분홍과 붉은색의 혼합으로</p>
                    <p class="info">경우에 따라 디자인 색상을 변경할 수 있습니다.</p>
                </div>
                <div class="color ml20">
                    <div class="color1 bk1"></div>
                    <div class="code">
                        <p class="code0">#f96880</p>
                        <p class="code0"><b>C</b> 0  <b>M</b> 58  <b>Y</b> 49  <b>K</b> 2</p>
                        <p class="code0"><b>R</b> 249  <b>G</b> 104  <b>B</b> 128</p>
                    </div>
                </div>
                <div class="color">
                    <div class="color1 bk2"></div>
                    <div class="code">
                        <p class="code0">#3D3D3D</p>
                        <p class="code0"><b>C</b> 0  <b>M</b> 0  <b>Y</b> 0  <b>K</b> 76</p>
                        <p class="code0"><b>R</b> 61  <b>G</b> 61  <b>B</b> 61</p>
                    </div>
                </div>
            </div>
            <div class="container_03">
                <img src="../logo/진하로고3.png" class="img04">
            </div>
            <div class="container_04">
                <div class="logo_other">
                    <img src="../logo/logo_zip.png" class="img05">
                </div>
            </div>
            <div class="container_05">
                <div class="logo_se1">
                    <div class="title001">다온 로고의 형식</div>
                    <div class="title002">로고 사용 시 주의할점</div>
                    <ul>
                        <li class="ml50">
                            <img src="../logo/혜원로고1.png" class="img06">
                            <img src="../logo/진하로고2.png" class="img06">
                            <h4 class="logo_info">[ CI 로고 국문 / 영문 ]</h4>
                        </li>
                        <li class="mr50">
                            <img src="../logo/예송로고3.png" class="img07 mr10">
                            <img src="../logo/시은로고1.png" class="img07 ml10">
                            <h4 class="logo_info">[ CI 로고 상하 조합 ]</h4>
                        </li>
                    </ul>
                    <p class="logo_co1">
                        워드마크는 다온의 아이덴티티를 표현하는 가장 중요한 요소이므로 일관된 이미지를 위해 사용할 때<br>
                        철저한 관리가 필요하며 임의로 작도하여 다온의 이미지를 손상시키는 경우가 없어야 한다.
                    </p>
                    <p class="logo_co mb40">
                        워드마크를 사용 또는 작도해야 하는 경우에는 그리드 또는 컴퓨터 데이터를<br>
                        이용하여 정확하게 축소 · 확대하여 사용해야 한다.
                    </p>
                </div>
            </div>
            <div class="slog">
                <div class="conwrap pt30 bor">
                    <div class="title001">다온 소개</div>
                    <div class="title002">다온의 슬로건을 소개합니다!</div>
                    <img src="../icon/slog.png" class="slog01">
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