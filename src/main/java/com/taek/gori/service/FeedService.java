package com.taek.gori.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taek.gori.dao.CommentDao;
import com.taek.gori.dao.FeedDao;
import com.taek.gori.dto.CommentDto;
import com.taek.gori.dto.FeedDto;
import com.taek.gori.util.MyFormatter;
import com.taek.gori.util.PageHandler;
import com.taek.gori.util.SearchCondition;

@Service
public class FeedService {
	@Autowired FeedDao fdao;
	@Autowired CommentDao cdao;
	
	public int insertFeed(FeedDto feed) {
		int res = 0;
		try {
			res = fdao.insert(feed);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
	public Map<String,Object> searchFeed(SearchCondition sc, String musicIdx) {
		Map<String,Object> map = new HashMap<>();
		List<FeedDto> fList = new ArrayList<>();
		PageHandler ph = new PageHandler();
		
		try {
			fList = fdao.selectSearched(sc.getField(), sc.getKeyword(), musicIdx, sc.getOffset(), sc.getPageSize());
			ph = new PageHandler(fdao.countSelected(sc.getField(), sc.getKeyword(), musicIdx), sc);
			
			// Timestamp를 문자열로 변환
			for(int i=0; i<fList.size(); i++) {
				if(fList.get(i).getUpdatedAt() == null) {
					Timestamp ts = fList.get(i).getCreatedAt();
					fList.get(i).setDiffString(MyFormatter.getDiffString(ts));
				} else {
					Timestamp ts = fList.get(i).getUpdatedAt();
					fList.get(i).setDiffString("수정됨 "+MyFormatter.getDiffString(ts));
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		map.put("list", fList);
		map.put("ph", ph);
		return map;
	}
	
	@Transactional(rollbackFor = Exception.class)
	public int updateFeed(FeedDto feed) throws Exception {
		int res = 0;
		try {
			res = fdao.update("content", feed.getContent(), feed.getIdx()+"");
			res = fdao.update("music_idx", feed.getMusicIdx()+"", feed.getIdx()+"");
			if(res == 0) throw new Exception();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
	public int deleteFeed(String feedIdx) throws Exception {
		int res = 0;
		try {
			res = fdao.delete(feedIdx);
			if(res == 0) throw new Exception();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
	public Map<String,Object> getComments(String feedIdx) throws Exception {
		Map<String,Object> map = new HashMap<>();
		List<CommentDto> cList = new ArrayList<>();
		PageHandler ph = new PageHandler();
		
		try {
			cList = cdao.selectComments(feedIdx);
			ph = new PageHandler(cdao.countComments(feedIdx), new SearchCondition());
			
			for(int i=0; i<cList.size(); i++) {
				Timestamp ts = cList.get(i).getCreatedAt();
				cList.get(i).setDiffString(MyFormatter.getDiffString(ts));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		map.put("list", cList);
		map.put("ph", ph);
		return map;
	}
	
	public int insertComment(CommentDto comment) throws Exception {
		int res = 0;
		try {
			res = cdao.insert(comment);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
	public void updateComment(String commentIdx, String content) throws Exception {
		int res = 0;
		try {
			res = cdao.update(commentIdx, content);
			if(res==0) throw new Exception();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteComment(String commentIdx) throws Exception {
		int res = 0;
		try {
			res = cdao.delete(commentIdx);
			if(res==0) throw new Exception();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
