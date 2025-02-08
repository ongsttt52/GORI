package com.taek.gori.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taek.gori.dao.MusicDao;
import com.taek.gori.dao.PlaylistDao;
import com.taek.gori.dao.UserDao;
import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.PlaylistDto;
import com.taek.gori.dto.UserDto;
import com.taek.gori.util.PageHandler;
import com.taek.gori.util.SearchCondition;

@Service
public class UserService {
	@Autowired UserDao udao;
	@Autowired MusicDao mdao;
	@Autowired PlaylistDao pdao;
	
	public UserDto selectUser(String idx) throws Exception {
		UserDto user = null;
		try {
			user = udao.select("idx", idx);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	public Map<String, Object> searchUser(SearchCondition sc) throws Exception {
		List<UserDto> uList = null;
		PageHandler ph = null;
		
		try {
			if(sc.getKeyword() == null || "".equals(sc.getKeyword())) uList = udao.selectAll();
			else uList = udao.selectSearched(sc);
			ph = new PageHandler(udao.count(), sc);
			System.out.println(uList);
		} catch(Exception e) {
			e.printStackTrace();
		}
		Map<String,Object> map = new HashMap<>();
		map.put("list", uList);
		map.put("ph", ph);
		return map;
	}
	
	public int updateUser(String id, String col,String value) throws Exception {
		int res = 0;
		try {
			res = udao.update(id, col, value);
			if(res == 0) throw new Exception("수정에 실패했습니다.");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
	public int deleteUser(String id) throws Exception {
		int res = 0;
		try {
			res = udao.delete(id);
			if(res == 0) throw new Exception("delete failed");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
	public int userFollowArtist(String userIdx, String artistId) throws Exception {
		int res = 0;
		res = udao.insertUserArtist(userIdx, artistId);
		return res;
	}
	
	public int userDeleteArtist(String userIdx, String artistId) throws Exception {
		int res = 0;
		res = udao.deleteUserArtist(userIdx, artistId);
		return res;
	}
	
	@Transactional(rollbackFor = Exception.class)
	public int userPlayedMusic(String userIdx, String musicIdx) throws Exception {
		int res = 0;
		MusicDto music = udao.selectUserMusic(userIdx, musicIdx);
		if(music == null) res = udao.insertUserMusic(userIdx, musicIdx);
		
		res = udao.userPlayedMusic(userIdx, musicIdx);
		if(res == 0) throw new Exception();

		return res;
	}
	
	@Transactional(rollbackFor = Exception.class)
	public int userLikeMusic(String userIdx, String musicIdx) throws Exception {
		int res = 0;
		MusicDto music = udao.selectUserMusic(userIdx, musicIdx);
		if(music == null) res = udao.insertUserMusic(userIdx, musicIdx);
		
		res = udao.userLikeMusic(userIdx, musicIdx);
		if(res == 0) throw new Exception();
		
		PlaylistDto playlist = pdao.selectLikelist(userIdx);
		res = pdao.insertMusic(playlist.getIdx()+"", musicIdx);
		if(res == 0) throw new Exception();
		
		return res;
	}
	
	@Transactional(rollbackFor = Exception.class)
	public int userNotLikeMusic(String userIdx, String musicIdx) throws Exception {
		int res = 0;
		res = udao.userNotLikeMusic(userIdx, musicIdx);
		if(res == 0) throw new Exception();
		
		PlaylistDto playlist = pdao.selectLikelist(userIdx);
		res = pdao.deleteMusicFromLikelist(playlist.getIdx()+"", musicIdx);
		if(res == 0) throw new Exception();
		return res;
	}
}
