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
	<link rel="stylesheet" href="test4.css">
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
                    --><a href="test3.jsp" class="bactive">연애력테스트</a><!--
                    --><a href="test4.jsp" class="active">연애능력고사</a><!--
                    --><a href="test5.jsp" class="bactive">운세</a>
                    </div>
                </div>
            </div>       
        </div>
        <main>
            <div class="main_in">
                <div class="test_title">
                    <h6>연애 능력 고사</h6>
                    <p>연애는 너무 어려워</p>
                </div>
                <div class="progress">
                    <div class="progress_in"  style="width: 0%;"></div>
                    <div class="progress_heart"></div>
                    <div class="progress_heart_full" style="display: none;"></div>
                </div>
                <div class="test_back">
                    <div class="test4_open">
                        <div class="test4_start">
                            <p>연애 영역</p>
                            <div class="question_boximg">
                                <p>○ 자신이 선택한 과목의 문제지인지 확인하시오</p>
                                <p>○ 문제지의 답을 정확하게 기입하시오</p>
                                <p>○ 필적 확인란에 다음의 문구를 정자로 기재하시오</p>
                                <div class="Certifying">연애는 너무 어려워</div>
                            </div>
                        </div>
                        <div class="start_btn">시작하기</div>
                    </div>
                    <div class="test4_close" data-question="1">
                        <div class="test4_Q">
                            <p>1. 다음 중 연인을 대하는 나의 말투는?</p>
                            <div class="question_box">
                                <p>① 다정다감 말투</p>
                                <p>② 장난기가 묻어나는 말투</p>
                                <p>③ 틱틱대는 말투</p>
                                <p>④ 무뚝뚝한 말투</p>
                            </div>
                        </div>
                        <div class="select_A" data-choice="A">①</div>
                        <div class="select_B" data-choice="B">②</div>
                        <div class="select_D" data-choice="D">③</div>
                        <div class="select_C" data-choice="C">④</div>
                    </div>
                    <div class="test4_close" data-question="2">
                        <div class="test4_Q">
                            <p>2. 연인이 기념일로 손편지를 써달라고 한다.</p>
                            <div class="question_box">
                                <p>① 뭐 그런걸... 부끄럽지만 써준다</p>
                                <p>② 미루고 미루다 까먹어버린다</p>
                                <p>③ 솜씨가 형편없지만 진심이 담긴 편지를 쓴다</p>
                                <p>④ 이미 쓰고있다</p>
                            </div>
                        </div>
                        <div class="select_B" data-choice="B">①</div>
                        <div class="select_D" data-choice="D">②</div>
                        <div class="select_C" data-choice="C">③</div>
                        <div class="select_A" data-choice="A">④</div>
                    </div>
                    <div class="test4_close" data-question="3">
                        <div class="test4_Q">
                            <p>3. 연인이 깜짝 선물이나 이벤트를 바라는 모양이다</p>
                            <div class="question_box">
                                <p>① 저번에 해줬는데 반응 별로던데...</p>
                                <p>② 깜짝 이벤트니까 공개적인 장소에서 할까?</p>
                                <p>③ 곰인형이라도 괜찮겠지?</p>
                                <p>④ 꽃과 분위기있는 장소를 준비한다.</p>
                            </div>
                        </div>
                        <div class="select_D" data-choice="D">①</div>
                        <div class="select_C" data-choice="C">②</div>
                        <div class="select_B" data-choice="B">③</div>
                        <div class="select_A" data-choice="A">④</div>
                    </div>
                    <div class="test4_close" data-question="4">
                        <div class="test4_Q">
                            <p>4. 이성과 대화하는 것이 어색한 나에게 추천하는 소개팅 장소</p>
                            <div class="question_box">
                                <p>① 사람이 많은 커피 전문점</p>
                                <p>② 놀이동산</p>
                                <p>③ 조용한 호텔 스카이 라운지</p>
                                <p>④ 만화카페</p>
                            </div>
                        </div>
                        <div class="select_A" data-choice="A">①</div>
                        <div class="select_B" data-choice="B">②</div>
                        <div class="select_C" data-choice="C">③</div>
                        <div class="select_D" data-choice="D">④</div>
                    </div>
                    <div class="test4_close" data-question="5">
                        <div class="test4_Q">
                            <p>5. 소개팅 할때 유리한 시간은?</p>
                            <div class="question_box">
                                <p>① 토요일 2시 PM</p>
                                <p>② 일요일 4시 PM</p>
                                <p>③ 금요일 7시 PM</p>
                                <p>④ 토요일 9시 AM</p>
                            </div>
                        </div>
                        <div class="select_B" data-choice="B">①</div>
                        <div class="select_C" data-choice="C">②</div>
                        <div class="select_A" data-choice="A">③</div>
                        <div class="select_D" data-choice="D">④</div>
                    </div>
                    <div class="test4_close" data-question="6">
                        <div class="test4_Q">
                            <p>6. 소개팅 첫만남, 호감도를 높이는 대화 주제는?</p>
                            <div class="question_box">
                                <p>① 취미나 특기</p>
                                <p>② 영화 취향</p>
                                <p>③ 여행</p>
                                <p>④ 시사</p>
                            </div>
                        </div>
                        <div class="select_A" data-choice="A">①</div>
                        <div class="select_B" data-choice="B">②</div>
                        <div class="select_C" data-choice="C">③</div>
                        <div class="select_D" data-choice="D">④</div>
                    </div>
                    <div class="test4_close" data-question="7">
                        <div class="test4_Q">
                            <p>7. 소개팅, 상대가 자기 나이가 몇살처럼 보이냐 묻는다.</p>
                            <div class="question_box">
                                <p>① 침묵이 길어진다</p>
                                <p>② 정직하게 보이는대로 말한다</p>
                                <p>③ 그냥 알려주시면 안될까요?</p>
                                <p>④ 보이는 것보다 5살 정도 어리게 말한다</p>
                            </div>
                        </div>
                        <div class="select_D" data-choice="D">①</div>
                        <div class="select_B" data-choice="B">②</div>
                        <div class="select_C" data-choice="C">③</div>
                        <div class="select_A" data-choice="A">④</div>
                    </div>
                    <div class="test4_close" data-question="8">
                        <div class="test4_Q">
                            <p>8. 비오는 소개팅 날, 상대와 함께 우산을 쓰기 위해 사용하는 방법은?</p>
                            <div class="question_box">
                                <p>① 우산을 잃어버린다</p>
                                <p>② 넉넉하게 파라솔같은 우산을 가져간다</p>
                                <p>③ 이왕이면 이쁜 우산을 가져간다</p>
                                <p>④ 같이 비를 맞자고 제안한다</p>
                            </div>
                        </div>
                        <div class="select_A" data-choice="A">①</div>
                        <div class="select_C" data-choice="C">②</div>
                        <div class="select_B" data-choice="B">③</div>
                        <div class="select_D" data-choice="D">④</div>
                    </div>
                    <div class="test4_close" data-question="9">
                        <div class="test4_Q">
                            <p>9. 소개팅에는 무슨 옷이 가장 최적일까?</p>
                            <div class="question_box">
                                <p>① 화려한 계열의 옷</p>
                                <p>② 단정한 옷</p>
                                <p>③ 기억에 남게 파격적인 옷</p>
                                <p>④ 무채색에 포인트를 준 옷</p>
                            </div>
                        </div>
                        <div class="select_C" data-choice="C">①</div>
                        <div class="select_A" data-choice="A">②</div>
                        <div class="select_D" data-choice="D">③</div>
                        <div class="select_B" data-choice="B">④</div>
                    </div>
                    <div class="test4_close" data-question="10">
                        <div class="test4_Q">
                            <p>10. 소개팅 후 자연스러운 에프터 신청 방법은?</p>
                            <div class="question_box">
                                <p>① 식사와 커피를 내가 산다</p>
                                <p>② 직설적으로 신청한다</p>
                                <p>③ 나 어떻냐고 은근히 떠본다</p>
                                <p>④ 기회를 틈타 물건을 빌려주고 다음에 돌려달라 한다</p>
                            </div>
                        </div>
                        <div class="select_B" data-choice="B">①</div>
                        <div class="select_C" data-choice="C">②</div>
                        <div class="select_D" data-choice="D">③</div>
                        <div class="select_A" data-choice="A">④</div>
                    </div>
                </div>
                <div class="result" id="result1" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">연애 능력 고사</p>
                        <p class="result_p">당신의 점수는</p>
                        <img src="test4/FFGRADE.png" alt="">
                        <div class="result_detail">
                            <p>최저 점수입니다</p>
                            <p>여러 방면에서 노력을 해야 겠네요</p>
                            <p>모든 스킬을 올릴 필요가 있습니다!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result2" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">연애 능력 고사</p>
                        <p class="result_p">당신의 점수는</p>
                        <img src="test4/FGRADE.png" alt="">
                        <div class="result_detail">
                            <p>노력이 많이 필요한 점수입니다</p>
                            <p>평균을 목표로 잡으세요</p>
                            <p>열심히 하면 최고점에 닿을 수 있습니다!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result3" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">연애 능력 고사</p>
                        <p class="result_p">당신의 점수는</p>
                        <img src="test4/DGRADE.png" alt="">
                        <div class="result_detail">
                            <p>노력이 필요한 점수입니다</p>
                            <p>평균보다 조금 떨어집니다</p>
                            <p>센스를 키울 필요가 있어 보입니다!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result4" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">연애 능력 고사</p>
                        <p class="result_p">당신의 점수는</p>
                        <img src="test4/CGRADE.png" alt="">
                        <div class="result_detail">
                            <p>그럭저럭인 점수입니다</p>
                            <p>평범함이 완벽은 아니죠</p>
                            <p>눈치를 조금 키울 필요가 있습니다!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result5" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">연애 능력 고사</p>
                        <p class="result_p">당신의 점수는</p>
                        <img src="test4/BGRADE.png" alt="">
                        <div class="result_detail">
                            <p>아쉬운 점수입니다</p>
                            <p>완벽한 연인이 되기 위해</p>
                            <p>조금만 더 노력해 보세요!</p>
                        </div>
                        <div class="btn_more">
                            <div class="share_btn">공유하기</div>
                            <div class="return_btn">다시하기</div>
                        </div>
                    </div>
                </div>
                <div class="result" id="result6" style="display: none;">
                    <div class="result_back">
                        <p class="result_title">연애 능력 고사</p>
                        <p class="result_p">당신의 점수는</p>
                        <img src="test4/AGRADE.png" alt="">
                        <div class="result_detail">
                            <p>완벽합니다!</p>
                            <p>연애를 완벽하게 이해하고 있군요</p>
                            <p>좋은 연인이 될 수 있을 것 같습니다!</p>
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
            const questions = document.querySelectorAll('.test4_close');
            const resultDivs = document.querySelectorAll('.result');
            const progressBar = document.querySelector('.progress_in');
            const progressHeart = document.querySelector('.progress_heart');
            const progressHeartFull = document.querySelector('.progress_heart_full');
            const testBack = document.querySelector('.test_back');
            const returnBtns = document.querySelectorAll('.return_btn');
            let currentQuestion = 0;
            let totalScore  = 0;
            let answers = {};

            startBtn.addEventListener('click', function() {
                document.querySelector('.test4_open').style.display = 'none';
                showQuestion(currentQuestion);
            });

            questions.forEach(question => {
                const options = question.querySelectorAll('.select_A, .select_B, .select_C, .select_D');
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
                totalScore = 0;
                for (let i = 1; i <= Object.keys(answers).length; i++) {
                    const choice = answers[i];
                    if (choice === 'A') totalScore += 40;
                    else if (choice === 'B') totalScore += 30;
                    else if (choice === 'C') totalScore += 20;
                    else if (choice === 'D') totalScore += 10;
                }

                // 결과 계산
                let resultNumber = 1;
                if (totalScore >= 400) resultNumber = 6;
                else if (totalScore >= 320) resultNumber = 5;
                else if (totalScore >= 240) resultNumber = 4;
                else if (totalScore >= 160) resultNumber = 3;
                else if (totalScore >= 80) resultNumber = 2;
                else if (totalScore >= 0) resultNumber = 1;
    
                return 'result' + resultNumber;

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
                document.querySelector('.test4_open').style.display = 'block';
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