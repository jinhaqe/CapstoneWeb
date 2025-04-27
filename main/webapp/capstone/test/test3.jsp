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
	<link rel="stylesheet" href="../cp_intro.css">
	<link rel="stylesheet" href="topmain.css">
	<link rel="stylesheet" href="test3.css">
	<script src="../cp_intro.js"></script>
	<meta charset="UTF-8">
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
                    --><a href="test3.jsp" class="active">연애력테스트</a><!--
                    --><a href="test4.jsp" class="bactive">연애능력고사</a><!--
                    --><a href="test5.jsp" class="bactive">운세</a>
                    </div>
                </div>
            </div>
        </div>
        <main>
            <div class="main_in">
                <div class="test_title">
                    <h6>연애력 테스트</h6>
                    <p>실제 같은 대화로 내 유형을 알아내자!</p>
                </div>
                <div class="progress">
                    <div class="progress_in"  style="width: 0%;"></div>
                    <div class="progress_heart"></div>
                    <div class="progress_heart_full" style="display: none;"></div>
                </div>
                <div class="test_back">
                    <div class="test3_open">
                        <div class="test3_start">
                            <div class="profile"></div>
                            <div class="chat_topL">
                                <div class="left_chat">안녕</div>
                                <div class="left_chat">뭐해?</div>
                            </div>
                            <div class="chat_topR">
                                <div class="right_chat">테스트중</div>
                            </div>
                        </div>
                        <div class="start_btn">시작하기</div>
                    </div>
                    <div class="test3_close" data-question="1">
                        <div class="profile"></div>
                        <div class="chat_topL">
                            <div class="left_chat">안녕!</div>
                            <div class="left_chat">내 성별은 뭐야?</div>
                        </div>
                        <div class="chat_topR">
                            <div class="right_chat"></div>
                        </div>
                        <div class="select_top">
                            <div class="select_A" data-choice="A">여자</div>
                            <div class="select_B" data-choice="B">남자</div>
                        </div>
                    </div>
                    <div class="test3_close" data-question="2">
                        <div class="profile"></div>
                        <div class="chat_topL">
                            <div class="left_chat">마음에 들어서 연락했어!</div>
                            <div class="left_chat">주말에는 주로 뭐해?</div>
                        </div>
                        <div class="chat_topR">
                            <div class="right_chat"></div>
                        </div>
                        <div class="select_top">
                            <div class="select_A" data-choice="A">나만의 시간을 보내</div>
                            <div class="select_B" data-choice="B">밖에 나가서 놀아</div>
                        </div>
                    </div>
                    <div class="test3_close" data-question="3">
                        <div class="profile"></div>
                        <div class="chat_topL">
                            <div class="left_chat">나랑 비슷하네</div>
                            <div class="left_chat">친구들은 보통 어떻게 만나?</div>
                        </div>
                        <div class="chat_topR">
                            <div class="right_chat"></div>
                        </div>
                        <div class="select_top">
                            <div class="select_A" data-choice="A">보통 친구가 먼저 불러</div>
                            <div class="select_B" data-choice="B">내가 먼저 약속을 잡아</div>
                        </div>
                    </div>
                    <div class="test3_close" data-question="4">
                        <div class="profile"></div>
                        <div class="chat_topL">
                            <div class="left_chat">그래?</div>
                            <div class="left_chat">애인인 너는 어떤 사람인 것 같아?</div>
                        </div>
                        <div class="chat_topR">
                            <div class="right_chat"></div>
                        </div>
                        <div class="select_top">
                            <div class="select_A" data-choice="A">의지가 되는 사람</div>
                            <div class="select_B" data-choice="B">웃음을 주는 사람</div>
                        </div>
                    </div>
                    <div class="test3_close" data-question="5">
                        <div class="profile"></div>
                        <div class="chat_topL">
                            <div class="left_chat">좋네!</div>
                            <div class="left_chat">데이트 코스 같은 건 어떻게 짜는 편?</div>
                        </div>
                        <div class="chat_topR">
                            <div class="right_chat"></div>
                        </div>
                        <div class="select_top">
                            <div class="select_A" data-choice="A">그런건 힘들어.. 맞춰줄 순 있어</div>
                            <div class="select_B" data-choice="B">나 그런거 엄청 잘해!</div>
                        </div>
                    </div>
                    <div class="test3_close" data-question="6">
                        <div class="profile"></div>
                        <div class="chat_topL">
                            <div class="left_chat">그렇구나!</div>
                            <div class="left_chat">만약 내가 이상한 주장을 계속 한다면?</div>
                        </div>
                        <div class="chat_topR">
                            <div class="right_chat"></div>
                        </div>
                        <div class="select_top">
                            <div class="select_A" data-choice="A">귀여우니까 봐줄게</div>
                            <div class="select_B" data-choice="B">아닌건 아니야</div>
                        </div>
                    </div>
                    <div class="test3_close" data-question="7">
                        <div class="profile"></div>
                        <div class="chat_topL">
                            <div class="left_chat">아 진짜?</div>
                            <div class="left_chat">화나면 보통 어때?</div>
                        </div>
                        <div class="chat_topR">
                            <div class="right_chat"></div>
                        </div>
                        <div class="select_top">
                            <div class="select_A" data-choice="A">그 자리에서 바로 말해</div>
                            <div class="select_B" data-choice="B">시간을 조금 가져</div>
                        </div>
                    </div>
                    <div class="test3_close" data-question="8">
                        <div class="profile"></div>
                        <div class="chat_topL">
                            <div class="left_chat">아하..</div>
                            <div class="left_chat">그럼 만약 우리가 싸운다면?</div>
                        </div>
                        <div class="chat_topR">
                            <div class="right_chat"></div>
                        </div>
                        <div class="select_top">
                            <div class="select_A" data-choice="A">왜 싸웠는지 아는 것이 중요해</div>
                            <div class="select_B" data-choice="B">서로의 감정을 털어놓는 것이 중요해</div>
                        </div>
                    </div>
                    <div class="test3_close" data-question="9">
                        <div class="profile"></div>
                        <div class="chat_topL">
                            <div class="left_chat">그렇구나!</div>
                            <div class="left_chat">내가 너한테 어떻게 접근했으면 좋겠어?</div>
                        </div>
                        <div class="chat_topR">
                            <div class="right_chat"></div>
                        </div>
                        <div class="select_top">
                            <div class="select_A" data-choice="A">수줍은 얼굴로 호감을 표현</div>
                            <div class="select_B" data-choice="B">적극적으로 마음을 표현</div>
                        </div>
                    </div>
                    <div class="test3_close" data-question="10">
                        <div class="profile"></div>
                        <div class="chat_topL">
                            <div class="left_chat">그렇게 해야겠네ㅎㅎ</div>
                            <div class="left_chat">연애를 결정하는 기준은 뭐야?</div>
                        </div>
                        <div class="chat_topR">
                            <div class="right_chat"></div>
                        </div>
                        <div class="select_top">
                            <div class="select_A" data-choice="A">현실적인 조건이 중요해</div>
                            <div class="select_B" data-choice="B">내가 감정적으로 끌리는지가 중요해</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result1" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">나는 너의</p>
                        <p class="result_p">소신있는 모습에 반했어</p>
                        <div class="result_detail">
                            <div class="pro_g1"></div>
                            <div class="result_topL">
                                <div class="result_chat">너와 몇 번 대화해보면서 느꼈어</div>
                                <div class="result_chat">너는 소신있는 사람인 것 같아</div>
                                <div class="result_chat">너의 확실하고 단호하면서도</div>
                                <div class="result_chat">부끄러움이 많은 성격에 끌렸어!</div>
                                <div class="result_chat">내 생각에는 우리 둘이 꽤 잘맞을 것 같은데...</div>
                            </div>
                            <p>나랑 한번 만나보지 않을래?</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result2" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">나는 너의</p>
                        <p class="result_p">짱구같은 모습에 반했어</p>
                        <div class="result_detail">
                            <div class="pro_g2"></div>
                            <div class="result_topL">
                                <div class="result_chat">너는 정말 엉뚱한 것 같아</div>
                                <div class="result_chat">하지만 나는 그 성격에 매력을 느껴</div>
                                <div class="result_chat">장난기도 많고 틱틱대기도 하지만</div>
                                <div class="result_chat">기본적으로 다정한 성격에 끌렸어!</div>
                                <div class="result_chat">내 생각에는 우리 둘이 꽤 잘맞을 것 같은데...</div>
                            </div>
                            <p>나랑 한번 만나보지 않을래?</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result3" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">나는 너의</p>
                        <p class="result_p">통찰력있는 모습에 반했어</p>
                        <div class="result_detail">
                            <div class="pro_g3"></div>
                            <div class="result_topL">
                                <div class="result_chat">너와 대화하면서 꿰뚫린 느낌이 들었어</div>
                                <div class="result_chat">너와 연인이 된다면 내 마음을</div>
                                <div class="result_chat">잘 파악해줄 것 같은 느낌이 들어</div>
                                <div class="result_chat">너는 나 어떻게 생각해?</div>
                                <div class="result_chat">내 생각에는 우리 둘이 꽤 잘맞을 것 같은데...</div>
                            </div>
                            <p>나랑 한번 만나보지 않을래?</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result4" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">나는 너의</p>
                        <p class="result_p">코난같은 모습에 반했어</p>
                        <div class="result_detail">
                            <div class="pro_g4"></div>
                            <div class="result_topL">
                                <div class="result_chat">내 생각엔 넌 좀 똑똑한 것 같아</div>
                                <div class="result_chat">책 같은거 많이 읽지 않아?</div>
                                <div class="result_chat">별로 많은 대화를 나누지도 않았는데</div>
                                <div class="result_chat">다 파악할 수 있었어</div>
                                <div class="result_chat">내 생각에는 우리 둘이 꽤 잘맞을 것 같은데...</div>
                            </div>
                            <p>나랑 한번 만나보지 않을래?</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result5" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">나는 너의</p>
                        <p class="result_p">뚱이같은 모습에 반했어</p>
                        <div class="result_detail">
                            <div class="pro_g5"></div>
                            <div class="result_topL">
                                <div class="result_chat">너는 다른 사람과 좀 다른것 같아</div>
                                <div class="result_chat">특이하다는 말 자주 듣지?</div>
                                <div class="result_chat">하지만 상냥한 말은 잊지 않는 너에게</div>
                                <div class="result_chat">특이하게도 끌려버렸어!</div>
                                <div class="result_chat">내 생각에는 우리 둘이 꽤 잘맞을 것 같은데...</div>
                            </div>
                            <p>나랑 한번 만나보지 않을래?</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result6" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">나는 너의</p>
                        <p class="result_p">소소한 모습에 반했어</p>
                        <div class="result_detail">
                            <div class="pro_g6"></div>
                            <div class="result_topL">
                                <div class="result_chat">너는 평범한 스타일인 것 같아</div>
                                <div class="result_chat">수수한 스타일을 좋아하지 않아?</div>
                                <div class="result_chat">하지만 난 오히려 그런 평범한</div>
                                <div class="result_chat">모습에 매력을 느꼈어!</div>
                                <div class="result_chat">내 생각에는 우리 둘이 꽤 잘맞을 것 같은데...</div>
                            </div>
                            <p>나랑 한번 만나보지 않을래?</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result7" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">나는 너의</p>
                        <p class="result_p">대담한 모습에 반했어</p>
                        <div class="result_detail">
                            <div class="pro_g7"></div>
                            <div class="result_topL">
                                <div class="result_chat">너는 마음에 들면 직진하는 스타일같아</div>
                                <div class="result_chat">간혹 가볍다고 오해를 받을 수도 있지만</div>
                                <div class="result_chat">난 그렇게 생각안해</div>
                                <div class="result_chat">오히려 그런 모습에 더 매력을 느꼈어!</div>
                                <div class="result_chat">내 생각에는 우리 둘이 꽤 잘맞을 것 같은데...</div>
                            </div>
                            <p>나랑 한번 만나보지 않을래?</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result8" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">나는 너의</p>
                        <p class="result_p">확고한 모습에 반했어</p>
                        <div class="result_detail">
                            <div class="pro_g8"></div>
                            <div class="result_topL">
                                <div class="result_chat">너는 좋고 나쁨이 명확한 사람 같아</div>
                                <div class="result_chat">처음엔 냉철하고 단호한 모습이</div>
                                <div class="result_chat">무섭다고 느껴졌지만 지금은</div>
                                <div class="result_chat">너의 그 확고한 마음에 더 끌리는 것 같아</div>
                                <div class="result_chat">내 생각에는 우리 둘이 꽤 잘맞을 것 같은데...</div>
                            </div>
                            <p>나랑 한번 만나보지 않을래?</p>
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
            const questions = document.querySelectorAll('.test3_close');
            const resultDivs = document.querySelectorAll('.result');
            const progressBar = document.querySelector('.progress_in');
            const progressHeart = document.querySelector('.progress_heart');
            const progressHeartFull = document.querySelector('.progress_heart_full');
            const testBack = document.querySelector('.test_back');
            const returnBtns = document.querySelectorAll('.return_btn');
            let currentQuestion = 0;
            let answers = {};

            startBtn.addEventListener('click', function() {
                document.querySelector('.test3_open').style.display = 'none';
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
                const predefinedResults = {};

                const allPossibleKeys = [];

                // Generate all possible 9-bit keys
                for (let i = 0; i < 1024; i++) {
                    let binaryString = i.toString(2).padStart(9, '0').replace(/0/g, 'A').replace(/1/g, 'B');
                    allPossibleKeys.push(binaryString);
                }

                let valueA1 = [1, 2, 3, 4];
                let valueB1 = [5, 6, 7, 8];
                let valueA4 = [3, 4, 6, 7];
                let valueB4 = [1, 2, 5, 8];
                let valueA6 = [2, 3, 6, 7];
                let valueB6 = [1, 4, 5, 8];
                let valueA9 = [1, 2, 6, 8];
                let valueB9 = [3, 4, 5, 7];

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

                        if (key[3] === 'A') {
                            predefinedResults[key] = valueA4.shift();
                            valueA4.push(predefinedResults[key]);
                        } else if (key[3] === 'B') {
                            predefinedResults[key] = valueB4.shift();
                            valueB4.push(predefinedResults[key]);
                        }

                        if (key[5] === 'A') {
                            predefinedResults[key] = valueA6.shift();
                            valueA6.push(predefinedResults[key]);
                        } else if (key[5] === 'B') {
                            predefinedResults[key] = valueB6.shift();
                            valueB6.push(predefinedResults[key]);
                        }

                        if (key[8] === 'A') {
                            predefinedResults[key] = valueA9.shift();
                            valueA9.push(predefinedResults[key]);
                        } else if (key[8] === 'B') {
                            predefinedResults[key] = valueB9.shift();
                            valueB9.push(predefinedResults[key]);
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
                document.querySelector('.test3_open').style.display = 'block';
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