package com.mid.VO;

import org.springframework.stereotype.Component;

@Component
public class roommatelikesVO {
	private String num;
	private String userNum;
	private String roommatlikeseNum;
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getRoommatlikeseNum() {
		return roommatlikeseNum;
	}
	public void setRoommatlikeseNum(String roommatlikeseNum) {
		this.roommatlikeseNum = roommatlikeseNum;
	}
	

}
