package com.zlzkj.app.service;

import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
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
	
	public List<Row> findAllBySQL(){
		
		String sql = SQLBuilder.getSQLBuilder(User.class)
				.fields("*")
				.selectSql();
		
		//System.out.println("sql==="+sql);
		
		return sqlRunner.select(sql,1);
	}
	
	
	public boolean login(String account,String password){
		if(account.equals(""))return false;
		if(password.equals(""))return false;
		String sql="select * from x_user where username = '"+account + "' and password = '"+password+"'";
		if(sqlRunner.select(sql,1).size()>0)
			return true;
		else
			return false;
	}
	
	
}

