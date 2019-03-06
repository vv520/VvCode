package com.vv.controller;

import com.vv.mapper.UserInfoMapper;
import com.vv.util.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by weiwei.xu on 2018/11/15.
 */
@Controller
public class HelloWorldController {

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Resource
    RedisUtil redisUtil;

    @ResponseBody
    @RequestMapping("/hello")
    public String hello(){
//        redisUtil.del("睡觉了喂");
//        redisUtil.set("睡觉了喂","男神");
        String value = (String)redisUtil.get("aa");

        return "Hello World!" + userInfoMapper.selectAll().size() + value;
    }

}
