package com.mid.service;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.python.icu.text.SimpleDateFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mid.VO.cityCoordinatesVO;
import com.mid.VO.roommateChatVO;
import com.mid.VO.roommateVO;
import com.mid.mapper.mentiMapper;
import com.mid.mapper.roommateMapper;

@Service
public class roommateService {
	
	@Autowired
	roommateMapper mapper;

	public Map<String, List<String>> selectedCountry(String selectedCountry) {
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		List<String> list = mapper.selectedCountry(selectedCountry);
		
		map.put("city", list);
		return map;
	}
	// 기본 룸메 구직 정보 출력
	public List<roommateVO> getRoommateList(String num, String cityName, String selectedCountry) {
		PageHelper.startPage(Integer.valueOf(num), 10);
		
//		숫자 formatting
		List<roommateVO> list = mapper.getRoommateList(cityName, selectedCountry);
		DecimalFormat df = new DecimalFormat("#,###.##");
		
		for(int i = 0; i<list.size(); i++) {
			list.get(i).setExpense(df.format(Integer.valueOf(list.get(i).getExpense())));
			list.get(i).setSecurityDeposit(df.format(Integer.valueOf(list.get(i).getSecurityDeposit())));
		}
		
		PageInfo<roommateVO> pageinfo = new PageInfo<roommateVO>(list);
		
		return pageinfo.getList();
	}
	// 기본 룸메 구직 정보 페이지 번호 출력
	public int[] roommateListPageNum(String num, String cityName, String selectedCountry) {
		PageHelper.startPage(Integer.valueOf(num), 10);
		PageInfo<roommateVO> pageinfo = new PageInfo<roommateVO>(mapper.getRoommateList(cityName, selectedCountry));
		
		return pageinfo.getNavigatepageNums();
	}
//	기본 룸메 세부사항 정보 출력
	public roommateVO roommateInfo(String num) {
		roommateVO vo = mapper.roommateInfo(num);
		DecimalFormat df = new DecimalFormat("#,###.##");
		
		vo.setExpense(df.format(Integer.valueOf(vo.getExpense())));
		vo.setSecurityDeposit(df.format(Integer.valueOf(vo.getSecurityDeposit())));
		
		return vo;
	}
	public List<String> files(String num) {
		return mapper.files(num);
	}
	public cityCoordinatesVO getCoordinates(String cityName) {
		return mapper.getCoordinates(cityName);
	}
	public void like(String num, String boardNum, String userType) {
		mapper.like(num, boardNum, userType);
	}
	public int likeCheck(String num, String userNum, String userType) {
		return mapper.likeCheck(num, userNum, userType);
	}
	public void likerevert(String num, String boardNum, String userType) {
		mapper.likerevert(num, boardNum, userType);
		
	}
	public void viewIncrease(String num) {
		mapper.viewIncrease(num);
	}
	
//	검색 룸메 구직 정보 
	public List<roommateVO> getRoommateListSearch(String num, String cityName, String selectedCountry, String search) {
		PageHelper.startPage(Integer.valueOf(num), 10);

//		숫자 formatting
		List<roommateVO> list = mapper.getRoommateListSearch(cityName, selectedCountry, "%"+search+"%");
		DecimalFormat df = new DecimalFormat("#,###.##");
		
		for(int i = 0; i<list.size(); i++) {
			list.get(i).setExpense(df.format(Integer.valueOf(list.get(i).getExpense())));
			list.get(i).setSecurityDeposit(df.format(Integer.valueOf(list.get(i).getSecurityDeposit())));
		}
		PageInfo<roommateVO> pageinfo = new PageInfo<roommateVO>(list);
		return pageinfo.getList();
	}
	
//	검색 룸메 구직 정보 페이징 번호
	public int[] roommateListSearchPageNum(String num, String cityName, String selectedCountry, String search) {
		PageHelper.startPage(Integer.valueOf(num), 10);
		PageInfo<roommateVO> pageinfo = new PageInfo<roommateVO>(mapper.getRoommateListSearch(cityName, selectedCountry, "%"+search+"%"));
		
		return pageinfo.getNavigatepageNums();
	}
	
	public String getCurrency(String selectedCountry) {
		return mapper.getCurrency(selectedCountry);
	}
	
//	글 저장
	public boolean savePost(roommateVO vo) {
//		오늘 날짜 추출
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today = sdf.format(date);
		
		vo.setPostDate(today);
		return mapper.savePost(vo)>0 ? true : false;
	}
	public boolean saveFiles(String ainum, String savefilesName) {
		return mapper.saveFiles(ainum, savefilesName)>0 ? true : false;
	}
	public List<roommateVO> getsavePost(String userNum, String userType) {
		return mapper.getsavePost(userNum, userType);
	}
	
