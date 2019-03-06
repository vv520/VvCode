package com.vv.mapper;

import com.vv.entity.UserInfo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Mapper
public interface UserInfoMapper {
    int deleteByPrimaryKey(BigDecimal userId);

    int insert(UserInfo record);

    UserInfo selectByPrimaryKey(BigDecimal userId);

    List<UserInfo> selectAll();

    int updateByPrimaryKey(UserInfo record);

    UserInfo selectByAccount(String account);
}