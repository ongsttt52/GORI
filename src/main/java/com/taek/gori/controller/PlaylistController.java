package com.taek.gori.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.PlaylistDto;
import com.taek.gori.dto.UserDto;
import com.taek.gori.service.MusicService;
import com.taek.gori.service.PlaylistService;
@Controller
public class PlaylistController {
	@Autowired PlaylistService psv;
	@Autowired MusicService msv;
	
	@GetMapping("/quelist")
	@ResponseBody
	public ResponseEntity<PlaylistDto> getUsersQuelist(String userIdx) {
		PlaylistDto quelist = null;
		try {
			quelist = psv.getUsersQuelist(userIdx);
			if(quelist == null) throw new Exception();
			return new ResponseEntity<PlaylistDto> (quelist, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<PlaylistDto> (quelist, HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping("/quelist")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> postToQuelist(String type, String id, HttpSession session) {
		Map<String,Object> map = new HashMap<>();
		UserDto user = (UserDto)session.getAttribute("user");
		String userIdx = null;
		if(user != null) userIdx = user.getIdx()+"";
		try {
			if("album".equals(type)) {
				map = psv.insertAlbumToQuelist(userIdx, id);
			} else if("artist".equals(type)) {
				map = psv.insertArtistToQuelist(userIdx, id);
			} else if("playlist".equals(type)) {
				map = psv.insertPlaylistToQuelist(userIdx, id);
			}
			if(map == null) throw new Exception();
			return new ResponseEntity<Map<String,Object>> (map, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Map<String,Object>> (map, HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping("/quelist/music/{musicIdx}")
	@ResponseBody
	public ResponseEntity<String> postMusicToQuelist(@PathVariable String musicIdx, String userIdx) {
		int res = 0;
		try {
			res = psv.insertMusicToQuelist(userIdx, musicIdx);
			if(res == 0) throw new Exception();
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@DeleteMapping("/user/{userIdx}/quelist/{listOrder}")
	@ResponseBody
	public ResponseEntity<String> deleteMusicFromQuelist(@PathVariable String userIdx, @PathVariable String listOrder) {
		try {
			psv.deleteMusicFromQuelist(userIdx, listOrder);
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/user/{userIdx}/playlist")
	@ResponseBody
	public ResponseEntity<List<PlaylistDto>> getUsersPlaylist(@PathVariable String userIdx) {
		List<PlaylistDto> pList = null;
		try {
			pList = psv.getUsersPlaylist(userIdx);
			if(pList == null) throw new Exception();
			return new ResponseEntity<List<PlaylistDto>> (pList, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<List<PlaylistDto>> (pList, HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping("/playlist")
	@ResponseBody
	public ResponseEntity<String> postPlaylist(PlaylistDto playlist, MultipartFile[] uploadFile, HttpSession session) {
		int res = 0;
		
		// 파일 업로드
		String uploadFolder = session.getServletContext().getRealPath("/resources/image/playlist");
		System.out.println("uploadFile : " + uploadFile);
		System.out.println("uploadFolder : " + uploadFolder);
		
		for(MultipartFile file : uploadFile) {
			String fileName = file.getOriginalFilename();
			fileName = fileName.substring(fileName.lastIndexOf("\\") + 1); // 경로에서 원래 파일명만 가져오기
			System.out.println("fileName : " + fileName);
			
			UUID uuid = UUID.randomUUID();
			fileName = uuid.toString()+"_" + fileName;
			System.out.println("변환 후 파일이름 " + fileName);
			
			File saveFile = new File(uploadFolder, fileName); //uploadFolder 위치에 uploadFileName으로 생성
			
			try {
				file.transferTo(saveFile); // 실제 파일로 저장
				playlist.setPlaylistImage(fileName);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
				System.out.println("파일 저장 실패");
			}
		}
		
		try {
			res = psv.insertPlaylist(playlist);
			if(res == 0) throw new Exception();
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/playlist/{playlistIdx}/music/{musicIdx}")
	@ResponseBody
	public ResponseEntity<String> checkMusicInPlaylist(@PathVariable String playlistIdx, @PathVariable String musicIdx) {
		try {
			MusicDto music = psv.getMusicInPlaylist(playlistIdx, musicIdx);
			if(music == null) 
				return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
			else 
				return new ResponseEntity<String> ("DUPLICATED", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping("/playlist/{playlistIdx}/music/{musicIdx}")
	@ResponseBody
	public ResponseEntity<String> postMusicToPlaylist(@PathVariable String playlistIdx, @PathVariable String musicIdx) {
		int res = 0;
		try {
			res = psv.insertMusicToPlaylist(playlistIdx, musicIdx);
			if(res == 0) throw new Exception();
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@DeleteMapping("/playlist/{playlistIdx}/listOrder/{listOrder}")
	@ResponseBody
	public ResponseEntity<String> deleteMusicFromPlaylist(@PathVariable String playlistIdx, @PathVariable String listOrder) {
		int res = 0;
		try {
			res = psv.deleteMusicFromPlaylist(playlistIdx, listOrder);
			if(res == 0) throw new Exception();
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
}
