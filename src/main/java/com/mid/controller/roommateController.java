package com.mid.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.mid.VO.cityCoordinatesVO;
import com.mid.mapper.mentiMapper;
import com.mid.service.roommateService;

@Controller
@RequestMapping("/roommate")
public class roommateController {
	
	@Autowired
	roommateService service;
	
	@Autowired
	mentiMapper mentiMapper;
	
//	메인 페이지
	@GetMapping("")
	public String main() {
		return "/roommate/roommate";
	}

//	선택한 country 기준 city 항목 출력, ajax 비동기 데이터 transfer
	@PostMapping("")
	@ResponseBody
	public Map<String, List<String>>  selectedCountry(
			@RequestParam String selectedCountry) {
		return service.selectedCountry(selectedCountry);
	}
	
//	클릭한 도시에 맞게 룸메 구직 정보 출력
	@GetMapping("/{cityName}")
	public String roommate(@PathVariable("cityName") String cityName,
			@RequestParam(defaultValue = "1")String num,
			@RequestParam String selectedCountry, Model m) {
//		나라, 도시 출력
		m.addAttribute("selectedCountry", selectedCountry);
		m.addAttribute("cityName", cityName);
		
//		기본 정보 출력
		m.addAttribute("roommateList", service.getRoommateList(num, cityName, selectedCountry));
//		기본정보 페이지 넘버 출력
		m.addAttribute("roommateListPageNum", service.roommateListPageNum(num, cityName, selectedCountry));
		
		return "/roommate/roommateCity";
	}
	
//	룸메이트 구직 세부정보 출력
	@GetMapping("/brl")
	public String roommate(@RequestParam String num, @SessionAttribute(name = "num", required = false)String userNum, Model m){

//		나중에 필요한 num 화면에 유지
		m.addAttribute("boardNum", num);
		
//		기본 정보 출력
		m.addAttribute("roommateInfo", service.roommateInfo(num));
//		첨부된 파일 출력
		m.addAttribute("files", service.files(num));
		
//		좋아요 누른 글인지 확인
		m.addAttribute("like", service.likeCheck(userNum));
		
//		조회수 증가 반영
		service.viewIncrease(num);
		
		return "/roommate/roommateInfo";
	}
	
//	도시 coordinates 지도정보 반환
	@PostMapping("/getCoordinates")
	@ResponseBody
	public Map<String, Double> getCoordinates(@RequestParam String cityName){
		Map<String, Double> map = new HashMap<String, Double>();
		cityCoordinatesVO vo = service.getCoordinates(cityName);
		map.put("lng", vo.getLng());
		map.put("lat", vo.getLat());
		
		return map;
	}
	
//	좋아요 글 기능
	@PostMapping("/like")
	@ResponseBody
	public void like(@SessionAttribute String num,
			@RequestParam String boardNum){
		service.like(num, boardNum);
	}
	
//	좋아요 글 취소 기능
	@PostMapping("/likerevert")
	@ResponseBody
	public void likerevert(@SessionAttribute String num,
			@RequestParam String boardNum){
		service.likerevert(num, boardNum);
	}
	
//	검색 기능 post로 받아서 초기 데이터 출력
	@PostMapping("/search")
	public String search(@RequestParam String cityName,
			@RequestParam(defaultValue = "1")String num,
			@RequestParam String selectedCountry, @RequestParam(name = "search") String search, Model m) {

//		검색 키워드
		m.addAttribute("search", search);
//		나라, 도시 출력
		m.addAttribute("selectedCountry", selectedCountry);
		m.addAttribute("cityName", cityName);
		
//		기본 정보 출력
		m.addAttribute("roommateList", service.getRoommateListSearch(num, cityName, selectedCountry, search));
//		기본정보 페이지 넘버 출력
		m.addAttribute("roommateListPageNum", service.roommateListSearchPageNum(num, cityName, selectedCountry, search));
		
		return "/roommate/roommateCitySearch";
	}
	
//	검색 기능, 검색 결과 가진 데이터만 출력 mapping
	@GetMapping("/search")
	public String getsearch(@RequestParam String cityName,
			@RequestParam(defaultValue = "1")String num,
			@RequestParam String selectedCountry, @RequestParam(name = "search") String search, Model m) {
		
//		검색 키워드
		m.addAttribute("search", search);
//		나라, 도시 출력
		m.addAttribute("selectedCountry", selectedCountry);
		m.addAttribute("cityName", cityName);
		
//		기본 정보 출력
		m.addAttribute("roommateList", service.getRoommateListSearch(num, cityName, selectedCountry, search));
//		기본정보 페이지 넘버 출력
		m.addAttribute("roommateListPageNum", service.roommateListSearchPageNum(num, cityName, selectedCountry, search));
		
		return "/roommate/roommateCitySearch";
	}
	
	
//	룸메이트 글 등록하기
	@GetMapping("/newpost")
	@Transactional
	public String newpost(Model m){
	
		return "/roommate/newpost";
	}
	


}
