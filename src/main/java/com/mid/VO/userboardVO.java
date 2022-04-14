package com.mid.VO;

import org.springframework.stereotype.Component;

@Component
public class userboardVO extends userVO{
	
	private String userNum;
	private String country;
	private String city;
	private String boardTitle;
	private String boardContent;
	private String boardDate;
	private String boardLike;
	
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public String getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}
	public String getBoardLike() {
		return boardLike;
	}
	public void setBoardLike(String boardLike) {
		this.boardLike = boardLike;
	}
	
	
	

}
