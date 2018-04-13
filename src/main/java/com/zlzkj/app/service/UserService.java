package com.zlzkj.app.service;

import java.util.List;
import java.util.Map;

import com.zlzkj.app.util.Page;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zlzkj.app.mapper.UserMapper;
import com.zlzkj.app.model.User;
import com.zlzkj.core.mybatis.SqlRunner;
import com.zlzkj.core.sql.Row;
import com.zlzkj.core.sql.SQLBuilder;
import com.zlzkj.core.util.Fn;

@Service
@Transactional
public class UserService {

	@Value("${page.size}")
	private int PAGE_SIZE;

	@Autowired
	private UserMapper mapper;
	
	@Autowired
	private SqlRunner sqlRunner;
	
	public Integer delete(String id){
		return mapper.deleteByPrimaryKey(id);
	}
	
	public Integer update(User entity){
		return mapper.updateByPrimaryKey(entity);
	}
	
	public Integer save(User entity) {
		
		return mapper.insert(entity);
	}
	
	public User findById(String id){
		return mapper.selectByPrimaryKey(id);
	}

	public User findByUserName(String username){
		return mapper.selectByUserName(username);
	}

	public List<User> findByRoleId(String roleId){
		return mapper.selectByRoleId(roleId);
	}

	public List<User> findByMap(Map<String,Object> map){
		return mapper.selectByMap(map);
	}

	public Page findByMap(Map<String,Object> parmMap,int nowPage){
		return new Page(findByMap(parmMap),mapper.countByMap(parmMap),nowPage,PAGE_SIZE);
	}
	
}

