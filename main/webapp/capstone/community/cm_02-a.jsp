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
<link rel=stylesheet href="cm_02-a.css?after">
<link rel=stylesheet href="../Company introduction/main.css">
<link rel="stylesheet" href="../cp_intro.css">
<script src="../cp_intro.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<head>
	<meta charset="UTF-8">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const faqBlocks = document.querySelectorAll('.faq_block');
    
            faqBlocks.forEach(faqBlock => {
                const faqHeader = faqBlock.querySelector('.faq_header');
                const faqBody = faqBlock.querySelector('.faq_body');
                const button = faqBlock.querySelector('.button');
    
                faqHeader.addEventListener('click', function() {
                    toggleFaqBody();
                });
    
                button.addEventListener('click', function(event) {
                    event.stopPropagation(); // 버튼 클릭 이벤트의 전파를 막음
                    toggleFaqBody();
                });
    
                function toggleFaqBody() {
                    if (faqBody.style.display === 'none' || !faqBody.style.display) {
                        faqBody.style.display = 'block';
                        button.classList.add('open');
                    } else {
                        faqBody.style.display = 'none';
                        button.classList.remove('open');
                    }
                }
            });

            const tabs = document.querySelectorAll('.box ul li div');
            const innerBodies = document.querySelectorAll('.inner_body ul');

            tabs.forEach((tab, index) => {
                tab.addEventListener('click', function() {
                    tabs.forEach(t => t.classList.remove('on'));
                    innerBodies.forEach(body => body.style.display = 'none');
                    
                    tab.classList.add('on');
                    innerBodies[index].style.display = 'block';
                });
            });

            tabs[0].classList.add('on');
            innerBodies[0].style.display = 'block';

        });
    </script>
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
                <h5>FAQ</h5>
                <p>자주 하시는 질문들을 모아놨습니다!</p>
            </div>
        </div> 
        <div class="sub_tab">
            <div class="sub_tab_co">
                <div class="sub_tab_in">
                    <a href="cm_01-1a.jsp" class="bactive">공지사항</a><!--
                    --><a href="cm_02-a.jsp" class="active">FAQ</a><!--
                    --><a href="cm_03-1a.jsp" class="bactive">Q&A</a><!--
                    --><a href="cm_04-1a.jsp" class="bactive">자유게시판</a><!--
                    --><a href="cm_05-1a.jsp" class="bactive">후기</a>
                </div>
            </div>
        </div>     
        <div class="board_wrap">
            <div class="board_title">
                <h6>FAQ</h6>
            </div>
        </div>
        <div class="box"> 
            <ul>
                <li>
                    <div class="on"><img src="../icon/jh/Choice.png">
                        전체
                    </div>
                </li>
                <li>
                    <div><img src="../icon/hw/Join.png">
                        가입
                    </div>
                </li>
                <li>
                    <div><img src="../icon/hw/Application.png">
                        신청
                    </div>
                </li>
                <li>
                    <div><img src="../icon/hw/Matching.png">
                        매칭
                    </div>
                </li>
                <li>
                    <div><img src="../icon/hw/Meeting.png">
                        만남
                    </div>
                </li>
                <li>
                    <div><img src="../icon/hw/Payment.png">
                        결제
                    </div>
                </li>
                <li>
                    <div><img src="../icon/hw/Warning.png">
                        경고
                    </div>
                </li>
                <li>
                    <div><img src="../icon/hw/Event.png">
                        이벤트
                    </div>
                </li>
            </ul>
        </div>
        <div class="inner_body">

            <ul>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>재가입 할 수 있나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>기존 아이디로 이용이 불가하고, 새로운 아이디 생성 후 이용이 가능합니다.</p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>직업 인증은 어떻게 하나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            근무지명(회사명, 소속기관, 상호)와 회원의 성함이 동시에 명확히 보여지는 전체 이미지를 회원가입시 업로드 해주시면 됩니다.
                            <br><br>
                            ⭕ 재직증명서, 명함, 사원증, 공무원증, 사업자등록증, 4대보험 가입확인서, 원천징수영수증 등 객관적으로 근무사실 확인이 가능한 이미지
                            ❌ 단순 자격증, 면허증, 유니폼 등 객관적으로 근무사실 확인이 불가능한 이미지
                            <br><br>
                            ※ 단, 대학원생 및 프리랜서(소속되어 있는 경우 인증필요)의 경우에는 학업 내용이나 업무 내용을 자기소개에 기재해주시고 학생증, 졸업증명서, 자격증, 면허증 등으로 인증이 가능합니다.   
                            <br><br>
                            ※ 여러 직업이 있는 경우 주수입원으로 인증을 부탁드립니다. (본업 회사원 및 부업 쇼핑몰 운영 시 본업인 회사원으로 인증 필요)  
                            <br><br>
                            ※ 정확한 직업인증 후 이용이 가능하며 직업인증 이미지는 매니저만 확인할 수 있고 상대에게는 보여지지 않으므로 개인정보에 대해서는 염려하지 않으셔도 좋습니다.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>신청 전 인증이 완료되어야 하나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            인증사항은 신청 건이 있는 회원에 대해서 확인이 이루어지므로 마이페이지에서 인증체크가 되어 있지 않은 경우라도 신청하시면 인증 확인됩니다.
                            <br>
                            다만, 인증서류를 모두 업로드 해주신 상태에서 신청해주셔야 합니다. 
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>하나의 장소에서 여러 소개가 동시에 이루어지나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            하나의 일정(매니저소개 방식)에 여러 소개가 있는 경우 사전에 연락을 드려 시간을 조정하여 서로 마주치는 불편한 일이 없도록 하고 있습니다.
                            <br>
                            이미 소개팅을 한 이성 상대가 비슷한 일정에 있는 경우에도 확인하여 절대 마주치지 않도록 하므로 걱정하지 않으셔도 좋습니다.
                            <br>
                            또한 기존에 매칭 이력이 있는 상대와는 서로 다시 추천되거나 매칭이 이루어지지 않습니다. 
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>동시에 여러 개의 소개팅을 신청해도 되나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            여러 건을 각각 신청하여 결제시 동시에 여러 만남의 진행도 가능합니다. 
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>일정을 변경할 수 있나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            신청완료 및 매칭완료 단계에서는 일정 변경이 불가능합니다.
                            <br><br>
                            신청 후 매칭이 이루어지기 전이라도 매니저의 업무(신청확인, 매칭일정 계획, 추천문자 대상 탐색, 추천문자 발송, 문의대응 등)가 이루어집니다. 또한 매니저소개의 경우 약속된 만남일로 소개 매니저 편성 및 상대이성
                            또한 일정을 비워두고 만남을 준비하시는 것이기 때문에 일정 변경은 어렵습니다. 부득이하게 일정이 어려우신 경우에는 가능한 빠른 취소 부탁드립니다. 시점별/단계별 수수료가 차등 적용되며 취소클릭 즉시 상대에게
                            도 취소 안내 문자가 자동 발송됩니다.
                            <br><br>
                            ※ 입금필요 단계는 매니저의 업무진행 전으로 취소시 수수료가 발생하지 않습니다.
                            <br><br>
                            ※ 취소는 마이페이지의 취소클릭 시점으로 처리됩니다.
                            <br><br>
                            ※ 자세한 내용은 이용안내 페이지를 참고해주세요. 
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>지방도 이용 가능한가요??</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            6년차 소개팅 전문 회사로 지방에도 많은 회원분들이 이용하고 계시며 이용 가능합니다.
                            <br>
                            지방의 경우 일부 광역시 중심으로 평일에만 매니저소개 일정이 편성되어 있어, 매니저소개(일정으로 신청)보다는 개별만남(연락처 교환 후 두 분께서 일정을 조율하여 만남)으로 신청시 더욱 매칭률이 높습니다.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>매칭은 어떻게 이루어지나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            1) 무료 회원가입<br>
                            - 홈페이지 상단의 회원가입을 통해 다온의 회원이 되어주세요!<br>
                            - 휴대폰 본인 인증 및 회원가입 후 프로필을 꼼꼼하게 작성해주세요.
                            <br><br>
                            2) 매니저 선택 및 신청<br>
                            - 원하는 매니저에게 연락을 해주세요!<br>
                            - 매니저가 회원님의 프로필을 확인한 후 수정 또는 보완 필요시 피드백 문자가 발송됩니다.<br>
                            - 만남 장소에서 직접 소개 & 개별 만남 선택 가능<br>
                            - 일정에 따라 매니저에 의한 매칭 진행(필요시 일정 조율)<br>
                            - 빠른 선택 및 매니저와의 원활한 소통을 통하면 매칭이 빠르게 진행될 가능성이 높습니다.
                            <br><br>
                            3) 매칭 완료<br>
                            - 매칭 완료 시 마이페이지 및 담당매니저의 카톡 연락으로 알림이 발송됩니다.<br>
                            - 선택 옵션 및 나의 취향을 100% 만족하여 원하는 이성과의 만남을 가질 수 있습니다.<br>
                            - 상대와의 매칭이 확정된 후 사진이 있는 서로의 프로필을 확인하실 수 있습니다.
                            <br><br>
                            4) 매칭 결과 확인 & 상대 프로필 확인<br>
                            - 나와의 만남을 원하는 이성 회원의 프로필을 마이페이지에서 확인해주세요.<br>
                            - 회원 본인이 신청 시 선별적으로 공개하실 수 있습니다.
                            <br><br>
                            5) 결제<br>
                            - 상대와의 만남이 확정(희망)된 후 결제를 받습니다.<br>
                            - 저희 다온은 선불이 아닌 회원님의 만족을 극대화하기 위한 후불제로 운영되고 있습니다.
                            <br><br>
                            6) 만남 성사<br>
                            - 매니저 만남 & 개별만남을 통해 상대와의 만남을 가집니다.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>매칭결과는 언제 알 수 있나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            ◑개별만남<br>
                            결제일 기준 4일 후 오후 3시 <br>
                            예) 월요일 개별만남 신청 및 결제<br>
                            → 금요일 오후 3시 결과 확인
                            <br><br>
                            ◑매니저소개<br>
                            만남일 기준 2일 전 오후 3시<br>
                            예) 토요일 사이트 일정으로 신청 및 결제<br>
                            → 목요일 오후 3시 결과 확인
                            <br><br>
                            상황에 따라 더 빠른 결과 확인이 가능한 경우도 있으며 매칭결과 확정 시 회원님께 자동 안내 문자가 발송됨<br>
                            매칭이 되었을 경우 상대 프로필 확인은 마이페이지에서 확인(확인 가능 프로필 항목은 회원가입 페이지 참고) 가능<br>
                            매칭이 이루어지지 않을 수 있으며, 이러한 경우 100% 환불
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>
                                매칭 후 사진이나 다른 정보를 확인할 수 있나요?
                            </p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            <매칭완료 단계에서 자동 공개됨><br>
                            성별, 나이, 직종, 직업, 고용형태, 학과, 졸업여부, 신장, 취미, 종교, 혈액형, 흡연여부, 혼인정보, 자기소개
                            <br><br>
                            <매칭완료 단계에서 본인 설정에 따라 공개됨><br>
                            학교명, 직장명<br>
                            → 회원이 비공개 설정시 상대에게 아래와 같이 소개됨<br>
                            ex) 수도권 대학, 지방거점국립대학, 초대졸<br>
                            반도체 대기업, 종합병원, 공공기관 등
                            <br><br>
                            <매칭완료 단계에서 상호 설정에 따라 공개됨><br>
                            사진<br>
                            → 사진은 민감한 개인정보로 남녀 모두<br>
                            사진공개를 "공개"로 설정한 경우에만<br>
                            매칭완료 후 동시에 서로 확인 가능하며,<br>
                            한 쪽이라도 "비공개" 설정시 상호 보여지지 않음
                            <br><br>
                            ※ 매칭완료 단계에서 상대 프로필 확인은 마이페이지에서 가능<br>
                            ※ 가입 후에도 회원정보는 동의없이 이성에게 공개되지 않음 (신청시에만 추천문자의 형태로 선별적 공개)
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>
                                매칭 후 상대가 마음에 들지 않는 경우 어떻게 해야하나요?
                            </p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            매칭 후 상대가 마음에 들지 않는 경우 마이페이지에서 취소가 가능합니다.
                            <br><br>
                            가입비가 무료인 상태에서 신청 후 매칭까지는 평균 2시간의 매니저의 선매칭 업무(신청확인, 매칭일정 수립, 이상형 탐색, 시간차를 두고 이성 회원들에게 
                            추천문자 발송, 문의대응 등)가 이루어지므로 매칭완료 단계에서 취소시에는 매칭비용(자세한 내용은 이용안내-환불규정 참고)이 발생합니다.
                            <br><br>
                            ※ 신청시 신청자 옵션 선택사항을 100% 만족하며 거리 가이드라인을 충족하는 이성에게만 추천문자가 발송되어 매칭이 진행됩니다.
                            <br><br>
                            ※ 매칭은 상대 이성들이 신청자를 판단하여 공정하게 이루어지는 방식입니다.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>
                                매칭 전 상대의 정보를 알 수 있나요?
                            </p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            신청 시 나와 만남을 원하는 이성회원 1명을 찾아드리는 방식으로 매칭 후 상대의 정보를 확인하실 수 있습니다.
                            <br>
                            메이트 포토 인터뷰를 통해 어떤 회원님들이 있는지 확인하실 수 있습니다.(공개 허용한 회원 한정으로)
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>
                                상대의 지역은 어떻게 정해지나요?
                            </p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            신청 시 아래의 조건을 만족하는 이성에게만 추천문자가 발송됩니다.
                            <br><br>
                            매칭거리 기준은 상호 거주지 및 근무지를 고려(거주지~거주지, 거주지~근무지, 근무지~거주지, 근무지~근무지 중 가장 가까운 곳)하여 
                            한 쪽이라도 차량을 소유한 경우 차량이동 기준 모두 차량이 없는 경우 대중교통 기준 최대 1시간 내외입니다.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>
                                1 : 1 소개팅인가요? 미팅인가요?
                            </p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            6년차의 1:1 소개팅 전문 서비스입니다.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>
                                신용카드로 결제할 수 있나요?
                            </p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            소개팅의 경우 신용카드 결제(전자결제 설치의 제한 업종으로 분류)가 어려우며 사업장 전용 계좌로의 입금만 가능합니다.
                            <br>
                            ※ 구글 자체 결제를 사용하는 소개팅 어플과는 다르게 사이트 기반의 서비스입니다.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>
                                결제기한 및 입금확인에 대해서 알려주세요.
                            </p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            다온은 선불제가 아닌 후불제로 운영되고 있습니다.
                            <br>
                            입금 및 결제가 매칭이 성사된 후 만남의 시간 직전에 이루어집니다.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>
                                이용 불가 대상 회원님에 대해 알려드립니다.
                            </p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            1) 추천 알림을 수신하여 만남 의사 말씀 후 의사 번복 또는 4시간 이상 결제없이 연락이 두절되는 경우<br>
                            - 불필요한 업무 및 신청자의 매칭 시간이 줄어 상대 이성에게 피해가 발생합니다.<br>
                            - (만남 의사 말씀이 아닌 단순 문의는 괜찮습니다.)
                            <br><br>
                            2) 매니저 소개 시 반복적인 지각
                            <br><br>
                            3) 매니저와 대화 / 연락 시 예절에 어긋나는 언행, 진중하지 않은 태도
                            <br><br>
                            4) 회원의 프로필 기재 사항이 사실과 다른 경우<br>
                            - 허위 기재 시 법적 책임이 있습니다.
                            <br><br>
                            5) 개별 만남 연락 두절 / 만남 시 비매너 언행
                            <br><br>
                            6) 그 외 서비스 제공이 어렵다고 판단되는 경우
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>
                                다온에는 어떤 이벤트/파티가 진행되고 있나요?
                            </p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            다온에서는 정기적으로 오프라인 파티가 진행되고 있습니다.<br>
                            다양한 파티에 참여하셔서 나만의 인연과 추억도 쌓고 즐거운 시간도 보낼 수 있습니다!
                        </p>
                    </div>
                </li>
            </ul>

            <ul>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>재가입 할 수 있나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>기존 아이디로 이용이 불가하고, 새로운 아이디 생성 후 이용이 가능합니다.</p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>직업 인증은 어떻게 하나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            근무지명(회사명, 소속기관, 상호)와 회원의 성함이 동시에 명확히 보여지는 전체 이미지를 회원가입시 업로드 해주시면 됩니다.
                            <br><br>
                            ⭕ 재직증명서, 명함, 사원증, 공무원증, 사업자등록증, 4대보험 가입확인서, 원천징수영수증 등 객관적으로 근무사실 확인이 가능한 이미지
                            ❌ 단순 자격증, 면허증, 유니폼 등 객관적으로 근무사실 확인이 불가능한 이미지
                            <br><br>
                            ※ 단, 대학원생 및 프리랜서(소속되어 있는 경우 인증필요)의 경우에는 학업 내용이나 업무 내용을 자기소개에 기재해주시고 학생증, 졸업증명서, 자격증, 면허증 등으로 인증이 가능합니다.   
                            <br><br>
                            ※ 여러 직업이 있는 경우 주수입원으로 인증을 부탁드립니다. (본업 회사원 및 부업 쇼핑몰 운영 시 본업인 회사원으로 인증 필요)  
                            <br><br>
                            ※ 정확한 직업인증 후 이용이 가능하며 직업인증 이미지는 매니저만 확인할 수 있고 상대에게는 보여지지 않으므로 개인정보에 대해서는 염려하지 않으셔도 좋습니다.
                        </p>
                    </div>
                </li>
            </ul>

            <ul>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>신청 전 인증이 완료되어야 하나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            인증사항은 신청 건이 있는 회원에 대해서 확인이 이루어지므로 마이페이지에서 인증체크가 되어 있지 않은 경우라도 신청하시면 인증 확인됩니다.
                            <br>
                            다만, 인증서류를 모두 업로드 해주신 상태에서 신청해주셔야 합니다.  
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>하나의 장소에서 여러 소개가 동시에 이루어지나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            하나의 일정(매니저소개 방식)에 여러 소개가 있는 경우 사전에 연락을 드려 시간을 조정하여 서로 마주치는 불편한 일이 없도록 하고 있습니다.
                            <br>
                            이미 소개팅을 한 이성 상대가 비슷한 일정에 있는 경우에도 확인하여 절대 마주치지 않도록 하므로 걱정하지 않으셔도 좋습니다.
                            <br>
                            또한 기존에 매칭 이력이 있는 상대와는 서로 다시 추천되거나 매칭이 이루어지지 않습니다. 
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>개별만남과 매니저 소개의 차이는 무엇인가요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            매니저소개는 신청 장소에서 매니저가 직접 소개해드리는 방식이며 개별만남은 연락처 교환 후 두 분께서 원하시는 일정으로 자유롭게 조율하여 만나는 방식으로 매칭방법은 동일합니다.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>동시에 여러 개의 소개팅을 신청해도 되나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            여러 건을 각각 신청하여 결제시 동시에 여러 만남의 진행도 가능합니다. 
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>일정을 변경할 수 있나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            신청완료 및 매칭완료 단계에서는 일정 변경이 불가능합니다.
                            <br><br>
                            신청 후 매칭이 이루어지기 전이라도 매니저의 업무(신청확인, 매칭일정 계획, 추천문자 대상 탐색, 추천문자 발송, 문의대응 등)가 이루어집니다. 또한 매니저소개의 경우 약속된 만남일로 소개 매니저 편성 및 상대이성
                            또한 일정을 비워두고 만남을 준비하시는 것이기 때문에 일정 변경은 어렵습니다. 부득이하게 일정이 어려우신 경우에는 가능한 빠른 취소 부탁드립니다. 시점별/단계별 수수료가 차등 적용되며 취소클릭 즉시 상대에게
                            도 취소 안내 문자가 자동 발송됩니다.
                            <br><br>
                            ※ 입금필요 단계는 매니저의 업무진행 전으로 취소시 수수료가 발생하지 않습니다.
                            <br><br>
                            ※ 취소는 마이페이지의 취소클릭 시점으로 처리됩니다.
                            <br><br>
                            ※ 자세한 내용은 이용안내 페이지를 참고해주세요.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>지방도 이용 가능한가요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            6년차 소개팅 전문 회사로 지방에도 많은 회원분들이 이용하고 계시며 이용 가능합니다.
                            <br>
                            지방의 경우 일부 광역시 중심으로 평일에만 매니저소개 일정이 편성되어 있어, 매니저소개(일정으로 신청)보다는 개별만남(연락처 교환 후 두 분께서 일정을 조율하여 만남)으로 신청시 더욱 매칭률이 높습니다.
                        </p>
                    </div>
                </li>
            </ul>

            <ul>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>매칭은 어떻게 이루어지나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            1) 무료 회원가입<br>
                            - 홈페이지 상단의 회원가입을 통해 다온의 회원이 되어주세요!<br>
                            - 휴대폰 본인 인증 및 회원가입 후 프로필을 꼼꼼하게 작성해주세요.
                            <br><br>
                            2) 매니저 선택 및 신청<br>
                            - 원하는 매니저에게 연락을 해주세요!<br>
                            - 매니저가 회원님의 프로필을 확인한 후 수정 또는 보완 필요시 피드백 문자가 발송됩니다.<br>
                            - 만남 장소에서 직접 소개 & 개별 만남 선택 가능<br>
                            - 일정에 따라 매니저에 의한 매칭 진행(필요시 일정 조율)<br>
                            - 빠른 선택 및 매니저와의 원활한 소통을 통하면 매칭이 빠르게 진행될 가능성이 높습니다.
                            <br><br>
                            3) 매칭 완료<br>
                            - 매칭 완료 시 마이페이지 및 담당매니저의 카톡 연락으로 알림이 발송됩니다.<br>
                            - 선택 옵션 및 나의 취향을 100% 만족하여 원하는 이성과의 만남을 가질 수 있습니다.<br>
                            - 상대와의 매칭이 확정된 후 사진이 있는 서로의 프로필을 확인하실 수 있습니다.
                            <br><br>
                            4) 매칭 결과 확인 & 상대 프로필 확인<br>
                            - 나와의 만남을 원하는 이성 회원의 프로필을 마이페이지에서 확인해주세요.<br>
                            - 회원 본인이 신청 시 선별적으로 공개하실 수 있습니다.
                            <br><br>
                            5) 결제<br>
                            - 상대와의 만남이 확정(희망)된 후 결제를 받습니다.<br>
                            - 저희 다온은 선불이 아닌 회원님의 만족을 극대화하기 위한 후불제로 운영되고 있습니다.
                            <br><br>
                            6) 만남 성사<br>
                            - 매니저 만남 & 개별만남을 통해 상대와의 만남을 가집니다.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>매칭결과는 언제 알 수 있나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            ◑개별만남<br>
                            결제일 기준 4일 후 오후 3시 <br>
                            예) 월요일 개별만남 신청 및 결제<br>
                            → 금요일 오후 3시 결과 확인
                            <br><br>
                            ◑매니저소개<br>
                            만남일 기준 2일 전 오후 3시<br>
                            예) 토요일 사이트 일정으로 신청 및 결제<br>
                            → 목요일 오후 3시 결과 확인
                            <br><br>
                            상황에 따라 더 빠른 결과 확인이 가능한 경우도 있으며 매칭결과 확정 시 회원님께 자동 안내 문자가 발송됨<br>
                            매칭이 되었을 경우 상대 프로필 확인은 마이페이지에서 확인(확인 가능 프로필 항목은 회원가입 페이지 참고) 가능<br>
                            매칭이 이루어지지 않을 수 있으며, 이러한 경우 100% 환불
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>매칭 후 사진이나 다른 정보를 확인할 수 있나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            <매칭완료 단계에서 자동 공개됨><br>
                            성별, 나이, 직종, 직업, 고용형태, 학과, 졸업여부, 신장, 취미, 종교, 혈액형, 흡연여부, 혼인정보, 자기소개
                            <br><br>
                            <매칭완료 단계에서 본인 설정에 따라 공개됨><br>
                            학교명, 직장명<br>
                            → 회원이 비공개 설정시 상대에게 아래와 같이 소개됨<br>
                            ex) 수도권 대학, 지방거점국립대학, 초대졸<br>
                            반도체 대기업, 종합병원, 공공기관 등
                            <br><br>
                            <매칭완료 단계에서 상호 설정에 따라 공개됨><br>
                            사진<br>
                            → 사진은 민감한 개인정보로 남녀 모두<br>
                            사진공개를 "공개"로 설정한 경우에만<br>
                            매칭완료 후 동시에 서로 확인 가능하며,<br>
                            한 쪽이라도 "비공개" 설정시 상호 보여지지 않음
                            <br><br>
                            ※ 매칭완료 단계에서 상대 프로필 확인은 마이페이지에서 가능<br>
                            ※ 가입 후에도 회원정보는 동의없이 이성에게 공개되지 않음 (신청시에만 추천문자의 형태로 선별적 공개)
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>매칭 후 상대가 마음에 들지 않는 경우 어떻게 해야하나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            매칭 후 상대가 마음에 들지 않는 경우 마이페이지에서 취소가 가능합니다.
                            <br><br>
                            가입비가 무료인 상태에서 신청 후 매칭까지는 평균 2시간의 매니저의 선매칭 업무(신청확인, 매칭일정 수립, 이상형 탐색, 시간차를 두고 이성 회원들에게 
                            추천문자 발송, 문의대응 등)가 이루어지므로 매칭완료 단계에서 취소시에는 매칭비용(자세한 내용은 이용안내-환불규정 참고)이 발생합니다.
                            <br><br>
                            ※ 신청시 신청자 옵션 선택사항을 100% 만족하며 거리 가이드라인을 충족하는 이성에게만 추천문자가 발송되어 매칭이 진행됩니다.
                            <br><br>
                            ※ 매칭은 상대 이성들이 신청자를 판단하여 공정하게 이루어지는 방식입니다.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>매칭 전 상대의 정보를 알 수 있나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            신청 시 나와 만남을 원하는 이성회원 1명을 찾아드리는 방식으로 매칭 후 상대의 정보를 확인하실 수 있습니다.
                            <br>
                            메이트 포토 인터뷰를 통해 어떤 회원님들이 있는지 확인하실 수 있습니다.(공개 허용한 회원 한정으로)
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>상대의 지역은 어떻게 정해지나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            신청 시 아래의 조건을 만족하는 이성에게만 추천문자가 발송됩니다.
                            <br><br>
                            매칭거리 기준은 상호 거주지 및 근무지를 고려(거주지~거주지, 거주지~근무지, 근무지~거주지, 근무지~근무지 중 가장 가까운 곳)하여 
                            한 쪽이라도 차량을 소유한 경우 차량이동 기준 모두 차량이 없는 경우 대중교통 기준 최대 1시간 내외입니다.
                        </p>
                    </div>
                </li>
            </ul>

            <ul>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>1 : 1 소개팅인가요? 미팅인가요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            6년차의 1:1 소개팅 전문 서비스입니다.
                        </p>
                    </div>
                </li>
            </ul>

            <ul>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>신용카드로 결제할 수 있나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            소개팅의 경우 신용카드 결제(전자결제 설치의 제한 업종으로 분류)가 어려우며 사업장 전용 계좌로의 입금만 가능합니다.
                            <br>
                            ※ 구글 자체 결제를 사용하는 소개팅 어플과는 다르게 사이트 기반의 서비스입니다.
                        </p>
                    </div>
                </li>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>결제기한 및 입금확인에 대해서 알려주세요.</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            다온은 선불제가 아닌 후불제로 운영되고 있습니다.
                            <br>
                            입금 및 결제가 매칭이 성사된 후 만남의 시간 직전에 이루어집니다.
                        </p>
                    </div>
                </li>
            </ul>

            <ul>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>이용 불가 대상 회원님에 대해 알려드립니다.</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            1) 추천 알림을 수신하여 만남 의사 말씀 후 의사 번복 또는 4시간 이상 결제없이 연락이 두절되는 경우<br>
                            - 불필요한 업무 및 신청자의 매칭 시간이 줄어 상대 이성에게 피해가 발생합니다.<br>
                            - (만남 의사 말씀이 아닌 단순 문의는 괜찮습니다.)
                            <br><br>
                            2) 매니저 소개 시 반복적인 지각
                            <br><br>
                            3) 매니저와 대화 / 연락 시 예절에 어긋나는 언행, 진중하지 않은 태도
                            <br><br>
                            4) 회원의 프로필 기재 사항이 사실과 다른 경우<br>
                            - 허위 기재 시 법적 책임이 있습니다.
                            <br><br>
                            5) 개별 만남 연락 두절 / 만남 시 비매너 언행
                            <br><br>
                            6) 그 외 서비스 제공이 어렵다고 판단되는 경우
                        </p>
                    </div>
                </li>
            </ul>

            <ul>
                <li class="faq_block js-faq_block">
                    <div class="faq_item">
                       <div class="faq_header">
                            <h3>Q</h3>
                            <p>다온에는 어떤 이벤트/파티가 진행되고 있나요?</p>
                            <button class="button">&#9660;   </button>
                       </div>
                    </div> 
                    <div class="faq_body">
                        <p>
                            다온에서는 정기적으로 오프라인 파티가 진행되고 있습니다.<br>
                            다양한 파티에 참여하셔서 나만의 인연과 추억도 쌓고 즐거운 시간도 보낼 수 있습니다!
                        </p>
                    </div>
                </li>
            </ul>
        </div>
        <div class="foot_container">
            <div class="foot_list">
                <ul class="tabs">
                    <li class="tab-link current" data-tab="tab-1">NEWS</li>
                    <li class="tab-link" data-tab="tab-2">REAL후기</li>
                    <li class="tab-link" data-tab="tab-3">이벤트/파티 <span class="new">N</span></li>
                    <li class="tab-link" data-tab="tab-4">연애이야기 <span class="new">N</span></li>
                </ul>
                <div id="tab-1" class="tab-content current">
                    <a href="../Tip/Tip3.jsp" class="more_btn">+</a>
                    <ul>
                        <li>
                            <a href="">
                                <span class="tle">다온의 소개를 확인해보세요.</span>
                                <span class="date">2024.05.10</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">5월 휴무 안내</span>
                                <span class="date">2024.05.01</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">4월 10일 휴무 안내</span>
                                <span class="date">2024.04.09</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">봄맞이 봄이왔나봄 리뷰이벤트(기간연장!)</span>
                                <span class="date">2024.04.03</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">2023년도 3월 16일 두근두근 로테이션파티 파티 스케치 ♥ </span>
                                <span class="date">2024.03.18</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div id="tab-2" class="tab-content">
                    <a href="cm_05-1a.jsp" class="more_btn">+</a>
                    <ul>
                        <li>
                            <a href="">
                                <span class="tle">기적같은 만남 다온은 후회없는 선택이었어요</span>
                                <span class="date">2024.05.14</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">교제를 하게 되면서 후기입니다!</span>
                                <span class="date">2024.05.03</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">좋은 인연을 만나게 되어 감사합니다.</span>
                                <span class="date">2024.05.02</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">만남을 가질수 있게 주선해주신 매니저님께 감사를 표합니다.</span>
                                <span class="date">2024.04.22</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">하루 또 하루가 늘 행복합니다 :)</span>
                                <span class="date">2024.04.22</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div id="tab-3" class="tab-content">
                    <a href="../Tip/Tip2.jsp" class="more_btn">+</a>
                    <ul>
                        <li>
                            <a href="">
                                <span class="tle">24년도 3월 봄맞이 두근두근 로테이션 파티</span>
                                <span class="date">2024.03.02</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">9월 두근두근 로테이션 파티</span>
                                <span class="date">2023.09.01</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">6월 다온 홀리데이 파티</span>
                                <span class="date">2023.06.10</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">5월의 오프라인 로테이션 파티!</span>
                                <span class="date">2023.05.13</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">영화시사회 '아이 스틸 빌리브' 초대</span>
                                <span class="date">2023.03.11</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div id="tab-4" class="tab-content">
                    <a href="../Tip/Tip4.jsp" class="more_btn">+</a>
                    <ul>
                        <li>
                            <a href="">
                                <span class="tle">소개팅을 꼭 해야 하나요?</span>
                                <span class="date">2024.05.16</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">저는 왜 아직도 싱글일까요?</span>
                                <span class="date">2024.05.09</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">호감 가는 첫 인상을 만드는 7가지 법칙</span>
                                <span class="date">2024.05.02</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">콩깍지가 벗겨지는 순간</span>
                                <span class="date">2023.05.13</span>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <span class="tle">같은 크리스천을 만나야 하는 이유</span>
                                <span class="date">2024.02.21</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <script>
                $(document).ready(function(){

                    $('ul.tabs li').click(function(){
                        var tab_id = $(this).attr('data-tab');

                        $('ul.tabs li').removeClass('current');
                        $('.tab-content').removeClass('current');

                        $(this).addClass('current');
                        $("#"+tab_id).addClass('current');
                    })
                })
            </script>
            <div class="section">
                <input type="radio" name="slide" id="slide01" checked>
                <input type="radio" name="slide" id="slide02">
                <input type="radio" name="slide" id="slide03">
                <input type="radio" name="slide" id="slide04">
                <input type="radio" name="slide" id="slide05">

                <div class="slidewrap">
                    <ul class="slidelist">
                        <li>
                            <a>                                    
                                <label for="slide05" class="left"></label>
                                <a href=""><img src="../icon/img01.jpg" class="size"></a>
                                <label for="slide02" class="right"></label>
                                <em class="sam1">다온뉴스</em>
                            </a>
                            <span class="tlle">&nbsp;봄맞이 봄이왔나봄 리뷰이벤트(기간연장!)</span>
                        </li>
                        <li>
                            <a>
                                <label for="slide01" class="left"></label>
                                <a href=""><img src="../icon/img02.jpg" class="size"></a>
                                <label for="slide03" class="right"></label>
                                <em class="sam1">REAL후기</em>
                            </a>
                            <span class="tlle">&nbsp;♡연애♡ 5월에 연애라니 행복해요 >.< </span>
                        </li>
                        <li>
                            <a>
                                <label for="slide02" class="left"></label>
                                <a href=""><img src="../icon/img03.jpg" class="size"></a>
                                <label for="slide04" class="right"></label>
                                <em class="sam1">REAL후기</em>
                            </a>
                            <span class="tlle">&nbsp;올해 1월에 연애 시작했어요~!! ლ(╹◡╹ლ) </span>
                        </li>
                        <li>
                            <a>
                                <label for="slide03" class="left"></label>
                                <a href=""><img src="../icon/img04.jpg" class="size"></a>
                                <label for="slide05" class="right"></label>
                                <em class="sam1">이벤트/파티</em>
                            </a>
                            <span class="tlle">&nbsp;다온에서 나만의 인연을! 행복한 PARTY</span>
                        </li>
                        <li>
                            <a>
                                <label for="slide04" class="left"></label>
                                <a href=""><img src="../icon/img05.jpg" class="size"></a>
                                <label for="slide01" class="right"></label>
                                <em class="sam1">연애이야기</em>
                            </a>
                            <span class="tlle">&nbsp;호감 가는 첫 인상을 만드는 7가지 법칙</span>
                        </li>
                    </ul>
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
</html>