package com.zlzkj.app.mapper;

import com.zlzkj.app.model.User;
import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(String id);

    int insert(User record);

    User selectByPrimaryKey(String id);

    User selectByUserName(String username);

    List<User> selectByRoleId(String roleId);

    int updateByPrimaryKey(User record);
}