package com.mid.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mid.VO.cityCoordinatesVO;
import com.mid.VO.userPointVO;
import com.mid.VO.userVO;
import com.mid.VO.userboardVO;
import com.mid.mapper.loginMapper;
import com.mid.mapper.mainMapper;
import com.mid.mapper.mentiMapper;

@Service
public class mainService {

	@Autowired
	mainMapper mainMapper;
	
	@Autowired
	mentiMapper mentiMapper;
	
	@Autowired
	loginMapper loginMapper;
	
	public int[] userCount() {
		return mainMapper.userCount();
	}

	public List<Integer> getboardnumList() {
		return mainMapper.getboardnumList();
	}

	public List<cityCoordinatesVO> getCityCoordinates() {
		return mainMapper.getCityCoordinates();
	}

	public List<userVO> getUserList() {
		return mainMapper.getUserList();
	}

	public List<userPointVO> userPointRank() {
		return mainMapper.userPointRank();
	}

	public List<userboardVO> selectedList(String id) {
		String num = mentiMapper.getmentorNum(id);
//		채택된 boardNum 추출 후 boardNum의 정보를 화면에 출력
		int[] boardNum = mentiMapper.selectedBoardNumList(num);
		
		List<userboardVO> list = new ArrayList<userboardVO>();
		for(int i = 0; i<boardNum.length; i++) {
			userboardVO vo = new userPointVO();
			vo = mentiMapper.boardInfo(boardNum[i]);
			list.add(vo);
		}
		return list;
	}

	public List<userboardVO> likedList(String id, String userType) {
		int[] boardNum = mentiMapper.likedList(id, userType);
		
		List<userboardVO> list = new ArrayList<userboardVO>();
		for(int i = 0; i<boardNum.length; i++) {
			userboardVO vo = new userPointVO();
			vo = mentiMapper.boardInfo(boardNum[i]);
			list.add(vo);
		}
		return list;
	}

	public String prevDBPic(String userType, String id) {
		return mainMapper.prevDBPic(userType, id);
	}

	public boolean dbPicChange(String prevDBPic, String newPic, String userType) {
//		파일 업데이트
		return mainMapper.updateProfileFile(prevDBPic, newPic, userType) > 0 ? true : false;
	}

	public Map<String, String> modify(String userType, String id, userVO vo) {
		Map<String, String> resultmap = new HashMap<String, String>();
		
//		변경 닉네임 중복 유효성 검사
		if(loginMapper.dubNickname(userType + "user", vo.getNickname())>0) {
			resultmap.put("result", "dupnickname");
			return resultmap;
		}
		
//		현재 비밀번호 불일치 유효성 검사
		if(!loginMapper.getCWPassword(userType, id).equals(vo.getCurrentPW())) {
			resultmap.put("result", "CWPassword");
			return resultmap;
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("password", vo.getPassword());
		map.put("nickname", vo.getNickname());
		map.put("email", vo.getEmail());
		map.put("city", vo.getCity());
		map.put("country", vo.getCountry());
		map.put("id", id);
		map.put("userType", userType);
		
		if(mainMapper.modify(map)>0) {
			resultmap.put("result", "success");
			return resultmap;
		}
		return resultmap;
	}

	public List<userboardVO> writenList(String id) {
		String num = mentiMapper.getuserNum(id);
		return mentiMapper.writenList(num);
	}

	public List<userboardVO> requiredList(String id) {
		String num = mentiMapper.getuserNum(id);
		return mentiMapper.requiredList(num);
	}

	public int questionNum() {
		return mainMapper.questionNum();
	}

	public int SolvedquestionNum() {
		return mainMapper.SolvedquestionNum();
	}

}
