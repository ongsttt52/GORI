package com.taek.gori.dao;

import java.util.List;

import com.taek.gori.dto.FeedDto;

public interface FeedDao {

	int count() throws Exception;

	int countSelected(String col, String value, String musicIdx) throws Exception;
	
	int insert(FeedDto feed) throws Exception;

	List<FeedDto> select(String col, String value) throws Exception;

	List<FeedDto> selectAll() throws Exception;

	List<FeedDto> selectSearched(String col, String value, String musicIdx, Integer offset, Integer pageSize) throws Exception;

	int update(String col, String value, String idx) throws Exception;

	int delete(String feedIdx) throws Exception;

	

}