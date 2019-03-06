package com.vv.test;

import com.vv.entity.UserInfo;
import com.vv.mapper.UserInfoMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by weiwei.xu on 2018/11/15.
 */
// 获取启动类，加载配置，确定装载 Spring 程序的装载方法，它回去寻找 主配置启动类（被 @SpringBootApplication 注解的）
@SpringBootTest
// 让 JUnit 运行 Spring 的测试环境， 获得 Spring 环境的上下文的支持
@RunWith(SpringRunner.class)
public class SpringBootAppTest {

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Test
    public void testUser(){
        UserInfo user = userInfoMapper.selectByPrimaryKey(new BigDecimal(82));
        System.out.print("----" + user.getUserName());
    }
}
