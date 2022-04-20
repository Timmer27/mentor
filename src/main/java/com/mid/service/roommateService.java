package com.mid.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mid.VO.roommateVO;
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

	public List<roommateVO> getRoommateList(String cityName, String selectedCountry) {
		return mapper.getRoommateList(cityName, selectedCountry);
	}
	
}
