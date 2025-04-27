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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <meta charset="UTF-8">
    <link rel=stylesheet href="../cp_intro.css">
    <link rel=stylesheet href="cp_02.css">
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
                    <h5>다온은 어디에 있는</h5>
                    <p>회사일까요?</p>
                </div>
            </div> 
            <div class="sub_tab">
                <div class="sub_tab_co">
                    <div class="sub_tab_in">
                        <a href="cp_01.jsp" class="bactive">회사소개</a><!--
                    --><a href="cp_02.jsp" class="active">지사소개</a><!--
                    --><a href="cp_03.jsp" class="bactive">팀소개</a><!--
                    --><a href="cp_04.jsp" class="bactive">CI소개</a><!--
                    --><a href="cp_05.jsp" class="bactive">오시는길</a>
                    </div>
                </div>
            </div>       
        </div>
        <div class="body_Wrap">
            <p class="title02">
                지사소개
            </p>
            <div class="info_container">
                <div class="info_list">
                    <ul class="tabss">
                        <li class="tab-link current" data-tab="tab-1">서울본사</li>
                        <li class="tab-link" data-tab="tab-2">대구지사</li>
                        <li class="tab-link" data-tab="tab-3">대전지사</li>
                        <li class="tab-link" data-tab="tab-4">부산지사</li>
                        <li class="tab-link" data-tab="tab-5">전주지사</li>
                        
                    </ul>
                    <div id="tab-1" class="tab-content current">
                        <ul>
                            <li>
                                <img src="../icon/company_img.png" class="com_p">
                            </li>
                        </ul>
                    </div>
                    <div id="tab-2" class="tab-content">
                        <ul>
                            <li>
                                <img src="../icon/se_img.png" class="com_p">
                            </li>
                        </ul>
                    </div>
                    <div id="tab-3" class="tab-content">
                        <ul>
                            <li>
                                <img src="../icon/jinha_img.png" class="com_p">
                            </li>
                        </ul>
                    </div>
                    <div id="tab-4" class="tab-content">
                        <ul>
                            <li>
                                <img src="../icon/yeehe_img.png" class="com_p">
                            </li>
                        </ul>
                    </div>
                    <div id="tab-5" class="tab-content">
                        <ul>
                            <li>
                                <img src="../icon/yesong_img.png" class="com_p">
                            </li>
                        </ul>
                    </div>
                </div>
                <script>
                    $(document).ready(function(){

                        $('ul.tabss li').click(function(){
                            var tab_id = $(this).attr('data-tab');

                            $('ul.tabss li').removeClass('current');
                            $('.tab-content').removeClass('current');

                            $(this).addClass('current');
                            $("#"+tab_id).addClass('current');
                        })
                    })
                </script>
            </div>
        </div>
        <div class="map-group">
            <div class="map">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d51665.105042874944!2d128.3754684486328!3d35.96973690000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3565e97aad586311%3A0x50274a542863fb22!2z7JiB7KeE7KCE66y464yA7ZWZ6rWQIOq4gOuhnOuyjOy6oO2NvOyKpA!5e0!3m2!1sko!2skr!4v1716567507690!5m2!1sko!2skr" width="100%" height="500" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>
            <div class="map-info">
                <strong class="ttle">다온 본사 오시는 길</strong>
                <dl class="call">
                    <dt>대표전화  :  </dt>
                    <dd>010-0000-0000</dd>
                </dl>
                <dl class="address">
                    <dt>주소  :  </dt>
                    <dd>경상북도 칠곡군 지천면 금송로 60</dd>
                </dl>
                <dl class="station">
                    <dt>교통  :  </dt>
                    <dd>셔틀버스 / 성서2번 버스</dd>
                </dl>
                <dl class="person">
                    <dt>담당자  :  </dt>
                    <dd>최혜원</dd>
                </dl>
                <dl class="mail">
                    <dt>전자메일  :  </dt>
                    <dd>daon24@naver.com</dd>
                </dl>
            </div>
            <div class="btn-bottom">
                <a href="https://map.kakao.com/?urlX=509208&urlY=1111786&urlLevel=3&itemId=1921916827&q=%EC%98%81%EC%A7%84%EC%A0%84%EB%AC%B8%EB%8C%80%ED%95%99%EA%B5%90%20%EA%B8%80%EB%A1%9C%EB%B2%8C%EC%BA%A0%ED%8D%BC%EC%8A%A4&srcid=1921916827&map_type=TYPE_MAP" target="_blank" class="btn1 btn-more1">자세히 길찾기</a>
            </div>
        </div>
        <div class="set3">
            <div class="conwrap">
                <div class="title001">다온 회사 정보</div>
                <div class="title002">다온에 물어보세요!</div>
                <ul>
                    <li class="mr8">
                        <a href="../community/cm_01-1a.jsp">
                            <div class="num">01</div>
                            <div class="ico"><img src="../icon/jh/Notice.png" class="ico-1"></div>
                            <dl>
                                <dt>공지사항</dt>
                                <dd>공지사항 확인하기</dd>
                            </dl>
                        </a>
                    </li>
                    <li class="mr8">
                        <a href="../Company introduction/cp_02.jsp">
                            <div class="num">02</div>
                            <div class="ico"><img src="../icon/jh/Location.png" class="ico-1"></div>
                            <dl>
                                <dt>회사 위치</dt>
                                <dd>다온 위치 확인하기</dd>
                            </dl>
                        </a>
                    </li>
                    <li class="mr8">
                        <a href="../community/cm_02-a.jsp">
                            <div class="num">03</div>
                            <div class="ico"><img src="../icon/jh/FAQ.png" class="ico-1"></div>
                            <dl>
                                <dt>F & Q</dt>
                                <dd>자주하는 질문 확인하기</dd>
                            </dl>
                        </a>
                    </li>
                    <li class="mr8">
                        <a href="../community/cm_03-1a.jsp">
                            <div class="num">04</div>
                            <div class="ico"><img src="../icon/jh/QA.png" class="ico-1"></div>
                            <dl>
                                <dt>Q & A</dt>
                                <dd>궁금한 내용 질문하기</dd>
                            </dl>
                        </a>
                    </li>
                    <li>
                        <a href="../Tip/Tip2.jsp">
                            <div class="num">05</div>
                            <div class="ico"><img src="../icon/jh/Party.png" class="ico-1"></div>
                            <dl>
                                <dt>이벤트 & 파티</dt>
                                <dd>새로운 인연을 만나보기</dd>
                            </dl>
                        </a>
                    </li>
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