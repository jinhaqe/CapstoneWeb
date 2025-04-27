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
    <link rel=stylesheet href="../cp_intro.css">
    <link rel=stylesheet href="cp_09.css">
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
                    <h5>세부 규정에 대해</h5>
                    <p>알려드립니다.</p>
                </div>
            </div> 
            <div class="sub_tab">
                <div class="sub_tab_co">
                    <div class="sub_tab_in">
                        <a href="cp_06.jsp" class="bactive">이용절차</a><!--
                    --><a href="cp_07.jsp" class="bactive">이용금액</a><!--
                    --><a href="cp_08.jsp" class="bactive">매칭이용가이드</a><!--
                    --><a href="cp_09.jsp" class="active">세부규정</a><!--
                    --><a href="cp_10.jsp" class="bactive">환불규졍</a>
                    </div>
                </div>
            </div>       
        </div>
        <div class="body_Wrap">
            <p class="title02">
                세부규정
            </p>
            <div class="tablebox">
                <div class="box01 mt50">
                    <p class="s_title mt20"> 매칭관련 </p>
                    <ul class="numlist mt30">
                        <li>
                            <em>1</em>
                            김, 이, 박, 최, 정의 성씨를 제외한 동일한 성씨와는 매칭이 이루어질 확률이 적습니다.
                            <p class="subtext mt3">&nbsp;&nbsp;매칭 상대 선정 시 이 점을 유의해서 선정해주세요.</p>
                        </li>
                        <li>
                            <em>2</em>
                            매칭이 진행 중인데 다른 사람이 원하면 추천(매칭) 알림을 받을 수 있습니다.
                            <p class="subtext mt3">&nbsp;&nbsp;알림 수신 시 명확한 거절 의사를 말씀해주시면 매칭이 되지 않습니다.</p>
                            <p class="subtext mt3" >&nbsp;&nbsp;본 서비스에서 한 번이라도 매칭 or 만남을 한 이성과는 다시 매칭되지 않습니다.</p>
                        </li>
                        <li>
                            <em>3</em>
                            매칭이 완료된 후 지인이거나 어떠한 이유로 매칭을 취소할 시 상황에 따라 불이익 발생할 수 있습니다.
                            <p class="subtext mt3">&nbsp;&nbsp;취소한 회원님께는 환불이 되지 않으며, 상대 회원님께는 100% 환불이 진행됩니다.</p>
                            <p class="subtext mt3">&nbsp;&nbsp;취소하신 회원님이 모든 책임을 지고, 상대는 환불을 받습니다.</p>
                        </li>
                        <li>
                            <em>4</em>
                            전문직은 8대 전문직(의사, 변호사, 약사 등)만을 지칭하며, 프리랜서는 사업가로 분류합니다.
                        </li>
                        <li>
                            <em>5</em>
                            교수, 연구원, 법원 시행관, 기술 관련직, 간호사, 강사, 미용사, 변역가 등은 전문직이 아닌 회사원 / 사업가 / 프리랜서로 분류합니다.
                        </li>
                        <li>
                            <em>6</em>
                            회사원 / 공역원 / 전문직 / 사업가 직업을 가진 분이 대학(원)을 병행하는 경우 원래의 직업으로 분류합니다.
                        </li>
                        <li>
                            <em>7</em>
                            2개 이상의 직업 군에 동시에 속하는 경우 수입이 더 큰 쪽을 기준으로 직업을 분류합니다.
                        </li>
                    </ul>
                </div>

                <div class="box01 mt50">
                    <p class="s_title mt20"> 이용불가 </p>
                    <ul class="numlist mt30">
                        <li>
                            <em>1</em>
                            추천 알림을 수신하여 만남 의사 말씀 후 의사 번복 또는 4시간 이상 결제없이 연락이 두절되는 경우
                            <p class="subtext mt3">&nbsp;&nbsp;불필요한 업무 및 신청자의 매칭 시간이 줄어 상대 이성에게 피해가 발생합니다.</p>
                            <p class="subtext mt3">&nbsp;&nbsp;(만남 의사 말씀이 아닌 단순 문의는 괜찮습니다.)</p>
                        </li>
                        <li>
                            <em>2</em>
                            매니저 소개 시 반복적인 지각
                        </li>
                        <li>
                            <em>3</em>
                            매니저와 대화 / 연락 시 예절에 어긋나는 언행, 진중하지 않은 태도
                        </li>
                        <li>
                            <em>4</em>
                            회원의 프로필 기재 사항이 사실과 다른 경우
                            <p class="subtext mt3">&nbsp;&nbsp;허위 기재 시 법적 책임이 있습니다.</p>
                        </li>
                        <li>
                            <em>5</em>
                            개별 만남 연락 두절 / 만남 시 비매너 언행
                        </li>
                        <li>
                            <em>6</em>
                            그 외 서비스 제공이 어렵다고 판단되는 경우
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