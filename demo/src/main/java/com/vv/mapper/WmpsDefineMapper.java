package com.vv.mapper;

import com.vv.entity.WmpsDefine;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface WmpsDefineMapper {
    int insert(WmpsDefine record);

    List<WmpsDefine> selectAll();
}