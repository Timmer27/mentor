package com.mid.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
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

import com.mid.VO.userVO;
import com.mid.service.loginService;

@Controller
@RequestMapping("/loginRegister")
@SessionAttributes("id")
public class loginRegisterController {
	
	@Autowired
	ResourceLoader resourceLoader;
	
	@Autowired
	loginService service;

//	로그인 페이지 이동
	@GetMapping("/login")
	public String login(@SessionAttribute(value = "id", required = false)String id) {
		if(id!=null) {
			return "redirect:/main";
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
			return true;
		}
		return false;
	}
	
//	웹 로그인 - DB
	@PostMapping("/webLogin")
	@ResponseBody
	public boolean webLogin(@RequestParam String userType, String password, String id, Model m) {
		if(service.webLogin((userType+"user"), id, password)) {
			m.addAttribute("id", id);
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
	@ResponseBody
	public  Map<String, Boolean> webRegister(userVO vo) {
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
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
			System.err.println(e.getMessage());
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
