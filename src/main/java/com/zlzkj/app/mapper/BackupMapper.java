package com.zlzkj.app.mapper;

import com.zlzkj.app.model.Backup;

import java.util.List;
import java.util.Map;

public interface BackupMapper {
    int deleteByPrimaryKey(String id);

    int insert(Backup record);

    Backup selectByPrimaryKey(String id);

    List<Backup> selectByMap(Map<String,Object> map);

    int countByMap(Map<String,Object> map);

    int updateByPrimaryKey(Backup record);
}