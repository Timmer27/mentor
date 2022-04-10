package com.mid.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller // 브라우저로 바로안감
@RequestMapping("/main")
public class mainController {
	
	@GetMapping("")
	public String index() {
		return "/main/main";
	}
}
