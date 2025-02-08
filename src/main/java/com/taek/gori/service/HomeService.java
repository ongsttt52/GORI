package com.taek.gori.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taek.gori.dao.ArtistDao;
import com.taek.gori.dao.MusicDao;
import com.taek.gori.dao.PlaylistDao;
import com.taek.gori.dao.UserDao;
import com.taek.gori.dto.ArtistDto;
import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.PlaylistDto;
import com.taek.gori.util.MyFormatter;

@Service
public class HomeService {
	@Autowired ArtistDao adao;
	@Autowired MusicDao mdao;
	@Autowired PlaylistDao pdao;
	@Autowired UserDao udao;
	
	// 보류
	public List<MusicDto> getUserMix(String userIdx) throws Exception {
		List<MusicDto> mixList = new ArrayList<>();
		try {
			List<ArtistDto> recentList = adao.selectUsersRecentArtist(userIdx);
			System.out.println("recentList : " + recentList);
			List<String> idList = new ArrayList<>();
			
			for(int i=0; i<recentList.size(); i++) { // 최근 많이 들은 아티스트 5명
				ArtistDto artist = recentList.get(i);
				ArtistDto newArtist = adao.select("id", artist.getId()); // 발매일 평균 계산을 위해 한 번 더 조회
				System.out.println("최근 많이 들은 아티스트 : ");
				System.out.println(newArtist);
				List<ArtistDto> similarList = adao.selectSimilarArtists(newArtist); 
				for(int i2=0; i2<similarList.size(); i2++) {
					idList.add(similarList.get(i).getId());
					System.out.println("similarArtist : "+similarList.get(i));
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mixList;
	}
	public List<MusicDto> getHottest() throws Exception {
		List<MusicDto> list = new ArrayList<>();
		try {
			list = mdao.selectHottest();
			for(MusicDto m : list) {
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public List<MusicDto> getRecent(String userIdx) throws Exception {
		List<MusicDto> recentList = new ArrayList<>();
		try {
			List<ArtistDto> aList = adao.selectUsersFavoriteArtist(userIdx);
			for(int i=0; i<aList.size(); i++) {
				ArtistDto artist = aList.get(i);
				MusicDto recentAlbum = mdao.selectRecentAlbum(artist.getId());
				if(recentAlbum != null) recentList.add(recentAlbum);
			}
			if(recentList.size() < 5) {
				for(int i=0; i<5-recentList.size(); i++) {
					MusicDto recentAlbum = mdao.selectRecentAlbum(null);
					recentList.add(recentAlbum);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return recentList;
	}
	public List<MusicDto> getPlayBack(String userIdx) throws Exception {
		List<MusicDto> mList = new ArrayList<>();
		try {
			mList = mdao.selectPlayedMonthLater(userIdx);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mList;
	}
	
	public List<ArtistDto> getFamousArtists() throws Exception {
		List<ArtistDto> aList = new ArrayList<>();
		try {
			aList = adao.selectFamousArtists();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return aList;
	}
	public List<MusicDto> getFamousAlbums() throws Exception {
		List<MusicDto> mList = new ArrayList<>();
		try {
			mList = mdao.selectFamousAlbums();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mList;
	}
	public List<MusicDto> getPopChart(String userIdx) throws Exception {
		List<MusicDto> chart = new ArrayList<>();
		List<MusicDto> newList = new ArrayList<>();
		try {
			chart = mdao.selectHottest();
			for(int i=0; i<chart.size(); i++) {
				MusicDto m = chart.get(i);
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
		return newList;
	}

	// 플레이리스트
	public void insertPlaylist(PlaylistDto playlist) throws Exception {
		int res = 0;
		try {
			res = pdao.insert(playlist);
			if(res == 0) throw new Exception();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertMusicIntoQue(String userIdx, String musicIdx) throws Exception {
		PlaylistDto quelist = null;
		int res = 0;
		try {
			quelist = pdao.selectQuelist(userIdx);
			if(quelist == null) throw new Exception();
			res = pdao.insertMusic(quelist.getIdx()+"", userIdx);
			if(res == 0) throw new Exception();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
