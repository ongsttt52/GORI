package com.taek.gori.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.taek.gori.api.SpotifyApi;
import com.taek.gori.dto.Genre;
import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.UserDto;
import com.taek.gori.service.ArtistService;
import com.taek.gori.service.MusicService;
import com.taek.gori.service.UserService;
import com.taek.gori.util.SearchCondition;

@Controller
public class AdminController {
	@Autowired MusicService msv;
	@Autowired ArtistService asv;
	@Autowired UserService usv;
	@Autowired SpotifyApi api;
	
//	@ModelAttribute("genres") // 이 컨트롤러 내의 모든 요청에서 아래 Enum을 뷰로 전달함
//	public Genre[] getGenres() {
//		return Genre.values();
//	}
	
	@GetMapping("/admin/{field}")
	public String admin(@PathVariable String field, @RequestParam(required=false) String toUrl, HttpSession session, Model m) {
		UserDto user = (UserDto)session.getAttribute("user");
		if(user == null || !"admin".equals(user.getGrade())) return toUrl == null ? "redirect:/" : "redirect:"+toUrl;
		
		m.addAttribute("genres", Genre.values());
		if("music".equals(field)) return "admin-music";
		else if("user".equals(field)) return "admin-user";
		else if("stats".equals(field)) return "admin-stats";
		return "admin-music";
	}
	
