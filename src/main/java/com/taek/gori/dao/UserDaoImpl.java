package com.taek.gori.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.UserDto;
import com.taek.gori.util.SearchCondition;

@Repository
public class UserDaoImpl implements UserDao {
	@Autowired SqlSession session;
	String namespace = "gori.user.";
	
	@Override
	public int count() throws Exception {
		return session.selectOne(namespace+"count");
	}
	
	@Override
	public int deleteAll() throws Exception {
		return session.delete(namespace+"deleteAll");
	}
	
	@Override
	public int insert(UserDto user) throws Exception {
		return session.insert(namespace+"insert", user);
	}
	
	@Override
	public UserDto select(String col, String value) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		return session.selectOne(namespace+"select", map);
	}
	
	@Override
	public List<UserDto> selectAll() throws Exception {
		return session.selectList(namespace+"selectAll");
	}
	
	@Override
	public List<UserDto> selectSearched(SearchCondition sc) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("col", sc.getField());
		map.put("value", sc.getKeyword());
		map.put("offset", sc.getOffset()+"");
		map.put("pageSize", sc.getPageSize()+"");
		return session.selectList(namespace+"selectSearched", map);
	}
	
	@Override
	public int update(String id, String col, String value) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("id", id);
		map.put("col", col);
		map.put("value", value);
		return session.update(namespace+"update", map);
	}
	
	@Override
	public int delete(String id) throws Exception {
		return session.delete(namespace+"delete", id);
	}
	
	// user_artist
	@Override
	public int insertUserArtist(String userIdx, String artistId) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("userIdx", userIdx);
		map.put("artistId", artistId);
		return session.insert(namespace+"insertUserArtist", map);
	}
	
	@Override
	public int deleteUserArtist(String userIdx, String artistId) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("userIdx", userIdx);
		map.put("artistId", artistId);
		return session.delete(namespace+"deleteUserArtist", map);
	}
	// user_music
	@Override
	public int insertUserMusic(String userIdx, String musicIdx) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("userIdx", userIdx);
		map.put("musicIdx", musicIdx);
		return session.insert(namespace+"insertUserMusic", map);
	}
	
	@Override
	public MusicDto selectUserMusic(String userIdx, String musicIdx) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("userIdx", userIdx);
		map.put("musicIdx", musicIdx);
		return session.selectOne(namespace+"selectUserMusic", map);
	}
	
	@Override
	public int userPlayedMusic(String userIdx, String musicIdx) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("userIdx", userIdx);
		map.put("musicIdx", musicIdx);
		return session.insert(namespace+"userPlayedMusic", map);
	}
	
	@Override
	public int userLikeMusic(String userIdx, String musicIdx) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("userIdx", userIdx);
		map.put("musicIdx", musicIdx);
		return session.update(namespace+"userLikeMusic", map);
	}
	
	@Override
	public int userNotLikeMusic(String userIdx, String musicIdx) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("userIdx", userIdx);
		map.put("musicIdx", musicIdx);
		return session.update(namespace+"userNotLikeMusic", map);
	}
}
