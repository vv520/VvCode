package com.designPattern.proxy;

/**
 * Created by weiwei.xu on 2019/3/7.
 */
public class Student implements Person {

    private String name;

    public Student(String name){
        this.name = name;
    }

    public void giveMoney() {
        System.out.print("收班费啦！\n");
    }

    public void giveHomework() {
        System.out.print("收作业啦！\n");
    }
}
