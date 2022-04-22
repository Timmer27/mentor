package com.mid.service;

import java.text.DecimalFormat;
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
	public roommateVO roommateInfo(String num) {
		return mapper.roommateInfo(num);
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
	
}
