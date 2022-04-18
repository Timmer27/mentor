package com.mid.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface mainMapper {

	int[] userCount();

	List<Integer> getboardnumList();

}
