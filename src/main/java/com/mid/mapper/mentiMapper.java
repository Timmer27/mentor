package com.mid.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mid.VO.mentiboardReplyVO;
import com.mid.VO.userboardVO;
import com.mid.VO.userboardfilesVO;

@Mapper
public interface mentiMapper {

	int newpost(userboardVO vo);

	String getuserNum(String id);

	void saveFiles(String saveName, String num);

	String getuserboardNum(String num);

	List<userboardVO> getBoard(String countryDBname);

	void spendPoint(Map<String, Object> map);

	userboardVO mentiboard(String num);

	List<userboardVO> searchInfo(String search);

	List<userboardfilesVO> getfiles(String num);

	String getmentorNum(String id);

	int saveReply(String replyContent, String boardNum, String mentiNum, String mentorNum, String today);

	String getboardPoint(String boardNum);

	void getreputationPoint(String mentorNum, String mentiNum, String boardNum, String updatedrepPoint, String today);

	List<mentiboardReplyVO> replyList(String num);

	String recentrepPoint(String mentorNum);

	Object recentrepPointbyID(String id);

}
