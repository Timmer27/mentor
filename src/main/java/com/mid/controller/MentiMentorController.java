package com.mid.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.python.modules.itertools.count;
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

import com.mid.VO.mentiboardReplyVO;
import com.mid.VO.userPointVO;
import com.mid.VO.userboardVO;
import com.mid.VO.userboardfilesVO;
import com.mid.mapper.loginMapper;
import com.mid.mapper.mentiMapper;
import com.mid.service.mentimentorService;

@Controller // 브라우저로 바로안감
@RequestMapping("/menti")
@SessionAttributes("currentPoint")
public class MentiMentorController {
	
	@Autowired
	mentimentorService service;
	
	@Autowired
	mentiMapper mapper;

	@Autowired
	loginMapper loginMapper;
	
//	글쓰기 페이지 이동
	@GetMapping("/newpost")
	public String newpost(@SessionAttribute(name ="id", required = false) String id) {
		if(id==null) {
			return "/loginrequired";
		}
		return "/mentoring/newpost";
	}

//	글작성 후 포스팅 - menti
	@Transactional
	@PostMapping("/newpost")
	public String newpostwrite(@SessionAttribute String userType, @SessionAttribute String id, @SessionAttribute String currentPoint, userboardVO vo, @RequestParam(name = "files", required = false)MultipartFile[] files, Model m){
		
//		mentiboardReplyVO v = new mentiboardReplyVO();
//		작성한 유저번호 구하기
		String usernum = mapper.getuserNum(id);
		
//		useGeneratedKey를 사용한 autoincrement 숫자 구하기
		String boardNum = vo.getNum();

//		받은 게시판 정보 저장
		service.newpost(vo, usernum, boardNum, currentPoint, userType);
		int updatedPoint = Integer.valueOf(currentPoint) - Integer.valueOf(vo.getBoardPoint());
		m.addAttribute("currentPoint", updatedPoint);

//		받은 파일 저장
		String uploadPath = "C:/Eclipse/mentor/src/main/resources/static/upload";
		try {
			for(int i=0; i<files.length; i++) {
				String saveName = files[i].getOriginalFilename() + "." + System.nanoTime();
				
				File file = new File(uploadPath, saveName);
				files[i].transferTo(file);
				service.saveFiles(saveName, boardNum);
			}
		} catch (IllegalStateException | IOException e) {
			System.err.println(e.getMessage());
		}
		return "redirect:/main/mentoring";
	}
	
//	게시글 세부사항 출력 - detail
	@GetMapping("mentiboard")
	public String mentiboard(@RequestParam String num, Model m) {
		
//		저장된 댓글 목록 출력
		m.addAttribute("replyList", service.replyList(num));
		
//		저장된 파일, 글 리스트 출력
		m.addAttribute("fileList", service.getfiles(num));
		m.addAttribute("list", service.mentiboard(num));

		return "/mentoring/questionBoard";
	}
	
//	글 검색기능
	@PostMapping("/search")
	public String search(@RequestParam("seacrh")String search, Model m) {
		
		m.addAttribute("search", search);
		m.addAttribute("list", service.searchInfo(search));
		
		return "/mentoring/searchBoard";
	}
	
//	댓글 달기 기능 - 만약 board 포인트가 0이라면 repPoint 적립
	@PostMapping("saveReply")
	@ResponseBody
	public Map<String, Boolean> saveReply(@RequestParam String replyContent, @RequestParam String boardNum, @RequestParam String mentiNum, @RequestParam String id){
		String boardPoint = mapper.getboardPoint(boardNum);
		String mentorNum = mapper.getmentorNum(id);

//		명예 포인트 적립 - service에서 누적적립 로직 실행
		if(Integer.parseInt(boardPoint) == 0) {
			service.getreputationPoint(mentorNum, mentiNum, boardNum);
		}
		
//		댓글 저장
		Map<String, Boolean> map = service.saveReply(replyContent, boardNum, mentiNum, mentorNum);
			
		return map;
	}
	
}
