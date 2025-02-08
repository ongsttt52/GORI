package com.taek.gori.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taek.gori.dto.ArtistDto;

@Repository
public class ArtistDaoImpl implements ArtistDao {
	@Autowired SqlSession session;
	String namespace = "gori.artist.";
	
	@Override
	public int count() throws Exception {
		return session.selectOne(namespace+"count");
	}
	
	@Override
	public int countFollower(String artistId) throws Exception {
		return session.selectOne(namespace+"countFollower", artistId);
	}
	
	@Override
	public int countSelected(String col, String value) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		return session.selectOne(namespace+"countSelected", map);
	}
	
	@Override
	public int insert(ArtistDto artist) throws Exception {
		return session.insert(namespace+"insert", artist);
	}
	
	@Override
	public ArtistDto select(String col, String value) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		return session.selectOne(namespace+"select", map);
	}
	
	@Override
	public List<ArtistDto> selectList(String col, String value) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		return session.selectList(namespace+"selectList", map);	
	}
	
	@Override
	public List<ArtistDto> selectAll() throws Exception {
		return session.selectList(namespace+"selectAll");
	}
	
	// field = artist, 검색어 없음
	@Override
	public List<ArtistDto> selectSearched(String offset, String pageSize) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("pageSize", pageSize);
		map.put("offset", offset);
		return session.selectList(namespace+"selectSearched", map);
	}
	
	// field = artist, 검색어 있음
	@Override
	public List<ArtistDto> selectSearched(String col, String value, String offset, String pageSize) {
		Map<String, String> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		map.put("offset", offset);
		map.put("pageSize", pageSize);
		return session.selectList(namespace+"selectSearched", map);
	}
	
	@Override
	public ArtistDto selectUserArtist(String userIdx, String artistId) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("userIdx", userIdx);
		map.put("artistId", artistId);
		return session.selectOne(namespace+"selectUserArtist", map);
	}
	
	@Override
	public int update(String field, String id, String col, String value) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("field", field);
		map.put("id", id);
		map.put("col", col);
		map.put("value", value);
		return session.update(namespace+"update", map);
	}
	
	@Override
	public int delete(String col, String value) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		return session.delete(namespace+"delete", map);
	}
	
	// home
	@Override
	public List<ArtistDto> selectUsersRecentArtist(String userIdx) throws Exception {
		return session.selectList(namespace+"selectUsersRecentArtist", userIdx);
	}
	
	@Override
	public List<ArtistDto> selectUsersFavoriteArtist(String userIdx) throws Exception {
		return session.selectList(namespace+"selectUsersFavoriteArtist", userIdx);
	}
	
	@Override
	public List<ArtistDto> selectFamousArtists() throws Exception {
		return session.selectList(namespace+"selectFamousArtists");
	}
	
	// view
	@Override
	public List<ArtistDto> selectSimilarArtists(ArtistDto artist) throws Exception {
		return session.selectList(namespace+"selectSimilarArtists", artist);
	}
}
