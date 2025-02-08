package com.taek.gori.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.taek.gori.dto.ArtistDto;
import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.UserDto;
import com.taek.gori.service.HomeService;

@Controller
public class HomeController {
	@Autowired HomeService hsv;
	
	@GetMapping("/")
	public String home(HttpSession session, Model m) {
		UserDto user = (UserDto)session.getAttribute("user");
		String userIdx = null;
		if(user != null) userIdx = user.getIdx()+"";
		try {
			List<MusicDto> chart = hsv.getPopChart(userIdx);
			m.addAttribute("chart", chart);
			if(user != null) {
				List<MusicDto> mixList = hsv.getUserMix(userIdx);
				List<MusicDto> hottest = hsv.getHottest();
				List<MusicDto> recent = hsv.getRecent(userIdx);
				List<MusicDto> playBack = hsv.getPlayBack(userIdx);
				m.addAttribute("hottest", hottest);
				m.addAttribute("recent", recent);
				m.addAttribute("playBack", playBack);
				
//				System.out.println("hotList : ");
//				for(MusicDto music : hottest) {
//					System.out.println(music);
//				}
//				System.out.println("recent : ");
//				for(MusicDto music : recent) {
//					System.out.println(music);
//				}
//				System.out.println("playBack : ");
//				for(MusicDto music : playBack) {
//					System.out.println(music);
//				}
			} else {
				// 인기 아티스트, 인기 앨범, 인기 차트
				List<ArtistDto> artists = hsv.getFamousArtists();
				List<MusicDto> albums = hsv.getFamousAlbums();

				m.addAttribute("artists", artists);
				m.addAttribute("albums", albums);

				
				System.out.println("artists : ");
				for(int i=0; i<artists.size(); i++) {
					ArtistDto artist = artists.get(i);
					System.out.println(artist);
				}
				System.out.println("albums : ");
				for(int i=0; i<albums.size(); i++) {
					MusicDto music = albums.get(i);
					System.out.println(music);
				}
				System.out.println("chart : ");
				for(int i=0; i<chart.size(); i++) {
					MusicDto music = chart.get(i);
					System.out.println(music);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "home";
	}
	
	@GetMapping("/chart")
	public String getChart(Model m, HttpSession session) {
		UserDto user = (UserDto)session.getAttribute("user");
		String userIdx = null;
		if(user != null) userIdx = user.getIdx()+"";
		
		try {
			List<MusicDto> chart = hsv.getPopChart(userIdx);
			m.addAttribute("chart", chart);
			return "chart";
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		}
	}
}
