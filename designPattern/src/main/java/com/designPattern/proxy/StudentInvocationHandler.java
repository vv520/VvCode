package com.designPattern.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

/**
 * Created by weiwei.xu on 2019/3/7.
 */
public class StudentInvocationHandler<T> implements InvocationHandler{

    //持有类的代理对象
    T target;

    public StudentInvocationHandler(T target){
        this.target = target;
    }

    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.printf("执行方法前！\n");
        Object result = method.invoke(target, args);
        System.out.printf("执行方法后！\n");
        return result;
    }
}
