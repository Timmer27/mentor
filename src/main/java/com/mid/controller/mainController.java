package com.mid.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.mid.service.mainService;

@Controller // 브라우저로 바로안감
@RequestMapping("/main")
public class mainController {
	
	@Autowired
	mainService mainService;
	
	@GetMapping("")
	public String index(Model m) {
		m.addAttribute("userCount", mainService.userCount());
		return "/main/main";
	}
}
