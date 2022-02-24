package com.bao.tlxm;

import com.bao.util.Utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.time.LocalDateTime;
import java.util.Properties;

public class Encry {
    public static void main(String[] args) throws Exception {
        String absolutePath =System.getProperty("user.dir");
        String userName = System.getProperty("user.name");//user.home

        //为避免操作系统不同导致目录结构不一样，此处使用拼接绝对路径。
        //System.out.println(absolutePath);
        String osName = System.getProperty ("os.name");
        Reader inStream = new InputStreamReader(new FileInputStream(absolutePath+"/src/main/resources/secret.properties"));

        Properties prop = new Properties();
        prop.load(inStream);
        String salt = prop.getProperty("salt");
        String pswd = prop.getProperty("password");
        String secPath = prop.getProperty("path_sec");
        String mingPath = prop.getProperty("path_ming");

        String localDateTime = LocalDateTime.now().toString();
        secPath = secPath + localDateTime+".txt";
        mingPath = mingPath + localDateTime+".txt";
        String osPath = "";
        if(osName.startsWith("Windows")){
            osPath = "windowsSourcePath";
        }else{//Mac os X
            osPath = "macSourcePath";
        }
        String sourcePath = prop.getProperty(osPath);
        String encoding = Utils.GetEncoding(new File(sourcePath));
//加密
        /*=========================================================================*/
        String accountContent = Utils.getFileContent(sourcePath,encoding);
        String secResult = Utils.encrypt(accountContent,salt,pswd);
        System.out.println("加密后密文:" + secResult);
        Utils.saveToFile(secResult, secPath);


    }
}
