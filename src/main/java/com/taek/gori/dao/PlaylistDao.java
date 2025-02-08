package com.taek.gori.dao;

import java.util.List;

import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.PlaylistDto;

public interface PlaylistDao {

	int countMusics(String playlistIdx) throws Exception;
	
	int countSelected(String col, String value) throws Exception;
	
	MusicDto selectGenre(String playlistIdx) throws Exception;
	
	int insert(PlaylistDto playlist) throws Exception;

	int insertMusic(String playlistIdx, String musicIdx) throws Exception;

	PlaylistDto select(String playlistIdx) throws Exception;
	
	PlaylistDto selectQuelist(String userIdx) throws Exception;
	
	PlaylistDto selectLikelist(String userIdx) throws Exception;

	List<PlaylistDto> selectUsersPlaylist(String userIdx) throws Exception;

	List<PlaylistDto> searchPlaylist(String field, String keyword) throws Exception;
	
	List<PlaylistDto> selectArtistsPlaylist(String artistId) throws Exception;

	List<PlaylistDto> selectSimilarPlaylists(String playlistIdx, String genre) throws Exception;

	int deleteMusic(String playlistIdx, String listOrder) throws Exception;

	int deleteMusicFromLikelist(String playlistIdx, String musicIdx) throws Exception;

}