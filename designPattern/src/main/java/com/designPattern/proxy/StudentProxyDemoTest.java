package com.designPattern.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;

/**
 * Created by weiwei.xu on 2019/3/7.
 */
public class StudentProxyDemoTest {

    public static void main(String[] args) {
        // 创建一个实例对象，这个对象是被代理的对象
        Person zhangsan = new Student("张三");

        // 创建一个与代理对象相关联的InvocationHandler
        InvocationHandler studentHander = new StudentInvocationHandler<Person>(zhangsan);

        //创建一个代理对象proxyPerson来代理zhangsan，代理对象的每个执行方法都会替换执行Invocation中的invoke方法
        Person proxyPerson = (Person) Proxy.newProxyInstance(Person.class.getClassLoader(), new Class<?>[]{Person.class}, studentHander);

        proxyPerson.giveMoney();

        proxyPerson.giveHomework();
    }
}
