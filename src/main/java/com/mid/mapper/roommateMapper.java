package com.mid.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mid.VO.cityCoordinatesVO;
import com.mid.VO.roommateChatVO;
import com.mid.VO.roommateVO;

@Mapper
public interface roommateMapper {

	List<String> selectedCountry(String selectedCountry);

	List<roommateVO> getRoommateList(String cityName, String selectedCountry);

	roommateVO roommateInfo(String num);

	List<String> files(String num);

	cityCoordinatesVO getCoordinates(String cityName);

	void like(String num, String boardNum, String userType);

	int likeCheck(String num, String userNum, String userType);

	void likerevert(String num, String boardNum, String userType);

	void viewIncrease(String num);

	List<roommateVO> getRoommateListSearch(String cityName, String selectedCountry, String search);

	String getCurrency(String selectedCountry);

	int savePost(roommateVO vo);

	int saveFiles(String ainum, String savefilesName);

	List<roommateVO> getsavePost(String userNum, String userType);

	roommateVO getUserInfo(String boardNum);

	void chatSave(Map<String, String> map);

	List<roommateChatVO> chathistory(String userNum, String userType, String receiveuserNum, String receiveuserType);

	String getprofilePic(String userNum, String userType);

	List<roommateChatVO> chatList(String userType, String num);

	roommateChatVO getreceiverInfo(String num);

}
