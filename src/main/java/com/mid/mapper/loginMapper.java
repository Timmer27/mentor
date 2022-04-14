package com.mid.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mid.VO.userVO;

@Mapper
public interface loginMapper {

	void getList(String dbName);

	int kakaoLogin(Map<String, String> map);

	int webLogin(String userType, String id, String password);

	int dubId(String userType, String id);

	int dubNickname(String userType, String nickname);

	int webRegister(userVO vo);

	int kakaoRegister(userVO vo);

	int GoogleRegister(userVO vo);

	int Googlelogin(userVO vo);

	String getProfileImg(String userType, String id);

}
