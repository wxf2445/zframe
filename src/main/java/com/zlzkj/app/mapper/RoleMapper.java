package com.zlzkj.app.mapper;


import com.zlzkj.app.model.Role;
import com.zlzkj.app.model.User;

import java.util.List;
import java.util.Map;

public interface RoleMapper {
    int deleteByPrimaryKey(String id);

    int insert(Role record);

    Role selectByPrimaryKey(String id);

    int updateByPrimaryKey(Role record);

    List<User> selectByMap(Map<String,Object> map);

    int countByMap(Map<String,Object> map);
}