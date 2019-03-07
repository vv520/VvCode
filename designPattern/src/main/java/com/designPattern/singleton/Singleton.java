package com.designPattern.singleton;

/**
 * 单例模式 饿汉式
 * 线程安全
 * 类加载时就初始化，浪费内存
 * Created by weiwei.xu on 2019/3/7.
 */
public class Singleton {

    private static Singleton singleton = new Singleton();

    private Singleton(){

    }

    public static Singleton getInstance(){
        return singleton;
    }

    public void showMessage(){
        System.out.print("单例模式!--饿汉式");
    }
}


class Singleton2{

    private static Singleton2 singleton2;

    private Singleton2(){}

    /**
     * 懒汉式
     * 线程不安全
     */
    /*public static Singleton2 getInstance(){
        if(singleton2 == null){
            singleton2 = new Singleton2();
        }
        return singleton2;
    }*/

    /**
     * 线程安全
     * @return
     */
   /* public static synchronized  Singleton2 getInstance(){
        if(singleton2 == null){
            singleton2 = new Singleton2();
        }
        return singleton2;
    }*/

    /**
     * 双重检查
     */
    public static Singleton2 getInstance(){
        if(singleton2 == null){
            synchronized (Singleton2.class){
                if(singleton2 == null){
                    singleton2 = new Singleton2();
                }
            }
        }
        return singleton2;
    }

    public void showMessage(){
        System.out.printf("单例模式!");
    }
}
