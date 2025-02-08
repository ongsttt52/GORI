package com.taek.gori.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taek.gori.dao.ArtistDao;
import com.taek.gori.dao.MusicDao;
import com.taek.gori.dao.PlaylistDao;
import com.taek.gori.dao.UserDao;
import com.taek.gori.dto.ArtistDto;
import com.taek.gori.dto.FileUrl;
import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.PlaylistDto;
import com.taek.gori.util.MyFormatter;


@Service
public class ViewService {
	@Autowired ArtistDao adao;
	@Autowired MusicDao mdao;
	@Autowired PlaylistDao pdao;
	@Autowired UserDao udao;
	
	public Map<String,Object> getArtistPage(String artistId, String userIdx) throws Exception {
		Map<String,Object> map = new HashMap<>();
		ArtistDto artist = null;
		List<MusicDto> albums = null;
		List<MusicDto>  popularMusics = null;
		List<ArtistDto> similars = null;
		List<PlaylistDto> playlists = null;
		List<MusicDto> newList = new ArrayList<>();
		try {
			artist = adao.select("id", artistId);
			if(userIdx != null) {
				ArtistDto selected = adao.selectUserArtist(userIdx, artistId);
				if(selected != null) artist.setIsFollowed(selected.getIsFollowed());
			}
			albums = mdao.selectAlbumsInArtist(artistId);
			popularMusics = mdao.selectPopularMusics(artistId);
			similars = adao.selectSimilarArtists(artist);
			playlists = pdao.selectArtistsPlaylist(artistId);
			
			artist.setFollowCount(adao.countFollower(artistId));
			
			for(int i=0; i<popularMusics.size(); i++) {
				MusicDto m = popularMusics.get(i);
				MusicDto m2 = udao.selectUserMusic(userIdx, m.getIdx()+"");
				if(m2 == null) m.setIsLiked(false);
				else {
					if(m2.getIsLiked()) m.setIsLiked(true);
					else m.setIsLiked(false);
				}
				String duration = MyFormatter.formatSeconds(m.getDuration());
				m.setDurationString(duration);
				
				newList.add(m);
			}
			for(int i=0; i<playlists.size(); i++) {
				PlaylistDto playlist = playlists.get(i);
				playlist.setMusicList(mdao.selectMusicsInPlaylist(playlist.getIdx()+""));
				
				if(playlist.getMusicList().size() == 0) {
					playlist.setPlaylistImage(FileUrl.DEFAULT_ALBUM.getUrl());
				} else {
					String albumImg = playlist.getMusicList().get(0).getAlbumImg();
					playlist.setPlaylistImage(albumImg);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		map.put("artist", artist);
		map.put("albums", albums);
		map.put("populars", newList);
		map.put("similars", similars);
		map.put("playlists", playlists);
		return map;
	}
	
	public Map<String,Object> getAlbumPage(String albumId, String userIdx) throws Exception {
		Map<String,Object> map = new HashMap<>();
		MusicDto album = null;
		List<MusicDto> mList = null;
		List<MusicDto> otherAlbums = null;
		List<MusicDto> similarMusics = null;
		List<MusicDto> newList = new ArrayList<>();
		try {
			album = mdao.selectAlbum(albumId);
			mList = mdao.selectMusicsInAlbum(albumId);
			otherAlbums = mdao.selectOtherAlbums(albumId);
			similarMusics = mdao.selectSimilarAlbums(album.getArtistId(), album.getGenre(), album.getReleaseDate(), album.getPopularity());
			
			for(int i=0; i<mList.size(); i++) {
				MusicDto m = mList.get(i);
				MusicDto m2 = udao.selectUserMusic(userIdx, m.getIdx()+"");
				if(m2 == null) m.setIsLiked(false);
				else {
					if(m2.getIsLiked()) m.setIsLiked(true);
					else m.setIsLiked(false);
				}
				String duration = MyFormatter.formatSeconds(m.getDuration());
				m.setDurationString(duration);
				
				newList.add(m);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		map.put("album", album);
		map.put("mList", newList);
		map.put("others", otherAlbums);
		map.put("similars", similarMusics);
		return map;
	}
	
//	public Map<String,Object> getMusic(String musicIdx) throws Exception {
//		Map<String,Object> map = new HashMap<>();
//		MusicDto music = null;
//		List<MusicDto> otherMusics = null;
//		List<MusicDto> similars = null;
//		try {
//			music = mdao.select("musicIdx", musicIdx);
//			otherMusics = mdao.selectOtherMusics(musicIdx);
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
//		map.put("object", music);
//		map.put("others", otherMusics);
//		return map;
//	}
	
	public Map<String,Object> getPlaylistPage(String playlistIdx, String userIdx) throws Exception {
		Map<String,Object> map = new HashMap<>();
		PlaylistDto playlist = null;
		int playlistSize = 0;
		String playlistDuration = null;
		List<MusicDto> mList = null;
		List<MusicDto> newList = new ArrayList<>();
		List<PlaylistDto> similars = null;
		List<PlaylistDto> newSimilars = new ArrayList<>();
		List<MusicDto> recommends = null;
		
		try {
			playlist = pdao.select(playlistIdx);
			List<MusicDto> musics = mdao.selectMusicsInPlaylist(playlist.getIdx()+"");
			if(musics.size() == 0) {
				playlist.setPlaylistImage(FileUrl.DEFAULT_ALBUM.getUrl());
			} else {
				String albumImg = musics.get(0).getAlbumImg();
				playlist.setPlaylistImage(albumImg);
			}
			
			mList = mdao.selectMusicsInPlaylist(playlistIdx);
			for(int i=0; i<mList.size(); i++) {
				MusicDto m = mList.get(i);
				MusicDto m2 = udao.selectUserMusic(userIdx, m.getIdx()+"");
				if(m2 == null) m.setIsLiked(false);
				else {
					if(m2.getIsLiked()) m.setIsLiked(true);
					else m.setIsLiked(false);
				}
				String duration = MyFormatter.formatSeconds(m.getDuration());
				m.setDurationString(duration);
				
				newList.add(m);
			}
			
			MusicDto music = pdao.selectGenre(playlistIdx);
			String genre = null;
			if(music != null) genre = music.getGenre()+"";
			if(genre != null) similars = pdao.selectSimilarPlaylists(playlistIdx, genre);
			if(similars != null) {
				for(int i=0; i<similars.size(); i++) {
					if(userIdx != null && userIdx.equals(similars.get(i).getUserIdx()+"")) continue;
					
					PlaylistDto playlist2 = similars.get(i);
					List<MusicDto> musics2 = mdao.selectMusicsInPlaylist(playlist2.getIdx()+"");
					if(musics2.size() == 0) {
						playlist2.setPlaylistImage(FileUrl.DEFAULT_ALBUM.getUrl());
					} else {
						String albumImg = musics2.get(0).getAlbumImg();
						playlist2.setPlaylistImage(albumImg);
					}
					newSimilars.add(playlist2);
				}
			}
			
			//recommends = mdao.selectRecommendMusic(playlistIdx);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		int duration = 0;
		if(mList != null) {
			playlistSize = mList.size();
			for(int i=0; i<mList.size(); i++) {
				MusicDto m = mList.get(i);
				duration += m.getDuration();
			}
		}
		playlistDuration = MyFormatter.formatSeconds2(duration);
		map.put("playlist", playlist);
		map.put("playlistSize", playlistSize);
		map.put("playlistDuration", playlistDuration);
		map.put("mList", newList);
		map.put("similars", newSimilars);
		map.put("recommends", recommends);
		return map;
	}
}
