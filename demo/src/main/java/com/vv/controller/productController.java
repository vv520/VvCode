package com.vv.controller;

import com.vv.entity.WmpsDefine;
import com.vv.mapper.WmpsDefineMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by weiwei.xu on 2018/11/16.
 */
@RequestMapping("wmps")
@Controller
public class productController {

    @Autowired
    private WmpsDefineMapper wmpsDefineMapper;

    @ResponseBody
    @RequestMapping("/getProductList")
    public List<WmpsDefine> getProductList(){
        List<WmpsDefine> list = wmpsDefineMapper.selectAll();
        return list;
    }
}
