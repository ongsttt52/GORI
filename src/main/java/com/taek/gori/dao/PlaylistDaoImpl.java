package com.taek.gori.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.PlaylistDto;

@Repository
public class PlaylistDaoImpl implements PlaylistDao {
	@Autowired SqlSession session;
	String namespace = "gori.playlist.";
	
	@Override
	public int countMusics(String playlistIdx) throws Exception {
		return session.selectOne(namespace+"countMusics", playlistIdx);
	}
	
	@Override
	public int countSelected(String col, String value) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		
		return session.selectOne(namespace+"countSelected", map);
	}
	
	@Override
	public MusicDto selectGenre(String playlistIdx) throws Exception {
		return session.selectOne(namespace+"selectGenre", playlistIdx);
	}
	
	@Override
	public int insert(PlaylistDto playlist) throws Exception {
		return session.insert(namespace+"insert", playlist);
	}
	
	@Override
	public int insertMusic(String playlistIdx, String musicIdx) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("playlistIdx", playlistIdx);
		map.put("musicIdx", musicIdx);
		return session.insert(namespace+"insertMusic", map);
	}
	
	@Override
	public PlaylistDto select(String playlistIdx) throws Exception {
		return session.selectOne(namespace+"select", playlistIdx);
	}
	
	@Override
	public PlaylistDto selectQuelist(String userIdx) throws Exception {
		return session.selectOne(namespace+"selectQuelist", userIdx);
	}
	
	@Override
	public PlaylistDto selectLikelist(String userIdx) throws Exception {
		return session.selectOne(namespace+"selectLikelist", userIdx);
	}
	
	@Override
	public List<PlaylistDto> selectUsersPlaylist(String userIdx) throws Exception {
		return session.selectList(namespace+"selectUsersPlaylist", userIdx);
	}
	
	@Override
	public List<PlaylistDto> selectArtistsPlaylist(String artistId) throws Exception {
		return session.selectList(namespace+"selectArtistsPlaylist", artistId);
	}
	
	@Override
	public List<PlaylistDto> selectSimilarPlaylists(String playlistIdx, String genre) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("playlistIdx", playlistIdx);
		map.put("genre", genre);
		return session.selectList(namespace+"selectSimilarPlaylists", map);
	}
	
	@Override
	public List<PlaylistDto> searchPlaylist(String field, String keyword) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("field", field);
		map.put("keyword", keyword);
		return session.selectList(namespace+"searchPlaylist", map);
	}
	
	@Override
	public int deleteMusic(String playlistIdx, String listOrder) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("playlistIdx", playlistIdx);
		map.put("listOrder", listOrder);
		return session.delete(namespace+"deleteMusic", map);
	}
	
	@Override
	public int deleteMusicFromLikelist(String playlistIdx, String musicIdx) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("playlistIdx", playlistIdx);
		map.put("musicIdx", musicIdx);
		return session.delete(namespace+"deleteMusicFromLikelist", map);
	}
}