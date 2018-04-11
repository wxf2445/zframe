package com.zlzkj.app.mapper;


import com.zlzkj.app.model.Authority;

import java.util.List;

public interface AuthorityMapper {
    int deleteByPrimaryKey(String id);

    int insert(Authority record);

    int updateByPrimaryKey(Authority record);
}