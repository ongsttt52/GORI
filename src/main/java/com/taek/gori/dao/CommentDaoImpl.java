package com.taek.gori.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taek.gori.dto.CommentDto;

@Repository
public class CommentDaoImpl implements CommentDao {
	@Autowired SqlSession session;
	String namespace = "gori.comment.";
	
	@Override
	public int countComments(String feedIdx) throws Exception {
		return session.selectOne(namespace+"countComments", feedIdx);
	}
	
	@Override
	public int insert(CommentDto comment) throws Exception {
		return session.insert(namespace+"insert", comment);
	}
	
	@Override
	public List<CommentDto> selectComments(String feedIdx) throws Exception {
		return session.selectList(namespace+"selectComments", feedIdx);
	}
	
	@Override
	public int update(String commentIdx, String content) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("idx", commentIdx);
		map.put("content", content);
		return session.update(namespace+"update", map);
	}
	
	@Override
	public int delete(String commentIdx) throws Exception {
		return session.delete(namespace+"delete", commentIdx);
	}
}
