package com.mid.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mid.mapper.mainMapper;

@Service
public class mainService {

	@Autowired
	mainMapper mainMapper;

	public int[] userCount() {
		return mainMapper.userCount();
	}
		


}
