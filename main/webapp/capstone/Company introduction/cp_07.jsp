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
    <link rel=stylesheet href="../cp_intro.css">
    <link rel=stylesheet href="cp_07.css">
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
                    <h5>합리적인 가격으로 회원님들의</h5>
                    <p>운명의 상대를 찾아드립니다!</p>
                </div>
            </div> 
            <div class="sub_tab">
                <div class="sub_tab_co">
                    <div class="sub_tab_in">
                        <a href="cp_06.jsp" class="bactive">이용절차</a><!--
                    --><a href="cp_07.jsp" class="active">이용금액</a><!--
                    --><a href="cp_08.jsp" class="bactive">매칭이용가이드</a><!--
                    --><a href="cp_09.jsp" class="bactive">세부규정</a><!--
                    --><a href="cp_10.jsp" class="bactive">환불규졍</a>
                    </div>
                </div>
            </div>       
        </div>
        <div class="body_Wrap">
            <p class="title02">
                이용금액
            </p>
            <h4 class="title03">개별 만남 1회 기준</h4>
            <div class="box01 mt50">
                <div class="box01_inner">
                    <div>
                        <div class="inner_01">
                            <p>
                                <img src="../icon/jh/Man.png" class="icon04">
                            </p>
                            <h4 class="title04 pink">남성</h4>
                        </div>
                    </div>
                    <div class="inner01_2">
                        <p>
                            <img src="../icon/dot2.png" class="icon05">
                        </p>
                    </div>
                    <div class="tablebox mg">
                        <table class="setting">
                            <colgroup>
                                <col width = 25%>
                                <col width = 25%>
                                <col width = 25%>
                                <col width = 25%>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="4" class="color mint">남성</th>
                                </tr>
                                <tr>
                                    <th class="gray">연령</th>
                                    <th class="gray">총 이용금액</th>
                                    <th class="gray">매칭 비용</th>
                                    <th class="gray">만남 비용</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <b>20 ~ 23</b>
                                    </td>
                                    <td>
                                        <span class="un_line">60,000원</span>
                                    </td>
                                    <td>
                                        <p>36,000원</p>
                                    </td>
                                    <td>
                                        <p>24,000원</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>24 ~ 26</b>
                                    </td>
                                    <td>
                                        <span class="un_line">65,000원</span>
                                    </td>
                                    <td>
                                        <p>39,000원</p>
                                    </td>
                                    <td>
                                        <p>26,000원</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>27 ~ 30</b>
                                    </td>
                                    <td>
                                        <span class="un_line">70,000원</span>
                                    </td>
                                    <td>
                                        <p>42,000원</p>
                                    </td>
                                    <td>
                                        <p>28,000원</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>31 ~ 33</b>
                                    </td>
                                    <td>
                                        <span class="un_line">75,000원</span>
                                    </td>
                                    <td>
                                        <p>45,000원</p>
                                    </td>
                                    <td>
                                        <p>30,000원</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>34 ~ 37</b>
                                    </td>
                                    <td>
                                        <span class="un_line">80,000원</span>
                                    </td>
                                    <td>
                                        <p>48,000원</p>
                                    </td>
                                    <td>
                                        <p>32,000원</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>38 ~ 40</b>
                                    </td>
                                    <td>
                                        <span class="un_line">85,000원</span>
                                    </td>
                                    <td>
                                        <p>51,000원</p>
                                    </td>
                                    <td>
                                        <p>34,000원</p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="box01 mt50">
                <div class="box01_inner">
                    <div>
                        <div class="inner_01">
                            <p>
                                <img src="../icon/jh/Woman.png" class="icon04">
                            </p>
                            <h4 class="title04 pink">여성</h4>
                        </div>
                    </div>
                    <div class="inner01_2">
                        <p>
                            <img src="../icon/dot2.png" class="icon05">
                        </p>
                    </div>
                    <div class="tablebox mg">
                        <table class="setting">
                            <colgroup>
                                <col width = 25%>
                                <col width = 25%>
                                <col width = 25%>
                                <col width = 25%>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="4" class="color pink01">여성</th>
                                </tr>
                                <tr>
                                    <th class="gray">연령</th>
                                    <th class="gray">총 이용금액</th>
                                    <th class="gray">매칭 비용</th>
                                    <th class="gray">만남 비용</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <b>20 ~ 23</b>
                                    </td>
                                    <td>
                                        <span class="un_line">35,000원</span>
                                    </td>
                                    <td>
                                        <p>21,000원</p>
                                    </td>
                                    <td>
                                        <p>14,000원</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>24 ~ 26</b>
                                    </td>
                                    <td>
                                        <span class="un_line">40,000원</span>
                                    </td>
                                    <td>
                                        <p>24,000원</p>
                                    </td>
                                    <td>
                                        <p>16,000원</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>27 ~ 30</b>
                                    </td>
                                    <td>
                                        <span class="un_line">45,000원</span>
                                    </td>
                                    <td>
                                        <p>27,000원</p>
                                    </td>
                                    <td>
                                        <p>18,000원</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>31 ~ 33</b>
                                    </td>
                                    <td>
                                        <span class="un_line">50,000원</span>
                                    </td>
                                    <td>
                                        <p>30,000원</p>
                                    </td>
                                    <td>
                                        <p>20,000원</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>34 ~ 37</b>
                                    </td>
                                    <td>
                                        <span class="un_line">55,000원</span>
                                    </td>
                                    <td>
                                        <p>33,000원</p>
                                    </td>
                                    <td>
                                        <p>22,000원</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <b>38 ~ 40</b>
                                    </td>
                                    <td>
                                        <span class="un_line">60,000원</span>
                                    </td>
                                    <td>
                                        <p>36,000원</p>
                                    </td>
                                    <td>
                                        <p>24,000원</p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="startbtn mt50">
                <a href="cp_09.jsp">세부 규정 확인하기</a>
            </div>
            <div class="guidebox mt50">
                <ul class="text_list">
                    <li>1 : 1 소개팅 하나만을 전문적으로 합니다.</li>
                    <li>가입비는 무료이며 부가세가 포함된 금액입니다.</li>
                    <li>만 나이가 아닌 기종의 세는 나이 기준입니다.</li>
                    <li>총 이용 금액(매칭 비용 + 만남 비용)을 매칭 완료 후 만남 성사 시 결제합니다.</li>
                    <li>현재 성비가 남자 : 여자 = 54 : 46 으로 여자 회원분의 금액이 저렴합니다.</li>
                    <li>위 표는 개별 만남 기준이며 매니저 소개 이용 시 만남 비용에만 만원이 추가됩니다.</li>
                    <li>만남 성공 시 사례비는 청구되지 않으며 후기 작성 & 매니저 후기 작성을 부탁드립니다.</li>
                </ul>
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