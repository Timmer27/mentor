package com.mid.VO;

import org.springframework.stereotype.Component;

@Component
public class userPointVO extends userboardVO{
	private String currentPoint;
	private String spendDate;
	private String spendAmount;
	
	public String getCurrentPoint() {
		return currentPoint;
	}
	public void setCurrentPoint(String currentPoint) {
		this.currentPoint = currentPoint;
	}
	public String getSpendDate() {
		return spendDate;
	}
	public void setSpendDate(String spendDate) {
		this.spendDate = spendDate;
	}
	public String getSpendAmount() {
		return spendAmount;
	}
	public void setSpendAmount(String spendAmount) {
		this.spendAmount = spendAmount;
	}
	
	
	

}
