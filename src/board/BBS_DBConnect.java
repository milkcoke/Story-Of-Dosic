package board;
import java.sql.Connection;
import java.sql.DriverManager;

public class BBS_DBConnect {
	public BBS_DBConnect() {
		
	}
	
	public Connection getConnection() {
		String dbURL = "jdbc:mysql://localhost:3306/DOSIC?characterEncoding=UTF-8&serverTimezone=UTC"; //3306은 DB서버 Port번호 . DB이름: DOSIC
		String dbID = "root";
		String dbPassword = "dosic"; // 임의로 설정
		
		Connection con = null; //null로 초기화
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");			//DB 연동을 위해 DriverManager에 등록
			con=DriverManager.getConnection(dbURL,dbID,dbPassword);	//DriverManager 객체로부터 Connection 객체 얻어옴
		}catch(Exception e) {
			e.printStackTrace();
		}
		return con; //connection 객체 반환
	}
	
}

