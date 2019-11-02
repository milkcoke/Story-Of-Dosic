package board;

public class BBS_VO {
	private int bbsTypeNum;		//게시판 ID
	private int bbsNum;			//게시물 번호
	private String userNum;		//유저 ID
	private String bbsTitle;	//게시물 제목
	private String bbsDate;		//게시물 작성일
	private String bbsLastMode;	//게시물 최종 수정일
	private String bbsContent;	//게시물 내용
	private boolean bbsState;	//게시물 삭제여부(0이면 존재, 1이면 삭제 상태)
	private int bbsHit;			//게시물 조회수
	private int bbsIndent;		//게시물 답글 수준
	private int bbsResfPost;	//답글단 원 게시물
	private boolean IsAno;		//익명 여부
	private boolean IsNotice;	//공지 여부
	
	public BBS_VO() {
		
	}
	
	public BBS_VO(int bbsTypeNum, int bbsNum, String userNum, String bbsTitle, String bbsDate,
					String bbsLastMode, String bbsContent, boolean bbsState, int bbsHit,
					int bbsIndent, int bbsResfPost, boolean IsAno, boolean IsNotice) {
		this.setBBSTypeNum(bbsTypeNum);
		this.setBBSNum(bbsNum);
		this.setUserNum(userNum);
		this.setBBSTitle(bbsTitle);
		this.setBBSDate(bbsDate);
		this.setBBSContent(bbsContent);
		this.setBBSState(bbsState);
		this.setBBSHit(bbsHit);
		this.setBBSIndent(bbsIndent);
		this.setBBSResfPost(bbsResfPost);
		this.setIsAno(IsAno);
		this.setIsNotice(IsNotice);
	}

	public int getBBSNum() {
		return bbsNum;
	}

	public void setBBSNum(int bbsNum) {
		this.bbsNum = bbsNum;
	}

	public String getUserNum() {
		return userNum;
	}

	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}

	public String getBBSTitle() {
		return bbsTitle;
	}

	public void setBBSTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}

	public String getBBSDate() {
		return bbsDate;
	}

	public void setBBSDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}

	public String getBBSContent() {
		return bbsContent;
	}

	public void setBBSContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}

	public boolean isBbsState() {
		return bbsState;
	}

	public void setBBSState(boolean bbsState) {
		this.bbsState = bbsState;
	}

	public int getBBSHit() {
		return bbsHit;
	}

	public void setBBSHit(int bbsHit) {
		this.bbsHit = bbsHit;
	}

	public int getBBSIndent() {
		return bbsIndent;
	}

	public void setBBSIndent(int bbsIndent) {
		this.bbsIndent = bbsIndent;
	}

	public int getBBSResfPost() {
		return bbsResfPost;
	}

	public void setBBSResfPost(int bbsRefPost) {
		this.bbsResfPost = bbsRefPost;
	}

	public int getBBSTypeNum() {
		return bbsTypeNum;
	}

	public void setBBSTypeNum(int bbsTypeNum) {
		this.bbsTypeNum = bbsTypeNum;
	}

	public String getBBSLastMode() {
		return bbsLastMode;
	}

	public void setBBSLastMode(String bbsLastMode) {
		this.bbsLastMode = bbsLastMode;
	}

	public boolean getIsNotice() {
		return IsNotice;
	}

	public void setIsNotice(boolean isNotice) {
		IsNotice = isNotice;
	}

	public boolean getIsAno() {
		return IsAno;
	}

	public void setIsAno(boolean isAno) {
		IsAno = isAno;
	}
	
}
