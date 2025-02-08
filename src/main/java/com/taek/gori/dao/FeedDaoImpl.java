package com.taek.gori.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taek.gori.dto.FeedDto;

@Repository
public class FeedDaoImpl implements FeedDao {
	@Autowired SqlSession session;
	String namespace = "gori.feed.";
	
	@Override
	public int count() throws Exception {
		return session.selectOne(namespace+"count");
	}
	
	@Override
	public int countSelected(String col, String value, String musicIdx) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		map.put("musicIdx", musicIdx);
		return session.selectOne(namespace+"countSelected", map);
	}
	
	@Override
	public int insert(FeedDto feed) throws Exception {
		return session.insert(namespace+"insert", feed);
	}
	
	@Override
	public List<FeedDto> select(String col, String value) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		return session.selectList(namespace+"select", map);
	}
	
	@Override
	public List<FeedDto> selectAll() throws Exception {
		return session.selectList(namespace+"selectAll");
	}
	
	@Override
	public List<FeedDto> selectSearched(String col, String value, String musicIdx, Integer offset, Integer pageSize) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		map.put("musicIdx", musicIdx);
		map.put("offset", offset);
		map.put("pageSize", pageSize);
		return session.selectList(namespace+"selectSearched", map);
	}
	
	@Override
	public int update(String col, String value, String idx) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("col", col);
		map.put("value", value);
		map.put("idx", idx);
		return session.update(namespace+"update", map);
	}
	
	@Override
	public int delete(String feedIdx) throws Exception {
		return session.delete(namespace+"delete", feedIdx);
	}
}
