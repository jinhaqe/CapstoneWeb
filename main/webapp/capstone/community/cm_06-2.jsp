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
<link rel=stylesheet href="cm_06-2.css?after">
<link rel=stylesheet href="main.css">
<link rel="stylesheet" href="../cp_intro.css">
<script src="../cp_intro.js"></script>
<head>
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
                <li class="li_dropdown"><a href="cm_01-1a.jsp">커뮤니티</a>
                    <ul class="ul_border">
                        <li><a href="cm_01-1a.jsp">공지사항</a></li>
                        <li><a href="cm_02-a.jsp">FAQ</a></li>
                        <li><a href="cm_03-1a.jsp">Q&A</a></li>
                        <li><a href="cm_04-1a.jsp">자유게시판</a></li>
                        <li><a href="cm_05-1a.jsp">후기</a></li>
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
                <h5>회원가입</h5>
                <p>다온의 소중한 회원이 되어보세요!</p>
            </div>
        </div>      
    </div>
    <div class="agree_main">
        <div class="member_main">
            <div class="container">
                <h2 class="form_title">회원 등록
                    <p class="note">
                        <b class="nec">*</b>
                        필수 입력
                    </p></h2>
                <form method="post" action="joinAction.jsp">
                <div class="member_info">
                    <div class="con_box">
                        <dl>
                            <dt>아이디
                                <b class="nec">*</b>
                            </dt>
                            <dd><input name="userID" class="real_text"></dd>
                        </dl>
                        <dl>
                            <dt>비밀번호
                                <b class="nec">*</b>
                            </dt>
                            <dd><input type="password"name="userPW" class="real_text">
                            <span class="text_info">8~20자 / 공백없이 만들어주세요.</span></dd>
                        </dl>
                        <dl>
                            <dt>이름
                                <b class="nec">*</b>
                            </dt>
                            <dd><input name="userName" class="real_text"></dd>
                        </dl>
                        <dl>
                            <dt>성별
                                <b class="nec">*</b>
                            </dt>
                            <dd><input type="radio" name="userGender" value="여자" class="real_radio">여자
                            	<input type="radio" name="userGender" value="남자" class="real_radio">남자</dd>
                        </dl>
                        <dl>
                            <dt>이메일
                                <b class="nec">*</b>
                            </dt>
                            <dd>
                            	<input name="userEmail" class="real_email">
                            	<button onclick="submitForm()" type="button" class="btnChk">메일 인증</button>
                            </dd>
                            <script>
							    function submitForm() {
							        var email = document.querySelector('input[name="userEmail"]').value;
							        if (email) {
							            // 이메일 값이 있으면 폼 전송
							            var form = document.createElement('form');
							            form.action = 'mailGo.jsp';  // mailGo.jsp로 POST 요청
							            form.method = 'post';
							
							            // 이메일 값을 hidden 필드로 전송
							            var emailInput = document.createElement('input');
							            emailInput.type = 'hidden';
							            emailInput.name = 'userEmail';
							            emailInput.value = email;
							            form.appendChild(emailInput);
							
							            // 폼 제출
							            document.body.appendChild(form);
							            form.submit();  // 폼을 실제로 제출하여 mailGo.jsp로 전송
							            alert('인증 메일이 발송되었습니다. 메일함을 확인해주세요.');
							        } else {
							            alert('이메일을 입력해주세요.');
							        }
							    }
							</script>
                        </dl>
                        <dl>
                            <dt>인증번호 입력
                            </dt>
                            <dd>
						        <input name="inputCode" class="real_email">
						        <button onclick="submitAuthCode()" type="button" class="btnChk">인증</button>
						    </dd>
						    <script>
						        function submitAuthCode() {
						            var inputCode = document.querySelector('input[name="inputCode"]').value;
						            var email = document.querySelector('input[name="userEmail"]').value;
						            
						            if (inputCode && email) {
						                // 인증번호와 이메일 값이 있으면 폼 전송
						                var form = document.createElement('form');
						                form.action = 'authCodeCheck.jsp';  // authCodeCheck.jsp로 POST 요청
						                form.method = 'post';
						
						                // 이메일과 인증번호 값을 hidden 필드로 전송
						                var emailInput = document.createElement('input');
						                emailInput.type = 'hidden';
						                emailInput.name = 'userEmail';
						                emailInput.value = email;
						                form.appendChild(emailInput);
						
						                var codeInput = document.createElement('input');
						                codeInput.type = 'hidden';
						                codeInput.name = 'inputCode';
						                codeInput.value = inputCode;
						                form.appendChild(codeInput);
						
						                // 폼 제출
						                document.body.appendChild(form);
						                form.submit();  // 폼을 실제로 제출하여 authCodeCheck.jsp로 전송
						                alert('인증 요청이 완료되었습니다.');
						            } else {
						                alert('이메일과 인증번호를 입력해주세요.');
						            }
						        }
						    </script>
                        </dl>
                        <dl>
                            <dt>휴대번호
                                <b class="nec">*</b>
                            </dt>
                            <dd><input name="phone" class="real_text"></dd>
                        </dl>
                        <dl>
                            <dt>지역
                                <b class="nec">*</b>
                            </dt>
                            <dd><input name="addr" class="real_addr">
                                <span class="text_info">ex ) 경상남도 함안군</span></dd></dd></dd>
                        </dl>
                        <dl>
                            <dt>생년월일
                                <b class="nec">*</b>
                            </dt>
                            <dd><input name="bdate" class="real_text">
                                <span class="text_info">ex ) 021231</span></dd></dd>
                        </dl>
                    </div>
                    <div class="btn_warp">
                        <span class="btn_white"><a href="../cp_intro.jsp">취소</a></span>
                        <span class="btn_red"><input type="submit"  value="가입"></span>
                    </div>
                </div>
                </form>
            </div>
        </div>
    </div>
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
</body>
<script src="cm_06-2.js"></script>
</html>