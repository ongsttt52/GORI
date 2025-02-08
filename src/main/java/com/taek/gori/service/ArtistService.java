package com.taek.gori.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taek.gori.api.SpotifyApi;
import com.taek.gori.dao.ArtistDao;
import com.taek.gori.dto.ArtistDto;
import com.taek.gori.dto.Genre;
import com.taek.gori.dto.MusicDto;
import com.taek.gori.util.PageHandler;
import com.taek.gori.util.SearchCondition;

@Service
public class ArtistService {
	@Autowired ArtistDao adao;
	@Autowired SpotifyApi api;
	
	public int insertArtist(String id, Genre genre) throws Exception {
		int res = 0;
		try {
			JSONObject artistObject = api.searchObjectById("artist", id);
			if(artistObject == null) { 
				throw new Exception("ArtistService.insertArtist() : artistObject 검색 실패");
			}
			ArtistDto artist = api.createArtistDto(artistObject, genre);
			res = adao.insert(artist);
			if(res == 0) { 
				throw new Exception("ArtistService.insertArtist() : insert 실패");
			}
		} catch(Exception e) {
			throw e;
		}
		return res;
	}
	
	public List<ArtistDto> selectAll() throws Exception {
		List<ArtistDto> aList = null;
		try {
			aList = adao.selectAll();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return aList;
	}

	public Map<String,Object> searchArtist(SearchCondition sc) throws Exception {
		Map<String,Object> map = new HashMap<>();
		List<ArtistDto> aList = new ArrayList<>();
		sc.setField("name");
		try {
			aList = adao.selectSearched(sc.getField(), sc.getKeyword(), sc.getOffset()+"", sc.getPageSize()+"");
			System.out.println(aList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		PageHandler ph = new PageHandler(adao.countSelected(sc.getField(), sc.getKeyword()),sc);
		map.put("list", aList);
		map.put("ph", ph);
		return map;
	}
}
