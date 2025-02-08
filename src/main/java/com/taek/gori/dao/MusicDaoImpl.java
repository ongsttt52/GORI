package com.taek.gori.dao;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taek.gori.dto.Genre;
import com.taek.gori.dto.MusicDto;

@Repository
public class MusicDaoImpl implements MusicDao {
	@Autowired SqlSession session;
	String namespace = "gori.music.";
	
	@Override
	public int count() throws Exception {
		return session.selectOne(namespace+"count");
	}
	
	@Override
	public int countSelected(String col, String value) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		return session.selectOne(namespace+"countSelected", map);
	}
	
	@Override
	public int insert(MusicDto music) throws Exception {
		session.insert(namespace+"insert", music);
		return music.getIdx();
	}
	
	@Override
	public int insertArtistName(int musicIdx, String artistId, String artistName, String role) throws Exception {
	    Map<String, String> map = new HashMap<>();
	    map.put("musicIdx", String.valueOf(musicIdx));
	    map.put("artistId", artistId);
	    map.put("artistName", artistName);
	    map.put("role", role);
	    return session.insert(namespace + "insertArtistName", map);
	}
	
	@Override
	public MusicDto select(String col, String value) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		return session.selectOne(namespace+"select", map);
	}
	
	@Override
	public List<MusicDto> selectMusic(String col, String value) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		return session.selectList(namespace+"selectMusic", map);
	}
	
	@Override
	public List<MusicDto> selectMusicsInAlbum(String albumId) throws Exception {
		return session.selectList(namespace+"selectMusicsInAlbum", albumId);
	}
	
	@Override
	public MusicDto selectAlbum(String albumIdx) throws Exception {
		return session.selectOne(namespace+"selectAlbum", albumIdx);
	}
	
	@Override
	public List<MusicDto> selectAlbumsInArtist(String artistId) throws Exception {
		return session.selectList(namespace+"selectAlbumsInArtist", artistId);
	}
	
	@Override // 단순 검색
	public List<MusicDto> selectSearched(String col, String value, String offset, String pageSize) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		map.put("offset", offset);
		map.put("pageSize", pageSize);
		if("album_name".equals(col))
			return session.selectList(namespace+"selectSearchedAlbum", map);
		else
			return session.selectList(namespace+"selectSearchedMusic", map);
	}
	
	@Override // 우선도 검색, 한글이 아닐 경우
	public List<MusicDto> selectSearched2(String value) {
		Map<String,String> map = new HashMap<>();
		map.put("value", value);
		return session.selectList(namespace+"selectSearchedMusic2", map);
	}
	@Override // 우선도 검색, 한글일 경우
	public List<MusicDto> selectSearched2(String value, String word1, String word2) {
		Map<String,Object> map = new HashMap<>();
		map.put("value", value);
		map.put("word1", word1);
		map.put("word2", word2);
		return session.selectList(namespace+"selectSearchedBetween", map);
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
	public List<MusicDto> selectUsersMixAlbum(List<String> idList) throws Exception {
		return session.selectList(namespace+"selectUsersMixAlbum", idList);
	}
	
	@Override
	public List<MusicDto> selectHottest() throws Exception {
		return session.selectList(namespace+"selectHottest");
	}
	
	@Override
	public MusicDto selectRecentAlbum(String artistId) throws Exception {
		return session.selectOne(namespace+"selectRecentAlbum", artistId);
	}
	
	@Override
	public List<MusicDto> selectPlayedMonthLater(String userIdx) throws Exception {
		return session.selectList(namespace+"selectPlayedMonthLater", userIdx);
	}
	
	@Override
	public List<MusicDto> selectFamousAlbums() throws Exception {
		return session.selectList(namespace+"selectFamousAlbums");
	}

	// view
	@Override
	public List<MusicDto> selectPopularMusics(String artistId) throws Exception {
		return session.selectList(namespace+"selectPopularMusics", artistId);
	}
	
	@Override
	public List<MusicDto> selectOtherAlbums(String albumId) throws Exception {
		return session.selectList(namespace+"selectOtherAlbums", albumId);
	}
	
	@Override
	public List<MusicDto> selectSimilarAlbums(String artistId, Genre genre, LocalDate releaseDate, long popularity) throws Exception {
		Map<String,Object> map = new HashMap<>();
		map.put("artistId", artistId);
		map.put("genre", genre);
		map.put("releaseDate", releaseDate);
		map.put("popularity", popularity);
		return session.selectList(namespace+"selectSimilarAlbums", map);
	}
	
	// playlist
	@Override
	public List<MusicDto> selectMusicsInPlaylist(String playlistIdx) throws Exception {
		return session.selectList(namespace+"selectMusicsInPlaylist", playlistIdx);
	}
}
