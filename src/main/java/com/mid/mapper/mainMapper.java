package com.mid.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mid.VO.cityCoordinatesVO;
import com.mid.VO.userPointVO;
import com.mid.VO.userVO;

@Mapper
public interface mainMapper {

	int[] userCount();

	List<Integer> getboardnumList();

	List<cityCoordinatesVO> getCityCoordinates();

	List<userVO> getUserList();

	List<userPointVO> userPointRank();

	String prevDBPic(String userType, String id);

	int updateProfileFile(String prevDBPic, String newPic, String userType);

	userVO modifyInfo(String id, String userType);

	int modify(Map<String, String> map);

	int questionNum();

	int SolvedquestionNum();

}
