package com.mid.controller;

import java.util.List;
import java.util.Map;

import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mid.service.roommateService;

@Controller
@RequestMapping("/roommate")
public class roommateController {
	
	@Autowired
	roommateService service;
	
//	메인 페이지
	@GetMapping("")
	public String main() {
		return "/roommate/roommate";
	}

//	선택한 country 기준 city 항목 출력, ajax 비동기 데이터 transfer
	@PostMapping("")
	@ResponseBody
	public Map<String, List<String>>  selectedCountry(
			@RequestParam String selectedCountry) {
		return service.selectedCountry(selectedCountry);
	}
	
//	클릭한 도시에 맞게 룸메 구직 정보 출력
	@GetMapping("/{cityName}")
	public String roommate(@PathVariable("cityName") String cityName,
			@RequestParam String selectedCountry, Model m) {
//		나라, 도시 출력
		m.addAttribute("selectedCountry", selectedCountry);
		m.addAttribute("cityName", cityName);
		
		
//		기본 정보 출력
		m.addAttribute("roommateList", service.getRoommateList(cityName, selectedCountry));
		
		
		
		return "/roommate/roommateCity";
	}

}
