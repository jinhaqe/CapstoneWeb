package user;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {
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
	public boolean isAdmin(String userID) throws SQLException {
        String SQL = "SELECT admin FROM USER WHERE userID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, userID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int adminValue = rs.getInt("admin");
                    return adminValue == 1;
                }
            }
        }
        return false;
    }
	
	public int login(String userID, String userPW) {
		String SQL = "SELECT userPW FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPW))
					return 1;
			 else 
				return 0;
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	
	public int join(User user) {
	    String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    try {
	        pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, user.getUserID());
	        pstmt.setString(2, user.getUserPW());
	        pstmt.setString(3, user.getUserName());
	        pstmt.setString(4, user.getUserGender());
	        pstmt.setString(5, user.getUserEmail());
	        pstmt.setString(6, user.getPhone());
	        pstmt.setString(7, user.getAddr());
	        pstmt.setString(8, user.getBdate());
	        pstmt.setBoolean(9, false);
	        return pstmt.executeUpdate();
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return -1;
	}
}