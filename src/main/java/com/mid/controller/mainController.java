package com.mid.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.mid.VO.cityCoordinatesVO;
import com.mid.VO.replycountVO;
import com.mid.VO.userVO;
import com.mid.mapper.mainMapper;
import com.mid.mapper.mentiMapper;
import com.mid.service.mainService;
import com.mid.service.mentimentorService;

@Controller // 브라우저로 바로안감
@RequestMapping("/main")
@SessionAttributes({"profile_image", "nickName"})
public class mainController {
	
	@Autowired
	mainService mainService;
	
	@Autowired
	mentimentorService service;
	
	@Autowired
	mentiMapper mentiMapper;
	
	@Autowired
	mainMapper mainMapper;

	
//	시작페이지
	@GetMapping("")
	public String main(Model m) {
//		활동 회원 수 출력
		m.addAttribute("userCount", mainService.userCount());
		
//		회원 포인트 랭킹보드 출력
		m.addAttribute("userPointRank", mainService.userPointRank());
		
//		질문 수 출력
		m.addAttribute("qNum", mainService.questionNum());

//		질문 해결 수 출력
		m.addAttribute("solvedqNum", mainService.SolvedquestionNum());
		
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
//		List<replycountVO> countLikesList = new ArrayList<>();
		
//		글 목록을 출력하기 위한 보드 넘버 리스트를 뽑아서 일일이 대조
		for(int j = 0; j<list.size(); j++) {
//		출력한 number 리스트를 사용하여 댓글개수, booardNum 출력
			countList.add(service.countReplies((list.get(j) + "")));
		}
//		댓글 숫자 화면 출력
		m.addAttribute("countReplies", countList);
	
//		좋아요 숫자 화면 출력
		m.addAttribute("countLikes", service.countLikesList());
		
		return "/mentoring/mentoring";
	}

//	글쓰기 페이지 이동
	@GetMapping("/newpost")
	public String newpost() {
		return "/mentoring/newpost";
	}

//	멘티 마이페이지 이동
	@GetMapping("/mypageMenti")
	public String mypageMenti(Model m, @SessionAttribute(required = false) String id,
			@SessionAttribute(required = false) String profile_image, @SessionAttribute(required = false) String nickName,
			@SessionAttribute(required = false) String currentRepPoint, @SessionAttribute(required = false) String currentPoint,
			@SessionAttribute(required = false) String userType) {
		if(id==null) {
			return "redirect:/main";
		}
//		필요한 기본 정보 출력
		Map<String, String> map = new HashMap<String, String>();
//		멘티 num 출력
		String num = mentiMapper.getuserNum(id);
		
		map.put("num", num);
		map.put("id", id);
		map.put("profile_image", profile_image);
		map.put("nickName", nickName);
		map.put("currentPoint", currentPoint);
		
		m.addAttribute("mentorUser", map);
		
//		개인정보 변경을 위한 저장된 이메일, 나라, 도시 출력
		m.addAttribute("modifyInfo", mainMapper.modifyInfo(id, userType));
		
//		작성한 글 출력
 		m.addAttribute("writenList", mainService.writenList(id));
		
//		채택 필요한 글 출력
 		m.addAttribute("requiredList", mainService.requiredList(id));

//		좋아요 누른 글 출력
 		m.addAttribute("likedList", mainService.likedList(id, userType));
		
		return "/main/mypageMenti";
	}
	
//	멘토 마이페이지 이동
	@GetMapping("/mypageMentor")
	public String mypageMentor(Model m, @SessionAttribute(required = false) String id,
			@SessionAttribute(required = false) String profile_image, @SessionAttribute(required = false) String nickName,
			@SessionAttribute(required = false) String currentRepPoint, @SessionAttribute(required = false) String currentPoint,
			@SessionAttribute(required = false) String userType) {
		if(id==null) {
			return "redirect:/main";
		}
//		필요한 기본 정보 출력
		Map<String, String> map = new HashMap<String, String>();
//		멘토 num 출력
		String num = mentiMapper.getmentorNum(id);
		
		map.put("num", num);
		map.put("id", id);
		map.put("profile_image", profile_image);
		map.put("nickName", nickName);
		map.put("currentPoint", currentPoint);
		
		m.addAttribute("mentorUser", map);
		m.addAttribute("currentRepPoint", currentRepPoint);
		
//		개인정보 변경을 위한 저장된 이메일, 나라, 도시 출력
		m.addAttribute("modifyInfo", mainMapper.modifyInfo(id, userType));
		
//		채택된 글 출력
 		m.addAttribute("selectedList", mainService.selectedList(id));
		
//		좋아요 누른 글 출력
 		m.addAttribute("likedList", mainService.likedList(id, userType));
 		
		return "/main/mypageMentor";
	}	
	
//	마이페이지 좋아요글 전체 보기
	@GetMapping("seeAllLikes")
	public String seeAll(Model m, @RequestParam(defaultValue = "0")String pageNum,
			@RequestParam String num, @SessionAttribute String userType) {
		
		String id = mentiMapper.getID(num, userType);
		
//		전체페이지 출력
		m.addAttribute("countryList", service.seeAllLikes(Integer.valueOf(pageNum), id, userType));
		
//		페이징 넘버 출력
		m.addAttribute("countryListPageNum", service.seeAllLikesListMyPagePageNum(Integer.valueOf(pageNum), id, userType));
		
//		페이징 마지막 숫자 출력
		m.addAttribute("countryListLastPageNum", service.countryListLikesMyPageLastPageNum(Integer.valueOf(pageNum), id, userType));

//		페이징 효과를 위한 filter address
		m.addAttribute("url","main/seeAllLikes");

		
		return "/main/seeAllBoard";
	}
	
//	마이페이지 채택글 전체 보기 - 멘토
	@GetMapping("seeAllSelected")
	public String seeAllSelected(Model m, @RequestParam(defaultValue = "0")String pageNum,
			@RequestParam String num) {
		
//		전체페이지 출력
		m.addAttribute("countryList", service.seeAllSelected(Integer.valueOf(pageNum), num));
		
//		페이징 넘버 출력
		m.addAttribute("countryListPageNum", service.seeAllSelectedMyPagePageNum(Integer.valueOf(pageNum), num)); 
		
//		페이징 마지막 숫자 출력
		m.addAttribute("countryListLastPageNum", service.seeAllSelectedMyPageLastPageNum(Integer.valueOf(pageNum), num));
		
//		페이징 효과를 위한 filter address
		m.addAttribute("url","main/seeAllSelected");
		
		return "/main/seeAllBoard";
	}
	
//	마이페이지 작성글 전체 보기 - 멘티
	@GetMapping("seeAllWriten")
	public String seeAllWriten(Model m, @RequestParam(defaultValue = "0")String pageNum,
			@RequestParam String num) {
		
//		전체페이지 출력
		m.addAttribute("countryList", service.seeAllWriten(Integer.valueOf(pageNum), num));
		
//		페이징 넘버 출력
		m.addAttribute("countryListPageNum", service.seeAllWritenMyPagePageNum(Integer.valueOf(pageNum), num)); 
		
//		페이징 마지막 숫자 출력
		m.addAttribute("countryListLastPageNum", service.seeAllWritenMyPageLastPageNum(Integer.valueOf(pageNum), num));
		
//		페이징 효과를 위한 filter address
		m.addAttribute("url","main/seeAllWriten");
		
		return "/main/seeAllBoard";
	}
	
//	마이페이지 채택 요구글 전체 보기 - 멘티
	@GetMapping("seeAllrequired")
	public String seeAllrequired(Model m, @RequestParam(defaultValue = "0")String pageNum,
			@RequestParam String num) {
		
//		전체페이지 출력
		m.addAttribute("countryList", service.seeAllrequired(Integer.valueOf(pageNum), num));
		
//		페이징 넘버 출력
		m.addAttribute("countryListPageNum", service.seeAllrequiredMyPagePageNum(Integer.valueOf(pageNum), num)); 
		
//		페이징 마지막 숫자 출력
		m.addAttribute("countryListLastPageNum", service.seeAllrequiredMyPageLastPageNum(Integer.valueOf(pageNum), num));
		
//		페이징 효과를 위한 filter address
		m.addAttribute("url","main/seeAllrequired");
		
		return "/main/seeAllBoard";
	}
	
	
	
	
//	프로필 사진 변경
	@PostMapping("/profileChange")
	@Transactional
	@ResponseBody
	public Map<String, Boolean> profileChange(@SessionAttribute String userType,
			@SessionAttribute String id, @RequestParam(name = "file")MultipartFile file,
			Model m){
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		String uploadPath = "/C:/Eclipse/mentor/src/main/resources/static/upload/";
		boolean serverPic = false;
		boolean serverPicUpload = false;
		
//		전 DB사진 구하기 
		String prevDBPic = mainService.prevDBPic(userType, id);
		
//		DB사진 삭제 후 받은 파일 업로드
		String newPic = file.getOriginalFilename() + "_" + System.nanoTime();
		boolean dbPicChange = mainService.dbPicChange(prevDBPic, newPic, userType);
		
//		DB사진 삭제
		File deleteFile = new File(uploadPath + prevDBPic);
		if(deleteFile.exists()) {
			if(deleteFile.delete()) {
//				삭제 후 db profile pic 업뎃
				if(mainService.prevDBPic(userType, id).contains("http")) {
					m.addAttribute("profile_image", mainService.prevDBPic(userType, id));
				}
				else {
					m.addAttribute("profile_image", "/upload/" + mainService.prevDBPic(userType, id));
				}
				serverPic = true;
			}
			else {
				System.err.println("파일 삭제 실패");
			}
		}
		else {
			System.err.println("파일이 존재하지 않습니다.");
		}
		
//		받은 사진 재업로드
		try {
			File savefile = new File(uploadPath, newPic);
			file.transferTo(savefile);
			serverPicUpload = true;
		} catch (IllegalStateException | IOException e) {
			System.err.println(e.getMessage());
		}
		
		if(dbPicChange && serverPic && serverPicUpload) {
			map.put("result", true);
			return map;
		}
		map.put("result", false);
		return map;
	}
	
//	개인정보 변경
	@PostMapping("/modify")
	@Transactional
	@ResponseBody
	public Map<String, String> modify(@SessionAttribute String userType, @SessionAttribute String nickName,
			@SessionAttribute String id, userVO vo, Model m){
		Map<String, String> map = new HashMap<String, String>();
		
		if(mainService.modify(userType, id, vo).get("result").equals("success")) {
			map.put("result", "success");
//			변경 닉네임 업데이트
			m.addAttribute("nickName", vo.getNickname());
			return map;
		}
		return mainService.modify(userType, id, vo);
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
