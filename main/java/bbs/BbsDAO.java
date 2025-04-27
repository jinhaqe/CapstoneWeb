package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
public class BbsDAO {
	private Connection conn; 
	private ResultSet rs;
	public BbsDAO() {
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

	public int getNext(String bbsCategory) {
	    String SQL = "SELECT MAX(bbsID) FROM BBS WHERE bbsCategory = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, bbsCategory);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1) + 1;
	        }
	        return 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1;
	}
	public int write(String bbsTitle, String userID, String bbsContent, String bbsCategory, String bbsSecret) { 
		String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, 0);
			pstmt.setInt(2, getNext(bbsCategory));
			pstmt.setString(3, bbsTitle);
			pstmt.setString(4, userID);
			pstmt.setString(5, getDate());
			pstmt.setString(6, bbsContent);
			pstmt.setInt(7,1);
			pstmt.setString(8, bbsCategory);
			pstmt.setString(9, bbsSecret);
			pstmt.setInt(10, 0);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public ArrayList<Bbs> getList(int pageNumber, String bbsCategory) {
	    String SQL = "SELECT * FROM BBS WHERE bbsCategory = ? AND bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
	    ArrayList<Bbs> list = new ArrayList<Bbs>();
	    try { 
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, bbsCategory);
	        pstmt.setInt(2, getNext(bbsCategory) - (pageNumber-1)*10);
	        rs = pstmt.executeQuery();
	        while(rs.next()) {
	            Bbs bbs = new Bbs();
	            bbs.setBbsNum(rs.getInt(1));
	            bbs.setBbsID(rs.getInt(2));
	            bbs.setBbsTitle(rs.getString(3));
	            bbs.setUserID(rs.getString(4));
	            bbs.setBbsDate(rs.getString(5));
	            bbs.setBbsContent(rs.getString(6));
	            bbs.setBbsAvailable(rs.getInt(7));
	            bbs.setBbsCategory(rs.getString(8));
	            bbs.setBbsSecret(rs.getString(9));
	            bbs.setBbsCount(rs.getInt(10));
	            list.add(bbs);
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	public boolean nextPage(int pageNumber, String bbsCategory) {
		String SQL ="SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext(bbsCategory) - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; 		
	}
	
	public Bbs getBbs(int bbsID, String bbsCategory){
		String SQL ="SELECT * FROM BBS WHERE bbsID = ? and bbsCategory = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setString(2, bbsCategory);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsNum(rs.getInt(1));
				bbs.setBbsID(rs.getInt(2));
				bbs.setBbsTitle(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsContent(rs.getString(6));
				bbs.setBbsAvailable(rs.getInt(7));
				bbs.setBbsCategory(rs.getString(8));
				bbs.setBbsSecret(rs.getString(9));
				int bbsCount=rs.getInt(10);
				bbs.setBbsCount(bbsCount);
				bbsCount++;
				countUpdate(bbsCount,bbsID,bbsCategory);
				return bbs;
				
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public int countUpdate(int bbsCount, int bbsID, String bbsCategory) {
		String SQL = "update bbs set bbsCount = ? WHERE bbsID = ? and bbsCategory = ? ";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsCount);
			pstmt.setInt(2, bbsID);
			pstmt.setString(3, bbsCategory);
			return pstmt.executeUpdate();		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent, String bbsCategory, String bbsSecret) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ?, bbsSecret = ? WHERE bbsID = ? and bbsCategory = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setString(3, bbsSecret);
			pstmt.setInt(4, bbsID);
			pstmt.setString(5, bbsCategory);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int delete(int bbsID, String bbsCategory) {
		String deleteSQL = "DELETE FROM BBS WHERE bbsID = ? and bbsCategory = ?";
	    String updateSQL = "UPDATE BBS SET bbsID = bbsID - 1 WHERE bbsID > ? and bbsCategory = ?";
		try {
			// Step 1: Delete the specified BBS record
	        PreparedStatement deleteStmt = conn.prepareStatement(deleteSQL);
	        deleteStmt.setInt(1, bbsID);
	        deleteStmt.setString(2, bbsCategory);
	        deleteStmt.executeUpdate();
	        
	        // Step 2: Update remaining BBS records to decrement bbsID
	        PreparedStatement updateStmt = conn.prepareStatement(updateSQL);
	        updateStmt.setInt(1, bbsID);
	        updateStmt.setString(2, bbsCategory);
	        updateStmt.executeUpdate();
	        return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}		
}
