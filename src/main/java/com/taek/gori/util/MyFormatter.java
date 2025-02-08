package com.taek.gori.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.taek.gori.dao.MusicDao;
import com.taek.gori.dao.MusicDaoImpl;
import com.taek.gori.dao.UserDao;
import com.taek.gori.dao.UserDaoImpl;
import com.taek.gori.dto.FileUrl;
import com.taek.gori.dto.MusicDto;
import com.taek.gori.dto.PlaylistDto;

@Component
public class MyFormatter {
	// 현재 시각을 Timestamp로 생성 후 문자열로 반환
	public static String getCurrentTime() {
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentTime = sdf.format(ts);
		return currentTime;
	}
	
	// Timestamp -> [0] DateTime , [1] Date, [2] Time
	public static String[] formatTimestamp(Timestamp ts) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String tsDateTime = sdf.format(ts);
		
		String tsDate = tsDateTime.substring(0,10);
		String tsTime = tsDateTime.substring(11,16);
		
		return new String[] {tsDateTime, tsDate, tsTime};
	}
	
	// Timestamp ts를 매개변수로 넣어서 LocalDate.now()의 날짜와 비교 -> ts가 오늘이면 true
	public static boolean isToday(Timestamp ts) {
		String[] formatted = formatTimestamp(ts);
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate now = LocalDate.now();
		String today = dtf.format(now);
		
		if(formatted[1].equals(today)) return true; 
		else return false;
	}
	
	// Timestamp, LocalDate의 차이를 int값으로 반환
	public static int getDiff(Timestamp ts, LocalDateTime ldt, String type) {
		String[] formatted = formatTimestamp(ts);
		
		DateTimeFormatter dtfDateTime = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		DateTimeFormatter dtfDate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		LocalDateTime tsDateTime = LocalDateTime.parse(formatted[0], dtfDateTime); // Timestamp ts를 LocalDateTime으로 변환
		LocalDate tsDate = LocalDate.parse(formatted[1], dtfDate); // Timestamp ts를 LocalDate로 변환
		
		String ldStr = dtfDate.format(ldt); // 매개변수의 LocalDateTime을 문자열로 변경
		LocalDate ld = LocalDate.parse(ldStr, dtfDate); // 변경한 문자열로 LocalDate를 생성
		
		Period period = Period.between(tsDate, ld); // 년,월,일 비교 -> LocalDate
		Duration duration = Duration.between(tsDateTime, ldt); // 시, 분, 초 비교 -> LocalDateTime
		long res = 0;
		
		switch(type) {
			case("year"): 
				res = period.getYears();
				break;
			case("month"): 
				res = period.getMonths();
				break;
			case("day"): 
				res = period.getDays();
				break;
			case("hour"): 
				res = duration.toHours();
				break;
			case("minute"): 
				res = duration.toMinutes();
				break;
			case("second"): 
				res = duration.toSeconds();
				break;
		}
		return (int)res; // tsDate가 ldt보다 이전이면 양수, 이후이면 음수를 반환
	}
	
	// getDiff 함수에 LocalDateTime.now()를 매개변수로 넣어 Timestamp와 현재 시각 사이의 차이를 반환해 적절한 문자열로 변환
	public static String getDiffString(Timestamp ts) {
		if(ts == null) return null;
		LocalDateTime now = LocalDateTime.now();
		int diff = MyFormatter.getDiff(ts, now, "hour");
		String diffString = diff + " 시간 전";
		// 0시간 전 -> ~분 전으로 변환
		if (diff == 0) {
			diff = MyFormatter.getDiff(ts, now, "minute");
			diffString = diff + " 분 전";
			// 0분 전 -> ~초 전으로 변환
			if(diff == 0) {
				diff = MyFormatter.getDiff(ts, now, "second");
				diffString = diff + " 초 전";
			}
		}
		// ts가 오늘이면 변환한 문자열을, 오늘이 아니면 yyyy-MM-dd를 반환
		String result = MyFormatter.isToday(ts) ? diffString : MyFormatter.formatTimestamp(ts)[1];
		
		return result;
	}
	
	// 밀리초를 mm:ss 형식의 문자열로 변환
	public static String formatSeconds(int duration) {
		int minutes = (int)Math.floor(duration/1000 / 60);
		int seconds = (int)Math.floor(duration/1000 % 60);
		String durationString = String.format("%02d", minutes) + ":" + String.format("%02d", seconds);
		return durationString;
	}
	
	// 밀리초를 hh시간 mm분 형식의 문자열로 변환
	public static String formatSeconds2(int duration) {
		int hours = 0;
		int minutes = 0;
		String formatted = null;
		
		if(duration/1000 >= 3600) {
			hours = (int)Math.floor(duration/1000 / 3600);
			int durationLeft = (duration/1000) - (hours*3600);
			minutes = (int)Math.floor(durationLeft / 60);
			formatted = hours + "시간 " + minutes + "분";
		} else if(duration/1000 >= 60) {
			minutes = (int)Math.floor(duration/1000 / 60);
			formatted = minutes + "분 ";
		} else {
			formatted = "1분";
		}
		return formatted;
	}
	
	// List<MusicDto>의 모든 MusicDto에 대해 isLiked를 초기화
	public MusicDto formatMusicDto(MusicDto music, String userIdx) throws Exception {
		UserDao udao = new UserDaoImpl();
		MusicDto m2 = udao.selectUserMusic(userIdx, music.getIdx()+"");
		if(m2 == null) music.setIsLiked(false);
		else {
			if(m2.getIsLiked()) music.setIsLiked(true);
			else music.setIsLiked(false);
		}
		String duration = MyFormatter.formatSeconds(music.getDuration());
		music.setDurationString(duration);
		
		return music;
		
//		List<MusicDto> newList = new ArrayList<>();
//		
//			for(int i=0; i<mList.size(); i++) {
//				MusicDto m = mList.get(i);
//				MusicDto m2 = udao.selectUserMusic(userIdx, m.getIdx()+"");
//				if(m2 == null) m.setIsLiked(false);
//				else {
//					if(m2.getIsLiked()) m.setIsLiked(true);
//					else m.setIsLiked(false);
//				}
//				newList.add(m);
//			}
//		return newList;
	}
	
	public PlaylistDto formatPlaylist(PlaylistDto playlist) throws Exception {
		if(playlist == null) throw new NullPointerException();
		
		if(playlist.getPlaylistImage() == null) {
			MusicDao mdao = new MusicDaoImpl();
			List<MusicDto> musics = mdao.selectMusicsInPlaylist(playlist.getIdx()+"");
			if(musics.size() == 0) {
				playlist.setPlaylistImage(FileUrl.DEFAULT_ALBUM.getUrl());
			} else {
				String albumImg = musics.get(0).getAlbumImg();
				playlist.setPlaylistImage(albumImg);
			}
		}
		return playlist;
	}
}
