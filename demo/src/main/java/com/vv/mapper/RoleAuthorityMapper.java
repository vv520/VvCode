package com.vv.mapper;

import com.vv.entity.RoleAuthority;
import java.util.List;

public interface RoleAuthorityMapper {
    int insert(RoleAuthority record);

    List<RoleAuthority> selectAll();
}