package com.bao.tlxm;

import com.bao.util.Utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.time.LocalDateTime;
import java.util.Properties;

public class Decry {
    public static void main(String[] args) throws Exception {
        String absolutePath =System.getProperty("user.dir");
        String userName = System.getProperty("user.name");//user.home

        //为避免操作系统不同导致目录结构不一样，此处使用拼接绝对路径。
        //System.out.println(absolutePath);
        Reader inStream = new InputStreamReader(new FileInputStream(absolutePath+"/src/main/resources/secret.properties"));

        Properties prop = new Properties();
        prop.load(inStream);
        String salt = prop.getProperty("salt");
        String pswd = prop.getProperty("password");
        String secPath = prop.getProperty("path_sec");

        String mingPath = prop.getProperty("path_ming");

        String localDateTime = LocalDateTime.now().toString().replaceAll("\\.|-|:", "");
        secPath = "src/main/resources/密文.txt";
        mingPath = mingPath + localDateTime+".txt";
        /*=========================================================================*/
        //解密
        System.out.println("secPath"+secPath);
        String secContent = Utils.getFileContent(secPath);
        String ming_content = Utils.decrypt(secContent, salt, pswd);
        System.out.println(ming_content);
        Utils.saveToFile(ming_content,mingPath);
    }

}
