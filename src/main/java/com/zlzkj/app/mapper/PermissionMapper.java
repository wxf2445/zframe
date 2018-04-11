package com.zlzkj.app.mapper;

import com.zlzkj.app.model.Authority;
import com.zlzkj.app.model.Permission;
import com.zlzkj.app.model.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Interface description
 *
 *
 * @version        1.0.0, 16/03/31
 * @author         zhm    
 */
public interface PermissionMapper {

    int deleteByRoleId(String roleId);

    List<Authority> selectAuthorityByRoleId(String roleId);

    List<String> selectByRoleId(String roleId);

    List<Role> selectRolesByRoleId(String roleId);
}


//~ Formatted by Jindent --- http://www.jindent.com
