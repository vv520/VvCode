package com.vv.util;


import org.apache.commons.codec.digest.DigestUtils;

/**
 * Created by weiwei.xu on 2018/11/16.
 */
public class EncryptUtil {
    private static String confusionStr = "aMwL*^234kL)(2d>lSl%$flEr";

    public static String encryptPassWord(String account, String passWord) {
        return DigestUtils.md5Hex(account + confusionStr + passWord);
    }
}
