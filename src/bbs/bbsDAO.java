package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import user.User;

public class bbsDAO {
	private Connection conn; // DB에 접근하게 해주는 하나의 객체
	private PreparedStatement pstmt;
	private ResultSet rs; // 결과값 정보를 받기 위한 객체
	
	public bbsDAO()
	{
		try {
			String dbURL = "jdbc:mysql://localhost:3306/DOSIC?characterEncoding=UTF-8&serverTimezone=UTC"; //3306은 DB서버 Port번호 . DB이름: DOSIC
			String dbID = "root";
			String dbPassword = "dosic"; // 임의로 설정
			Class.forName("com.mysql.cj.jdbc.Driver"); // Driver는 mysql에 접속하기 위한 매개체 역할 Library
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getDate() { // 현재 DB서버 시간을 가져오는 함수
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery(); // 실제 실행했을 때 나오는 결과를 가져옴.
			if (rs.next()) {
				return rs.getString(1); // 1번째 결과 parameter에 '날짜'값을 가져옴.
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "" ; // 데이터베이스 오류
	}
	
		public int getNext() { // bbs 테이블의 게시물번호(bbsNum)을 가져오는 함수
			String SQL = "SELCT bbsNum FROM BBS ORDER BY bbsNum DESC"; 
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery(); // 실제 실행했을 때 나오는 결과를 가져옴.
				if (rs.next()) {
					return rs.getInt(1) + 1; // 1번째 결과 parameter에 '날짜'값을 가져옴.
				}
				return 1; // 첫 번째 게시물인 경우.
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1 ; // 데이터베이스 오류	
	}
		/*write 메소드는 게시판마다 parameter를 달리해서 설정해야할 것 같음.
		 */
		public int write(String bbsTitle, String userNum, String bbsContent, int bbsTypeNum, int bbsIndent,  int bbsResfPost, int IsNotice, int IsAno)
		{
			
			String SQL = "INSERT INTO BBS VALUES (?, ?, ? ,?, ?, ?, ?, ?, ?, ?, ?)";
			try { 
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext()); 
				pstmt.setString(2, bbsTitle);
				pstmt.setString(3, getDate());
				pstmt.setString(4, bbsContent);
				pstmt.setInt(5, 1); // 글 작성시 무조건 1로 ture
				pstmt.setString(6, userNum);
				pstmt.setInt(7, bbsTypeNum);
				pstmt.setInt(8, bbsIndent);
				pstmt.setInt(9, bbsResfPost);
				pstmt.setString(10, getDate());
				pstmt.setInt(10, IsNotice);
				pstmt.setInt(11, IsAno);
				return pstmt.executeUpdate();
				} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
}
