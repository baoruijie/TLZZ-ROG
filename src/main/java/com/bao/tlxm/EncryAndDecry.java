package com.bao.tlxm;

import com.bao.util.Utils;
import org.apache.commons.codec.binary.Hex;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;
import java.io.*;
import java.security.Key;
import java.time.LocalDateTime;
import java.util.Properties;

public class EncryAndDecry {
	/**
	 * 加密：
	 * 1.设置文件：secret.properties
	 * 2.读取账号文件内容 默认文件.txt
	 * 3.加密内容
	 * 4.输出到新文件 账号密文.txt
	 * 
	 * 解密：
	 * 1.读取密文文件 密文.txt
	 * 2.解密密文 
	 * 3.输出到新文件 默认文件decrypt.txt
	 * 4.解密完成。
	 * @param args
	 * @throws Exception 
	 */
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

		String localDateTime =LocalDateTime.now().toString();
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
		System.out.println(encoding);
		
		//加密
		/*=========================================================================*/
		String accountContent = Utils.getFileContent(sourcePath,encoding);
		String secResult = Utils.encrypt(accountContent,salt,pswd);
		System.out.println("加密后密文:" + secResult);
		Utils.saveToFile(secResult, secPath);
		/*=========================================================================*/
		//解密
		String secContent = Utils.getFileContent(secPath);
		String ming_content = Utils.decrypt(secContent, salt, pswd);
		System.out.println(ming_content);
		Utils.saveToFile(ming_content,mingPath);
	}

}
