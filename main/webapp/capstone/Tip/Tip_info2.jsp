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
                            가만 있지 말고 찾아 나서라 -게리토머스-       
                        </h3>
                        <div class="view_info">
                            <span>2023.03.18 18:22</span> &nbsp;&nbsp; <span>다온 D A O N</span>
                        </div>
                    </div>
                    <div class="view_body">
                        <div class="user_contents">
                            <div alige style>
                                <div align style>
                                    <br>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <img src="../icon/love2.jpg">
                                            <br style="clear:both;">
                                        </span>
                                    </p>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <br style="clear:both;">
                                            "연애 대상을 고르는 일에 관한 한 때가 되면 운명을 만날거야 나는 가만히 앉아 기다리면돼!"
                                            <br>
                                            이 말은 정말 무책임하고 수동적이고 운명론처럼 들린다.
                                            <br>
                                            하지만 이런 태도를 삶의 다른 영역에 대입해 보자.
                                            <br>
                                            예컨대 이런 말은 얼마나 거룩하고, 지혜롭게 틀리는가?
                                            <br>
                                            “나는 대학에 입학 원서를 내지 않겠어.
                                            <br>
                                            나를 대학에 보내 실거라면 반드시 텍사스 대학교를 시켜 내게 입학 초청장과
                                            <br>
                                            기숙사 열쇠를 보내게 하실 거야 그게 표징이야.” 이 것은 또 어떤가?
                                            <br>
                                            “취업 원서를 작성할 이유가 뭐지? 내가 마이크로소프트에서 일하는게 운명의 뜻이라면
                                            <br>
                                            그분이 그곳의 CEO를 시켜 나에게 전화를 하게 하실거야."
                                            <br>
                                            그런 식으로 말하는 사람이 있다면 확실한 정신이상자로 취급될 것이다.
                                        </span>
                                        <br>
                                    </p>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <br style="clear:both;">
                                            그런데 우리는 데이트와 연인의 선택에 대해서는 그와 비슷한 '운명적 언어'로말한다.
                                            <br>
                                            그리고 그런 말이 아주 고상하게 들린다.
                                            <br>
                                            "연인을 찾는 일로 걱정할 것 없어. 운명에 집중하고 있으면 때가 되면 나의 인연을 만날 수 있을거야."
                                        </span>
                                        <br>
                                    </p>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <br style="clear:both;">
                                            그런 철학대로 살다가 30대가 되어 깊은 실망에 빠진 사람들이 있다.
                                        </span>
                                        <br>
                                    </p>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <br style="clear:both;">
                                            그들은 아직도 연애도 해보지 못해 자신을 원망하는 마음과 싸우고 있다.
                                            <br>
                                            마땅히 보이지 않는 인연이 연애 대상을 눈앞에 보내 주셨어야 하는 것 아닌가?
                                            <br>
                                        </span>
                                        <br>
                                    </p>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <br style="clear:both;">
                                            그 못지않게 잘못된 일이 또 있다.
                                            <br>
                                            연인을 만날 기대를 품고 대학에 가거나 그 일에 의지적으로 힘쓰는 듯한 사람을 많은 사람이 공공연히 경멸한다.
                                            <br>
                                            나는 좋은 교육을 매우 중시하는 사람이다. 하지만 솔직해지자.
                                            <br>
                                            대부분 사람은 대학에서 받는 학위를 평생 써먹을 일이 없다.
                                            <br>
                                            그렇다고 학위와 학습 경험이 귀중하지 않다는 것은 아니다.
                                            <br>
                                            그것은 당연히 귀중하다. 하지만 전공 [대학에 가지 않기로 선택 한 사람의 경우 전공의 부재] 보다
                                            <br>
                                            연애와 결혼이 인생의 만족에 훨씬 큰 영향을 미친다.
                                            <br>
                                        </span>
                                        <br>
                                    </p>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <br style="clear:both;">
                                            4년 동안 대학에서 나의 이상형을 찾으려 하는 게 무슨 잘못이란 말인가?
                                            <br>
                                            그것이 대학의 주목표는 아닐지라도 최고의 목표 중 하나는 될 수 있다.
                                            <br>
                                            대학생이 아닌 경우, 남녀를 접할 기회가 많은 소개팅이나 파티에 나가는 것이 무슨 잘못인가?
                                            <br>
                                            어차피 우리가 다녀야 할 파티가 딱 하나로 정해져 있는 것도 아니다.
                                            <br>
                                            연애가 인륜의 대사라면 그 대사에 착수할 기회가 더 많은 소개팅에 가는 것은 좋은 일이다.
                                            <br>
                                            그보다 못한 이유로도 사람들은 소개팅을 선택하곤 한다.
                                            <br>
                                            내가 구직 중이라면 취업 박람회에 갈 것이다.
                                            <br>
                                            내가 배우자를 찾는 중이라면 더 많은 대상자가 있는 곳에서 찾을 것이다.
                                            <br>
                                        </span>
                                        <br>
                                    </p>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <br style="clear:both;">
                                            어떤 여자들은 이 부분에서 신중을 기한다
                                            <br>
                                            남자 쪽에서 먼저 다가오는게 옳다는 생각에서다. [그렇게 생각할 만한 충분한 이유가 있다.]
                                            <br>
                                            지금 내가 하는 말은 그 경우와도 상충되지 않는다.
                                            <br>
                                            그런데 당신은 남자들이 다가올 만한 상황 속에 있는가?
                                            <br>
                                            남자 들의 눈에 띌 만한 곳에 있는가?
                                            <br>
                                            누군가의 마음속에 입력되기 위해 당신이 할 수 있는 일이 있는가?
                                            <br>
                                            주변에 동성 친구들이 여럿 있는 경우, 남자들에게 여자인 당신의 존재를 알리고 싶다면 답은 아주 간단하다.
                                            <br>
                                            파티를 열어 남자들에게 먹을 것을 대접하라. 그들은 음식을 준비한 사람이 누구인지 알아낼 것이다.
                                            <br>
                                        </span>
                                        <br>
                                    </p>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <br style="clear:both;">
                                            음악 소리가 나는 쪽으로 가라. 그곳에 무엇이 있는지 알아보라.
                                            <br>
                                            적극적이고 의지적이고 열정적으로 연인을 찾아라.
                                            <br>
                                            여러 연구와 개인적 경험을 보면 대부분 사람은 최종 연애를 학교에서 만나거나 친구와 가족을 통해 소개받는다.
                                            <br>
                                            요즘은 온라인 중매 서비스를 이용하는 사람도 점점 증가하고 있다.
                                            <br>
                                            이 모두가 연인을 찾기에 좋은 장이다.
                                            <br>
                                        </span>
                                        <br>
                                    </p>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <br style="clear:both;">
                                            당신은 사람을 찾을 만한 곳이나 남의 눈에 띌 만한 곳에 있는가?
                                            <br>
                                            당신이 원하는 부류의 사람들이 자주 가는 곳에 당신도 자주 가는가? 
                                            <br>
                                            당신이 직장을 옮길 수 없다면 바깥에서라도 사람들을 만날 수 있다.
                                            <br>
                                            운동하는 장소라도 바꿀 수 있다.
                                            <br>
                                            다시 말해서 사람을 찾기가 어렵다는 이유만으로 집으로 돌아가 하루를 마감해서는 안된다. 
                                            <br>
                                        </span>
                                        <br>
                                    </p>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <br style="clear:both;">
                                            희미한 가능성이라도 보고 노력을 기울이라.
                                            <br>
                                            사랑에 게으르지 말라.
                                            <br>
                                            내 친구 스티브 와터즈가 지혜로운 말을 했다.
                                            <br>
                                            “연애를 잘한 사람들은 애정 운이 좋아서가 아니라 의지적으로 그 길을 갔기 때문이다”
                                            <br>
                                            사랑에 게으른 인간이 너무 많다.
                                            <br>
                                            자신의 나태함을 타인의 문제로 때우려 한다.
                                            <br>
                                            연애는 의지적으로 추구해야 할 일이며, 행복한 연애의 대상은 딱 하나로 정해져 있지 않다.  
                                            <br>
                                        </span>
                                        <br>
                                    </p>
                                    <p>
                                        <span style="font-size: 10pt; letter-spacing: -0.07em;">
                                            <br style="clear:both;">
                                            연애학교 중에서 -게리토머스- 
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