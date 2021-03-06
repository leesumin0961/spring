package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

	  private int startPage;	//시작페이지
	  private int endPage;	//끝페이지
	  private boolean prev, next;	//이전,다음페이지 유무.flag

	  private int total;	//전체레코드수
	  private Criteria cri;	//Criteria객체

	  public PageDTO(Criteria cri, int total) {

	    this.cri = cri;
	    this.total = total;

	    this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;

	    this.startPage = this.endPage - 9;
	    //실제끝페이지
	    int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
	    //실제끝페이지가 끝페이지보다 작으면 끝페이지를 실제끝페이지값으로 변경
	    if (realEnd <= this.endPage) {
	      this.endPage = realEnd;
	    }
	    //시작페이지가 1페이지보다 크면 prev가 true
	    this.prev = this.startPage > 1;
	    //끝페이지가 실제끝페이지보다 작으면 next가 true
	    this.next = this.endPage < realEnd;
	  }
	  
}
