package com.mid.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mid.VO.cityCoordinatesVO;
import com.mid.VO.replycountVO;
import com.mid.VO.userVO;
import com.mid.service.mainService;
import com.mid.service.mentimentorService;

@Controller // 브라우저로 바로안감
@RequestMapping("/main")
public class mainController {
	
	@Autowired
	mainService mainService;
	
	@Autowired
	mentimentorService service;
	
//	시작페이지
	@GetMapping("")
	public String main(Model m) {
//		활동 회원 수 출력
		m.addAttribute("userCount", mainService.userCount());
		
//		회원 포인트 랭킹보드 출력
		m.addAttribute("userPointRank", mainService.userPointRank());
		
		return "/main/main";
	}
	
//	시작 맵 이용자 표시
	@PostMapping("")
	@ResponseBody
	public List<Map<String, Object>> mainMap() {
		
		List<userVO> userList = mainService.getUserList();
		List<cityCoordinatesVO> cityList = mainService.getCityCoordinates();
		
		List<Map<String, Object>> coordinates = new ArrayList<>();
		
		for(int i = 0; i<userList.size(); i++) {
			
			for(int j = 0; j<cityList.size(); j++) {
				if(cityList.get(j).getCity().contains(userList.get(i).getCity())) {
					Map<String, Object> map = new HashMap<String, Object>();
					List<Double> tmp = new ArrayList<>();

					map.put("id", userList.get(i).getId());
					
					if(userList.get(i).getProfile_image().contains("http")) {
						map.put("profile", userList.get(i).getProfile_image());
					}
					else {
						map.put("profile", "/upload/" + userList.get(i).getProfile_image());
					}
					
					map.put("city", userList.get(i).getCity());
					
					tmp.add(cityList.get(i).getLng());
					tmp.add(cityList.get(i).getLat());

					map.put("coordiates", tmp);
					
					coordinates.add(map);
				}
			}
		}
		return coordinates;
	}
	
//	멘토링 페이지 이동
	@GetMapping("/mentoring")
	public String mentoring(Model m) {
		
//		나라별로 글 목록 출력
		String[] countryList={"usaBoard", "caBoard", "eurBoard", "jpBoard", "cnBoard", "apBoard", "meBoard"};
		String[] countryDBList= {"미국", "캐나다", "유럽", "일본", "중국", "동남아", "중동"};
		
		for(int i = 0; i<countryDBList.length; i++) {
			m.addAttribute(countryList[i], service.getBoard(countryDBList[i]));
		}
		
//		글 목록 출력 후 아래의 댓글 개수 입력
//		표시 리스트 수가 4개이므로 4개만 출력 후 대조
		List<Integer> list = mainService.getboardnumList();
		List<replycountVO> countList = new ArrayList<>();
		List<replycountVO> countLikesList = new ArrayList<>();
		
//		글 목록을 출력하기 위한 보드 넘버 리스트를 뽑아서 일일이 대조
		for(int j = 0; j<list.size(); j++) {
//		출력한 number 리스트를 사용하여 댓글개수, booardNum 출력
			countList.add(service.countReplies((list.get(j) + "")));
		}
//		댓글 숫자 화면 출력
		m.addAttribute("countReplies", countList);
	
//		좋아요 숫자 화면 출력
		m.addAttribute("countLikes", service.countLikesList());
		
////		이미 채택된 글이라면 채택됨 출력
//		m.addAttribute("selectedList", service.selectedBoardList());
		
		return "/mentoring/mentoring";
	}

	//	글쓰기 페이지 이동
	@GetMapping("/newpost")
	public String newpost() {
		return "/mentoring/newpost";
	}
	
//	자유게시판 이동
	@GetMapping("/board")
	public String board() {
		return "/categories/board";
	}
	
//	룸메이트 이동
	@GetMapping("/rommate")
	public String rommate() {
		return "/categories/rommate";
	}
	
//	유학정보 이동
	@GetMapping("/univInfo")
	public String univInfo() {
		return "/categories/univInfo";
	}
	
}
