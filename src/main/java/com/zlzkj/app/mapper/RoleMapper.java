package com.zlzkj.app.mapper;


import com.zlzkj.app.model.Role;

import java.util.List;

public interface RoleMapper {
    int deleteByPrimaryKey(String id);

    int insert(Role record);

    Role selectByPrimaryKey(String id);

    Role selectByRoleName(String Rolename);

    List<Role> selectByUserId(String userId);

    int updateByPrimaryKey(Role record);
}