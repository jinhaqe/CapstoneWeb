package chat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
public class ChatDAO {
	private Connection conn; 
	private ResultSet rs;
	public ChatDAO() {
		try {
			String dbURL =  "jdbc:mysql://localhost:3306/cap?serverTimezone=UTC";
			String dbID = "root";
			String dbPW = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; 
	}
	
	public int sendMessage(String chatID, String userID, String chatContent) {
        String SQL = "INSERT INTO CHAT (chatNum, chatDate, userID, chatID, chatContent) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, 0);
            pstmt.setString(2, getDate());
            pstmt.setString(3, userID);
            pstmt.setString(4, chatID);
            pstmt.setString(5, chatContent);
            return pstmt.executeUpdate(); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 오류 발생 시 -1 반환
    }
	
	public ArrayList<Chat> getChatList(String chatID, String userID) {
        String SQL = "SELECT * FROM CHAT WHERE userID = ? and chatID = ? ORDER BY chatNum ASC";
        ArrayList<Chat> list = new ArrayList<Chat>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, chatID);
            pstmt.setString(2, userID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
            	Chat chat = new Chat();
                chat.setChatNum(rs.getInt(1));
                chat.setChatDate(rs.getString(2));
                chat.setUserID(rs.getString(3));
                chat.setChatID(rs.getString(4));
                chat.setChatContent(rs.getString(5));
                list.add(chat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

