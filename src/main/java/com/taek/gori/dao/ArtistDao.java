package com.taek.gori.dao;

import java.util.List;

import com.taek.gori.dto.ArtistDto;
import com.taek.gori.dto.PlaylistDto;

public interface ArtistDao {
	int count() throws Exception;
	
	int countFollower(String artistId) throws Exception;
	
	int countSelected(String col, String value) throws Exception;
	
	int insert(ArtistDto artist) throws Exception;

	ArtistDto select(String col, String value) throws Exception;
	
	List<ArtistDto> selectList(String col, String value) throws Exception;
	
	List<ArtistDto> selectAll() throws Exception;

	List<ArtistDto> selectSearched(String offset, String pageSize) throws Exception;

	List<ArtistDto> selectSearched(String col, String value, String offset, String pageSize);
	
	ArtistDto selectUserArtist(String userIdx, String artistId) throws Exception;

	int update(String field, String id, String col, String value) throws Exception;

	int delete(String col, String value) throws Exception;
	
	// home
	List<ArtistDto> selectUsersFavoriteArtist(String userIdx) throws Exception;
	
	List<ArtistDto> selectUsersRecentArtist(String userIdx) throws Exception;
	
	List<ArtistDto> selectFamousArtists() throws Exception;
	
	// view
	List<ArtistDto> selectSimilarArtists(ArtistDto artist) throws Exception;


}