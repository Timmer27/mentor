package com.mid.VO;

import org.springframework.stereotype.Component;

@Component
public class roommateVO{
	private String num;
	private String userNum;
	private String userType;
	private String country;
	private String city;
	private String boardTitle;
	private String boardContent;
	private String thumbPic;
	private String expense;
	private String address;
	private String phone;
	private String email;
	private String beds;
	private String bath;
	private String securityDeposit;
	private String postDate;
	private String found;
	private String gender;
	private String condition;
	private String view;
	
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getView() {
		return view;
	}
	public void setView(String view) {
		this.view = view;
	}
	public String getBeds() {
		return beds;
	}
	public void setBeds(String beds) {
		this.beds = beds;
	}
	public String getBath() {
		return bath;
	}
	public void setBath(String bath) {
		this.bath = bath;
	}
	public String getSecurityDeposit() {
		return securityDeposit;
	}
	public void setSecurityDeposit(String securityDeposit) {
		this.securityDeposit = securityDeposit;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getExpense() {
		return expense;
	}
	public void setExpense(String expense) {
		this.expense = expense;
	}
	public String getFound() {
		return found;
	}
	public void setFound(String found) {
		this.found = found;
	}
	public String getThumbPic() {
		return thumbPic;
	}
	public void setThumbPic(String thumbPic) {
		this.thumbPic = thumbPic;
	}
	public String getPostDate() {
		return postDate;
	}
	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
}
