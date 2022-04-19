package com.mid.mapper;

import java.util.List;

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

}
