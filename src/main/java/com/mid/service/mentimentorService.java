package com.mid.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.python.icu.text.SimpleDateFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mid.VO.mentiboardReplyVO;
import com.mid.VO.replycountVO;
import com.mid.VO.userVO;
import com.mid.VO.userboardVO;
import com.mid.VO.userboardfilesVO;
import com.mid.mapper.mentiMapper;

@Service
@SessionAttributes("")
public class mentimentorService {
	
	@Autowired
	mentiMapper mapper;

	public boolean newpost(userboardVO vo, String usernum, String boardNum, String currentPoint, String userType) {
//		오늘날짜 구하기
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today = sdf.format(date);
		
//		소모한 포인트 반영
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("userType", userType);
		map.put("mentiNum", usernum);
		map.put("mentiboardnum", boardNum);
		map.put("currentPoint", (Integer.valueOf(currentPoint) - Integer.valueOf(vo.getBoardPoint())) );
		map.put("spendDate", today);
		map.put("spendAmount", vo.getBoardPoint());
		mapper.spendPoint(map);
		
//		포스팅 저장
		vo.setUserNum(usernum);
		vo.setBoardDate(today);
		
		return mapper.newpost(vo) > 0 ? true : false;
	}

	public void saveFiles(String saveName, String num) {
		mapper.saveFiles(saveName, num);
	}

	public List<userboardVO> getBoard(String countryDBname) {
		return mapper.getBoard(countryDBname);
	}

	public userboardVO mentiboard(String num) {
		return mapper.mentiboard(num);
	}

	public List<userboardVO> searchInfo(String search) {
		return mapper.searchInfo("%" + search + "%");
	}

	public List<userboardfilesVO> getfiles(String num) {
		return mapper.getfiles(num);
	}

	public Map<String, Boolean> saveReply(String replyContent, String boardNum, String mentiNum, String mentorNum) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today = sdf.format(date);
		
		
		if(mapper.saveReply(replyContent, boardNum, mentiNum, mentorNum, today)>0) {
			map.put("result", true);
			return map;
		}
		map.put("result", false);
		return map;
		
	}
	public void getreputationPoint(String mentorNum, String mentiNum, String boardNum) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(date);
		
//		명예포인트 누적합
		String repPoint = mapper.recentrepPoint(mentorNum);
		String updatedrepPoint = (Integer.valueOf(repPoint) + 1) + "";

		mapper.getreputationPoint(mentorNum, mentiNum, boardNum, updatedrepPoint, today);
	}

	public List<mentiboardReplyVO> replyList(String num) {
		return mapper.replyList(num);
	}

	public replycountVO countReplies(String countryDBname, String boardNum) {
		return mapper.countReplies(countryDBname, boardNum);
	}

	public replycountVO countReplies(String boardNum) {
		return mapper.countReplies(boardNum);
	}

	public int like(String boardNum) {
		return mapper.like(boardNum);
	}

	public int saveLikePost(String boardNum, String userType, String id) {
		return mapper.saveLikePost(boardNum, userType, id);
	}
	
	public int likeRevert(String boardNum) {
		return mapper.likeRevert(boardNum);
	}

	public int saveLikePostRevert(String boardNum, String userType, String id) {
		return mapper.saveLikePostRevert(boardNum, userType, id);
	}

	public boolean likecheck(String id, String boardNum, String userType) {
		return mapper.likecheck(id, boardNum, userType)>0 ? true : false;
	}

	public List<replycountVO> countLikesList() {
		return mapper.countLikesList();
	}

	public List<userboardVO> seeAllList(int pageNum, String country) {
		
		country = filterCountry(country);
		
		PageHelper.startPage(pageNum, 15);
		PageInfo<userboardVO> pageinfo = new PageInfo<userboardVO>(mapper.seeAllList(country));
		
		return pageinfo.getList();
		
	}

	public int[] seeAllListPageNum(int pageNum, String country) {
		
		country = filterCountry(country);
		
		PageHelper.startPage(pageNum, 15);
		PageInfo<userboardVO> pageinfo = new PageInfo<userboardVO>(mapper.seeAllList(country));
		
		return pageinfo.getNavigatepageNums();
	}

	public int countryListLastPageNum(int pageNum, String country) {
		country = filterCountry(country);
		
		PageHelper.startPage(pageNum, 15);
		PageInfo<userboardVO> pageinfo = new PageInfo<userboardVO>(mapper.seeAllList(country));
		
		return pageinfo.getNavigateLastPage();
	}

	public Object getCountryName(String country) {
		country = filterCountry(country);
		return country;
	}

	public Object seeAllListFiltered(int pageNum, String country, String type) {
		country = filterCountry(country);
		
		PageHelper.startPage(pageNum, 15);
		PageInfo<userboardVO> pageinfo = new PageInfo<userboardVO>(mapper.seeAllListFiltered(country, type));
		
		return pageinfo.getList();
	}

	public int[] seeAllListPageNumFiltered(int pageNum, String country, String type) {
		country = filterCountry(country);
		
		PageHelper.startPage(pageNum, 15);
		PageInfo<userboardVO> pageinfo = new PageInfo<userboardVO>(mapper.seeAllListFiltered(country, type));
		
		return pageinfo.getNavigatepageNums();
	}

	public int countryListLastPageNumFiltered(int pageNum, String country, String type) {
		country = filterCountry(country);
		
		PageHelper.startPage(pageNum, 15);
		PageInfo<userboardVO> pageinfo = new PageInfo<userboardVO>(mapper.seeAllListFiltered(country, type));
		
		return pageinfo.getNavigateLastPage();
	}
	
	public userVO mentiuser(String userNum) {
		return mapper.mentiuser(userNum);
	}

	public mentiboardReplyVO chosenAnswer(String replyNum) {
		return mapper.getboardReply(replyNum);
	}
	
	public boolean accruedPoint(String point, String mentorNum, String boardNum) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today = sdf.format(date);
		
		
