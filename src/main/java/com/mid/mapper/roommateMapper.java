package com.mid.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mid.VO.roommateVO;

@Mapper
public interface roommateMapper {

	List<String> selectedCountry(String selectedCountry);

	List<roommateVO> getRoommateList(String cityName, String selectedCountry);

}
