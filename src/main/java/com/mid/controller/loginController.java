package com.mid.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.mid.VO.userVO;
import com.mid.service.loginService;

@Controller
@RequestMapping("/loginRegister")
@SessionAttributes("id")
public class loginController {
	
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
	
//	회원가입 페이지 이동
	@GetMapping("/register")
	public String register() {
		return "/loginRegister/register";
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
	
	
	
//	로그아웃
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/main";
	}
}