//		포인트 누적합 - 현재 포인트 구하여 누적합
		String curPoint = mapper.recentcurPoint(mentorNum);
		String adjustedPoint = (Integer.valueOf(point) + Integer.valueOf(curPoint))+"";

		return mapper.accruedPoint(adjustedPoint, point, mentorNum, boardNum, today)>0 ? true : false;
	}

	public int view(String boardNum) {
//		조회수 증가
		mapper.viewIncrease(boardNum);
//		증가된 조회수 출력
		return mapper.view(boardNum);
	}


//	============ 마이페이지 좋아요 전체페이지 보기 페이징 작업 ============ 
	public List<userboardVO> seeAllLikes(int pageNum, String id, String userType) {
		return pagination(pageNum, id, userType).getList();
	}
	
	public int[] seeAllLikesListMyPagePageNum(int pageNum, String id, String userType) {
		return pagination(pageNum, id, userType).getNavigatepageNums();
	}
	
	public int countryListLikesMyPageLastPageNum(int pageNum, String id, String userType) {
		return pagination(pageNum, id, userType).getNavigateLastPage();
	}
//	============ 마이페이지 좋아요 전체페이지 보기 페이징 작업 ============ 
	
//	 ============ 마이페이지 채택글 전체페이지 보기 페이징 작업 - 멘토 ============ 
	public List<userboardVO> seeAllSelected(int pageNum, String num) {
		return pagination(pageNum, num).getList();
	}
	
	public int[] seeAllSelectedMyPagePageNum(int pageNum, String num) {
		return pagination(pageNum, num).getNavigatepageNums();
	}

	public int seeAllSelectedMyPageLastPageNum(int pageNum, String num) {
		return pagination(pageNum, num).getNavigateLastPage();
	}
//	 ============ 마이페이지 채택글 전체페이지 보기 페이징 작업 - 멘토 ============ 

//	============ 마이페이지 작성 글 전체 보기 ============ 
	public List<userboardVO> seeAllWriten(int pageNum, String num) {
		return paginationAll(pageNum, num).getList();
	}

	public int[] seeAllWritenMyPagePageNum(int pageNum, String num) {
		return paginationAll(pageNum, num).getNavigatepageNums();
	}

	public int seeAllWritenMyPageLastPageNum(int pageNum, String num) {
		return paginationAll(pageNum, num).getNavigateLastPage();
	}
//	============ 마이페이지 작성 글 전체 보기 ============ 
	
//	============ 마이페이지 채택 필요한 글 전체 보기 ============ 
	public List<userboardVO> seeAllrequired(int pageNum, String num) {
		return paginationRequired(pageNum, num).getList();
	}

	public int[] seeAllrequiredMyPagePageNum(int pageNum, String num) {
		return paginationRequired(pageNum, num).getNavigatepageNums();
	}

	public int seeAllrequiredMyPageLastPageNum(int pageNum, String num) {
		return paginationRequired(pageNum, num).getNavigateLastPage();
	}
//	============ 마이페이지 채택 필요한 글 전체 보기 ============ 
	
	
	
	

//	============ 멘토링 전체 글 보기 ============ 정체가 무엇???
	public List<userboardVO> seeAllMyPage(int pageNum, String num) {
		return pagination(pageNum, num).getList();
	}
	public int[] seeAllListMyPagePageNum(int pageNum, String num) {
		return pagination(pageNum, num).getNavigatepageNums();
	}
	public int countryListMyPageLastPageNum(int pageNum, String num) {
		return pagination(pageNum, num).getNavigateLastPage();
	}
//	============ 멘토링 전체 글 보기 ============ 

	
//	Pagination 좋아요 글 메서드
	public PageInfo<userboardVO> pagination(int pageNum, String id, String userType){
		PageHelper.startPage(pageNum, 15);
		PageInfo<userboardVO> pageinfo = new PageInfo<userboardVO>(mapper.seeAllLikesMyPage(id, userType));
	
		return pageinfo;
	}
//	Pagination 채택 글 메서드
	public PageInfo<userboardVO> pagination(int pageNum, String num){
		PageHelper.startPage(pageNum, 15);
		PageInfo<userboardVO> pageinfo = new PageInfo<userboardVO>(mapper.seeAllMyPage(num));
		
		return pageinfo;
	}
	
//	Pagination 전체 글 메서드
	public PageInfo<userboardVO> paginationAll(int pageNum, String num){
		PageHelper.startPage(pageNum, 15);
		PageInfo<userboardVO> pageinfo = new PageInfo<userboardVO>(mapper.seeAllMyPageWritten(num));
		
		return pageinfo;
	}
	
//	Pagination 채택 요구 전체 글 메서드
	public PageInfo<userboardVO> paginationRequired(int pageNum, String num){
		PageHelper.startPage(pageNum, 15);
		PageInfo<userboardVO> pageinfo = new PageInfo<userboardVO>(mapper.seeAllMyPageRequired(num));
		
		return pageinfo;
	}
	
//	나라 필터링 메서드
	private String filterCountry(String country) {
		
		if(country.equals("usa")) {
			country = "미국";
		}
		else if(country.equals("ca")) {
			country = "캐나다";
		}
		else if(country.equals("eur")) {
			country = "유럽";
		}
		else if(country.equals("jp")) {
			country = "일본";
		}
		else if(country.equals("cn")) {
			country = "중국";
		}
		else if(country.equals("ap")) {
			country = "동남아";
		}
		else {
			country = "중동";
		}
		return country;
	}


}
