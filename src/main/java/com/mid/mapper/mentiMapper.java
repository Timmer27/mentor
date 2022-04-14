package com.mid.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mid.VO.userboardVO;

@Mapper
public interface mentiMapper {

	int newpost(userboardVO vo);

	String getuserNum(String id);

	void saveFiles(String saveName, String num);

}
