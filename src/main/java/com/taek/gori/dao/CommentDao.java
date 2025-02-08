package com.taek.gori.dao;

import java.util.List;

import com.taek.gori.dto.CommentDto;

public interface CommentDao {

	int countComments(String feedIdx) throws Exception;

	int insert(CommentDto comment) throws Exception;
	
	List<CommentDto> selectComments(String feedIdx) throws Exception;

	int update(String commentIdx, String content) throws Exception;

	int delete(String commentIdx) throws Exception;


}