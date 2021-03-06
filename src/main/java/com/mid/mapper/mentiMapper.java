package com.mid.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mid.VO.mentiboardReplyVO;
import com.mid.VO.replycountVO;
import com.mid.VO.userVO;
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

	replycountVO countReplies(String countryDBname, String boardNum);

	replycountVO countReplies(String boardNum);

	int like(String boardNum);

	int saveLikePost(String boardNum, String userType, String id);

	int likeRevert(String boardNum);

	int saveLikePostRevert(String boardNum, String userType, String id);

	int likecheck(String id, String boardNum, String userType);

	List<replycountVO> countLikesList();

	List<userboardVO> seeAllList(String country);

	List<userboardVO> seeAllListFiltered(String country, String type);

	int recentrepPointbyNum(String mentorNum);

	userVO mentiuser(String userNum);

	mentiboardReplyVO getboardReply(String replyNum);

	String recentcurPoint(String mentorNum);

	int accruedPoint(String adjustedPoint, String point, String mentorNum, String boardNum, String today);

	void selection(String replyNum);

	int selectedReply(String boardNum);

	void selectionBoard(String boardNum);

	List<userboardVO> selectedBoardList();

	void viewIncrease(String boardNum);

	int view(String num);

	int[] selectedBoardNumList(String num);

	userboardVO boardInfo(int num);

	List<userboardVO> seeAllMyPage(String num);

	int[] likedList(String id, String userType);

	List<userboardVO> seeAllLikesMyPage(String id, String userType);

	String getID(String num, String userType);

	List<userboardVO> seeAllSelectedMyPage(String num);

	List<userboardVO> writenList(String num);

	List<userboardVO> requiredList(String num);

	List<userboardVO> seeAllMyPageWritten(String num);

	List<userboardVO> seeAllMyPageRequired(String num);

}
