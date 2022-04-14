package com.mid.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.python.icu.text.SimpleDateFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mid.VO.userPointVO;
import com.mid.VO.userboardVO;
import com.mid.mapper.mentiMapper;

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
}
