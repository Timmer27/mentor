package com.mid.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mid.VO.userboardVO;

@Mapper
public interface mentiMapper {

	int newpost(userboardVO vo);

	String getuserNum(String id);

	void saveFiles(String saveName, String num);

	String getuserboardNum(String num);

	List<userboardVO> getBoard(String countryDBname);

	void spendPoint(Map<String, Object> map);

}
