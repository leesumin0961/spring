package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {

	//조회목록
	/* public List<BoardVO> getList(); */
	
	//목록 with 페이징
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	//등록
	public void insert(BoardVO board);
	
	//등록2
	public void insertSelectKey(BoardVO board);
	
	//상세보기
	public BoardVO read(Long bno);
	
	//삭제
	public int delete(Long bon);
	
	//수정
	public int update(BoardVO board);
	
	//전체레코드수
	public int getTotalCount(Criteria cri);
	
	//댓글갯수
	public void updateReplyCnt(@Param("bno") Long bno, 
			@Param("amount") int amount);
}
