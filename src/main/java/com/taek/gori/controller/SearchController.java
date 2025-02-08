package com.taek.gori.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.taek.gori.api.SpotifyApi;
import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.UserDto;
import com.taek.gori.service.ArtistService;
import com.taek.gori.service.MusicService;
import com.taek.gori.service.PlaylistService;
import com.taek.gori.util.SearchCondition;

@Controller
public class SearchController {
	@Autowired SpotifyApi api;
	@Autowired ArtistService asv;
	@Autowired MusicService msv;
	@Autowired PlaylistService psv;
	
	@GetMapping("/search/{searchWord}")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> search2(@PathVariable String searchWord, HttpSession session) {
		UserDto user = (UserDto)session.getAttribute("user");
		String userIdx = null;
		if(user != null) userIdx = user.getIdx()+"";
		
		Map<String,Object> map = new HashMap<>();
		SearchCondition sc = new SearchCondition();
		sc.setKeyword(searchWord);
		try {
			List<MusicDto> mList = msv.searchMusic2(sc, userIdx);
			for(MusicDto music : mList) {
				System.out.println(music);
			}
			map.put("list", mList);
			return new ResponseEntity<Map<String,Object>> (map, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Map<String,Object>> (map, HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/search/{field}/{keyword}")
	public String search(@PathVariable String field, @PathVariable String keyword, Model m, HttpSession session) {
		UserDto user = (UserDto)session.getAttribute("user");
		String userIdx = null;
		if(user != null) userIdx = user.getIdx()+"";
		
		SearchCondition sc = new SearchCondition();
		sc.setKeyword(keyword);
		
		List<MusicDto> musics = new ArrayList<>();
		Map<String,Object> albums = new HashMap<>();
		Map<String,Object> artists = new HashMap<>();
		Map<String,Object> playlists = new HashMap<>();
		try {
			if("all".equals(field)) {
				musics = msv.searchMusic2(sc, userIdx);
				albums = msv.searchAlbum(sc);
				artists = asv.searchArtist(sc);
				playlists = psv.searchPlaylist(sc);
				m.addAttribute("musics", musics);
				m.addAttribute("albums", albums);
				m.addAttribute("artists", artists);
				m.addAttribute("playlists", playlists);
				return "search";
				
			} else if("music".equals(field)) {
				musics = msv.searchMusic2(sc, userIdx);
				m.addAttribute("musics", musics);
				return "search-music";
				
			} else if("album".equals(field)) {
				albums = msv.searchAlbum(sc);
				m.addAttribute("object", albums);
				return "search-detail";
				
			} else if("artist".equals(field)) {
				artists = asv.searchArtist(sc);
				m.addAttribute("object", artists);
				return "search-detail";
				
			} else if("playlist".equals(field)) {
				playlists = psv.searchPlaylist(sc);
				m.addAttribute("object", playlists);
				return "search-detail";
				
			} else {
				throw new Exception();
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		}

		
	}
	
	
}