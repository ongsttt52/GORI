package com.taek.gori.dao;

import java.time.LocalDate;
import java.util.List;

import com.taek.gori.dto.Genre;
import com.taek.gori.dto.MusicDto;

public interface MusicDao {
	int count() throws Exception;
	
	int countSelected(String col, String value) throws Exception;
	
	int insert(MusicDto music) throws Exception;
	
	int insertArtistName(int musicIdx, String artistId, String artistName, String role) throws Exception;

	MusicDto select(String col, String value) throws Exception;
	
	List<MusicDto> selectMusic(String col, String value) throws Exception;
	
	List<MusicDto> selectMusicsInAlbum(String albumId) throws Exception;
	
	MusicDto selectAlbum(String albumIdx) throws Exception;
	
	List<MusicDto> selectAlbumsInArtist(String artistId) throws Exception;
	
	List<MusicDto> selectSearched(String col, String value, String offset, String pageSize) throws Exception;

	List<MusicDto> selectSearched2(String value);
	
	List<MusicDto> selectSearched2(String value, String word1, String word2);
	
	int update(String field, String id, String col, String value) throws Exception;

	int delete(String col, String value) throws Exception;
	
	// home
	List<MusicDto> selectUsersMixAlbum(List<String> idList) throws Exception;
	
	List<MusicDto> selectHottest() throws Exception;
	
	MusicDto selectRecentAlbum(String artistId) throws Exception;
	
	List<MusicDto> selectPlayedMonthLater(String userIdx) throws Exception;
	
	List<MusicDto> selectFamousAlbums() throws Exception;

	// view
	List<MusicDto> selectPopularMusics(String artistId) throws Exception;
	
	List<MusicDto> selectOtherAlbums(String albumId) throws Exception;

	List<MusicDto> selectSimilarAlbums(String artistId, Genre genre, LocalDate releaseDate, long popularity) throws Exception;

	List<MusicDto> selectMusicsInPlaylist(String playlistIdx) throws Exception;





}