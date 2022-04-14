package com.mid.service;

import java.util.Date;

import org.python.icu.text.SimpleDateFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mid.VO.userboardVO;
import com.mid.mapper.mentiMapper;

@Service
public class mentiService {
	
	@Autowired
	mentiMapper mapper;

	public boolean newpost(userboardVO vo, String id) {
//		오늘날짜 구하기
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(date);
		
//		유저 번호 구하기
		String num = mapper.getuserNum(id);
		
		vo.setUserNum(num);
		vo.setBoardDate(today);
		
		return mapper.newpost(vo) > 0 ? true : false;
	}

	public void saveFiles(String saveName, String id) {
//		유저 번호 구하기
		String num = mapper.getuserNum(id);
		
		mapper.saveFiles(saveName, num);
		
	}

	
	
}
