package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
public class CommentDAO {
	private Connection conn; 
	private ResultSet rs;
	public CommentDAO() {
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
	public int write(String userID, int bbsNum, String comContent, String bbsCategory) { 
		String SQL = "INSERT INTO COMMENT VALUES(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, 0);
			pstmt.setString(2, userID);
			pstmt.setInt(3, bbsNum);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsCategory);
			pstmt.setString(6, comContent);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public ArrayList<Comment> getList(int bbsNum) {
	    String SQL = "SELECT * FROM COMMENT WHERE bbsNum = ?";
	    ArrayList<Comment> list = new ArrayList<Comment>();
	    try { 
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, bbsNum);
	        rs = pstmt.executeQuery();
	        while(rs.next()) {
	        	Comment comment = new Comment();
	        	comment.setComNum(rs.getInt(1));
	        	comment.setUserID(rs.getString(2));
	            comment.setBbsNum(rs.getInt(3));
	            comment.setComDate(rs.getString(4));
	            comment.setBbsCategory(rs.getString(5));
	            comment.setComContent(rs.getString(6));
	            list.add(comment);
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
}
