package com.zlzkj.app.service;

import com.zlzkj.app.mapper.RoleMapper;
import com.zlzkj.app.model.Role;
import com.zlzkj.app.util.Page;
import com.zlzkj.core.mybatis.SqlRunner;
import com.zlzkj.core.sql.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class RoleService {

	@Value("${PAGE_SIZE}")
	private int PAGE_SIZE;

	@Autowired
	private RoleMapper mapper;
	
	@Autowired
	private SqlRunner sqlRunner;
	
	public Integer delete(String id){
		return mapper.deleteByPrimaryKey(id);
	}
	
	public Integer update(Role entity){
		return mapper.updateByPrimaryKey(entity);
	}
	
	public Integer save(Role entity) {
		
		return mapper.insert(entity);
	}
	
	public Role findById(String id){
		return mapper.selectByPrimaryKey(id);
	}

	public List<Row> findByMap(Map<String,Object> map){
		return mapper.selectByMap(map);
	}

	public Page findByMap(Map<String,Object> parmMap,Integer nowPage){
		if(nowPage == null) nowPage = 0;
		return new Page(findByMap(parmMap),mapper.countByMap(parmMap),nowPage,PAGE_SIZE);
	}
	
}

