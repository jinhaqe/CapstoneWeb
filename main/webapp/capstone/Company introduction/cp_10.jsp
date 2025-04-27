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
    <link rel=stylesheet href="cp_10.css">
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
                    <h5>환불 규정에 대해</h5>
                    <p>알려드립니다.</p>
                </div>
            </div> 
            <div class="sub_tab">
                <div class="sub_tab_co">
                    <div class="sub_tab_in">
                        <a href="cp_06.jsp" class="bactive">이용절차</a><!--
                    --><a href="cp_07.jsp" class="bactive">이용금액</a><!--
                    --><a href="cp_08.jsp" class="bactive">매칭이용가이드</a><!--
                    --><a href="cp_09.jsp" class="bactive">세부규정</a><!--
                    --><a href="cp_10.jsp" class="active">환불규졍</a>
                    </div>
                </div>
            </div>       
        </div>
        <div class="body_Wrap">
            <p class="title02">
                환불규정
            </p>
            <div class="box01 mt50">
                <div class="box01_inner">
                    <div>
                        <div class="inner_01">
                            <p>
                                <img src="../icon/jh/Managermeeting.png" class="icon04">
                            </p>
                            <h4 class="title04 pink">매니저 소개 방식</h4>
                        </div>
                    </div>
                    <div class="inner01_2">
                        <p>
                            <img src="../icon/jh/Arrow.png" class="icon05">
                        </p>
                    </div>
                    <div id="wrap">
                        <div class="card ml30">
                            <div class="card-front">
                                <p>
                                    <img src="../icon/jh/ApplicationStage.png" class="icon06">
                                </p>
                                <h4 class="title04 pink">신청 완료 단계</h4>
                            </div>
                            <div class="card-back">
                                <div class="text">
                                    <p class="ss_title mb20">신청 완료 단계</p>
                                    <ul class="s_text_list">
                                        <li>
                                            매칭 실패<br> → 
                                            <b>
                                                총 이용 금액의
                                                <span class="un_line">100% 환불</span>
                                            </b>
                                        </li>
                                        <li>
                                            만남일 기준 4일 전까지 취소<br> → 
                                            <b>
                                                총 이용 금액의
                                                <span class="un_line">80% 환불</span>
                                            </b>
                                        </li>
                                        <li>
                                            만남일 기준 3일 전까지 취소<br> → 
                                            <b>
                                                총 이용 금액의
                                                <span class="un_line">60% 환불</span>
                                            </b>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="wrap">
                        <div class="card">
                            <div class="card-front">
                                <p>
                                    <img src="../icon/jh/Matchingcomplete.png" class="icon06">
                                </p>
                                <h4 class="title04 pink">매칭 완료 단계</h4>
                            </div>
                            <div class="card-back">
                                <div class="text">
                                    <p class="ss_title mb20">매칭 완료 단계</p>
                                    <ul class="s_text_list">
                                        <li>
                                            상대가 취소<br> → 
                                            <b>
                                                총 이용 금액의
                                                <span class="un_line">100% 환불</span>
                                            </b>
                                        </li>
                                        <li>
                                            만남일 기준 1일 전까지 본인 취소<br> → 
                                            <b>
                                                총 이용 금액의
                                                <span class="un_line">50% 환불</span>
                                            </b>
                                        </li>
                                        <li>
                                            만남일 당일 비매너 or 취소 or 노쇼<br> → 
                                            <b>
                                                <span class="un_line">환불 불가 및 추가 배상</span>
                                            </b>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box02_inner">
                    <ul class="text_list">
                        <li>취소는 마이페이지의 취소 클릭 시점으로 처리됩니다.</li>
                        <li>신청 완료 이후에는 일정 변경이 불가능 하므로 가능한 일정으로 신청 부탁드립니다.</li>
                        <li>매니저 소개 방식은 개별 만남 방식과 다르게 추가 비용이 생길 수 있습니다.</li>
                        <li>매니저 소개 만남 당일 30분 이상 지각 시 만남 취소 처리되며 지각 당사자에 대한 환불은 이루어지지 않습니다.</li>
                        <li>환불은 결제하신 하신 계좌로 매니저가 송금하는 방식으로 즉시 이루어지며, 다음 만남 성사 시 재결제를 진행합니다.</li>
                        <li>본 환불 규정은 1회 기준이며, 매칭이 이루어지는 부분이나 주의사항은 세부규정을 확인부탁드립니다.</li>
                        <li>저희 다온은 선불이 아닌 후불로 매칭 결제가 이루어지고 있음을 다시 한 번 안내드립니다.</li>
                        <li>기타 사항은 세부규정 참고 및 담당 매니저에게 문의를 부탁드립니다.</li>
                    </ul>
                </div>
            </div>

            <div class="box01 mt50">
                <div class="box01_inner">
                    <div>
                        <div class="inner_01">
                            <p>
                                <img src="../icon/jh/individualmeeting.png" class="icon04">
                            </p>
                            <h4 class="title04 pink">개별 만남 방식</h4>
                        </div>
                    </div>
                    <div class="inner01_2">
                        <p>
                            <img src="../icon/jh/Arrow.png" class="icon05">
                        </p>
                    </div>
                    <div id="wrap">
                        <div class="card ml30">
                            <div class="card-front">
                                <p>
                                    <img src="../icon/jh/ApplicationStage.png" class="icon06">
                                </p>
                                <h4 class="title04 pink">신청 완료 단계</h4>
                            </div>
                            <div class="card-back">
                                <div class="text">
                                    <p class="ss_title mb20">신청 완료 단계</p>
                                    <ul class="s_text_list">
                                        <li>
                                            매칭 실패<br> → 
                                            <b>
                                                총 이용 금액의
                                                <span class="un_line">100% 환불</span>
                                            </b>
                                        </li>
                                        <li>
                                            매칭 완료 전 본인 취소<br> → 
                                            <b>
                                                총 이용 금액의
                                                <span class="un_line">70% 환불</span>
                                            </b>
                                        </li>
                                        <li>
                                            매칭 결과 확인 1일 전까지 취소<br> → 
                                            <b>
                                                총 이용 금액의
                                                <span class="un_line">60% 환불</span>
                                            </b>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="wrap">
                        <div class="card">
                            <div class="card-front">
                                <p>
                                    <img src="../icon/jh/Matchingcomplete.png" class="icon06">
                                </p>
                                <h4 class="title04 pink">매칭 완료 단계</h4>
                            </div>
                            <div class="card-back">
                                <div class="text">
                                    <p class="ss_title mb20">매칭 완료 단계</p>
                                    <ul class="s_text_list">
                                        <li>
                                            상대가 취소<br> → 
                                            <b>
                                                총 이용 금액의
                                                <span class="un_line">100% 환불</span>
                                            </b>
                                        </li>
                                        <li>
                                            본인 취소<br> → 
                                            <b>
                                                총 이용 금액 중
                                                <span class="un_line">만남 비용 환불</span>
                                            </b><br>
                                            → 
                                            <b>
                                                <span class="un_line">상대의 연락처 교환 전</span>
                                            </b>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box02_inner">
                    <ul class="text_list">
                        <li>취소는 마이페이지의 취소 클릭 시점으로 처리됩니다.</li>
                        <li>환불은 즉시 이루어지며 본인 과실이 있을 시 환불에 어려움이 생길 수 있습니다.</li>
                        <li>개별 만남 방식은 매니저 소개 방식과 다르게 추가 금액이 생기지 않습니다.</li>
                        <li>본 환불 규정은 1회 기준이며, 매칭이 이루어지는 부분이나 주의사항은 세부규정을 확인부탁드립니다.</li>
                        <li>저희 다온은 선불이 아닌 후불로 매칭 결제가 이루어지고 있음을 다시 한 번 안내드립니다.</li>
                        <li>기타 사항은 세부규정 참고 및 담당 매니저에게 문의를 부탁드립니다.</li>
                        <li>연락처 교환 후 취소 및 환불이 불가함을 알려드립니다.</li>
                        <li>상호 동의 후 연락처 교환이 이루어지며 서로 꼭 만나보시는 것이 기본 매너입니다.</li>
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