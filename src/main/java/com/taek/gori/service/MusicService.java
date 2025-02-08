package com.taek.gori.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taek.gori.api.SpotifyApi;
import com.taek.gori.dao.ArtistDao;
import com.taek.gori.dao.MusicDao;
import com.taek.gori.dao.UserDao;
import com.taek.gori.dto.MusicDto;
import com.taek.gori.util.MyFormatter;
import com.taek.gori.util.PageHandler;
import com.taek.gori.util.SearchCondition;

@Service
public class MusicService {
	@Autowired MusicDao mdao;
	@Autowired ArtistDao adao;
	@Autowired UserDao udao;
	@Autowired SpotifyApi api;
	
	// ¾Ù¹üÀÇ ¸ðµç Æ®·¢ »ðÀÔ
	@Transactional(rollbackFor = Exception.class)
	public int insertAlbum(String id) throws Exception {
		int res = 0;
		try {
			JSONArray tracksArray = api.searchTracksByAlbum(id); // ¾Ù¹üÀÇ ¸ðµç Æ®·¢À» ¾òÀ½
			JSONObject albumObject = api.searchObjectById("album", id); // id¿¡ ÇØ´çÇÏ´Â ¾Ù¹üÀ» ¾òÀ½
			if(tracksArray == null || albumObject == null) 
				throw new Exception("");
			
			for(int i=0; i<tracksArray.size(); i++) {
				JSONObject trackObject = (JSONObject)tracksArray.get(i);
				res = insertTrack(albumObject, trackObject);
			}
		} catch(Exception e) {
			e.printStackTrace();
			if(e instanceof org.springframework.dao.DataIntegrityViolationException) {
			}
		}
		return res;
	}
	
	// ´ÜÀÏ Æ®·¢ »ðÀÔ
	public int insertTrack(JSONObject albumObject, JSONObject trackObject) throws Exception {
		int res = 0;
		MusicDto music = api.createMusicDto(albumObject, trackObject);
		res = mdao.insert(music);
		
		if(res!=0) {
			JSONArray artists = (JSONArray)trackObject.get("artists");
			for(int i2=0; i2<artists.size(); i2++) {
				JSONObject artist = (JSONObject)artists.get(i2);
				String artistId = artist.get("id")+"";
				String artistName = artist.get("name")+"";
				String role = "main";
				if(i2>0) role = "featuring"; 
				mdao.insertArtistName(res, artistId, artistName, role);
			}
		}
		else throw new Exception("MusicService.insertTrack() : insert ½ÇÆÐ");
		
		return res;
	}
	
	public Map<String,Object> searchAlbum(SearchCondition sc) throws Exception {
		Map<String,Object> map = new HashMap<>();
		List<MusicDto> mList = new ArrayList<>();
		sc.setField("album_name");
		
		try {
			mList = mdao.selectSearched(sc.getField(), sc.getKeyword(), sc.getOffset()+"", sc.getPageSize()+"");
		} catch(Exception e) {
			e.printStackTrace();
		}
		PageHandler ph = new PageHandler(mdao.countSelected(sc.getField(), sc.getKeyword()),sc);
		map.put("list", mList);
		map.put("ph", ph);
		return map;
	}
	
	public Map<String,Object> searchMusic(SearchCondition sc) throws Exception {
		Map<String,Object> map = new HashMap<>();
		List<MusicDto> mList = new ArrayList<>();
		sc.setField("title");
		
		try {
			mList = mdao.selectSearched(sc.getField(), sc.getKeyword(), sc.getOffset()+"", sc.getPageSize()+"");
		} catch(Exception e) {
			e.printStackTrace();
		}
		PageHandler ph = new PageHandler(mdao.countSelected(sc.getField(), sc.getKeyword()),sc);
		map.put("list", mList);
		map.put("ph", ph);
		return map;
	}
	
