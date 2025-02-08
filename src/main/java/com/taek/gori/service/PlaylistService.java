package com.taek.gori.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taek.gori.dao.MusicDao;
import com.taek.gori.dao.PlaylistDao;
import com.taek.gori.dao.UserDao;
import com.taek.gori.dto.FileUrl;
import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.PlaylistDto;
import com.taek.gori.util.PageHandler;
import com.taek.gori.util.SearchCondition;

@Service
public class PlaylistService {
	@Autowired PlaylistDao pdao;
	@Autowired MusicDao mdao;
	@Autowired UserDao udao;
	
	public PlaylistDto getUsersQuelist(String userIdx) throws Exception {
		PlaylistDto quelist = null;
		quelist = pdao.selectQuelist(userIdx);
		List<MusicDto> mList = mdao.selectMusicsInPlaylist(quelist.getIdx()+"");
		quelist.setMusicList(mList);
		
		return quelist;
	}
	
	public Map<String,Object> insertArtistToQuelist(String userIdx, String artistId) throws Exception {
		Map<String,Object> map = new HashMap<>();
		PlaylistDto quelist = pdao.selectQuelist(userIdx);
		List<MusicDto> mList = mdao.selectPopularMusics(artistId);
		
		if(mList != null) {
			for(int i=0; i<mList.size(); i++) {
				MusicDto m = mList.get(i);
				pdao.insertMusic(quelist.getIdx()+"", m.getIdx()+"");
			}
		}
		map.put("mList", mList);
		return map;
	}
	
	public Map<String,Object> insertAlbumToQuelist(String userIdx, String albumId) throws Exception {
		Map<String,Object> map = new HashMap<>();
		PlaylistDto quelist = pdao.selectQuelist(userIdx);
		List<MusicDto> mList = mdao.selectMusicsInAlbum(albumId);
		
		if(mList != null) {
			for(int i=0; i<mList.size(); i++) {
				MusicDto m = mList.get(i);
				pdao.insertMusic(quelist.getIdx()+"", m.getIdx()+"");
			}
		}
		map.put("mList", mList);
		return map;
	}
	
	public int insertMusicToQuelist(String userIdx, String musicIdx) throws Exception {
		int res = 0;
		PlaylistDto quelist = pdao.selectQuelist(userIdx);
		res = pdao.insertMusic(quelist.getIdx()+"", musicIdx);
		
		return res;
	}
	
	public Map<String,Object> insertPlaylistToQuelist(String userIdx, String playlistIdx) throws Exception {
		Map<String,Object> map = new HashMap<>();
		PlaylistDto quelist = pdao.selectQuelist(userIdx);
		List<MusicDto> mList = mdao.selectMusicsInPlaylist(playlistIdx);
		
		if(mList != null) {
			for(int i=0; i<mList.size(); i++) {
				MusicDto m = mList.get(i);
				pdao.insertMusic(quelist.getIdx()+"", m.getIdx()+"");
			}
		}
		map.put("mList", mList);
		return map;
	}
	
	public int deleteMusicFromQuelist(String userIdx, String listOrder) throws Exception {
		int res = 0;
		PlaylistDto quelist = pdao.selectQuelist(userIdx);
		res = pdao.deleteMusic(quelist.getIdx()+"", listOrder);
		
		return res;
	}
	
	public int insertPlaylist(PlaylistDto playlist) throws Exception {
		int res = 0;
		res = pdao.insert(playlist);
		return res;
	}
	
	public int insertMusicToPlaylist(String playlistIdx, String musicIdx) throws Exception {
		int res = 0;
		PlaylistDto playlist = pdao.select(playlistIdx);
		if("likelist".equals(playlist.getType())) {
			udao.userLikeMusic(playlist.getUserIdx()+"", musicIdx);
		}
		res = pdao.insertMusic(playlistIdx, musicIdx);
		
		return res;
	}
	
	public MusicDto getMusicInPlaylist(String playlistIdx, String musicIdx) throws Exception {
		List<MusicDto> mList = mdao.selectMusicsInPlaylist(playlistIdx);
		for(MusicDto m : mList) {
			if(musicIdx.equals(m.getIdx()+"")) return m; 
		}
		return null;
	}
	
	public List<MusicDto> getAllMusicsInPlaylist(String playlistIdx) throws Exception {
		List<MusicDto> mList = mdao.selectMusicsInAlbum(playlistIdx);
		return mList;
	}
	
	public List<PlaylistDto> getUsersPlaylist(String userIdx) throws Exception {
		List<PlaylistDto> pList = null;
		pList = pdao.selectUsersPlaylist(userIdx);
		
		for(int i=0; i<pList.size(); i++) {
			PlaylistDto playlist = pList.get(i);
			playlist.setMusicList(mdao.selectMusicsInPlaylist(playlist.getIdx()+""));
			
			if(playlist.getMusicList().size() == 0) {
				playlist.setPlaylistImage(FileUrl.DEFAULT_ALBUM.getUrl());
			} else {
				String albumImg = playlist.getMusicList().get(0).getAlbumImg();
				playlist.setPlaylistImage(albumImg);
			}
		}
		return pList;
	}
	
	public int deleteMusicFromPlaylist(String playlistIdx, String listOrder) throws Exception {
		int res = 0;
		res = pdao.deleteMusic(playlistIdx, listOrder);
		
		return res;
	}
	
	public Map<String,Object> searchPlaylist(SearchCondition sc) throws Exception {
		Map<String,Object> map = new HashMap<>();
		sc.setField("name");
		
		List<PlaylistDto> pList = pdao.searchPlaylist(sc.getField(), sc.getKeyword());
		PageHandler ph = new PageHandler(pdao.countSelected(sc.getField(), sc.getKeyword()),sc);
		map.put("list", pList);
		map.put("ph", ph);
		
		return map;
	}
}
