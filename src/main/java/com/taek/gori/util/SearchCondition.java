package com.taek.gori.util;

import org.springframework.web.util.UriComponentsBuilder;

public class SearchCondition {
	private Integer page = 1;
	private Integer pageSize = 10;
	private String keyword = "";
	private String field;
	
	public Integer getPage() {
		return page; 
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	
	// offset 결과를 반환하는 함수
	public Integer getOffset() {
		if(page==null) return 0;
		return (page-1)*pageSize;
	}
	
	//쿼리문을 계속 작성하기에는 전달할 값이 많으므로 함수로 구현
	public String getQueryString(Integer page) {
		return UriComponentsBuilder.newInstance()
			.queryParam("page",page)
			.queryParam("pageSize",pageSize)
			.queryParam("field", field)
			.queryParam("keyword", keyword)
			.build().toString();
		
	}
	public String getQueryString() {
		return getQueryString(page);
	}
	
	public SearchCondition() {}
	
	public SearchCondition(String field, String keyword, Integer page, Integer pageSize) {
		super();
		this.field = field;
		this.keyword = (keyword == null) ? this.keyword : keyword;
		this.page = (page == null) ? 1 : page;
		this.pageSize = (pageSize == null) ? this.pageSize : pageSize;
	}
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	@Override
	public String toString() {
		return "SearchCondition [page=" + page + ", pageSize=" + pageSize + ", offset=" + getOffset() + ", keyword="
				+ keyword + ", field=" + field + "]";
	}
}
