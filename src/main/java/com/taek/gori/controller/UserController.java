package com.taek.gori.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.taek.gori.service.ArtistService;
import com.taek.gori.service.MusicService;
import com.taek.gori.service.UserService;

@Controller
public class UserController {
	@Autowired UserService usv;
	@Autowired ArtistService asv;
	@Autowired MusicService msv;
	
	@PostMapping("/user/{userIdx}/artist/{artistId}/follow")
	@ResponseBody
	public ResponseEntity<String> postUserArtistFollow(@PathVariable String userIdx, @PathVariable String artistId) {
		int res = 0;
		try {
			res = usv.userFollowArtist(userIdx, artistId);
			if(res == 0) throw new Exception();
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@DeleteMapping("/user/{userIdx}/artist/{artistId}/follow")
	@ResponseBody
	public ResponseEntity<String> deleteUserArtistFollow(@PathVariable String userIdx, @PathVariable String artistId) {
		int res = 0;
		try {
			res = usv.userDeleteArtist(userIdx, artistId);
			if(res == 0) throw new Exception();
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@PutMapping("/user/{userIdx}/music/{musicIdx}/like")
	@ResponseBody
	public ResponseEntity<String> putUserMusicLike(@PathVariable String userIdx, @PathVariable String musicIdx) {
		int res = 0;
		try {
			res = usv.userLikeMusic(userIdx, musicIdx);
			if(res == 0) throw new Exception();
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@DeleteMapping("/user/{userIdx}/music/{musicIdx}/like")
	@ResponseBody
	public ResponseEntity<String> deleteUserMusicLike(@PathVariable String userIdx, @PathVariable String musicIdx) {
		try {
			usv.userNotLikeMusic(userIdx, musicIdx);
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
}
