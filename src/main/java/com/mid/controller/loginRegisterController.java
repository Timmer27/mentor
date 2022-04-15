package com.mid.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.python.modules.struct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
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
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.mid.VO.userPointVO;
import com.mid.VO.userVO;
import com.mid.service.loginService;

@Controller
@RequestMapping("/loginRegister")
@SessionAttributes({"id", "nickName", "userType", "profile_image", "currentPoint"})
public class loginRegisterController {
	
	@Autowired
	ResourceLoader resourceLoader;
	
	@Autowired
	loginService service;

//	로그인 페이지 이동
	@GetMapping("/login")
	public String login(@SessionAttribute(value = "id", required = false)String id) {
		if(id!=null) {
			return "/loginrequired";
		}
		return "/loginRegister/login";
	}
	
//id, properties{nickname, profile_image, email, gender} // 가져오는 정보
//	카톡 로그인 실행
	@PostMapping("/login")
	@ResponseBody
	public boolean kakaoLogin(@RequestParam String userType, userVO vo, Model m) {
		if(service.kakaoLogin(userType, vo)) {
			m.addAttribute("id", vo.getId());
			m.addAttribute("nickName", vo.getNickname());
			m.addAttribute("userType", vo.getUserType());
			m.addAttribute("currentPoint", service.getpointN(userType, vo));
			
			if(vo.getProfile_image().contains("http")) {
				m.addAttribute("profile_image", vo.getProfile_image());
			}
			else {
				m.addAttribute("profile_image", ("/image/upload/"+vo.getProfile_image()));
			}
			return true;
		}
		return false;
	}
	
//	네이버 로그인 - 수정 예정
//	@PostMapping("/Naverlogin")
//	@ResponseBody
//	public boolean Naverlogin(@RequestParam String userType, userVO vo, Model m) {
//		if(service.kakaoLogin(userType, vo)) {
//			m.addAttribute("id", vo.getId());
//				m.addAttribute("userType", vo.getUserType());
//				return true;
//		}
//		return false;
//	}
	
//	구글 로그인
	@PostMapping("/Googlelogin")
	@ResponseBody
	public Map<String, Boolean> Googlelogin(userVO vo, Model m) {
		Map<String, Boolean> map = new HashMap<>();
		if(service.Googlelogin(vo)) {
			
			m.addAttribute("id", vo.getId());
			m.addAttribute("userType", vo.getUserType());
			m.addAttribute("nickName", vo.getNickname());
			m.addAttribute("currentPoint", service.getpointN(vo.getUserType(), vo));

			
			if(vo.getProfile_image().contains("http")) {
				m.addAttribute("profile_image", vo.getProfile_image());
			}
			else {
				m.addAttribute("profile_image", ("/image/upload/"+vo.getProfile_image()));
			}
			
			map.put("result", true);
			
			return map;
		}
		map.put("result", false);
		return map;
	}
//	웹 로그인 - DB
	@PostMapping("/webLogin")
	@ResponseBody
	public boolean webLogin(@RequestParam String userType, String password, String id, Model m) {
		userVO vo = new userVO();
		vo.setId(id);
		if(service.webLogin((userType+"user"), id, password)) {
			m.addAttribute("id", id);
			m.addAttribute("userType", userType);
			m.addAttribute("nickName", service.getnickName(userType, id));
			m.addAttribute("currentPoint", service.getpointN(userType, vo));

			String profile_image = service.getProfileImg(userType, id);
			
			if(profile_image.contains("http")) {
				m.addAttribute("profile_image", profile_image);
			}
			else {
				m.addAttribute("profile_image", ("/image/upload/"+profile_image));
			}
			return true;
		}
		return false;
	}
	
//	기본 회원가입 페이지 이동
	@GetMapping("/register")
	public String register(@SessionAttribute(name = "id", required = false) String id) {
		if(id!=null){
			return "redirect:/main";
		}
		return "/loginRegister/registerChoose";
	}
	
//	멘토 회원가입 페이지 이동
	@GetMapping("/mentorRegister")
	public String mentorRegister(@SessionAttribute(name = "id", required = false) String id) {
		if(id!=null){
			return "redirect:/main";
		}
		return "/loginRegister/mentorRegister";
	}
	
//	멘티 회원가입 페이지 이동
	@GetMapping("/mentiRegister")
	public String mentiRegister(@SessionAttribute(name = "id", required = false) String id) {
		if(id!=null){
			return "redirect:/main";
		}
		return "/loginRegister/mentiRegister";
	}
	
//	아이디 중복확인
	@PostMapping("/dupId")
	@ResponseBody
	public Map<String, Boolean> dubId(String userType, String id) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("result", service.dubId((userType + "user"), id));
		return map;
	}
	
//	닉네임 중복확인
	@PostMapping("/dupNickname")
	@ResponseBody
	public  Map<String, Boolean> dubNickname(String userType, String nickname) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("result", service.dubNickname((userType + "user"), nickname));
		return map;
	}
	
//	웹 회원가입
	@PostMapping("/webRegister")
	@Transactional
	@ResponseBody
	public  Map<String, Boolean> webRegister(userVO vo, @RequestParam(name="profilePicture")MultipartFile mfile) {
		
		String saveFileName = mfile.getOriginalFilename() + "|" + System.nanoTime();
		
		try {
			String uploadPath = "/C:\\Eclipse\\mentor\\src\\main\\resources\\static\\upload";
			File file = new File(uploadPath, saveFileName);
			mfile.transferTo(file);
		} catch (Exception e) {
		}
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		vo.setProfile_image(saveFileName);
		map.put("result", service.webRegister(vo));
		
		return map;
	}
	
//	카카오톡 회원가입
	@PostMapping("/kakaoRegister")
	@ResponseBody
	public  Map<String, Boolean> kakaoRegister(userVO vo, Model m) {
		if(service.kakaoRegister(vo)) {
			m.addAttribute("id");
		}
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("result", service.kakaoRegister(vo));
		
		return map;	
	}
	
////	네이버 회원가입
//	@PostMapping("/NaverRegister")
//	@ResponseBody
//	public  Map<String, Boolean> NaverRegister(userVO vo, Model m) {
////		if(service.kakaoRegister(vo)) {
////			m.addAttribute("id");
////		}
//		System.err.println(vo.getEmail());
//		System.err.println(vo.getNickname());
//		System.err.println(vo.getId());
//		
//		Map<String, Boolean> map = new HashMap<String, Boolean>();
////		map.put("result", service.kakaoRegister(vo));
//		
//		return map;	
//	}
	
//	구글 회원가입
	@PostMapping("/GoogleRegister")
	@ResponseBody
	public Map<String, Boolean> GoogleRegister(userVO vo, Model m) {
		if(service.GoogleRegister(vo)) {
			m.addAttribute("id");
		}
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		map.put("result", service.GoogleRegister(vo));
		
		return map;	
	}
	
	
	
	
	
	//사진업로드, 잠시 보류
	@PostMapping("/uploadProfile")
	@ResponseBody
	public Map<String, Boolean> uploadProfile(@RequestParam(name = "picture")MultipartFile mfile, HttpServletResponse response) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		System.err.println(mfile.getOriginalFilename());
		String uploadPath = "/C:\\Eclipse\\mentor\\src\\main\\resources\\static\\upload";
		
		File file = new File(uploadPath, mfile.getOriginalFilename());
		
		try {
			mfile.transferTo(file);
			map.put("result", true);
			return map;
			
		} catch (IllegalStateException | IOException e) {
			map.put("result", false);
			return map;
		}
	
	}	
	
	
//	로그아웃
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/main";
	}
}
