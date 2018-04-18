package com.zlzkj.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zlzkj.app.util.IDGenerator;
import com.zlzkj.app.util.Md5Util;
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

	@Value("${PAGE_SIZE}")
	private int PAGE_SIZE;

	@Autowired
	private UserMapper mapper;
	
	@Autowired
	private SqlRunner sqlRunner;
	
	public Integer delete(String id){
		return mapper.deleteByPrimaryKey(id);
	}
	public Integer deletebyIds(String[]id){
		Map parmMap = new HashMap();
		parmMap.put("ids",id);
		return mapper.deleteByMap(parmMap);
	}
	
	public Integer update(User entity){
		return mapper.updateByPrimaryKey(entity);
	}
	
	public Integer save(User entity) {
		entity.setId(IDGenerator.generator());
		entity.setPassword(Md5Util.getMD5(entity.getUsername()+entity.getPassword()));
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

	public List<Row> findByMap(Map<String,Object> map){
		return mapper.selectByMap(map);
	}

	public Page findByMap(Map<String,Object> parmMap,Integer nowPage){
		if(nowPage == null) nowPage = 1;
		parmMap.put("start",(nowPage-1)*PAGE_SIZE);
		parmMap.put("end",PAGE_SIZE);
		return new Page(findByMap(parmMap),mapper.countByMap(parmMap),nowPage,PAGE_SIZE);
	}
	
}

