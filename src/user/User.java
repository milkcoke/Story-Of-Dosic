package user;

public class User {
	private String userNum;
	private String userID;
	private String userPassword;
	private String userName;
	private String userEmail;
	private int userGroupID = 2; 
	
	public int getUserGroupID() {
		return userGroupID;
	}
	public void setUserGroupID(int userGroupID) {
		this.userGroupID = userGroupID;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}

	public String getUserName(String userNum) {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
	
}
