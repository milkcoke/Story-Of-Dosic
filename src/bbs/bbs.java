package bbs;

public class bbs {
	// IsNotice, bbsState, IsNo  int vs boolean  DB연동을 위해 다 int로 할까..
	private int bbsNum;
	private String bbsTitle;
	private String bbsDate;
	private String bbsContent;
	private boolean bbsState;
	private int bbsIndent;
	private int bbsResfPost;
	private String bbsLastMode;
	private boolean IsNotice;
	private boolean IsAno;
	
	public int getBbsNum() {
		return bbsNum;
	}
	public void setBbsNum(int bbsNum) {
		this.bbsNum = bbsNum;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public boolean isBbsState() {
		return bbsState;
	}
	public void setBbsState(boolean bbsState) {
		this.bbsState = bbsState;
	}
	public int getBbsIndent() {
		return bbsIndent;
	}
	public void setBbsIndent(int bbsIndent) {
		this.bbsIndent = bbsIndent;
	}
	public int getBbsResfPost() {
		return bbsResfPost;
	}
	public void setBbsResfPost(int bbsResfPost) {
		this.bbsResfPost = bbsResfPost;
	}
	public String getBbsLastMode() {
		return bbsLastMode;
	}
	public void setBbsLastMode(String bbsLastMode) {
		this.bbsLastMode = bbsLastMode;
	}
	public boolean isIsNotice() {
		return IsNotice;
	}
	public void setIsNotice(boolean isNotice) {
		IsNotice = isNotice;
	}
	public boolean isIsAno() {
		return IsAno;
	}
	public void setIsAno(boolean isAno) {
		IsAno = isAno;
	}
	
}