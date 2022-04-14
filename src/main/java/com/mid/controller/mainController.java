package com.mid.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mid.service.mainService;

@Controller // 브라우저로 바로안감
@RequestMapping("/main")
public class mainController {
	
	@Autowired
	mainService mainService;
	
//	홤녀 숫자 출력
	@GetMapping("")
	public String main(Model m) {
		m.addAttribute("userCount", mainService.userCount());
		return "/main/main";
	}
	
//	멘토링 페이지 이동
	@GetMapping("/mentoring")
	public String mentoring() {
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
