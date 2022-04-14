package com.mid.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mid.VO.userVO;
import com.mid.mapper.loginMapper;

@Service
public class loginService {
	
	@Autowired
	loginMapper loginMapper;
		
	public boolean kakaoLogin(String userType, userVO vo) {
		Map<String, String> map =  new HashMap<String, String>();
		map.put("id", vo.getId());
		map.put("userType", (userType + "user"));
		
		return ((loginMapper.kakaoLogin(map)>0) ? true : false);
		
	}
	public boolean webLogin(String userType, String id, String password) {
		return loginMapper.webLogin(userType, id, password) > 0 ? true : false;
	}
	public boolean dubId(String userType, String id) {
		return loginMapper.dubId(userType, id)>0 ? false : true;
	}
	public boolean dubNickname(String userType, String nickname) {
		return loginMapper.dubNickname(userType, nickname)>0 ? false : true;
	}
	public boolean webRegister(userVO vo) {
		return loginMapper.webRegister(vo)>0 ? true : false;
	}
	public boolean kakaoRegister(userVO vo) {
		if(loginMapper.dubId(vo.getUserType()+"user", vo.getId())>0) {
			return false;
		}
		return loginMapper.kakaoRegister(vo) > 0 ? true : false;
	}
	public boolean GoogleRegister(userVO vo) {
		return loginMapper.GoogleRegister(vo) > 0 ? true : false;
	}
	public boolean Googlelogin(userVO vo) {
		return loginMapper.Googlelogin(vo) > 0 ? true : false;
	}
	public String getProfileImg(String userType, String id) {
		return loginMapper.getProfileImg(userType, id);
	}
}
