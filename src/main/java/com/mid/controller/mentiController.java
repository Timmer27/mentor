package com.mid.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.mid.VO.userboardVO;
import com.mid.mapper.mentiMapper;
import com.mid.service.mentiService;

@Controller // 브라우저로 바로안감
@RequestMapping("/menti")
public class mentiController {
	
	@Autowired
	mentiService service;
	
//	글쓰기 페이지 이동
	@GetMapping("/newpost")
	public String newpost(@SessionAttribute(name ="id", required = false) String id) {
		if(id==null) {
			return "/loginrequired";
		}
		//곧 글 리스트 포스팅 예정 
		
		return "/mentoring/newpost";
	}

//	글작성 후 포스팅
	@Transactional
	@PostMapping("/newpost")
	public String newpostwrite(@SessionAttribute String id, userboardVO vo, @RequestParam(name = "files", required = false)MultipartFile[] files){

//		System.err.println("test " + vo.getCity());
//		System.err.println("test " + vo.getCountry());

//		받은 파일 저장
		String uploadPath = "C:/Eclipse/mentor/src/main/resources/static/upload";
		
		try {
			for(int i=0; i<files.length; i++) {
				String saveName = files[i].getOriginalFilename() + "." + System.nanoTime();
				
				File file = new File(uploadPath, saveName);
				files[i].transferTo(file);
				service.saveFiles(saveName, id);
				}
		} catch (IllegalStateException | IOException e) {
			System.err.println(e.getMessage());
		}
//		받은 게시판 정보 저장
		if(service.newpost(vo, id)) {
			return "/mentoring/mentoring";
		};
		return "/mentoring/mentoring";
	}
}