	// 음악 검색
	@GetMapping("/admin/search/artist/{artistName}")
	@ResponseBody
	public ResponseEntity<JSONArray> searchArtist(@PathVariable String artistName) {
		try {
			JSONArray artistItems = api.searchArtist(artistName);
			if(artistItems == null) throw new Exception("SearchController.searchArtist() : 검색 결과 없음");
			return new ResponseEntity<JSONArray>(artistItems, HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<JSONArray>(new JSONArray(), HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/admin/search/album/{artistId}")
	@ResponseBody
	public ResponseEntity<JSONArray> searchAlbum(@PathVariable String artistId) {
		try {
			JSONArray albumItems = api.searchAlbumsByArtist(artistId);
			if(albumItems == null) throw new Exception("SearchController.searchAlbum() : 검색 결과 없음");
			return new ResponseEntity<JSONArray>(albumItems, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<JSONArray> (new JSONArray(), HttpStatus.BAD_REQUEST);
		}
	}
	
	// insert
	@PostMapping("/admin/search/artist/{id}")
	@ResponseBody
	public ResponseEntity<String> insertArtist(@PathVariable String id, Genre genre) {
		try {
			asv.insertArtist(id, genre);
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			String error = "ERROR";
			if(e instanceof org.springframework.dao.DuplicateKeyException) {
				error = "DUPLICATED";
			}
			return new ResponseEntity<String>(error, HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping("/admin/search/album/{id}")
	@ResponseBody
	public ResponseEntity<String> insertAlbum(@PathVariable String id) {
		try {
			msv.insertAlbum(id);
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			String error = "ERROR";
			if(e instanceof org.springframework.dao.DuplicateKeyException) {
				error = "DUPLICATED";
			}
			return new ResponseEntity<String>(error, HttpStatus.BAD_REQUEST);
		}
	}
	
	// 음악 관리
	// 검색어 없음
	@GetMapping("/admin/manage/search/{field}")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> manageSearch(@PathVariable String field, SearchCondition sc) {
		sc.setField(field);
		Map<String,Object> map = new HashMap<>();
		try {
			if("artist".equals(field)) {
				map = asv.searchArtist(sc);
			} else if("album".equals(field)) {
				map = msv.searchAlbum(sc);
			} else if("music".equals(field)) {
				map = msv.searchMusic(sc);
			} else {
				throw new Exception();
			}
			return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity(null, HttpStatus.BAD_REQUEST);
		}
	}

	// 검색어 있음
	@GetMapping("/admin/manage/search/{field}/{keyword}")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> manageSearch(@PathVariable String field, @PathVariable String keyword, SearchCondition sc) {
		sc.setField(field);
		sc.setKeyword(keyword);
		Map<String,Object> map = new HashMap<>();
		try {
			if("artist".equals(field)) {
				map = asv.searchArtist(sc);
			} else if("album".equals(field)) {
				map = msv.searchAlbum(sc);
			} else if("music".equals(field)) {
				map = msv.searchMusic(sc);
			} else {
				throw new Exception();
			}
			return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity(null, HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/admin/manage/{field}/{id}")
	@ResponseBody
	public ResponseEntity<List<MusicDto>> getMusic(@PathVariable String field, @PathVariable String id) {
		List<MusicDto> mList = null;
		try {
			mList = msv.getMusicAndArtist(field, id);
			return new ResponseEntity<List<MusicDto>> (mList, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<List<MusicDto>> (mList, HttpStatus.BAD_REQUEST);
		}
	}
	
	@PutMapping("/admin/manage/{field}/{id}")
	@ResponseBody
	public ResponseEntity<String> updateMusic(@PathVariable String field, @PathVariable String id, @RequestBody Map<String,Object> map) {
		int res = 0;
		List<String> cols = (List<String>)map.get("cols");
		List<String> values = (List<String>)map.get("values");
		System.out.println(field);
		System.out.println(id);
		System.out.println(cols);
		System.out.println(values);
		try {
			res = msv.updateMusicAndArtist(field, id, cols, values);
			if(res==0) throw new Exception();
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@DeleteMapping("/admin/manage/{field}/{id}")
	@ResponseBody
	public ResponseEntity<String> deleteMusic(@PathVariable String field, @PathVariable String id) {
		int res = 0;
		try {
			res = msv.deleteMusicAndArtist(field, id);
			if(res==0) throw new Exception();
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/admin/user")
	public String user() {
		return "admin-user";
	}
	
	@GetMapping("/admin/search/users/")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> getUser(SearchCondition sc) {
		Map<String,Object> map = null;
		try {
			map = usv.searchUser(sc);
			return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/admin/search/users/{keyword}")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> getUser(@PathVariable String keyword, SearchCondition sc) {
		sc.setKeyword(keyword);
		System.out.println(sc);
		Map<String,Object> map = null;
		try {
			map = usv.searchUser(sc);
			return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/admin/user/{id}")
	@ResponseBody
	public ResponseEntity<UserDto> getUser(@PathVariable String id) {
		UserDto user = null;
		try {
			user = usv.selectUser(id);
			if(user == null) throw new Exception();
			return new ResponseEntity<UserDto> (user, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<UserDto> (user, HttpStatus.BAD_REQUEST);
		}
	}
	
	@PutMapping("/admin/user/{id}")
	@ResponseBody
	public ResponseEntity<String> updateUser(@PathVariable String id, @RequestBody(required=false) Map<String,Object> map) {
		String doing = map.get("doing")+"";
		
		if("deactivate".equals(doing)) {
			try {
				String date = map.get("date")+"";
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy. M. d. a h:m:s");
				LocalDateTime ldt = LocalDateTime.parse(date, dtf);
				DateTimeFormatter dtf2 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				date = dtf2.format(ldt);
				
				usv.updateUser(id, "deactivate", date);
				return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			} catch(Exception e) {
				e.printStackTrace();
				return new ResponseEntity<String>("ERROR", HttpStatus.BAD_REQUEST);
			} 
		} else if("cancleDeactivate".equals(doing)) {
			try {
				usv.updateUser(id, "deactivate", null);
				return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			} catch(Exception e) {
				return new ResponseEntity<String>("ERROR", HttpStatus.BAD_REQUEST);
			}
		} else if("resetPassword".equals(doing)) {
			try {
				usv.updateUser(id, "pwd", "123asdASD!");
				return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			} catch(Exception e) {
				e.printStackTrace();
				return new ResponseEntity<String>("ERROR", HttpStatus.BAD_REQUEST);
			}
		} else {
			return new ResponseEntity<String>("ERROR", HttpStatus.BAD_REQUEST);
		} 
	}
	
	@DeleteMapping("/admin/user/{id}")
	@ResponseBody
	public ResponseEntity<String> deleteUser(@PathVariable String id) {
		int res = 0;
		try {
			res = usv.deleteUser(id);
			if(res == 0) throw new Exception();
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
}
