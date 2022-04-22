package com.mid.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.mid.VO.cityCoordinatesVO;
import com.mid.VO.roommateVO;
import com.mid.mapper.mainMapper;
import com.mid.mapper.mentiMapper;
import com.mid.service.roommateService;

@Controller
@RequestMapping("/roommate")
public class roommateController {
	
	@Autowired
	roommateService service;
	
	@Autowired
	mentiMapper mentiMapper;
	
	@Autowired
	mainMapper mainMapper;
	
//	메인 페이지
	@GetMapping("")
	public String main() {
		return "/roommate/roommate";
	}

//	선택한 country 기준 city 항목 출력, ajax 비동기 데이터 transfer
	@PostMapping("")
	@ResponseBody
	public Map<String, List<String>> selectedCountry(
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
		
//		나라에 맞는 통화 출력
		m.addAttribute("currency", service.getCurrency(selectedCountry));
		
		return "/roommate/roommateCity";
	}
	
//	룸메이트 구직 세부정보 출력
	@GetMapping("/brl")
	public String roommates(@RequestParam String num, @SessionAttribute(name = "num", required = false)String userNum,
			@SessionAttribute String userType, Model m){

//		나중에 필요한 num 화면에 유지
		m.addAttribute("boardNum", num);
		
//		기본 정보 출력
		m.addAttribute("roommateInfo", service.roommateInfo(num));
		
//		첨부된 파일 출력
		if(service.files(num).size() == 0) {
			m.addAttribute("filecheck", "none");
		}
		m.addAttribute("files", service.files(num));
		
//		좋아요 누른 글인지 확인
		m.addAttribute("like", service.likeCheck(num, userNum, userType));
		
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
	public void like(@SessionAttribute String num, @SessionAttribute String userType,
			@RequestParam String boardNum){
		service.like(num, boardNum, userType);
	}
	
//	좋아요 글 취소 기능
	@PostMapping("/likerevert")
	@ResponseBody
	public void likerevert(@SessionAttribute String num, @SessionAttribute String userType,
			@RequestParam String boardNum){
		service.likerevert(num, boardNum, userType);
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
	public String newpost(@SessionAttribute(required = false) String id, Model m){
		if(id==null) {
			return "redirect:/main";
		}
		
		return "/roommate/newpost";
	}
	
//	글 통화 자동 입력
	@PostMapping("/currency")
	@ResponseBody
	public Map<String, String> currency(@RequestParam String selectedCountry){
		Map<String, String> map = new HashMap<String, String>();
//		없는 통화, 즉 ?이 포함되어있으면 달러로 통일
		if(service.getCurrency(selectedCountry).contains("?")) {
			map.put("currency", "$");
			return map;
		}
		map.put("currency", service.getCurrency(selectedCountry));
		return map;
	}
	
//	글 포스팅
	@PostMapping("/savePost")
	@Transactional
	@ResponseBody
	public Map<String, Boolean> savePost(@SessionAttribute String num, 
			@SessionAttribute String userType, roommateVO vo,
			@RequestParam(required = false, name = "thumbPicSave")MultipartFile thumbpic,
			@RequestParam(required = false, name = "files")MultipartFile[] files){
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		String uploadPath = "/C:\\Eclipse\\mentor\\src\\main\\resources\\static\\upload";
		String userNum = num;
		String saveFileName = thumbpic.getOriginalFilename() + "_" + System.nanoTime();

//		썸네일 파일 서버 저장
		try {
			File file = new File(uploadPath, saveFileName);
			thumbpic.transferTo(file);
		} catch (Exception e) {
		}
		
//		개행 문자 처리
		vo.setBoardContent(vo.getBoardContent().replaceAll(System.lineSeparator(), "<br>"));
		
//		썸네일 파일 이름 DB 저장 + userNum, userType 저장
		vo.setThumbPic(saveFileName);
		vo.setUserNum(userNum);
		vo.setUserType(userType);
//		글 저장 + 썸네일 파일
		boolean post = service.savePost(vo);
		
//		추가 파일 서버 저장
		String ainum = vo.getNum();
		
		boolean filestatus = false;
		if(files.length == 0) {
			filestatus = true;
		}
		else {
			for(int i=0; i<files.length; i++) {
				try {
					String savefilesName = files[i].getOriginalFilename()  + "_" + System.nanoTime();;
					File file = new File(uploadPath, savefilesName);
					files[i].transferTo(file);
					
	//				받은 파일 값 저장 다른 filesattach DB테이블에 저장
					filestatus = service.saveFiles(ainum, savefilesName);
					
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		
//		성공 시 return true 반환
		if(post && filestatus) {
			map.put("result", true);
			return map;
		}
		map.put("result", false);
		return map;
	}
	
//	마이페이지 룸메이트 칸 이동
	@GetMapping("myRoommate")
	public String myRoommate(Model m, @SessionAttribute(required = false) String id,
			@SessionAttribute(required = false) String profile_image, @SessionAttribute(required = false) String nickName,
			@SessionAttribute(required = false) String num, @SessionAttribute(required = false) String userType) {
		
		if(id==null || num==null) {
			return "redirect:/main";
		}
		
//		개인정보 변경을 위한 저장된 이메일, 나라, 도시 출력
		m.addAttribute("modifyInfo", mainMapper.modifyInfo(id, userType));
		m.addAttribute("nickName", nickName);
		m.addAttribute("profile_image", profile_image);
		
//		저장한 글 정보 출력
		m.addAttribute("savePost", service.getsavePost(num, userType));
		
		return "/roommate/mypageRoommate";
	}

}
