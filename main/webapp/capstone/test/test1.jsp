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
	<link rel="stylesheet" href="../cp_intro.css">
	<link rel="stylesheet" href="topmain.css">
	<link rel="stylesheet" href="test1.css?after">
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

                    <li class="li_dropdown"><a href="test1.jsp">테스트</a>
                        <ul class="ul_border">
                            <li><a href="test1.jsp">이상형테스트</a></li>
                            <li><a href="test2.jsp">성격유형</a></li>
                            <li><a href="test3.jsp">연애력테스트</a></li>
                            <li><a href="test4.jsp">연애능력고사</a></li>
                            <li><a href="test5.jsp">연애운세</a></li>
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
                    <h5>테스트</h5>
                    <p>나의 마음을 확실하게 알아보자</p>
                </div>
            </div> 
            <div class="sub_tab">
                    <div class="sub_tab_co">
                    <div class="sub_tab_in">
                        <a href="test1.jsp" class="active">이상형테스트</a><!--
                    --><a href="test2.jsp" class="bactive">성격유형</a><!--
                    --><a href="test3.jsp" class="bactive">연애력테스트</a><!--
                    --><a href="test4.jsp" class="bactive">연애능력고사</a><!--
                    --><a href="test5.jsp" class="bactive">운세</a>
                    </div>
                </div>
            </div>       
        </div>
        <main>
            <div class="main_in">
                <div class="test_title">
                    <h6>이상형 테스트</h6>
                    <p>자신의 취향을 알아낼 수 있는 기회!</p>
                </div>
                <div class="progress">
                    <div class="progress_in"  style="width: 0%;"></div>
                    <div class="progress_heart" ></div>
                    <div class="progress_heart_full" style="display: none;"></div>
                </div>
                <div class="test_back" id="test_back">
                    <div class="test1_open">
                        <div class="test1_start"></div>
                        <div class="start_btn">시작하기</div>
                    </div>
                    <div class="test1_close" data-question="1">
                        <div class="test1_img"><img src="test1/test1_1img.jpg"></div>
                        <p>이상형의 성별은?</p>
                        <div class="select_A" data-choice="A">여자</div>
                        <div class="select_B" data-choice="B">남자</div>
                    </div>
                    <div class="test1_close" data-question="2">
                        <div class="test1_img"><img src="test1/test1_2img.jpg"></div>
                        <p>나와 이상형의 첫만남이 어땠으면 좋겠는지?</p>
                        <div class="select_A" data-choice="B">지인과의 소개팅</div>
                        <div class="select_B" data-choice="A">길거리에서의 운명적인 만남</div>
                    </div>
                    <div class="test1_close" data-question="3">
                        <div class="test1_img"><img src="test1/test1_3img.jpg"></div>
                        <p>이상형과의 데이트 장소로는 어느곳이 좋은지?</p>
                        <div class="select_A" data-choice="A">분위기 있는 레스토랑</div>
                        <div class="select_B" data-choice="B">소박한 포장마차</div>
                    </div>
                    <div class="test1_close" data-question="4">
                        <div class="test1_img"><img src="test1/test1_4img.jpg"></div>
                        <p>이상형에게 바라는 점은?</p>
                        <div class="select_A" data-choice="A">내 기분을 잘 파악해 줬으면 좋겠어!</div>
                        <div class="select_B" data-choice="B">이벤트 서프라이즈를 원해!</div>
                    </div>
                    <div class="test1_close" data-question="5">
                        <div class="test1_img"><img src="test1/test1_5img.jpg"></div>
                        <p>이상형과 싸웠다! 당신의 선택은?</p>
                        <div class="select_A" data-choice="A">화가 풀릴때까지 아무말도 안한다</div>
                        <div class="select_B" data-choice="B">곧 죽어도 그자리에서 풀어야한다</div>
                    </div>
                    <div class="test1_close" data-question="6">
                        <div class="test1_img"><img src="test1/test1_6img.jpg"></div>
                        <p>이상형과 여행을 간다면?</p>
                        <div class="select_A" data-choice="A">이런건 무계획 여행이지!</div>
                        <div class="select_B" data-choice="B">계획이 없는 여행은 용납할 수 없어</div>
                    </div>
                    <div class="test1_close" data-question="7">
                        <div class="test1_img"><img src="test1/test1_7img.jpg"></div>
                        <p>이상형과 인스타 맛집에 왔는데 줄이 엄청 길다</p>
                        <div class="select_A" data-choice="A">그냥 딴곳으로 가자</div>
                        <div class="select_B" data-choice="B">여행인데 뭐 어때~ 기다리자</div>
                    </div>
                    <div class="test1_close" data-question="8">
                        <div class="test1_img"><img src="test1/test1_8img.jpg"></div>
                        <p>행복한 여행이 끝났다. 당신의 생각은?</p>
                        <div class="select_A" data-choice="A">또 놀러가고 싶은데!</div>
                        <div class="select_B" data-choice="B">역시 집데이트가 최고네~</div>
                    </div>
                </div>
                <div class="result" id="result1" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신이 좋아하는 스타일은</p>
                        <p class="result_p">세심한 스타일</p>
                        <img src="test1/resultimg1.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 이상형은 세심한 스타일!</p>
                            <p>연인에게 바라는 것이 많은 당신에게는</p>
                            <p>세심한 스타일이 잘 맞을거에요.</p>
                            <p>기념일을 세세하게 챙겨주는 연인을 만난다면</p>
                            <p>절대 놓치지 마세요!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result2" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신이 좋아하는 스타일은</p>
                        <p class="result_p">확실한 스타일</p>
                        <img src="test1/resultimg2.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 이상형은 확실한 스타일!</p>
                            <p>연인에게 믿음을 바라는 당신에게는</p>
                            <p>확실한 스타일이 잘 맞을거에요.</p>
                            <p>헷갈리지 않게 해주는 연인을 만난다면</p>
                            <p>절대 놓치지 마세요!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result3" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신이 좋아하는 스타일은</p>
                        <p class="result_p">편안한 스타일</p>
                        <img src="test1/resultimg3.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 이상형은 편안한 스타일!</p>
                            <p>마음을 둘 상대가 필요한 당신에게는</p>
                            <p>편안한 스타일이 잘 맞을거에요.</p>
                            <p>단 둘이 있을 때 말을 하지 않아도</p>
                            <p>초조한 마음이 들지 않는 연인을 만난다면</p>
                            <p>절대 놓치지 마세요!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result4" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신이 좋아하는 스타일은</p>
                        <p class="result_p">담담한 스타일</p>
                        <img src="test1/resultimg4.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 이상형은 담담한 스타일!</p>
                            <p>신경 쓸 거리가 많은 당신에게는</p>
                            <p>담담한 스타일이 잘 맞을거에요.</p>
                            <p>감정기복이 심하지 않은 연인을 만난다면</p>
                            <p>절대 놓치지 마세요!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result5" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신이 좋아하는 스타일은</p>
                        <p class="result_p">세심한 스타일</p>
                        <img src="test1/resultimg5.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 이상형은 세심한 스타일!</p>
                            <p>연인에게 바라는 것이 많은 당신에게는</p>
                            <p>세심한 스타일이 잘 맞을거에요.</p>
                            <p>기념일을 세세하게 챙겨주는 연인을 만난다면</p>
                            <p>절대 놓치지 마세요!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result6" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신이 좋아하는 스타일은</p>
                        <p class="result_p">확실한 스타일</p>
                        <img src="test1/resultimg6.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 이상형은 확실한 스타일!</p>
                            <p>연인에게 믿음을 바라는 당신에게는</p>
                            <p>확실한 스타일이 잘 맞을거에요.</p>
                            <p>헷갈리지 않게 해주는 연인을 만난다면</p>
                            <p>절대 놓치지 마세요!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result7" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신이 좋아하는 스타일은</p>
                        <p class="result_p">편안한 스타일</p>
                        <img src="test1/resultimg7.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 이상형은 편안한 스타일!</p>
                            <p>마음을 둘 상대가 필요한 당신에게는</p>
                            <p>편안한 스타일이 잘 맞을거에요.</p>
                            <p>단 둘이 있을 때 말을 하지 않아도</p>
                            <p>초조한 마음이 들지 않는 연인을 만난다면</p>
                            <p>절대 놓치지 마세요!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result8" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신이 좋아하는 스타일은</p>
                        <p class="result_p">담담한 스타일</p>
                        <img src="test1/resultimg8.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 이상형은 담담한 스타일!</p>
                            <p>신경 쓸 거리가 많은 당신에게는</p>
                            <p>담담한 스타일이 잘 맞을거에요.</p>
                            <p>감정기복이 심하지 않은 연인을 만난다면</p>
                            <p>절대 놓치지 마세요!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
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
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const startBtn = document.querySelector('.start_btn');
            const questions = document.querySelectorAll('.test1_close');
            const resultDivs = document.querySelectorAll('.result');
            const progressBar = document.querySelector('.progress_in');
            const progressHeart = document.querySelector('.progress_heart');
            const progressHeartFull = document.querySelector('.progress_heart_full');
            const testBack = document.querySelector('.test_back');
            const returnBtns = document.querySelectorAll('.return_btn');
            let currentQuestion = 0;
            let answers = {};

            startBtn.addEventListener('click', function() {
                document.querySelector('.test1_open').style.display = 'none';
                showQuestion(currentQuestion);
            });

            questions.forEach(question => {
                const options = question.querySelectorAll('.select_A, .select_B');
                options.forEach(option => {
                    option.addEventListener('click', function() {
                        const questionNum = question.getAttribute('data-question');
                        const choice = this.getAttribute('data-choice');
                        answers[questionNum] = choice;
                        currentQuestion++;
                        updateProgressBar(currentQuestion);
                        if (currentQuestion < questions.length) {
                            showQuestion(currentQuestion);
                        } else {
                            showResult();
                        }
                    });
                });
            });

            returnBtns.forEach(button => {
                button.addEventListener('click', function() {
                    resetTest();
                });
            });

            function showQuestion(index) {
                questions.forEach((question, i) => {
                    question.style.display = i === index ? 'block' : 'none';
                });
            }

            function showResult() {
                questions.forEach(question => {
                    question.style.display = 'none';
                });
                const resultKey = calculateResultKey();
                testBack.style.display = 'none';
                document.getElementById(resultKey).style.display = 'block';
            }

            function calculateResultKey() {
                let resultKey = '';
                for (let i = 1; i <= Object.keys(answers).length; i++) {
                    resultKey += answers[i];
                }
                return 'result' + determineResult(resultKey);
            }

            function determineResult(resultKey) {
                const predefinedResults = {
                    'AAAAAAAA': 1, 'AAAABAAB': 1, 'AAABAABA': 1, 'AAABBABB': 1,
                    'AAAAABAA': 2, 'AAAABBAB': 2, 'AAABABBA': 2, 'AAABBBBB': 2,
                    'ABBAAAAA': 3, 'ABBABAAB': 3, 'ABBBAABA': 3, 'ABBBBABB': 3,
                    'ABBAABAA': 4, 'ABBABBAB': 4, 'ABBBABBA': 4, 'ABBBBBBB': 4,
                    'BAAAAAAA': 5, 'BAAABAAB': 5, 'BAABAABA': 5, 'BAABBABB': 5,
                    'BAAAABAA': 6, 'BAAABBAB': 6, 'BAABABBA': 6, 'BAABBBBB': 6,
                    'BBBAAAAA': 7, 'BBBABAAB': 7, 'BBBBAABA': 7, 'BBBBBABB': 7,
                    'BBBAABAA': 8, 'BBBABBAB': 8, 'BBBBABBA': 8, 'BBBBBBBB': 8
                };

                const allPossibleKeys = [];

                for (let i = 0; i < 256; i++) {
                    let binaryString = i.toString(2).padStart(8, '0').replace(/0/g, 'A').replace(/1/g, 'B');
                    allPossibleKeys.push(binaryString);
                }

                let valueA = 1;
                let valueB = 5;
                for (let key of allPossibleKeys) {
                    if (!predefinedResults[key]) {
                        if (key.startsWith('A')) {
                            predefinedResults[key] = valueA;
                            valueA = (valueA % 4) + 1;  
                        } else if (key.startsWith('B')) {
                            predefinedResults[key] = valueB;
                            valueB = (valueB % 4) + 5; 
                        }
                    }
                }

                return predefinedResults[resultKey] || 1;  // 디폴트 값 1
            }

            function updateProgressBar(questionIndex) {
                const progressPercentage = (questionIndex / questions.length) * 100;
                progressBar.style.width = progressPercentage + '%';
                
                if (progressPercentage === 100) {
                    progressHeart.style.display = 'none';
                    progressHeartFull.style.display = 'block';
                }
            }

            function resetTest() {
                currentQuestion = 0;
                answers = {};
                progressBar.style.width = '0%';
                progressHeart.style.display = 'block';
                progressHeartFull.style.display = 'none';
                document.querySelector('.test1_open').style.display = 'block';
                testBack.style.display = 'block';
                resultDivs.forEach(result => {
                    result.style.display = 'none';
                });
                questions.forEach(question => {
                    question.style.display = 'none';
                });
            }
        });
    </script>
</body>
</html>