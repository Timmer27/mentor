package com.mid.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mid.VO.cityCoordinatesVO;
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
	// 기본 룸메 구직 정보 출력
	public List<roommateVO> getRoommateList(String num, String cityName, String selectedCountry) {
		PageHelper.startPage(Integer.valueOf(num), 10);
		PageInfo<roommateVO> pageinfo = new PageInfo<roommateVO>(mapper.getRoommateList(cityName, selectedCountry));
		
		return pageinfo.getList();
	}
	// 기본 룸메 구직 정보 페이지 번호 출력
	public int[] roommateListPageNum(String num, String cityName, String selectedCountry) {
		PageHelper.startPage(Integer.valueOf(num), 10);
		PageInfo<roommateVO> pageinfo = new PageInfo<roommateVO>(mapper.getRoommateList(cityName, selectedCountry));
		
		return pageinfo.getNavigatepageNums();
	}
	public roommateVO roommateInfo(String num) {
		return mapper.roommateInfo(num);
	}
	public List<String> files(String num) {
		return mapper.files(num);
	}
	public cityCoordinatesVO getCoordinates(String cityName) {
		return mapper.getCoordinates(cityName);
	}
	public void like(String num, String boardNum) {
		mapper.like(num, boardNum);
	}
	public int likeCheck(String userNum) {
		return mapper.likeCheck(userNum);
	}
	public void likerevert(String num, String boardNum) {
		mapper.likerevert(num, boardNum);
		
	}
	public void viewIncrease(String num) {
		mapper.viewIncrease(num);
	}
	
//	검색 룸메 구직 정보 
	public List<roommateVO> getRoommateListSearch(String num, String cityName, String selectedCountry, String search) {
		PageHelper.startPage(Integer.valueOf(num), 10);
		PageInfo<roommateVO> pageinfo = new PageInfo<roommateVO>(mapper.getRoommateListSearch(cityName, selectedCountry, "%"+search+"%"));
		
		return pageinfo.getList();
	}
	
//	검색 룸메 구직 정보 페이징 번호
	public int[] roommateListSearchPageNum(String num, String cityName, String selectedCountry, String search) {
		PageHelper.startPage(Integer.valueOf(num), 10);
		PageInfo<roommateVO> pageinfo = new PageInfo<roommateVO>(mapper.getRoommateListSearch(cityName, selectedCountry, "%"+search+"%"));
		
		return pageinfo.getNavigatepageNums();
	}
	
}
