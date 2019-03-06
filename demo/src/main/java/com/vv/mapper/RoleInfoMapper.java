package com.vv.mapper;

import com.vv.entity.RoleInfo;
import java.util.List;

public interface RoleInfoMapper {
    int deleteByPrimaryKey(Long roleId);

    int insert(RoleInfo record);

    RoleInfo selectByPrimaryKey(Long roleId);

    List<RoleInfo> selectAll();

    int updateByPrimaryKey(RoleInfo record);
}