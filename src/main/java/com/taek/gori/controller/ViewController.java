package com.taek.gori.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.taek.gori.dto.PlaylistDto;
import com.taek.gori.dto.UserDto;
import com.taek.gori.service.UserService;
import com.taek.gori.service.ViewService;

@Controller
public class ViewController {
	@Autowired ViewService vsv;
	@Autowired UserService usv;
	
	@GetMapping("/artist/{artistId}")
	public String getArtistPage(@PathVariable String artistId, HttpSession session, Model m) {
		try {
			UserDto user = (UserDto)session.getAttribute("user");
			String userIdx = null;
			if(user != null) userIdx = user.getIdx()+"";
			Map<String,Object> map = vsv.getArtistPage(artistId, userIdx);
			m.addAttribute("map", map);
			return "view-artist";
		} catch(Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
	
	@GetMapping("/album/{albumId}")
	public String getAlbumPage(@PathVariable String albumId, HttpSession session, Model m) {
		try {
			UserDto user = (UserDto)session.getAttribute("user");
			String userIdx = null;
			if(user != null) userIdx = user.getIdx()+"";
			Map<String,Object> map = vsv.getAlbumPage(albumId, userIdx);
			m.addAttribute("map", map);
			return "view-album";
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		}
	}
	
	@GetMapping("/playlist/{playlistIdx}")
	public String getPlaylist(@PathVariable String playlistIdx, HttpSession session, Model m) {
		try {
			UserDto user = (UserDto)session.getAttribute("user");
			String userIdx = null;
			if(user != null) userIdx = user.getIdx()+"";
			Map<String,Object> map = vsv.getPlaylistPage(playlistIdx, userIdx);
			m.addAttribute("map", map);
			return "view-playlist";
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		}
	}
}
