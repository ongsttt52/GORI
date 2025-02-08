package com.taek.gori.dao;

import java.util.List;

import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.UserDto;
import com.taek.gori.util.SearchCondition;

public interface UserDao {

	int count() throws Exception;

	int deleteAll() throws Exception;

	int insert(UserDto user) throws Exception;
	
	UserDto select(String col, String value) throws Exception;

	List<UserDto> selectAll() throws Exception;
	
	List<UserDto> selectSearched(SearchCondition sc) throws Exception;

	int update(String id, String col, String value) throws Exception;

	int delete(String id) throws Exception;
	
	// user_artist
	int insertUserArtist(String userIdx, String artistId) throws Exception;
	
	int deleteUserArtist(String userIdx, String artistId) throws Exception;
	
	// user_music
	int insertUserMusic(String userIdx, String musicIdx) throws Exception;
	
	MusicDto selectUserMusic(String userIdx, String musicIdx) throws Exception;
	
	int userPlayedMusic(String userIdx, String musicIdx) throws Exception;
	
	int userLikeMusic(String userIdx, String musicIdx) throws Exception;

	int userNotLikeMusic(String userIdx, String musicIdx) throws Exception;




}