package com.taek.gori.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.taek.gori.dto.CommentDto;
import com.taek.gori.dto.FeedDto;
import com.taek.gori.service.FeedService;
import com.taek.gori.util.SearchCondition;

@Controller
public class FeedController {
	@Autowired FeedService fsv;
	
	@GetMapping("/feed")
	public String getFeed(@RequestParam(required=false) String field, @RequestParam(required=false, defaultValue="") String keyword, @RequestParam(required=false) String musicIdx, @RequestParam(required=false) Integer page, @RequestParam(required=false) Integer pageSize, Model m) {
		Map<String, Object> map = new HashMap<>();
		SearchCondition sc = new SearchCondition(field, keyword, page, pageSize);
		try {
			map = fsv.searchFeed(sc, musicIdx);
			m.addAttribute("map", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "feed";
	}
	
	@PostMapping("/feed")
	public String postFeed(FeedDto feed, RedirectAttributes ra) {
		try {
			fsv.insertFeed(feed);
			String message = "SUCCESS";
			ra.addFlashAttribute("message", message);
			return "redirect:/feed";
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		}
	}
	
	@GetMapping("/feed/{feedIdx}/comments")
	@ResponseBody
	public ResponseEntity<Map<String,Object>> getComments(@PathVariable String feedIdx) {
		Map<String,Object> map = new HashMap<>();
		try {
			map = fsv.getComments(feedIdx);
			return new ResponseEntity<Map<String,Object>> (map, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Map<String,Object>> (map, HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping("/feed/{feedIdx}/comments")
	@ResponseBody
	public ResponseEntity<String> postComment(@PathVariable String feedIdx, CommentDto comment) {
		comment.setFeedIdx(Integer.valueOf(feedIdx));
		try {
			fsv.insertComment(comment);
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@PutMapping("/feed/{feedIdx}")
	@ResponseBody
	public ResponseEntity<String> updateFeed(@PathVariable String feedIdx, @RequestBody Map<String,Object> map) {
		String musicIdx = map.get("musicIdx")+"";
		String content = map.get("content")+"";
		
		FeedDto feed = new FeedDto();
		feed.setIdx(Integer.parseInt(feedIdx));
		feed.setMusicIdx(Integer.valueOf(musicIdx));
		feed.setContent(content);
		
		try {
			fsv.updateFeed(feed);
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@DeleteMapping("/feed/{feedIdx}")
	@ResponseBody
	public ResponseEntity<String> deleteFeed(@PathVariable String feedIdx) {
		try {
			fsv.deleteFeed(feedIdx);
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);

		}
	}
	
	@PutMapping("/feed/{feedIdx}/comment/{commentIdx}")
	@ResponseBody
	public ResponseEntity<String> updateComment(@PathVariable String feedIdx, @PathVariable String commentIdx, @RequestBody Map<String,Object> map) {
		try {
			fsv.updateComment(commentIdx, map.get("content")+"");
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@DeleteMapping("/feed/{feedIdx}/comment/{commentIdx}")
	@ResponseBody
	public ResponseEntity<String> deleteCommnet(@PathVariable String commentIdx) {
		try {
			fsv.deleteComment(commentIdx);
			return new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("ERROR", HttpStatus.BAD_REQUEST);
		}
	}
}