	public void chatSave(String userNum, String userType, String boardNum, String chat, String sendUserType, String sendUserNum) {
//		오늘 날짜 추출
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today = sdf.format(date);
		
//		받는사람 정보 룸메이트 boardNum을 사용해서 추출
		
//		만약 집 올린사람 장본인이면 동일인물로 들어가므로 receiver를 상대편으로 바꾼다.
		roommateVO vo = mapper.getUserInfo(boardNum);
		String currentUser = userNum + userType;
		String sendUser = vo.getUserNum()+vo.getUserType();
		
		if(currentUser.equals(sendUser)) {
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("roommateBoardNum", boardNum);
			map.put("textContent", chat);
			map.put("sendUserType", vo.getUserType());
			map.put("sendUserNum", vo.getUserNum());
			map.put("receiveUserType", sendUserType);
			map.put("receiveUserNum", sendUserNum);
			map.put("textDate", today);
			
			mapper.chatSave(map);
		}
		else {
			Map<String, String> map = new HashMap<String, String>();
			map.put("roommateBoardNum", boardNum);
			map.put("textContent", chat);
			map.put("sendUserType", userType);
			map.put("sendUserNum", userNum);
			map.put("receiveUserType", vo.getUserType());
			map.put("receiveUserNum", vo.getUserNum());
			map.put("textDate", today);
			
			mapper.chatSave(map);
		}
	}

//	특정 board 사용자와 주고 받은 채팅목록 출력
	public List<roommateChatVO> chathistory(String boardUserNum, String boardUserType, String num, String userType, String userNum) {
		List<roommateChatVO> list = new ArrayList<roommateChatVO>();
//		받는사람 정보 룸메이트 boardNum을 사용해서 추출
		roommateVO vo = mapper.getUserInfo(num);
		
		String sendUser = vo.getUserNum()+vo.getUserType();
		String receiveUser = userNum+userType;
		
//		보내는사람이 본인일 경우 receiver가 동일인으로 설정되어있으므로 sender로 바꿔서 보낸다
		if(sendUser.equals(receiveUser)) {
			
			list = mapper.chathistory(boardUserNum, boardUserType, userNum, userType);
			
	//		각각의 사용자 프로필 사진 대입
			for(int i = 0; i<list.size(); i++) {
				roommateChatVO chatvo = list.get(i);
				chatvo.setSendProfile(mapper.getprofilePic(chatvo.getSendUserNum(), chatvo.getSendUserType()));
				chatvo.setReceiveProfile(mapper.getprofilePic(chatvo.getReceiveUserNum(), chatvo.getReceiveUserType()));
			}
		}
		else {
			list = mapper.chathistory(userNum, userType, vo.getUserNum(), vo.getUserType());
//			각각의 사용자 프로필 사진 대입
			for(int i = 0; i<list.size(); i++) {
				roommateChatVO chatvo = list.get(i);
				chatvo.setSendProfile(mapper.getprofilePic(chatvo.getSendUserNum(), chatvo.getSendUserType()));
				chatvo.setReceiveProfile(mapper.getprofilePic(chatvo.getReceiveUserNum(), chatvo.getReceiveUserType()));
			}
		}
		
		return list;
	}
	
	public List<roommateChatVO> chathistory(String num, String userType, String userNum) {
//		받는사람 정보 룸메이트 boardNum을 사용해서 추출
		roommateVO vo = mapper.getUserInfo(num);
		
		List<roommateChatVO> list = mapper.chathistory(userNum, userType, vo.getUserNum(), vo.getUserType());
		
//		각각의 사용자 프로필 사진 대입
		for(int i = 0; i<list.size(); i++) {
			roommateChatVO chatvo = list.get(i);
			chatvo.setSendProfile(mapper.getprofilePic(chatvo.getSendUserNum(), chatvo.getSendUserType()));
			chatvo.setReceiveProfile(mapper.getprofilePic(chatvo.getReceiveUserNum(), chatvo.getReceiveUserType()));
		}
		return list;
	}
	
	public Map<String, String> currentChat(String chat, String userNum, String userType) {
		Map<String , String> map = new HashMap<String, String>();
//		오늘 날짜 추출
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today = sdf.format(date);

		map.put("textDate", today);
		map.put("sendProfile", mapper.getprofilePic(userNum, userType));
		map.put("textContent", chat);
		return map;
	}
	public List<roommateChatVO> chatList(String userType, String num) {
//		본인이 쓴 글의 댓글 불러오기
		List<roommateChatVO> list = mapper.chatList(userType, num);
		
		for(int i=0; i<list.size(); i++) {
			roommateChatVO chatVO = list.get(i);
			chatVO.setSendProfile(mapper.getprofilePic(chatVO.getSendUserNum(), chatVO.getSendUserType()));
			
			roommateVO vo = mapper.roommateInfo(chatVO.getReceiveUserNum());
			chatVO.setBoardTitle(vo.getBoardTitle());
		}
		
		return list;
	}

	
}
