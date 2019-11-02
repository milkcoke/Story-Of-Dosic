package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.*;
public class UserDAO { // DB Access Object
	
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs; 
	
	public UserDAO()
	{
		try {
			String dbURL = "jdbc:mysql://localhost:3306/DOSIC?characterEncoding=UTF-8&serverTimezone=UTC"; //3306�� DB���� Port��ȣ . DB�̸�: DOSIC
			String dbID = "root"; 
			String dbPassword = "dosic"; 
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}


	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID= ? ";
	
		try {
			pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1,  userID); //
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) // 
					return 1; 
				else
					return 0; 
				}
			return -1; // 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2; 
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?)"; 
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  user.getUserNum());
			pstmt.setString(2, user.getUserID());
			pstmt.setString(3, user.getUserPassword());
			pstmt.setString(4, user.getUserName());
			pstmt.setString(5, user.getUserEmail());
			pstmt.setInt(6, user.getUserGroupID());
			return pstmt.executeUpdate();
			
		}	catch(Exception e) { 
			e.printStackTrace();
		}
		return -1;
	}
	
	public String IDtoName(String userID) {
		String SQL = "SELECT userName FROM USER WHERE userID= ? ";
		String userName = null;
		
		try {
			pstmt = conn.prepareStatement(SQL);
	
			pstmt.setString(1,  userID); 
			rs = pstmt.executeQuery();
			userName = rs.getString(1);
			
		} catch(Exception e) {
			e.printStackTrace();
		} 
		return userName;
	}
}