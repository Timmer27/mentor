package com.mid.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mid.VO.cityCoordinatesVO;
import com.mid.VO.roommateVO;

@Mapper
public interface roommateMapper {

	List<String> selectedCountry(String selectedCountry);

	List<roommateVO> getRoommateList(String cityName, String selectedCountry);

	roommateVO roommateInfo(String num);

	List<String> files(String num);

	cityCoordinatesVO getCoordinates(String cityName);

	void like(String num, String boardNum);

	int likeCheck(String userNum);

	void likerevert(String num, String boardNum);

	void viewIncrease(String num);

	List<roommateVO> getRoommateListSearch(String cityName, String selectedCountry, String search);

}