	public List<MusicDto> selectAlbumList(String artistId) throws Exception {
		List<MusicDto> mList = null;
		try {
			mList = mdao.selectAlbumsInArtist(artistId);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mList;
	}
	
	public List<MusicDto> getMusicAndArtist(String field, String id) throws Exception {
		List<MusicDto> mList = new ArrayList<>();
		try {
			if("artist".equals(field)) mList = mdao.selectAlbumsInArtist(id);
			else if("album".equals(field)) mList = mdao.selectMusic("album_id", id);
			else if("music".equals(field)) mList = mdao.selectMusic("idx", id);
		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mList;
	}
	
	public int updateMusicAndArtist(String field, String id, List<String> cols, List<String> values) {
		int res = 0;
		try {
			if("artist".equals(field)) {
				for(int i=0; i<cols.size(); i++) {
					res = adao.update("id", id, cols.get(i), values.get(i));
				}
			} else if("album".equals(field)) {
				for(int i=0; i<cols.size(); i++) {
					res = mdao.update("album_id", id, cols.get(i), values.get(i));
				}
			} else if("music".equals(field)) {
				for(int i=0; i<cols.size(); i++) {
					res = mdao.update("idx", id, cols.get(i), values.get(i));
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
	public int deleteMusicAndArtist(String field, String id) throws Exception {
		int res = 0;
		if("artist".equals(field)) {
			res = adao.delete("id", id);
		} else if("album".equals(field)) {
			res = mdao.delete("album_id", id);
		} else if("music".equals(field)) {
			res = mdao.delete("idx", id);
		}
		return res;
	}
	
	public List<MusicDto> searchMusic2(SearchCondition sc, String userIdx) throws Exception {
		List<MusicDto> mList = new ArrayList<>();
		String word = sc.getKeyword();
		// (ÃÊ¼º ÀÎµ¦½º * 21 + Áß¼º ÀÎµ¦½º) * 28 + Á¾¼º ÀÎµ¦½º + 0xAC00
		// ÇÑ±ÛÀÏ °æ¿ì
		if(word.matches("[¤¡-¤¾°¡-ÆR]") || word.matches("[¤¡-¤¾°¡-ÆR][¤¡-¤¾°¡-ÆR¤¿-¤Ó0-9 ]*[¤¡-¤¾°¡-ÆR]")) {
			String newWord1 = "";
			String newWord2 = "";
	    	int jongNum = 0;
	    	char lastChar = word.charAt(word.length()-1);
	    	if(lastChar >= 0xAC00 && lastChar <= 0xD7A3) {
	    		jongNum = (lastChar - 0xAC00) % 28;
	    		// ¹ÞÄ§ ÀÖÀ½
	    		if(jongNum != 0) {
	    			//					  "", "¤¡", "¤¢", "¤£", "¤¤", "¤¥", "¤¦", "¤§", "¤©", "¤ª", "¤«", "¤¬", "¤­", "¤®", "¤¯", "¤°", "¤±", "¤²", "¤´", "¤µ", "¤¶", "¤·", "¤¸", "¤º", "¤»", "¤¼", "¤½", "¤¾"
	    			String[] syllables = {"", "°¡", "±î", "»ç", "³ª", "ÀÚ", "ÇÏ", "´Ù", "¶ó", "°¡", "¸¶", "¹Ù", "»ç", "Å¸", "ÆÄ", "ÇÏ", "¸¶", "¹Ù", "»ç", "»ç", "½Î", "¾Æ", "ÀÚ", "Â÷", "Ä«", "Å¸", "ÆÄ", "ÇÏ"};
	    	    	String[] syllableEnds = {"", "ƒ‰", "…ù", "šï", "ˆ¢", "£ ", "ÆR", "‹L", "¡", "ƒ‰", "“J", "•½", "šï", "»M", "À˜", "ÆR", "“J", "•½", "šï", "šï", "Ï", "Ÿç", "£ ", "¯†", "µi", "»M", "À˜", "ÆR"};
		    		if(word.length() == 1) {
			    		newWord1 = (char)(lastChar - jongNum) + syllables[jongNum];
			    		newWord2 = (char)(lastChar - jongNum) + syllableEnds[jongNum];
			    	} else {
			    		newWord1 = word.substring(0,word.length()-1) + (char)(lastChar - jongNum) + syllables[jongNum];
			    		newWord2 = word.substring(0, word.length()-1) + (char)(lastChar - jongNum) + syllableEnds[jongNum];
			    	}
		    		System.out.println(word + ", " + newWord1 + ", " + newWord2);
		    		mList = mdao.selectSearched2(word, newWord1, newWord2);
		    	// ¹ÞÄ§ ¾øÀ½
		    	} else {
		    		newWord1 = word;
		    		newWord2 = word.substring(0, word.length()-1) + (char)(lastChar + 28);
		    		System.out.println(word + ", " + newWord1 + ", " + newWord2);
		    		mList = mdao.selectSearched2(word, newWord1, newWord2);
		    	}
	    	} else if(lastChar >= 0x1100 && lastChar <= 0x115E) {
    			String[] jongs = {"¤¡", "¤¢", "¤¤", "¤§", "¤¨", "¤©", "¤±", "¤²", "¤³", "¤µ", "¤¶", "¤·", "¤¸", "¤¹", "¤º", "¤»", "¤¼", "¤½", "¤¾"};
    			String[] syllables = {"°¡", "±î", "³ª", "´Ù", "µû", "¶ó", "¸¶", "¹Ù", "ºü", "»ç", "½Î", "¾Æ", "ÀÚ", "Â¥", "Â÷", "Ä«", "Å¸", "ÆÄ", "ÇÏ"};
    	    	String[] syllableEnds = {"ƒ‰", "…ù", "ˆ¢", "‹L", "ê", "¡", "“J", "•½", "˜ª", "šï", "Ï", "Ÿç", "£ ", "Âö", "¯†", "µi", "»M", "À˜", "ÆR"};
    	    	
    	    	for(int i=0; i<jongs.length; i++) {
    	    		if(jongs[i].equals(lastChar+"")) jongNum = i;
    	    	}
    	    	
		    	if(word.length() == 1) {
		    		newWord1 = syllables[jongNum];
		    		newWord2 = syllableEnds[jongNum];
		    	} else {
		    		newWord1 = word.substring(0,word.length()-1) + syllables[jongNum];
		    		newWord2 = word.substring(0, word.length()-1) + syllableEnds[jongNum];
		    	}
		    	System.out.println(word + ", " + newWord1 + ", " + newWord2);
	    		mList = mdao.selectSearched2(word, newWord1, newWord2);
	    	}
	    // ÇÑ±ÛÀÌ ¾Æ´Ò °æ¿ì
		} else {
			mList = mdao.selectSearched2(word);
		}
		
		List<MusicDto> newList = new ArrayList<>();
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
		return newList;
	}
}
