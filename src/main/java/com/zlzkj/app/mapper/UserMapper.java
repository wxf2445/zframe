package com.zlzkj.app.mapper;

import com.zlzkj.app.model.User;
import com.zlzkj.core.sql.Row;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    int deleteByPrimaryKey(String id);

    int deleteByMap(Map<String,Object> map);

    int insert(User record);

    User selectByPrimaryKey(String id);

    User selectByUserName(String username);

    List<User> selectByRoleId(String roleId);

    List<Row> selectByMap(Map<String,Object> map);

    int countByMap(Map<String,Object> map);

    int updateByPrimaryKey(User record);
}