<%@page import="user.User"%>
<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="profile.Profile"%>
<%@ page import="profile.ProfileDAO"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="session" /> 
<jsp:useBean id="profile" class="profile.Profile" scope="session" /> 
<jsp:setProperty name = "user" property = "userID" />
<jsp:setProperty name = "user" property = "userPW" />
<jsp:setProperty name="profile" property="p_age" param="p_age"/>
<jsp:setProperty name="profile" property="p_addr" param="p_addr"/>
<jsp:setProperty name="profile" property="p_addrDetail" param="p_addrDetail"/>
<jsp:setProperty name="profile" property="p_job" param="p_job"/>
<jsp:setProperty name="profile" property="p_jobDetail" param="p_jobDetail"/>
<jsp:setProperty name="profile" property="p_height" param="p_height"/>
<jsp:setProperty name="profile" property="p_blood" param="p_blood"/>
<jsp:setProperty name="profile" property="p_mbti" param="p_mbti"/>
<jsp:setProperty name="profile" property="p_character" param="p_character"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel=stylesheet href="../cp_intro.css">
    <link rel=stylesheet href="main.css">
    <script src="../cp_intro.js"></script>
    <link rel=stylesheet href="login.css">
    <link rel=stylesheet href="matchInfo2.css?after">
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
	                <a href="login.jsp">
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
	                <a href="logoutAction.jsp">
	                    <img class="img01" src="../icon/yh/Logout.png">
	                    <span>로그아웃</span>
	                </a>
	                <a href="myPage.jsp">
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
		    	<div class="DM_X" onclick="DM_X()"><img src="dmx.png"></div>
		        <div class="massIn">
		        <div id="chatMessages">
				</div>
		        </div>
		       	<form method="post" id="chatForm" action="dmPageAction.jsp"  enctype="multipart/form-data" accept-charset="UTF-8">
			        <div class="DM_go">
			            <textarea name="chatContent" id="chatContent" maxlength="50" required></textarea>
			            <input type="submit" class="next-btn" value="전송">
			        </div>
		        </form>
		    </div>
   	</div>
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
	        xhr.open('POST', 'dmPageAction.jsp', true);
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
		    xhr.open('GET', 'getMessages.jsp', true); // 메시지를 받아오는 페이지
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
	                <h5>프로필 작성</h5>
	                <p>나를 자유롭게 표현해보세요!</p>
	            </div>
	        </div>      
	    </div>
    <form method="post" action="matchInfoAction2.jsp" accept-charset="UTF-8">
        <div class="big1">
            <div id="gage">
                    <p id="pageText">STEP 2. 프로필 작성</p>
                    <div id="circle1">1</div>
                    <hr id="line">
                    <div id="circle2">2</div>
                    <hr id="line2">
                    <div id="circle3">3</div>
                    <hr id="line3">
                    <div id="circle4">4</div>
            </div>
            <div class="big3">
                <table>
                    <!--<tr>
                        <th>&nbsp;이름</th>
                        <td><input type="text" id="inText"></td>
                    </tr>
                    <tr>
                        <th>&nbsp;성별</th>
                        <td>
                            <input type="radio" name="gender" value="male" id="radio1"><label for="male" id="radioLabel">남성</label>
                            <input type="radio" name="gender" value="female" id="radio1"><label for="female" id="radioLabel">여성</label>
                        </td>
                    </tr>
                      -->
                    <tr>
                        <th>&nbsp;나이</th>
                        <td>
                            <input type="number" name="p_age" id="age">&nbsp;세
                        </td>
                    </tr>
                    <tr>
                        <th>&nbsp;생일</th>
                        <td>
                            <input type="number" name="month" id="month">&nbsp;월
                            <input type="number" name="day" id="day">&nbsp;일
                        </td>
                    </tr>
                    <tr>
                        <th>&nbsp;거주지역</th>
                        <td>
                            <select name="p_addr" id="area">
                                <option value="서울특별시">서울특별시</option>
                                <option value="부산광역시">부산광역시</option>
                                <option value="대구광역시">대구광역시</option>
                                <option value="인천광역시">인천광역시</option>
                                <option value="광주광역시">광주광역시</option>
                                <option value="대전광역시">대전광역시</option>
                                <option value="울산광역시">울산광역시</option>
                                <option value="세종특별자치시">세종특별자치시</option>
                                <option value="경기도">경기도</option>
                                <option value="강원특별자치도">강원특별자치도</option>
                                <option value="충청북도">충청북도</option>
                                <option value="충청남도">충청남도</option>
                                <option value="전북특별자치도">전북특별자치도</option>
                                <option value="전라남도">전라남도</option>
                                <option value="경상북도">경상북도</option>
                                <option value="경상남도">경상남도</option>
                                <option value="제주특별자치도">제주특별자치도</option>
                            </select>
                            <input type="text" name="p_addrDetail" id="areaT">
                        </td>
                    </tr>
                    <tr>
                        <th>&nbsp;직업</th>
                        <td>
                            <select name="p_job" id="job">
                                <option value="관리자(공공 기관 및 기업 고위직 등)">관리자(공공 기관 및 기업 고위직 등)</option>
                                <option value="전문가 및 관련 종사자">전문가 및 관련 종사자</option>
                                <option value="사무 종사자">사무 종사자</option>
                                <option value="서비스 종사자">서비스 종사자</option>
                                <option value="판매 종사자">판매 종사자</option>
                                <option value="농림 어업 숙련 종사자">농림 어업 숙련 종사자</option>
                                <option value="기능원 및 관련 기능 종사자">기능원 및 관련 기능 종사자</option>
                                <option value="장치, 기계 조작 및 조립 종사자">장치, 기계 조작 및 조립 종사자</option>
                                <option value="단순노무 종사자">단순노무 종사자</option>
                                <option value="군인">군인</option>
                            </select>
                            <input type="text" name="p_jobDetail" id="jobT">
                        </td>
                    </tr>
                    <tr>
                        <th>&nbsp;신장</th>
                        <td>
                            <input type="number" name="p_height" id="height">&nbsp;cm
                        </td>
                    </tr>
                    <tr>
                        <th>&nbsp;혈액형</th>
                        <td>
                            <input type="radio" name="p_blood" value="A" id="radio1"><label for="A" id="radioLabel">A형</label>
                            <input type="radio" name="p_blood" value="B" id="radio1"><label for="B" id="radioLabel">B형</label>
                            <input type="radio" name="p_blood" value="O" id="radio1"><label for="O" id="radioLabel">O형</label>
                            <input type="radio" name="p_blood" value="AB" id="radio1"><label for="AB" id="radioLabel">AB형</label>
                        </td>
                    </tr>
                    <tr>
                        <th>&nbsp;MBTI</th>
                        <td>
                                <input type="radio" name="p_mbti" value="ESTJ" id="check"><label for="ESTJ" id="Label">ESTJ</label>
                                <input type="radio" name="p_mbti" value="ESTP" id="check"><label for="ESTP" id="Label">ESTP</label>
                                <input type="radio" name="p_mbti" value="ESFJ" id="check"><label for="ESFJ" id="Label">ESFJ</label>
                                <input type="radio" name="p_mbti" value="ESFP" id="check"><label for="ESFP" id="Label">ESFP</label>
                                <input type="radio" name="p_mbti" value="ENTJ" id="check"><label for="ENTJ" id="Label">ENTJ</label>
                                <input type="radio" name="p_mbti" value="ENTP" id="check"><label for="ENTP" id="Label">ENTP</label>
                                <input type="radio" name="p_mbti" value="ENFJ" id="check"><label for="ENFJ" id="Label">ENFJ</label>
                                <input type="radio" name="p_mbti" value="ENFP" id="check"><label for="ENFP" id="Label">ENFP</label>
                                <input type="radio" name="p_mbti" value="ISTJ" id="check"><label for="ISTJ" id="Label">ISTJ</label>
                                <input type="radio" name="p_mbti" value="ISTP" id="check"><label for="ISTP" id="Label">ISTP</label>
                                <input type="radio" name="p_mbti" value="ISFJ" id="check"><label for="ISFJ" id="Label">ISFJ</label>
                                <input type="radio" name="p_mbti" value="ISFP" id="check"><label for="ISFP" id="Label">ISFP</label>
                                <input type="radio" name="p_mbti" value="INTJ" id="check"><label for="INTJ" id="Label">INTJ</label>
                                <input type="radio" name="p_mbti" value="INTP" id="check"><label for="INTP" id="Label">INTP</label>
                                <input type="radio" name="p_mbti" value="INFJ" id="check"><label for="INFJ" id="Label">INFJ</label>
                                <input type="radio" name="p_mbti" value="INFP" id="check"><label for="INFP" id="Label">INFP</label>
                                <input type="radio" name="p_mbti" value="dont" id="check"><label for="dont" id="Label">모름</label>
                        </td>
                    </tr>
                    <tr>
                        <th>&nbsp;나의 성격은?</th>
                        <td>
                                <input type="radio" name="p_character" value="터프한" id="check1"><label for="터프한" id="Label1">터프한</label>
                                <input type="radio" name="p_character" value="귀여운" id="check1"><label for="귀여운" id="Label1">귀여운</label>
                                <input type="radio" name="p_character" value="유머있는" id="check1"><label for="유머있는" id="Label1">유머있는</label>
                                <input type="radio" name="p_character" value="지적인" id="check1"><label for="지적인" id="Label1">지적인</label>
                                <input type="radio" name="p_character" value="유행민감한" id="check1"><label for="유행민감한" id="Label1">유행에민감한</label>
                                <input type="radio" name="p_character" value="착한" id="check1"><label for="착한" id="Label1">착한</label>
                                <input type="radio" name="p_character" value="듬직한" id="check1"><label for="듬직한" id="Label1">듬직한</label>
                                <input type="radio" name="p_character" value="성실한" id="check1"><label for="성실한" id="Label1">성실한</label>
                                <input type="radio" name="p_character" value="끈기있는" id="check1"><label for="끈기있는" id="Label1">끈기있는</label>
                                <input type="radio" name="p_character" value="도도한" id="check1"><label for="도도한" id="Label1">도도한</label>
                                <input type="radio" name="p_character" value="스포티한" id="check1"><label for="스포티한" id="Label1">스포티한</label>
                                <input type="radio" name="p_character" value="신중한" id="check1"><label for="신중한" id="Label1">신중한</label>
                                <input type="radio" name="p_character" value="섬세한" id="check1"><label for="섬세한" id="Label1">섬세한</label>
                                <input type="radio" name="p_character" value="창의적인" id="check1"><label for="창의적인" id="Label1">창의적인</label>
                                <input type="radio" name="p_character" value="상냥한" id="check1"><label for="상냥한" id="Label1">상냥한</label>
                                <input type="radio" name="p_character" value="대범한" id="check1"><label for="대범한" id="Label1">대범한</label>
                                <input type="radio" name="p_character" value="낙천적인" id="check1"><label for="낙천적인" id="Label1">낙천적인</label>
                                <input type="radio" name="p_character" value="열정적인" id="check1"><label for="열정적인" id="Label1">열정적인</label>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nextBack">
                <button class="before-btn" onclick="location.href='matchInfo.jsp'">&#10094; 이전</button>
                <input type="submit" class="next-btn" value="다음">
            </div>
            
        </div>
        </form>
    </div>
</body>
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
</html>