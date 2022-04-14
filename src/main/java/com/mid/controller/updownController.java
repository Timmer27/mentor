package com.mid.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;



@Controller
@RequestMapping("/updown")
public class updownController {
//	파일 내려받기, 다운로드 할 때 필요함
	@Autowired
	ResourceLoader resourceLoader;
	
	@GetMapping("/uploadTest")
	public String uploadTest() {
		return "/upload/uploadTest";
	}
	
	@PostMapping("/upload")
	@ResponseBody
	public String upload(@RequestParam("author")String author,
			@RequestParam("files") MultipartFile[] mfiles,
			HttpServletRequest request) {
//		받은 파일은 여러개니까 배열로 오고 작성자 author텍스느느 String 으로 받ㄷ아온다.
//		request 형식을 받아와야하니까 servletrequest도 선언한다	.
		
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/WEB-INF/upload");
//		경로 지정을 잘해야된다. 디렉토리가 없으면 오류가 남
//		그 context객체를 이용해서 절대경로를 구할 수 있다. = 파일 저장을 위해 절대경로를 구해야 함
//		절대경로를 context.getRealPath로 구해서 savePath로 저장해준다.
		
		try {
			for(int i = 0; i<mfiles.length; i++) {
				mfiles[i].transferTo(new File(savePath + "|" + mfiles[i].getOriginalFilename()));
//				여러 파일을 배열로 돌려서 transferTo, 즉 해당 경로로 transfer시킴
//				해당 파일을 new File을 통해 구한 절대경로와 파일의 Original Name을 받아와서 저장한다. 
//				original name은 getOriginalFileName으로 구할 수 있다.
				
//				multipartFile 주요 메서드
//	            String cType = mfiles[i].getContentType();
//	            String pName = mfiles[i].getName();
//	            Resource res = mfiles[i].getResource();
//	            long fSize = mfiles[i].getSize();
//	            boolean empty = mfiles[i].isEmpty();
//	            */
			}
	         String msg = String.format("파일(%d)개 저장성공(작성자:%s)", mfiles.length,author);
	         return msg;
		} catch (Exception e) {
	         e.printStackTrace();
	         return "파일 저장 실패:";

		}
	}
//	다운로드 메서드 = 잡다한 코드가 뭉쳐있어서 원하는 곳만 수정해서 재사용 할 것
//	파일이름과 getMapping만 맞으면 자동으로 다운로드가 됨
	@GetMapping("download/{filename}")
	   public ResponseEntity<Resource> download(
	         HttpServletRequest request,
	         @PathVariable String filename){
//			Resources를 구해서 = 파일 경로를 구해서
		      Resource resource = resourceLoader.getResource("WEB-INF/upload/"+filename);
		      System.out.println("파일명:"+resource.getFilename());
		      String contentType = null;
	        try {
	        	contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	 
	        if(contentType == null) {
	            contentType = "application/octet-stream";
	        }
	 
//	        return은 다운로드하는 메서드
	        return ResponseEntity.ok()
	                .contentType(MediaType.parseMediaType(contentType))
//	                http헤더에 meta데이터를 넣고 = 이용자 화면에 뜨지않고 바로 다운로드 창으로 가게 해준다
	                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
//					실제데이터를 body에 넣어서 다운로드를 동작시킨다
	                .body(resource);
	   }
	
}
