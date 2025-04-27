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
	<link rel="stylesheet" href="test5.css">
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
                        <a href="test1.jsp" class="bactive">이상형테스트</a><!--
                    --><a href="test2.jsp" class="bactive">성격검사</a><!--
                    --><a href="test3.jsp" class="bactive">연애력테스트</a><!--
                    --><a href="test4.jsp" class="bactive">연애능력고사</a><!--
                    --><a href="test5.jsp" class="active">운세</a>
                    </div>
                </div>
            </div>       
        </div>
        <main>
            <div class="main_in">
                <div class="test_title">
                    <h6>운세</h6>
                    <p>오늘의 연애 운세는?</p>
                </div>
                <div class="progress">
                    <div class="progress_in"  style="width: 0%;"></div>
                    <div class="progress_heart"></div>
                    <div class="progress_heart_full" style="display: none;"></div>
                </div>
                <div class="test_back">
                    <div class="test5_open">
                        <div class="test5_start"></div>
                        <div class="start_btn">시작하기</div>
                    </div>
                    <div class="test5_close">
                        <div class="test5_img"><img src="test5/test5_1img.jpg"></div>
                        <p>지금 어떤 상황인가요?</p>
                        <div class="select_A" data-choice="A">썸타는 중</div>
                        <div class="select_B" data-choice="B">연애 중</div>
                    </div>
                    <div class="test5_close">
                        <div class="test5_img"><img src="test5/test5_2img.jpg"></div>
                        <p>어떤 연애를 하고 싶나요?</p>
                        <div class="select_A" data-choice="A">달달한 연애</div>
                        <div class="select_B" data-choice="B">장난스러운 연애</div>
                    </div>
                    <div class="test5_close">
                        <div class="test5_img"><img src="test5/test5_3img.jpg"></div>
                        <p>짝사랑 하는 사람과 어떤 관계가 되고 싶나요?</p>
                        <div class="select_A" data-choice="A">사랑하는 관계</div>
                        <div class="select_B" data-choice="B">바라만 보는 관계</div>
                    </div>
                    <div class="test5_close">
                        <div class="select_section">
                            <div class="section_A"><img src="test5/test5_cardA.jpg"></div>
                            <div class="section_B"><img src="test5/test5_cardB.jpg"></div>
                        </div>
                        <p>다음 중 마음에 드는 카드를 골라보세요</p>
                        <div class="select_A" data-choice="A">왼쪽</div>
                        <div class="select_B" data-choice="B">오른쪽</div>
                    </div>
                    <div class="test5_close">
                        <div class="select_section">
                            <div class="section_A" style="background-color: yellow;"></div>
                            <div class="section_B" style="background-color: purple;"></div>
                        </div>
                        <p>다음 중 마음에 드는 색을 골라보세요</p>
                        <div class="select_A" data-choice="A">노란색</div>
                        <div class="select_B" data-choice="B">보라색</div>
                    </div>
                    <div class="test5_close">
                        <div class="select_section">
                            <div class="section_A"><img src="test5/test5_flower.jpg"></div>
                            <div class="section_B"><img src="test5/test5_taddy.jpg"></div>
                        </div>
                        <p>다음 중 마음에 드는 소품을 골라보세요</p>
                        <div class="select_A" data-choice="A">꽃다발</div>
                        <div class="select_B" data-choice="B">곰인형</div>
                    </div>
                    <div class="test5_close">
                        <div class="test5_img"><img src="test5/test5_4img.jpg"></div>
                        <p>나의 연애 스타일은?</p>
                        <div class="select_A" data-choice="A">진중한 스타일</div>
                        <div class="select_B" data-choice="B">장난스러운 스타일</div>
                    </div>
                    <div class="test5_close">
                        <div class="test5_img"><img src="test5/test5_5img.jpg"></div>
                        <p>어떤 연인을 만나고 싶나요?</p>
                        <div class="select_A" data-choice="A">외적 조건 이상형</div>
                        <div class="select_B" data-choice="B">내적 조건 이상형</div>
                    </div>
                </div>
                <div class="result" id="result1" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 오늘 운세는</p>
                        <p class="result_p">바람 잘 들 날이 없네요.</p>
                        <img src="test5/resultimg1.jpg" alt="">
                        <div class="result_detail">
                            <p>조심해야 할 필요가 있습니다.</p>
                            <p>운세가 조금 나쁜 쪽에 치우쳐 있습니다.</p>
                            <p>데이트나 특별한 약속이 있다면</p>
                            <p>조금 미루는 것이 어떨까요?</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result2" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 오늘 운세는</p>
                        <p class="result_p">오늘은 날이 아닙니다.</p>
                        <img src="test5/resultimg2.jpg" alt="">
                        <div class="result_detail">
                            <p>좋은 일을 바라기는 힘듭니다.</p>
                            <p>연애가 관련되지 않은 운은 평범합니다.</p>
                            <p>고백이나 중요한 선택을 해야하는</p>
                            <p>일이 있다면 오늘은 하지마세요.</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result3" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 오늘 운세는</p>
                        <p class="result_p">안풀리던 일이 풀릴거에요.</p>
                        <img src="test5/resultimg3.jpg" alt="">
                        <div class="result_detail">
                            <p>평소에 고민했던 일을 해보세요.</p>
                            <p>오늘은 상당히 운이 좋은 날이에요.</p>
                            <p>고백하기에는 딱 좋은 날이네요.</p>
                            <p>하지만 중요한 일이라면 고민부터 해보세요.</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result4" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 오늘 운세는</p>
                        <p class="result_p">평소 하던대로 하세요.</p>
                        <img src="test5/resultimg4.jpg" alt="">
                        <div class="result_detail">
                            <p>오늘은 좋지도 나쁘지도 않은 날입니다.</p>
                            <p>평소에 하던대로 하세요.</p>
                            <p>새로운 일에 도전하지 않는 게 좋습니다.</p>
                            <p>언젠가 빛을 볼 날이 올 겁니다.</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result5" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 오늘 운세는</p>
                        <p class="result_p">평범합니다.</p>
                        <img src="test5/resultimg5.jpg" alt="">
                        <div class="result_detail">
                            <p>오늘은 정말 평범한 날입니다.</p>
                            <p>마음이 가는 대로 해도 좋고</p>
                            <p>조금 겁을 먹고 소심한 행동을 해도</p>
                            <p>결과는 그리 크게 바뀌지 않을 것입니다.</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result6" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 오늘 운세는</p>
                        <p class="result_p">복권이라도 사세요.</p>
                        <img src="test5/resultimg6.jpg" alt="">
                        <div class="result_detail">
                            <p>복권에 당첨될 만큼 운이 좋은 날입니다.</p>
                            <p>운이 따르는 일을 해보세요.</p>
                            <p>평소에 꺼려하거나 두려워했던</p>
                            <p>일을 해도 좋은 결과가 나올 겁니다.</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result7" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 오늘 운세는</p>
                        <p class="result_p">좋은 예감이 들어요.</p>
                        <img src="test5/resultimg7.jpg" alt="">
                        <div class="result_detail">
                            <p>좋은 예감이 드는 날입니다.</p>
                            <p>뭘 해도 될 날이라는 생각이 듭니다.</p>
                            <p>하지만 엄청나게 운 좋은 날은 </p>
                            <p>아니라는 것을 명심하길 바랍니다!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result8" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 오늘 운세는</p>
                        <p class="result_p">새로운 관계를 맺어보세요.</p>
                        <img src="test5/resultimg8.jpg" alt="">
                        <div class="result_detail">
                            <p>새로운 느낌이 필요한 날입니다.</p>
                            <p>기존의 관계에 시선을 돌리고</p>
                            <p>새로운 관계를 맺어보세요</p>
                            <p>나쁘지 않은 결과를 얻을 수 있을 겁니다.</p>
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
            const questions = document.querySelectorAll('.test5_close');
            const resultDivs = document.querySelectorAll('.result');
            const progressBar = document.querySelector('.progress_in');
            const progressHeart = document.querySelector('.progress_heart');
            const progressHeartFull = document.querySelector('.progress_heart_full');
            const testBack = document.querySelector('.test_back');
            const returnBtns = document.querySelectorAll('.return_btn');
            let currentQuestion = 0;
            let answers = {};
    
            startBtn.addEventListener('click', function() {
                document.querySelector('.test5_open').style.display = 'none';
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
                return 'result' + determineResult();
            }
    
            function determineResult() {
                return Math.floor(Math.random() * 8) + 1;
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
                document.querySelector('.test5_open').style.display = 'block';
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