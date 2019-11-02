package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class BBS_DAO {
	BBS_DBConnect dbconnect = null;
	String sql="";
	
	public BBS_DAO() {
		dbconnect = new BBS_DBConnect();
	}
	
	public int count(int bbsTypeNum) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		
		try {
			sql = "SELECT COUNT(*) FROM BBS WHERE bbsState = 0 AND bbsTypeNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Integer.toString(bbsTypeNum));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt=rs.getInt(1);
			}
		}catch(Exception e){
			
		}finally {
			BBS_DBClose.close(con,pstmt,rs);
		}
		
		return cnt;
	}
	
	public ArrayList<BBS_VO> getMemberList(int bbsTypeNum){
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<BBS_VO> alist = new ArrayList<BBS_VO>();
		try {
			sql = "SELECT bbsNum, userNum, bbsTitle, bbsDate, bbsHit, bbsIndent from BBS order by bbsResfPost desc, bbsIndent asc WHERE bbsState = 0 AND bbsTypeNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Integer.toString(bbsTypeNum));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BBS_VO vo = new BBS_VO();
				vo.setBBSNum(rs.getInt(1));
				vo.setUserNum(rs.getString(2));
				vo.setBBSTitle(rs.getString(3));
				vo.setBBSDate(rs.getString(4).substring(0, 10));
				vo.setBBSHit(rs.getInt(5));
				vo.setBBSIndent(rs.getInt(6));
				alist.add(vo);
				System.out.println(vo.getBBSTitle()+" is inserted");
			}
		}catch(Exception e){
			
		}finally {
			BBS_DBClose.close(con,pstmt,rs);
		}
		return alist;
	}
	
	public int getMax(int bbsTypeNum) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int max = 0;
		
		try {
			sql = "SELECT MAX(bbsNum) FROM BBS WHERE bbsState = 0 AND bbsTypeNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Integer.toString(bbsTypeNum));
			rs = pstmt.executeQuery();
			if(rs.next()) {
				max=rs.getInt(1);
			}
		}catch(Exception e) {
			
		}finally {
			BBS_DBClose.close(con, pstmt, rs);
		}
		return max;
	}
	
	public String pasing(String data) {
		try {
			data = new String(data.getBytes("8859_1"), "euc-kr");
		}catch (Exception e){}
		
		return data;
	}
	
	public String IDtoNum(String userID) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userNum = "";
		
		try {
			sql = "SELECT userNum FROM USER WHERE userID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				userNum = rs.getString(1); // 수정했음.
			}
		}catch(Exception e) {
			
		}finally {
			BBS_DBClose.close(con, pstmt, rs);
		}
		return userNum;
	}
	
	public String IDtoName(String userID) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userName = "";
		
		try {
			sql = "SELECT userName FROM USER WHERE userID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				userName = rs.getString(1); // 수정했음.
			}
		}catch(Exception e) {
			
		}finally {
			BBS_DBClose.close(con, pstmt, rs);
		}
		return userName;
	}
	
	public boolean chkPerm(int bbsTypeNum, String userID, String Per) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int permission=0;
		int userGroupID=0;
		boolean chk = false;
		
		try {
			sql = "SELECT ? FROM BBS_admin WHERE bbsTypeNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Per);
			pstmt.setString(2, Integer.toString(bbsTypeNum));
			
			rs = pstmt.executeQuery();
			permission = rs.getInt(1);
		}catch(Exception e) {
			
		}finally {
			BBS_DBClose.close(con,pstmt);
		}
		
		try {
			sql = "SELECT userGroupID FROM User WHERE userID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			userGroupID = rs.getInt(1);
		}catch(Exception e) {
			
		}finally {
			BBS_DBClose.close(con,pstmt);
		}
		if((permission/(int)Math.pow(10, userGroupID))%10==1) {
			chk=true;
		}
		
		//return chk;
		return true; //testing
	}
	
	public void insertWrite(BBS_VO vo, int max) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;	
		System.out.println(vo.getBBSTitle());
		System.out.println(vo.getBBSContent());
		Statement stmt = null;
		try { 
			//stmt = con.createStatement();
			sql = "INSERT INTO bbs(bbsNum, bbsTitle, bbsDate, bbsContent, bbsHit, bbsState, userNum, bbsTypeNum, bbsIndent, bbsRefPost, bbsLastMod, IsNotice, IsAno) VALUES(?,?,?,?,'0','1',?,?,'0',?,?,'0','0')";
			//sql = "INSERT INTO bbs(bbsNum, bbsTitle, bbsDate, bbsContent, bbsHit, bbsState, userNum, bbsTypeNum, bbsIndent, bbsRefPost, bbsLastMod, IsNotice, IsAno) VALUES('6','222',NULL,'123','0','0','201812308','1','0','123',NULL,'0','0');";
			//stmt.executeQuery(sql);
			pstmt = con.prepareStatement(sql);
			//pstmt = new LoggableStatement(con, sql);
			
			pstmt.setString(1, Integer.toString(max+1));
			pstmt.setString(2, pasing(vo.getBBSTitle()));
			pstmt.setString(3, pasing(vo.getBBSDate()));
			pstmt.setString(4, pasing(vo.getBBSContent()));
			pstmt.setString(5, pasing(vo.getUserNum()));
			pstmt.setString(6, Integer.toString(vo.getBBSTypeNum()));
			pstmt.setString(7, Integer.toString(max+1));
			pstmt.setString(8, pasing(vo.getBBSDate()));
			/*
			pstmt.setString(1, Integer.toString(1));
			pstmt.setString(3, "NULL");
			pstmt.setString(2, Integer.toString(3444));
			pstmt.setString(4, Integer.toString(123));
			pstmt.setString(5, Integer.toString(201812308));
			pstmt.setString(6, Integer.toString(1));
			pstmt.setString(7, Integer.toString(123));
			pstmt.setString(8, "NULL");
			*/
			pstmt.execute();
		}catch(Exception e) {
			
		}finally {
			BBS_DBClose.close(con,pstmt);
		}
	}
	
	public String getBoardName(int bbsTypeNum) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String BoardName = "";
		
		try {
			sql = "SELECT bbsName FROM BBS_Admin WHERE bbsTypeNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Integer.toString(bbsTypeNum));
			rs = pstmt.executeQuery();
			
			BoardName =  rs.getString(1);
		}catch(Exception e){
			
		}finally {
			BBS_DBClose.close(con,pstmt,rs);
		}
		//return BoardName;
		return BoardName; // <<여기 한글 깨져서 수정해봄.
	}
	
	public BBS_VO getView(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BBS_VO vo = null;
		
		try {
			sql = "SELECT userNum, bbsTitle, bbsContent, bbsDate, bbsHit, bbsResfPost, bbsIndent FROM BBS WHERE bbsNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Integer.toString(idx));
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo = new BBS_VO();
				vo.setUserNum(rs.getString(1));
				vo.setBBSTitle(rs.getString(2));
				vo.setBBSContent(rs.getString(3));
				vo.setBBSDate(rs.getString(4));
				vo.setBBSHit(rs.getInt(5)+1);
				vo.setBBSResfPost(rs.getInt(6));
				vo.setBBSIndent(rs.getInt(7));
			}
		}catch(Exception e){
			
		}finally {
			BBS_DBClose.close(con,pstmt,rs);
		}
		
		return vo;
	}
	
	public void UpdateHit(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		
		try {
			sql = "UPDATE BBS SET bbsHit=bbsHit+1 where bbsNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			
		}finally {
			BBS_DBClose.close(con,pstmt);
		}
	}
	
	public void delete(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		
		try {
			sql = "UPDATE BBS SET bbsState = 1 WHERE bbsNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		}catch(Exception e) {
			
		}finally {
			BBS_DBClose.close(con,pstmt);
		}
	}
	
	public void insertReply(BBS_VO vo, int ref, int indent) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		
		try {
			sql = "INSERT INTO BBS(bbsTypeNum, userNum, bbsTitle, bbsContent, bbsResfPost, bbsIndent) VALUES(?, ?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, Integer.toString(vo.getBBSTypeNum()));
			pstmt.setString(2, pasing(vo.getUserNum()));
			pstmt.setString(3, pasing(vo.getBBSTitle()));
			pstmt.setString(4, pasing(vo.getBBSContent()));
			pstmt.setInt(5, ref);
			pstmt.setInt(6, indent+1);
			
			pstmt.execute();
		}catch(Exception e) {
			
		}finally {
			BBS_DBClose.close(con,pstmt);
		}
	}
	
	public void modify(BBS_VO vo, int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		
		try {
			sql = "UPDATE BBS SET BBSTitle=?, BBSContent=? where bbsNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pasing(vo.getBBSTitle()));
			pstmt.setString(2, pasing(vo.getBBSContent()));
			pstmt.setInt(3, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			
		}finally {
			BBS_DBClose.close(con,pstmt);
		}
	}
	
}
