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
	<link rel="stylesheet" href="../cp_intro.css">
	<link rel="stylesheet" href="topmain.css">
	<link rel="stylesheet" href="test2.css">
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
                    --><a href="test2.jsp" class="active">성격검사</a><!--
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
                    <h6>성격 검사</h6>
                    <p>내 성격은 무슨 유형일까?</p>
                </div>
                <div class="progress">
                    <div class="progress_in"  style="width: 0%;"></div>
                    <div class="progress_heart"></div>
                    <div class="progress_heart_full" style="display: none;"></div>
                </div>
                <div class="test_back">
                    <div class="test2_open">
                        <div class="test2_start"></div>
                        <div class="start_btn">시작하기</div>
                    </div>
                    <div class="test2_close" data-question="1">
                        <div class="test2_img"><img src="test2/test2_1img.jpg"></div>
                        <p>오늘은 기다리던 데이트날! 당신의 생각은?</p>
                        <div class="select_A" data-choice="A">침대에서 일어나기가 힘들다</div>
                        <div class="select_B" data-choice="B">약속 시간이 빠르게 다가왔으면 좋겠다</div>
                        <div class="left_arrow"></div>
                        <div class="right_arrow"></div>
                    </div>
                    <div class="test2_close" data-question="2">
                        <div class="test2_img"><img src="test2/test2_2img.jpg"></div>
                        <p>당신은 몇시에 약속 장소로 도착할까?</p>
                        <div class="select_A" data-choice="A">정시에 딱 맞춰 도착한다</div>
                        <div class="select_B" data-choice="B">여유롭게 10분 일찍 도착한다</div>
                        <div class="left_arrow"></div>
                        <div class="right_arrow"></div>
                    </div>
                    <div class="test2_close" data-question="3">
                        <div class="test2_img"><img src="test2/test2_3img.jpg"></div>
                        <p>연인과 만나 점심을 먹으러가자</p>
                        <div class="select_A" data-choice="A">일주일 전 짜놓은 계획대로 가자</div>
                        <div class="select_B" data-choice="B">주변에 맛있어보이는 곳을 간다</div>
                        <div class="left_arrow"></div>
                        <div class="right_arrow"></div>
                    </div>
                    <div class="test2_close" data-question="4">
                        <div class="test2_img"><img src="test2/test2_4img.jpg"></div>
                        <p>점심을 먹고 나오는 길, 갑자기 주변에 사람이 많아졌다</p>
                        <div class="select_A" data-choice="A">무슨 공연이라도 하나? 재미있겠다</div>
                        <div class="select_B" data-choice="B">실시간으로 기가 빨린다</div>
                        <div class="left_arrow"></div>
                        <div class="right_arrow"></div>
                    </div>
                    <div class="test2_close" data-question="5">
                        <div class="test2_img"><img src="test2/test2_5img.jpg"></div>
                        <p>연인과 대화 중 초능력 드라마 이야기가 나왔다</p>
                        <div class="select_A" data-choice="A">드라마의 내용에 초점을 둔다</div>
                        <div class="select_B" data-choice="B">초능력이라는 소재에 초점을 둔다</div>
                        <div class="left_arrow"></div>
                        <div class="right_arrow"></div>
                    </div>
                    <div class="test2_close" data-question="6">
                        <div class="test2_img"><img src="test2/test2_6img.jpg"></div>
                        <p>연인이 기념일에 쓸데없는 선물을 서로 사주자고 한다</p>
                        <div class="select_A" data-choice="A">재미있겠다! 그것도 추억이지</div>
                        <div class="select_B" data-choice="B">왜 굳이 그런걸 하지?</div>
                        <div class="left_arrow"></div>
                        <div class="right_arrow"></div>
                    </div>
                    <div class="test2_close" data-question="7">
                        <div class="test2_img"><img src="test2/test2_7img.jpg"></div>
                        <p>애인이 앞을 보지 않고 걷다가 발목을 다쳤다</p>
                        <div class="select_A" data-choice="A">괜찮아? 많이 아파?</div>
                        <div class="select_B" data-choice="B">병원 갈래? 조심하지 그랬어..</div>
                        <div class="left_arrow"></div>
                        <div class="right_arrow"></div>
                    </div>
                    <div class="test2_close" data-question="8">
                        <div class="test2_img"><img src="test2/test2_8img.jpg"></div>
                        <p>애인이 자기가 바퀴벌레가 되면 어떻겠냐고 물어본다</p>
                        <div class="select_A" data-choice="A">사랑으로 키워준다는 대답을 한다</div>
                        <div class="select_B" data-choice="B">그런 생각 해본 적 없는데...</div>
                        <div class="left_arrow"></div>
                        <div class="right_arrow"></div>
                    </div>
                    <div class="test2_close" data-question="9">
                        <div class="test2_img"><img src="test2/test2-9img.jpg"></div>
                        <p>이제 집에 갈 시간, 나를 행복하게 하는 애인의 마지막 한마디는?</p>
                        <div class="select_A" data-choice="A">오늘 너무 재미있었어!</div>
                        <div class="select_B" data-choice="B">데이트 계획 다 짜줘서 고마워</div>
                        <div class="left_arrow"></div>
                        <div class="right_arrow"></div>
                    </div>
                </div>
                <div class="result" id="result1" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 성격 유형은</p>
                        <p class="result_p">조용한 예언자형</p>
                        <img src="test2/resultimg1.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 성격 유형은 조용한 예언자형!</p>
                            <p>깊은 통찰력과 생각을 지니고 있어요.</p>
                            <p>고집이 쎄고 완벽주의자 성향을 지닌</p>
                            <p>당신은 주위 시선을 신경쓰고 소심한</p>
                            <p>성정도 가지고 있어요.</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result2" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 성격 유형은</p>
                        <p class="result_p">민감한 이상주의자형</p>
                        <img src="test2/resultimg2.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 성격 유형은 민감한 이상주의자형!</p>
                            <p>강한 개성을 띄는 성격이에요.</p>
                            <p>겉모습은 정말 조용하지만 한번 친해지면</p>
                            <p>끊임없이 이야기를 풀어낼 수 있어요.</p>
                            <p>마음에 상처를 숨기는 버릇이 있어요.</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result3" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 성격 유형은</p>
                        <p class="result_p">진지한 독창적형</p>
                        <img src="test2/resultimg3.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 성격 유형은 진지한 독창적형!</p>
                            <p>내성적인 성격이지만 친구와 만나는건 좋아해요.</p>
                            <p>항상 주변이 깔끔하고 좋은 평가를 받아내요.</p>
                            <p>혼자 있는 시간을 좋아하지만 의외로</p>
                            <p>단체활동시에 주도적인 역할도 잘 맡아요.</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result4" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 성격 유형은</p>
                        <p class="result_p">관대한 추상형</p>
                        <img src="test2/resultimg4.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 성격 유형은 관대한 추상형!</p>
                            <p>이 유형은 자기주장이 엄청나게 강해요.</p>
                            <p>누구보다 혼자만의 시간을 중요하게 여겨요.</p>
                            <p>나서야할 때는 나설줄도 아는 이 유형은</p>
                            <p>가장 중간에 존재하는 유형이라고 볼 수 있어요.</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result5" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 성격 유형은</p>
                        <p class="result_p">리더십있는 실용형</p>
                        <img src="test2/resultimg5.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 성격 유형은 리더십있는 실용형!</p>
                            <p>추진력이 좋은 당신은 현대사회에 최적화되어 있어요.</p>
                            <p>체계적이고 계획적인 것을 좋아해</p>
                            <p>계획이 틀어지는 것을 누구보다 싫어해요.</p>
                            <p>감정에 둔한 편이라 오해를 살 수 있어요.</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result6" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 성격 유형은</p>
                        <p class="result_p">영리한 행동지향형</p>
                        <img src="test2/resultimg6.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 성격 유형은 영리한 행동지향형!</p>
                            <p>직설적이고 인간관계에 스트레스 받지 않는</p>
                            <p>당신은 상대방의 열정에 끌리는 편이에요.</p>
                            <p>자기주장이 강하고 자존감이 높은게 특징인</p>
                            <p>이 유형은 우울감을 느낄 새가 없을거에요.</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result7" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 성격 유형은</p>
                        <p class="result_p">사교적인 열정형</p>
                        <img src="test2/resultimg7.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 성격 유형은 사교적인 열정형!</p>
                            <p>다른 누구보다 사람들을 좋아하는 당신은</p>
                            <p>인간관계에 상처를 많이 받는 편이에요.</p>
                            <p>활발함과 밝음으로 무장한 이 유형을</p>
                            <p>싫어하는 사람은 없을거에요.</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result8" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">당신의 성격 유형은</p>
                        <p class="result_p">따뜻한 책임감형</p>
                        <img src="test2/resultimg8.jpg" alt="">
                        <div class="result_detail">
                            <p>당신의 성격 유형은 따뜻한 책임감형!</p>
                            <p>공감, 감성 지능, 강한 책임감을 지녔어요.</p>
                            <p>솔직하고 공감적인 사람에게 관심을 보이는</p>
                            <p>당신에게 가장 잘 맞는 짝은 아마</p>
                            <p>자기 자신일거에요.</p>
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
            const questions = document.querySelectorAll('.test2_close');
            const resultDivs = document.querySelectorAll('.result');
            const progressBar = document.querySelector('.progress_in');
            const progressHeart = document.querySelector('.progress_heart');
            const progressHeartFull = document.querySelector('.progress_heart_full');
            const testBack = document.querySelector('.test_back');
            const returnBtns = document.querySelectorAll('.return_btn');
            let currentQuestion = 0;
            let answers = {};

            startBtn.addEventListener('click', function() {
                document.querySelector('.test2_open').style.display = 'none';
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
                    'AAAAAAAAA': 1, 'AAAABAABA': 1,
                    'AABBAAAAAB': 2, 'ABBABAABB': 2,
                    'AAAAABBAA': 3, 'AAAABBBBA': 3,
                    'ABBABBBBB': 4, 'ABBAABBAB': 4,
                    'BAABBBBBA': 5, 'BAABABBAB': 5,
                    'BBBBABBAB': 6, 'BBBBBBBBB': 6,
                    'BBBBBAABB': 7, 'BBBBAAAAB': 7,
                    'BAABAAAAA': 8, 'BAABBAABA': 8,
                };

                const allPossibleKeys = [];

                for (let i = 0; i < 512; i++) {
                    let binaryString = i.toString(2).padStart(9, '0').replace(/0/g, 'A').replace(/1/g, 'B');
                    allPossibleKeys.push(binaryString);
                }

                let valueA1 = [1, 2, 3, 4];
                let valueB1 = [5, 6, 7, 8];
                let valueA3 = [1, 3, 5, 8];
                let valueB3 = [2, 4, 6, 7];
                let valueA7 = [3, 4, 5, 6];
                let valueB7 = [1, 2, 7, 8];

                // Distribute results for keys not predefined
                for (let key of allPossibleKeys) {
                    if (!predefinedResults[key]) {
                        if (key[0] === 'A') {
                            predefinedResults[key] = valueA1.shift();
                            valueA1.push(predefinedResults[key]);
                        } else if (key[0] === 'B') {
                            predefinedResults[key] = valueB1.shift();
                            valueB1.push(predefinedResults[key]);
                        }

                        if (key[2] === 'A') {
                            predefinedResults[key] = valueA3.shift();
                            valueA3.push(predefinedResults[key]);
                        } else if (key[2] === 'B') {
                            predefinedResults[key] = valueB3.shift();
                            valueB3.push(predefinedResults[key]);
                        }

                        if (key[6] === 'A') {
                            predefinedResults[key] = valueA7.shift();
                            valueA7.push(predefinedResults[key]);
                        } else if (key[6] === 'B') {
                            predefinedResults[key] = valueB7.shift();
                            valueB7.push(predefinedResults[key]);
                        }
                    }
                }

                return predefinedResults[resultKey] || 1;  // Default value 1
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
                document.querySelector('.test2_open').style.display = 'block';
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