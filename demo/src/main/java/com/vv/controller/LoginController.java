package com.vv.controller;

import com.vv.entity.UserInfo;
import com.vv.mapper.UserInfoMapper;
import com.vv.util.EncryptUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;


/**
 * Created by weiwei.xu on 2018/11/16.
 */

@Controller
@RequestMapping("/user")
public class LoginController {

    @Autowired
    private UserInfoMapper userInfoMapper;

    @ResponseBody
    @RequestMapping("/login.action")
    public Object login(HttpServletRequest request){
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        String MD5pwd = EncryptUtil.encryptPassWord(account, password);
        UserInfo userInfo = userInfoMapper.selectByAccount(account);
        if(userInfo != null) {
            if(userInfo.getPassword().equals(MD5pwd)){
                return true;
            }else{
                return "用户密码不对！";
            }
        }else{
            return "该用户不存在！";
        }
    }
}

