package com.taek.gori.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.taek.gori.dto.MusicDto;
import com.taek.gori.service.ArtistService;
import com.taek.gori.service.MusicService;
import com.taek.gori.service.PlaylistService;
import com.taek.gori.service.UserService;

@Controller
public class PlayController {
	@Autowired ArtistService asv;
	@Autowired MusicService msv;
	@Autowired PlaylistService psv;
	@Autowired UserService usv;
	
	@GetMapping("/play/{type}/{id}")
	@ResponseBody
	public ResponseEntity<List<MusicDto>> getMusicsToPlay(@PathVariable String type, @PathVariable String id) {
		List<MusicDto> mList = new ArrayList<>();
		try {
			if("music".equals(type)) {
				mList = msv.getMusicAndArtist("music", id);
			} else if("album".equals(type)) {
				mList = msv.getMusicAndArtist("album", id);
			} else if("playlist".equals(type)) {
				mList = psv.getAllMusicsInPlaylist(id);
			} else {
				throw new Exception();
			}
			return new ResponseEntity<List<MusicDto>> (mList, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<List<MusicDto>> (mList, HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping("/user/{userIdx}/music/{musicIdx}/played")
	@ResponseBody
	public ResponseEntity<String> userPlayedMusic(@PathVariable String userIdx, @PathVariable String musicIdx) {
		int res = 0;
		try {
			res = usv.userPlayedMusic(userIdx, musicIdx);
			if(res == 0) throw new Exception();
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
}
