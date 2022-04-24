package com.mid.VO;

import org.springframework.stereotype.Component;

@Component
public class roommateChatVO extends roommateVO{
	private String roommateBoardNum;
	private String textContent;
	private String sendUserType;
	private String sendUserNum;
	private String sendProfile;
	private String receiveUserType;
	private String receiveUserNum;
	private String receiveProfile;
	private String textDate;
	
	
	public String getSendProfile() {
		return sendProfile;
	}
	public void setSendProfile(String sendProfile) {
		this.sendProfile = sendProfile;
	}
	public String getReceiveProfile() {
		return receiveProfile;
	}
	public void setReceiveProfile(String receiveProfile) {
		this.receiveProfile = receiveProfile;
	}
	public String getSendUserType() {
		return sendUserType;
	}
	public void setSendUserType(String sendUserType) {
		this.sendUserType = sendUserType;
	}
	public String getSendUserNum() {
		return sendUserNum;
	}
	public void setSendUserNum(String sendUserNum) {
		this.sendUserNum = sendUserNum;
	}
	public String getReceiveUserType() {
		return receiveUserType;
	}
	public void setReceiveUserType(String receiveUserType) {
		this.receiveUserType = receiveUserType;
	}
	public String getReceiveUserNum() {
		return receiveUserNum;
	}
	public void setReceiveUserNum(String receiveUserNum) {
		this.receiveUserNum = receiveUserNum;
	}
	public String getTextContent() {
		return textContent;
	}
	public void setTextContent(String textContent) {
		this.textContent = textContent;
	}
	public String getTextDate() {
		return textDate;
	}
	public void setTextDate(String textDate) {
		this.textDate = textDate;
	}
	public String getRoommateBoardNum() {
		return roommateBoardNum;
	}
	public void setRoommateBoardNum(String roommateBoardNum) {
		this.roommateBoardNum = roommateBoardNum;
	}
	
}
