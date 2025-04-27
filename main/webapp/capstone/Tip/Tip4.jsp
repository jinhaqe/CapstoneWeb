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
    <link rel=stylesheet href="Tip3.css">
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
                <p class="title03">
                    연애이야기
                </p>
                <div class="container user_board">
                    <div class="photo_list con_box">
                        <div class="remark_list">
                            <div class="swiper-container swiper-container-initialized swiper-container-horizontal">
                                <div class="swiper-wrapper" style="transition-duration: 0ms; transform: translate3d(0px, 0px, 0px);">
                                    <div class="swiper-slide remark swiper-slide-active" style="width: 1200px;">
                                        <div class="img_wrap" style="background-image:url(../icon/love1.jpg);"></div>
                                        <div class="txt_wrap">
                                            <h6>Notice</h6>
                                            <h5 class="tit">
                                                <a href="Tip_info1.jsp">사랑에 게으르지 말라 -게리토머스-</a>
                                            </h5>
                                            <p>
                                                사랑에 게으르지 말라내 친구 스티브 와터즈가 지혜로운 말을 했다.
                                                "결혼을 잘한 사람들은 애정 운이 좋아서가 아니라 의지적으로 그 길을 갔기 때문이다"
                                                사랑에 게으른 그리스도인이 너무 많다.그들은 자신의 나태함을 하나님으로 때우려 한다. 
                                                결혼은 의지적으로 추구해야 할 일이며, 행복한 결혼의 대상은 딱 하나로 정해져 있지 않다 
                                            </p>
                                        </div>
                                    </div>
                                    <div class="swiper-slide remark swiper-slide-active" style="width: 1200px;">
                                        <div class="img_wrap" style="background-image:url(../icon/love2.jpg);"></div>
                                        <div class="txt_wrap">
                                            <h6>Notice</h6>
                                            <h5 class="tit">
                                                <a href="Tip_info2.jsp">가만 있지 말고 찾아 나서라 -게리토머스-</a>
                                            </h5>
                                            <p>
                                                "배우자를 고르는 일에 관한 한 하나님이 때가 되면 적임자를 보내 주실거야 나는 가만히 앉아 기다리면돼!"
                                                이 말은 정말 영적이고 믿음이 좋고 거룩하게 들린다. 하지만 이런 태도를 삶의 다른 영역에 대입해 보자. 
                                                예컨대 이런 말은 얼마나 거룩하고, 지혜롭게 틀리는가?“나는 대학에 입학 원서를 내지 않겠어.
                                            </p>
                                        </div>
                                    </div>
                                    <div class="swiper-slide remark swiper-slide-active" style="width: 1200px;">
                                        <div class="img_wrap" style="background-image:url('../icon/love/love_17.jpg');"></div>
                                        <div class="txt_wrap">
                                            <h6>Notice</h6>
                                            <h5 class="tit">
                                                <a href="Tip_info3.html">사랑은 감정이다?</a>
                                            </h5>
                                            <p>
                                                < 사랑은 감정이다? > 사랑에 있어서 의지와 감정을 제대로 이해하는 것이 굉장히 중요합니다.
                                                이 두 요소를 어떻게 이해하느냐에 따라 그 사람의 사랑하는 방식이 결정됩니다.
                                            </p>
                                        </div>
                                    </div>
                                    <div class="swiper-slide remark swiper-slide-active" style="width: 1200px;">
                                        <div class="img_wrap" style="background-image:url('../icon/love/love_19.jpg');"></div>
                                        <div class="txt_wrap">
                                            <h6>Notice</h6>
                                            <h5 class="tit">
                                                <a href="Tip_info4.jsp">정서적 건강을 준비하십시오 -돈 로니카-</a>
                                            </h5>
                                            <p>
                                                어떤 사람들은 과거의 아픈 상처를 지니고 살아갑니다.그것들을 가슴 깊이 묻어두고 살지만,때로는 불쑥 불쑥 떠오르는 상처들로 괴로워하곤 합니다.
                                                연애 문제에 봉착하게 되면전에 묻어 두었던 상처들이 다시 수면 위로 떠오릅니다. 더러는 연애의 즐거움이 과거의 고통을 상쇄시켜 줄 것이라고 기대합니다.
                                            </p>
                                        </div>
                                    </div>
                                    <div class="swiper-slide remark swiper-slide-active" style="width: 1200px;">
                                        <div class="img_wrap" style="background-image:url(../icon/love/love_13.jpg);"></div>
                                        <div class="txt_wrap">
                                            <h6>Notice</h6>
                                            <h5 class="tit">
                                                <a href="Tip_info5.html">이 순간, 내가 만날 수 있는 사람에게 최선을 다하자</a>
                                            </h5>
                                            <p>
                                                옥수수밭 이야기 아세요?남아메리카의 한 부족에서는 딸이 결혼할 때가 되면 아버지가 딸을 옥수수 밭으로 데려가서제일 괜찮은 옥수수를 골라오라고 한답니다.
                                                거기에 맞는 신랑감을 골라준다고 말이에요.하지만 어떤 딸들은 썩은 옥수수를 고르거나 아예 빈손으로 밭을 나온다고 합니다.
                                            </p>
                                        </div>
                                    </div>
                                    <div class="swiper-slide remark swiper-slide-active" style="width: 1200px;">
                                        <div class="img_wrap" style="background-image:url('../icon/love/love_21.jpg');"></div>
                                        <div class="txt_wrap">
                                            <h6>Notice</h6>
                                            <h5 class="tit">
                                                <a href="Tip_info6.jsp">연애의 태도 ♡</a>
                                            </h5>
                                            <p>
                                                사랑은 기술이 아닙니다.게다가 연애 기술과 달리 사랑은 모든 사람이 타고났습니다. 
                                                인간의 기본 설정입니다. 하나님은 자신을 본떠서 인간을 창조하셨습니다.
                                            </p>
                                        </div>
                                    </div>
                                    <div class="swiper-slide remark swiper-slide-active" style="width: 1200px;">
                                        <div class="img_wrap" style="background-image:url('../icon/love/love_24.png');"></div>
                                        <div class="txt_wrap">
                                            <h6>Notice</h6>
                                            <h5 class="tit">
                                                <a href="Tip_info7.jsp">고백! 스킬보다는 타이밍입니다. (사랑이 아팠던 날 - 심이준)</a>
                                            </h5>
                                            <p>
                                                배드민턴, 테니스, 배구 등의 경기에서는 매치포인트라는 것이 있는데요. 
                                                바로 경기의 승부를 결정짓는 마지막 하나의 포인트를 말합니다  
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="remark_btn">
                                    <div class="button-prev slide_btn swiper-button-disabled" tabindex="0" role="button" aria-label="Previous slide" aria-disabled="false">
                                        <p class="fal fa-chevron-left"></p>
                                    </div>
                                    <div class="button-next slide_btn" tabindex="0" role="button" aria-label="Next slide" aria-disabled="true">
                                        <p class="fal fa-chevron-right"></p>
                                    </div>
                                </div>
                                <span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
                            </div>
                        </div>
                        <script>
		                    var swiper = new Swiper('.swiper-container', {
			                    navigation: {
				                    nextEl: '.button-next',
				                    prevEl: '.button-prev',
			                    },
		                    });
                        </script>
                        <div class="page_info">
                            <div class="total">
                                총 <em class="hilite">12</em>건( <em class="hilite">1</em> / 1 페이지)
                            </div>
                        </div>
                        <ul>
                            <li>
                                <a href="Tip_info8.jsp">
                                    <span class="thum" style="background-image:url('../icon/love/love_1.jpg');"></span>
                                    <h2 class="tit">
                                        <span>
                                            <b class="hot">HOT</b>
                                            상대방 성품의 참 모습을 알려면?
                                        </span>
                                    </h2>
                                    <p>
                                        상대방 성품의 참 모습을 알려면? 다른 사람들과 함께 있는 자리에서 잘 관찰하라 어떤 청년이 장래의
                                        상사와 함께 저녁을 먹다가 그만 취직의 기회를 날려 버렸다. 웨이터가 음식을 내오자 그 청년은 먹기 전에 소금부터 쳤다. 
                                        부당할 수도 있지만, 상사는 단도직입적으로 말했다."나는 음식을 맛보기도 전에 소금부터 치는 사람들은 채용하지 않네.
                                    </p>
                                </a>
                                <p class="more_btn">
                                    <a href="Tip_info8.jsp" style="color: #ff7b91;">view more +</a>
                                </p>
                            </li>
                            <li>
                                <a href="Tip_info9.jsp">
                                    <span class="thum" style="background-image:url('../icon/love/love_2.jpg');"></span>
                                    <h2 class="tit">
                                        <span>
                                            <b class="hot">HOT</b>
                                            데이트를 할 때 이것만은 기억하라
                                        </span>
                                    </h2>
                                    <p>
                                        : 우정부터 쌓아라나는 소개팅에 나가서 너무 따지지 말라고 조언한다.
                                        '얘랑 결혼하면 어떨까? 아파트 정도는 마련할 수 있을까?' 이것보다 같이 있는 시간이 즐거워야 한다. 
                                        그래서 우정을 먼저 쌓으라고 말한다. 왜냐하면 결혼은 삶의 동반자, 친구를 찾는 것이기 때문이다.
                                        : 둘에게만 집중하지 마라둘만 만나지 마라.
                                    </p>
                                </a>
                                <p class="more_btn">
                                    <a href="Tip_info9.jsp" style="color: #ff7b91;">view more +</a>
                                </p>
                            </li>
                            <li>
                                <a href="Tip_info10.jsp">
                                    <span class="thum" style="background-image:url('../icon/love/love_3.jpg');"></span>
                                    <h2 class="tit">
                                        <span>
                                            <b class="hot">HOT</b>
                                            자신의 사랑의 언어를 발견하는 방법
                                        </span>
                                    </h2>
                                    <p>
                                        자신의 사랑의 언어를 발견하는 방법사랑의 언어 5가지: '함께하는 시간', '봉사', '선물', '스킨십', '인정하는 말' 
                                        자신의 주된 사랑의 언어를 발견하도록 도와주는 3가지 접근 방법이 있다.1. 자신의 행동을 관찰하라당신은 
                                        상대방에 대한 사랑과 감사를 주로 어떻게 표현하는가?만일 당신이 자주 사람들의 등을 두드리거나 포용한다면 
                                        당신의 주된 사랑의 언어는 '스킨십'일 수 있다.
                                    </p>
                                </a>
                                <p class="more_btn">
                                    <a href="Tip_info10.jsp" style="color: #ff7b91;">view more +</a>
                                </p>
                            </li>
                            <li>
                                <a href="Tip_info11.jsp">
                                    <span class="thum" style="background-image:url('../icon/love/love_4.jpg');"></span>
                                    <h2 class="tit">
                                        <span>
                                            <b class="hot">HOT</b>
                                            연인을 찾고 선택할 때
                                        </span>
                                    </h2>
                                    <p>
                                        그렇다면 연애는 어떻게 시작되는가? 물론 대다수 독자는 애인이 될 사람을 열심히 찾아 나서야 한다고 답할 것이다. 
                                        하지만 이는 현대식 답이다. 과거에는 집안에서 연인을 정해 주었다.
                                    </p>
                                </a>
                                <p class="more_btn">
                                    <a href="Tip_info11.jsp" style="color: #ff7b91;">view more +</a>
                                </p>
                            </li>
                            <li>
                                <a href="Tip_info12.jsp">
                                    <span class="thum" style="background-image:url('../icon/love/love_5.jpg');"></span>
                                    <h2 class="tit">
                                        <span>
                                            <b class="hot">HOT</b>
                                            소개팅을 꼭 해야 하나요?
                                        </span>
                                    </h2>
                                    <p>
                                        "30대 중반의 모태 솔로입니다. 친구가 소개팅을 해 준다고 하네요. 
                                        그런데 상대의 나이가 저보다 다섯 살이 많아요. 성격은 진짜 좋다고 해요. 
                                        친구가 겪어 봤는데 저랑 정말 잘 어울릴 것 같대요.
                                    </p>
                                </a>
                                <p class="more_btn">
                                    <a href="Tip_info12.jsp" style="color: #ff7b91;">view more +</a>
                                </p>
                            </li>
                            <li>
                                <a href="Tip_info13.jsp">
                                    <span class="thum" style="background-image:url('../icon/love/love_6.jpg');"></span>
                                    <h2 class="tit">
                                        <span>
                                            <b class="hot">HOT</b>
                                            저는 왜 아직도 싱글일까요?
                                        </span>
                                    </h2>
                                    <p>
                                        '왜 나는 아직 혼자일까?' 하며 궁금해하는 이들에게 몇 가지 이유를 든다면 다음과 같다. 
                                        오해하지 말자. 각자의 삶에 대한 하나님의 크신 계획과 때와 이유를 다 알 수는 없다. 
                                        다만, 가능성 있는 성찰 지점들이 도움이 될 수는 있다.
                                    </p>
                                </a>
                                <p class="more_btn">
                                    <a href="Tip_info13.jsp" style="color: #ff7b91;">view more +</a>
                                </p>
                            </li>
                            <li>
                                <a href="Tip_info14.jsp">
                                    <span class="thum" style="background-image:url('../icon/love/love_7.jpg');"></span>
                                    <h2 class="tit">
                                        <span>
                                            <b class="hot">HOT</b>
                                            호감 가는 첫 인상을 만드는 7가지 법칙
                                        </span>
                                    </h2>
                                    <p>
                                        사람들을 만나보면 분명 친근감이 가고 다시 보고 싶은 사람이 있고, 왠지 거리감이 느껴지고 다시 만나기가 꺼려지는 사람이 있습니다. 
                                        초두 효과란 맨 처음 들어온 정보가 나중에 들어온 정보의 해석에 영향을 주는 것을 말합니다.
                                    </p>
                                </a>
                                <p class="more_btn">
                                    <a href="Tip_info14.jsp" style="color: #ff7b91;">view more +</a>
                                </p>
                            </li>
                            <li>
                                <a href="Tip_info15.jsp">
                                    <span class="thum" style="background-image:url('../icon/love/love_8.jpg');"></span>
                                    <h2 class="tit">
                                        <span>
                                            <b class="hot">HOT</b>
                                            콩깍지가 벗겨지는 순간
                                        </span>
                                    </h2>
                                    <p>
                                        콩깍지가 벗겨지는 순간대부분의 커플은연애 초반에는 잘 다투지 않는다.
                                        흔히 말하는 콩깍지가 씌어있기 때문에얼굴만 봐도 설레고, 행복해 하며뭘 해도 예쁘고, 멋있어 보인다.
                                    </p>
                                </a>
                                <p class="more_btn">
                                    <a href="Tip_info15.jsp" style="color: #ff7b91;">view more +</a>
                                </p>
                            </li>
                            <li>
                                <a href="Tip_info16.jsp">
                                    <span class="thum" style="background-image:url('../icon/love/love_9.jpg');"></span>
                                    <h2 class="tit">
                                        <span>
                                            <b class="hot">HOT</b>
                                            나를 사랑하기로 선택하는 누군가에 의해 사랑받을 필요가 있다.
                                            <em class="cmt_num">+1</em>
                                        </span>
                                    </h2>
                                    <p>
                                        사랑에 빠진 경험이 일시적으로 고조된 상태라는 것을인식하고 연인과 더불어 "진정한 사랑"을 추구하라는 것이다.
                                    </p>
                                </a>
                                <p class="more_btn">
                                    <a href="Tip_info16.jsp" style="color: #ff7b91;">view more +</a>
                                </p>
                            </li>
                            <li>
                                <a href="Tip_info17.jsp">
                                    <span class="thum" style="background-image:url('../icon/love/love_13.jpg');"></span>
                                    <h2 class="tit">
                                        <span>
                                            <b class="hot">HOT</b>
                                            자꾸 보면 좋아진다
                                        </span>
                                    </h2>
                                    <p>
                                        사랑을 바라는 당신을 위한 조언" 서로 직접 만나서 인사를 나누는 건 남녀관계의 진전에 있어 빠질 수 없는 과정이다.
                                        플라토닉 러브라면 편지, 전화, 이메일과 같은 수단을 통해서도 사랑이 커지고 또 그만큼 큰 흥분과 만족을 얻을 수 있겠지만,
                                        대부분의 사람들은 직접 얼굴을 보고 나서 사랑할 것인지 아닌지를 판단한다.
                                    </p>
                                </a>
                                <p class="more_btn">
                                    <a href="Tip_info17.jsp" style="color: #ff7b91;">view more +</a>
                                </p>
                            </li>
                            <li>
                                <a href="Tip_info18.jsp">
                                    <span class="thum" style="background-image:url('../icon/love/love_14.jpg');"></span>
                                    <h2 class="tit">
                                        <span>
                                            <b class="hot">HOT</b>
                                            사랑의 뒷면
                                        </span>
                                    </h2>
                                    <p>
                                        '사랑은 달콤하고, 사랑은 행복하며..'이렇게 시작하지 않습니다.사랑은 인내이며,성숙의 열매입니다.
                                        연인들은 사랑자체보다사랑이 주는 달콤함, 낭만, 분위기를 사랑합니다.
                                    </p>
                                </a>
                                <p class="more_btn">
                                    <a href="Tip_info18.jsp" style="color: #ff7b91;">view more +</a>
                                </p>
                            </li>
                            <li>
                                <a href="Tip_info19.html">
                                    <span class="thum" style="background-image:url('../icon/love/love_10.jpg');"></span>
                                    <h2 class="tit">
                                        <span>
                                            <b class="hot">HOT</b>
                                            3초 쉬고 1+1으로 질문하기 - 소개팅 심리 수업 -
                                        </span>
                                    </h2>
                                    <p>
                                        소개팅에서 '분위기는 좋았다' 라는 말은자신만의 생각일 가능성이 매우 높습니다.실제로 분위기가 좋아서 내심 기대했는데 
                                        이후 연락이 없어서고민하는 사람들 중 의외로 많은 비율이혼자 도취되어 신나게 자기 얘기만 하고 온 경우거든요.
                                    </p>
                                </a>
                                <p class="more_btn">
                                    <a href="Tip_info19.jsp" style="color: #ff7b91;">view more +</a>
                                </p>
                            </li>
                        </ul>
                    </div>
                    <div class="btn_wrap right mt30"></div>
                    <div class="pager">
                        <ul>
                            <li class="arrow mgr">
                                <img src="../icon/new_arr01.png" alt="처음">
                            </li>
                            <li class="arrow mgr">
                                <img src="../icon/new_arr02.png" alt="이전">
                            </li>
                            <li id="present">1</li>
                            <li class="arrow mgl">
                                <a href="../Tip/Tip4_1.jsp">
                                    <img src="../icon/new_arr03.png" alt="다음">
                                </a>
                            </li>
                            <li class="arrow mgl">
                                <a href="../Tip/Tip4_1.jsp">
                                    <img src="../icon/new_arr04.png" alt="마지막">
                                </a>
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