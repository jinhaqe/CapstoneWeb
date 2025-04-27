package profile_s;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Profile_sDAO {
	private Connection conn; 
	private ResultSet rs;
	public Profile_sDAO() {
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
	
	public int PSwrite(Profile_s profile_s) { 
	    String SQL = "INSERT INTO profile_s(userID, ps_hobby, ps_vacation, ps_stress, ps_person, ps_date, ps_happy, ps_impor, ps_single) "
	    		+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, profile_s.getUserID());
	        pstmt.setString(2, profile_s.getPs_hobby());
	        pstmt.setString(3, profile_s.getPs_vacation());
	        pstmt.setString(4, profile_s.getPs_stress());
	        pstmt.setString(5, profile_s.getPs_person());
	        pstmt.setString(6, profile_s.getPs_date());
	        pstmt.setString(7, profile_s.getPs_happy());
	        pstmt.setString(8, profile_s.getPs_impor());
	        pstmt.setString(9, profile_s.getPs_single());
	        
	        return pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; 
	}
	
	public int PSupdate(Profile_s profile_s) { 
	    String SQL = "UPDATE profile_s SET ps_sign = ? WHERE userID = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, profile_s.getPs_sign());
	        pstmt.setString(2, profile_s.getUserID());
	        
	        return pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; 
	}
}
