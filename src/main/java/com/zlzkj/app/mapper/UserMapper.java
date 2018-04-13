package com.zlzkj.app.mapper;

import com.zlzkj.app.model.User;
import java.util.List;
import java.util.Map;

public interface UserMapper {
    int deleteByPrimaryKey(String id);

    int insert(User record);

    User selectByPrimaryKey(String id);

    User selectByUserName(String username);

    List<User> selectByRoleId(String roleId);

    List<User> selectByMap(Map<String,Object> map);

    int countByMap(Map<String,Object> map);

    int updateByPrimaryKey(User record);
}