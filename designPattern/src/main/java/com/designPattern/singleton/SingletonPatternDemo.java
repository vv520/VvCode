package com.designPattern.singleton;

/**
 * Created by weiwei.xu on 2019/3/7.
 */
public class SingletonPatternDemo {
    public static void main(String[] args) {

        //不合法的构造函数
        //编译时错误：构造函数 Singleton() 是不可见的
        //Singleton object = new Singleton();

        //获取唯一可用的对象
        Singleton singleton = Singleton.getInstance();
        singleton.showMessage();

        Singleton2 singleton2 = Singleton2.getInstance();
        singleton2.showMessage();
    }
}
