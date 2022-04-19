package com.mid.VO;

public class mentiboardReplyVO extends userboardVO{
	
	private String mentiNum;
	private String mentorNum;
	private String boardNum;
	private String mentorreplyContent;
	private String replyDate;
	private String selection;
	
	public String getSelection() {
		return selection;
	}
	public void setSelection(String selection) {
		this.selection = selection;
	}
	public String getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(String boardNum) {
		this.boardNum = boardNum;
	}
	
	public String getMentiNum() {
		return mentiNum;
	}
	public void setMentiNum(String mentiNum) {
		this.mentiNum = mentiNum;
	}
	public String getMentorNum() {
		return mentorNum;
	}
	public void setMentorNum(String mentorNum) {
		this.mentorNum = mentorNum;
	}
	public String getMentorreplyContent() {
		return mentorreplyContent;
	}
	public void setMentorreplyContent(String mentorreplyContent) {
		this.mentorreplyContent = mentorreplyContent;
	}
	public String getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(String replyDate) {
		this.replyDate = replyDate;
	}
	
	
	

}
