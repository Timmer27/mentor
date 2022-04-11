package com.mid.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		
		System.err.println(loginMapper.kakaoLogin(map));
		
		
		return ((loginMapper.kakaoLogin(map)>0) ? true : false);
		
//		나중에 카톡 회원가입 아래로 ㄱㄱ
//		Map<String, String> map =  new HashMap<String, String>();
//		try {
//			map.put("id", vo.getId());
//			map.put("userType", (userType + "user"));
//			map.put("password", "kakaoPW");
//			map.put("nickname", vo.getNickname());
//			map.put("profile_image", vo.getProfile_image());
//			map.put("email", vo.getEmail());
//			map.put("gender", vo.getGender());
//			
//			loginMapper.kakaoLogin(map);
//			
//		} catch (Exception e) {
////			이미 등록된 사용자일 경우
//			return;
//		}
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
}
