package com.mid.service;

import java.util.List;

import org.apache.ibatis.type.MappedJdbcTypes;
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

	public List<Integer> getboardnumList() {
		return mainMapper.getboardnumList();
	}
		


}
