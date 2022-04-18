package com.mid.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mid.VO.cityCoordinatesVO;
import com.mid.VO.userPointVO;
import com.mid.VO.userVO;
import com.mid.mapper.mainMapper;

@Service
public class mainService {

	@Autowired
	mainMapper mainMapper;

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
		

}
