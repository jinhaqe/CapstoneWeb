package profile;
import java.util.Date;
import java.util.Calendar;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ProfileDAO {
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	public ProfileDAO() {
		try {
			String dbURL =  "jdbc:mysql://localhost:3306/cap?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
			String dbID = "root";
			String dbPW = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int Pwrite(String userID, String p_picture) { 
		String SQL = "INSERT INTO profile(userID, p_picture) VALUES(? , ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			/*Calendar calendar = Calendar.getInstance();
	        calendar.set(month - 1, day);
	        Date p_birth = calendar.getTime();*/
	        
			pstmt.setString(1, userID);
			pstmt.setString(2, p_picture);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int Pupdate(Profile profile) { 
	    String SQL = "UPDATE profile SET p_age = ?, p_birth = ?, p_addr = ?, p_addrDetail = ?, p_job = ?, p_jobDetail = ?, p_height = ?, p_blood = ?, p_mbti = ?, p_character = ? WHERE userID = ?";
	    try {
	    	
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, profile.getP_age());
	        pstmt.setDate(2, new java.sql.Date(profile.getP_birth().getTime()));
	        pstmt.setString(3, profile.getP_addr());
	        pstmt.setString(4, profile.getP_addrDetail());
	        pstmt.setString(5, profile.getP_job());
	        pstmt.setString(6, profile.getP_jobDetail());
	        pstmt.setInt(7, profile.getP_height());
	        pstmt.setString(8, profile.getP_blood());
	        pstmt.setString(9, profile.getP_mbti());
	        pstmt.setString(10, profile.getP_character());
	        pstmt.setString(11, profile.getUserID()); // userID를 WHERE 절에 추가

	        return pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; 
	}
	
	
	
	public Profile getProfileByUserID(String userID) {
	    String SQL = "SELECT p_picture, p_age, p_birth, p_jobDetail, p_addr, p_character FROM profile WHERE userID = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID);
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            Profile profile = new Profile();
	            profile.setP_picture(rs.getString("p_picture"));
	            profile.setP_age(rs.getInt("p_age"));
	            profile.setP_birth(rs.getDate("p_birth"));
	            profile.setP_jobDetail(rs.getString("p_jobDetail"));
	            profile.setP_addr(rs.getString("p_addr"));
	            profile.setP_character(rs.getString("p_character"));
	            return profile; // 조회된 프로필 정보 반환
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null; // 오류 발생 시
	}
	
	public Profile getMatchingUserRead(String userID) {
	    String SQL_getInfo = "SELECT p_age, p_addr, u.userGender FROM profile p JOIN user u ON p.userID = u.userID WHERE p.userID = ?";
	    
	    try (PreparedStatement pstmt1 = conn.prepareStatement(SQL_getInfo)) {
	        pstmt1.setString(1, userID);
	        ResultSet rs1 = pstmt1.executeQuery();

	        int userAge = 0;
	        String userAddr = "";
	        String userGender = "";
	        if (rs1.next()) {
	            userAge = rs1.getInt("p_age");
	            userAddr = rs1.getString("p_addr");
	            userGender = rs1.getString("userGender");
	        }
	        rs1.close(); // rs1 닫기

	        String SQL = "SELECT p.p_picture, p.p_age, u.userName, ps.ps_single, u.userID "
	                   + "FROM profile p "
	                   + "JOIN user u ON p.userID = u.userID "
	                   + "JOIN profile_s ps ON p.userID = ps.userID "
	                   + "WHERE (p.p_age BETWEEN ? AND ?) "
	                   + "AND (p.p_addr = ?) "
	                   + "AND (u.userGender != ?) "
	                   + "AND p.userID != ?";

	        try (PreparedStatement pstmt2 = conn.prepareStatement(SQL)) {
	            pstmt2.setInt(1, userAge - 3); 
	            pstmt2.setInt(2, userAge + 3); 
	            pstmt2.setString(3, userAddr); 
	            pstmt2.setString(4, userGender);
	            pstmt2.setString(5, userID); 
	            ResultSet rs2 = pstmt2.executeQuery();

	            while (rs2.next()) {
	                Profile profile = new Profile();
	                profile.setP_picture(rs2.getString("p_picture"));
	                profile.setP_age(rs2.getInt("p_age"));
	                profile.setUserName(rs2.getString("userName"));
	                profile.setPs_single(rs2.getString("ps_single"));
	                profile.setUserID(rs2.getString("userID"));
	                rs2.close(); 
	                return profile; 
	            }
	            rs2.close(); 
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return null; 
	}

	
	public ArrayList<Profile> getMatchingUsers(String userID, int pageNumber) {
	    ArrayList<Profile> matchedProfiles = new ArrayList<>();
	    String SQL_getInfo = "SELECT p_age, p_addr, u.userGender FROM profile p JOIN user u ON p.userID = u.userID WHERE p.userID = ?";

	    try (PreparedStatement pstmt1 = conn.prepareStatement(SQL_getInfo)) {
	        pstmt1.setString(1, userID);
	        ResultSet rs1 = pstmt1.executeQuery();

	        int userAge = 0;
	        String userAddr = "";
	        String userGender = "";
	        if (rs1.next()) {
	            userAge = rs1.getInt("p_age");
	            userAddr = rs1.getString("p_addr");
	            userGender = rs1.getString("userGender");
	        }
	        rs1.close();

	        String SQL = "SELECT p.p_picture, p.p_age, u.userName, ps.ps_single, u.userID "
	                   + "FROM profile p "
	                   + "JOIN user u ON p.userID = u.userID "
	                   + "JOIN profile_s ps ON p.userID = ps.userID "
	                   + "WHERE (p.p_age BETWEEN ? AND ?) "
	                   + "AND (p.p_addr = ?) "
	                   + "AND (u.userGender != ?) "
	                   + "AND p.userID != ? "
	                   + "ORDER BY p.userID DESC "
	                   + "LIMIT 5 OFFSET ?";

	        try (PreparedStatement pstmt2 = conn.prepareStatement(SQL)) {
	            pstmt2.setInt(1, userAge - 5); 
	            pstmt2.setInt(2, userAge + 5); 
	            pstmt2.setString(3, userAddr); 
	            pstmt2.setString(4, userGender);
	            pstmt2.setString(5, userID); 
	            pstmt2.setInt(6, (pageNumber - 1) * 5);
	            ResultSet rs2 = pstmt2.executeQuery();

	            while (rs2.next()) { // 수정된 부분
	                Profile profile = new Profile();
	                profile.setP_picture(rs2.getString("p_picture"));
	                profile.setP_age(rs2.getInt("p_age"));
	                profile.setUserName(rs2.getString("userName"));
	                profile.setPs_single(rs2.getString("ps_single")); 
	                profile.setUserID(rs2.getString("userID"));
	                matchedProfiles.add(profile); 
	            }
	            rs2.close(); 
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return matchedProfiles; 
	}
	
	public int getMatchingUserCount(String userID) {
	    String SQL_getInfo = "SELECT p_age, p_addr FROM profile WHERE userID = ?";
	    int totalCount = 0;

	    try (PreparedStatement pstmt1 = conn.prepareStatement(SQL_getInfo)) {
	        pstmt1.setString(1, userID);
	        ResultSet rs1 = pstmt1.executeQuery();

	        int userAge = 0;
	        String userAddr = "";
	        if (rs1.next()) {
	            userAge = rs1.getInt("p_age");
	            userAddr = rs1.getString("p_addr");
	        }
	        rs1.close();

	        String SQL = "SELECT COUNT(*) "
	                   + "FROM profile p "
	                   + "JOIN user u ON p.userID = u.userID "
	                   + "JOIN profile_s ps ON p.userID = ps.userID "
	                   + "WHERE (p.p_age BETWEEN ? AND ?) " // 여기서 ?가 첫 번째 파라미터로 바인딩 됩니다.
	                   + "AND (p.p_addr = ?) "
	                   + "AND p.userID != ?";

	        try (PreparedStatement pstmt2 = conn.prepareStatement(SQL)) {
	            pstmt2.setInt(1, userAge - 5); // 추가된 부분: userAge - 5 설정
	            pstmt2.setInt(2, userAge + 5); // 두 번째 파라미터는 userAge + 5
	            pstmt2.setString(3, userAddr); // 주소 조건 설정
	            pstmt2.setString(4, userID); // 본인 제외

	            ResultSet rs2 = pstmt2.executeQuery();
	            if (rs2.next()) {
	                totalCount = rs2.getInt(1); // 총 매칭된 프로필 수
	            }
	            rs2.close();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return totalCount;
	}
	
	public boolean hasNextPage(int pageNumber, String userID) {
	    String SQL = "SELECT COUNT(*) FROM Profile WHERE userID = ? AND available = 1";
	    
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID);
	        ResultSet rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            int totalProfiles = rs.getInt(1);
	            return (pageNumber * 10) < totalProfiles; // 현재 페이지 번호가 전체 프로필 수보다 작은지 확인
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public int addMatch(String userID, String matchingID) {
	    String SQL = "INSERT INTO matching (userID, matchingID, matchStatus) VALUES(?, ?, 'pending')";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID);         
	        pstmt.setString(2, matchingID);  
	        return pstmt.executeUpdate();      
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1;  // 실패 시 -1 반환
	}
	
	public int updateMatchStatus(String userID, String matchingID, String newStatus) {
	    String SQL = "UPDATE matching SET matchStatus = ? WHERE userID = ? and matchingID = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, newStatus);  
	        pstmt.setString(2, userID);         
	        pstmt.setString(3, matchingID);       
	        return pstmt.executeUpdate();  
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1;  // 실패 시 -1 반환
	}
	
	public Profile getHeartRead(String userID) {
	    String SQL = "SELECT p.p_picture, m.matchingID, m.matchStatus FROM profile p JOIN matching m ON p.userID = m.matchingID WHERE m.userID = ?";
	    Profile profile = null;
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID);
	        ResultSet rs = pstmt.executeQuery(); 

	        if (rs.next()) { 
	            profile = new Profile(); 
	            profile.setP_picture(rs.getString("p_picture")); 
	            profile.setMatchingID(rs.getString("matchingID"));
	            profile.setMatchStatus(rs.getString("matchStatus"));
	        }
	        rs.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return profile; 
	}
	
	public Profile getHeartComing(String userID) {
	    String SQL = "SELECT p.p_picture, m.userID, m.matchStatus FROM profile p JOIN matching m ON p.userID = m.userID WHERE m.matchingID = ?";
	    Profile profile = null;
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID);
	        ResultSet rs = pstmt.executeQuery(); 

	        if (rs.next()) { 
	            profile = new Profile(); 
	            profile.setP_picture(rs.getString("p_picture")); 
	            profile.setUserID(rs.getString("userID"));
	            profile.setMatchStatus(rs.getString("matchStatus"));
	        }
	        rs.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return profile; 
	}
}
