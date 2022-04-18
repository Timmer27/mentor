package com.mid.VO;

import org.springframework.stereotype.Component;

@Component
public class replycountVO {
	private String countNum;
	private String boardNum;
	
	public String getCountNum() {
		return countNum;
	}
	public void setCountNum(String countNum) {
		this.countNum = countNum;
	}
	public String getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(String boardNum) {
		this.boardNum = boardNum;
	}
	
	
}
