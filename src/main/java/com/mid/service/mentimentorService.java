package com.mid.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.python.icu.text.SimpleDateFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mid.VO.mentiboardReplyVO;
import com.mid.VO.userboardVO;
import com.mid.VO.userboardfilesVO;
import com.mid.mapper.mentiMapper;
import com.mysql.cj.protocol.a.NativeConstants.IntegerDataType;

@Service
@SessionAttributes("")
public class mentimentorService {
	
	@Autowired
	mentiMapper mapper;

	public boolean newpost(userboardVO vo, String usernum, String boardNum, String currentPoint, String userType) {
//		오늘날짜 구하기
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(date);
		
//		소모한 포인트 반영
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("userType", userType);
		map.put("mentiNum", usernum);
		map.put("mentiboardnum", boardNum);
		map.put("currentPoint", (Integer.valueOf(currentPoint) - Integer.valueOf(vo.getBoardPoint())) );
		map.put("spendDate", today);
		map.put("spendAmount", vo.getBoardPoint());
		mapper.spendPoint(map);
		
//		포스팅 저장
		vo.setUserNum(usernum);
		vo.setBoardDate(today);
		
		return mapper.newpost(vo) > 0 ? true : false;
	}

	public void saveFiles(String saveName, String num) {
		mapper.saveFiles(saveName, num);
	}

	public List<userboardVO> getBoard(String countryDBname) {
		return mapper.getBoard(countryDBname);
	}

	public userboardVO mentiboard(String num) {
		return mapper.mentiboard(num);
	}

	public List<userboardVO> searchInfo(String search) {
		return mapper.searchInfo("%" + search + "%");
	}

	public List<userboardfilesVO> getfiles(String num) {
		return mapper.getfiles(num);
	}

	public Map<String, Boolean> saveReply(String replyContent, String boardNum, String mentiNum, String mentorNum) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(date);
		
		
		if(mapper.saveReply(replyContent, boardNum, mentiNum, mentorNum, today)>0) {
			map.put("result", true);
			return map;
		}
		map.put("result", false);
		return map;
		
	}
	public void getreputationPoint(String mentorNum, String mentiNum, String boardNum) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(date);
		
//		명예포인트 누적합
		String repPoint = mapper.recentrepPoint(mentorNum);
		String updatedrepPoint = (Integer.valueOf(repPoint) + 1) + "";

		mapper.getreputationPoint(mentorNum, mentiNum, boardNum, updatedrepPoint, today);
	}

	public List<mentiboardReplyVO> replyList(String num) {
		return mapper.replyList(num);
	}
}
