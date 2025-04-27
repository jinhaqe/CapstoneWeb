<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="chat.ChatDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="chat.Chat"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.util.Comparator"%>
<%
    // 세션에서 chatID와 userID 가져오기
    String chatID = (String) session.getAttribute("chatID");
    String userID = (String) session.getAttribute("userID");

    if (chatID == null || userID == null) {
	%>
	    <p>세션 정보가 없습니다. 로그인 후 다시 시도하세요.</p>
	<%
    } else {
        // 채팅 메시지 목록 가져오기
        ChatDAO chatDAO = new ChatDAO();
        ArrayList<Chat> list = chatDAO.getChatList(chatID, userID); // 내가 보낸 메시지
        ArrayList<Chat> list1 = chatDAO.getChatList(userID, chatID); // 상대방이 보낸 메시지

        // 두 리스트를 합침
        list.addAll(list1);

        // 채팅 메시지 번호(chatNum)를 기준으로 정렬 (오름차순)
        Collections.sort(list, new Comparator<Chat>() {
            public int compare(Chat c1, Chat c2) {
                return Integer.compare(c1.getChatNum(), c2.getChatNum());
            }
        });

        System.out.println("Total messages: " + list.size()); // 디버깅용 출력

        if (list.isEmpty()) {
		%>
		    <p>메시지가 없습니다.</p>
		<%
        } else {
            // 정렬된 리스트에서 메시지 출력
            for (Chat chat : list) {
                // 내가 보낸 메시지인지 확인
                if (chat.getUserID().equals(chatID)) {
				%>
				    <div class="DM_me">
				        <p><%= chat.getChatContent() %></p>
				    </div>
				<%
                } else { // 상대방이 보낸 메시지
				%>
				    <div class="DM_you">
				        <img src="profileImage/<%= chatID %>.jpg" alt="상대방 프로필">
				        <p><%= chat.getChatContent() %></p>
				    </div>
				<%
                }
            }
        }
    }
%>