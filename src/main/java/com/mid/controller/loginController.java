package com.mid.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mid.VO.userVO;
import com.mid.service.mainService;

@Controller
@RequestMapping("/loginRegister")
@SessionAttributes("id")
public class loginController {
	
	@Autowired
	mainService service;

//	로그인 페이지 이동
	@GetMapping("/login")
	public String login() {
		return "/loginRegister/login";
	}
	
//id, properties{nickname, profile_image, email, gender} // 가져오는 정보
//	카톡 로그인 DB저장 후 로그인 실행
	@PostMapping("/login")
	public String kakaoLogin(@SessionAttribute("id")String id, userVO vo) {
		service.kakaoLogin();
		
		
		return "/loginRegister/login";
	}
	
//	회원가입 페이지 이동
	@GetMapping("/register")
	public String register() {
		return "/loginRegister/register";
	}
}
