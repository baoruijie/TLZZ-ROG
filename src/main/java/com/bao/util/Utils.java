package com.bao.util;

import org.apache.commons.codec.binary.Hex;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;
import java.io.*;
import java.security.Key;

public class Utils {
    public static String encrypt(String sourceContent,String salt,String pswd) throws Exception{
        // 口令与密钥
        PBEKeySpec pbeKeySpec = new PBEKeySpec(pswd.toCharArray());
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBEWITHMD5andDES");
        Key key = factory.generateSecret(pbeKeySpec);

//		byte[] salt =Hex.decodeHex(saltStr.toCharArray());
        PBEParameterSpec pbeParameterSpac = new PBEParameterSpec(Hex.decodeHex(salt.toCharArray()), 100);
        Cipher cipher = Cipher.getInstance("PBEWITHMD5andDES");
        cipher.init(Cipher.ENCRYPT_MODE, key, pbeParameterSpac);
        byte[] result = cipher.doFinal(sourceContent.getBytes());

        return Hex.encodeHexString(result);
    }
    public static String decrypt(String secContent,String salt,String pswd) throws Exception{
        // 口令与密钥
        PBEKeySpec pbeKeySpec = new PBEKeySpec(pswd.toCharArray());
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBEWITHMD5andDES");
        Key key = factory.generateSecret(pbeKeySpec);

        PBEParameterSpec pbeParameterSpac = new PBEParameterSpec(Hex.decodeHex(salt.toCharArray()), 100);
        Cipher cipher = Cipher.getInstance("PBEWITHMD5andDES");
        // 解密
        cipher.init(Cipher.DECRYPT_MODE, key, pbeParameterSpac);
        byte[] result = cipher.doFinal(Hex.decodeHex(secContent.toCharArray()));
        return new String(result);
    }
    //字符流
    public static String getFileContent(String path) throws IOException {
        File file = new File(path);
        BufferedReader reader = new BufferedReader(new FileReader(file));
        String result ="";
        String line = "";
        while ((line = reader.readLine())!=null){
            result +=line+"\r\n";
        }
        reader.close();
        return result.trim();
    }
    //字节流
    public static String getFileContent(String path,String encoding)throws IOException{
        FileInputStream is = new FileInputStream(path);
//		FileInputStream is = new FileInputStream("C:/天龙小蜜/游戏账号/默认文件.txt");
//		FileInputStream is = new FileInputStream("H:/JAVA/Tools/eclipse-kepler/workspace/tlxm/TLXM/游戏账号/默认文件.txt");
        int len = 0;
        String result = "";
        byte[]bys = new byte[1024];
        while((len = is.read(bys))!=-1){
            result += new String(bys,0,len,encoding);
        }
        is.close();
        return result;
    }

    public static void saveToFile(String content,String path) throws Exception{
        FileWriter file = new FileWriter(new File(path));
        BufferedWriter writer = new BufferedWriter(file);
        writer.write(content);
        writer.flush();
        writer.close();
    }

    public static String GetEncoding(File file){
        String charset = "GBK";
        byte[] first3Bytes = new byte[3];
        try {
            boolean checked = false;
            InputStream is = new FileInputStream(file);
            int read = is.read(first3Bytes, 0, 3);

            if (read == -1)
                return charset;
            if (first3Bytes[0] == (byte) 0xFF && first3Bytes[1] == (byte) 0xFE) {
                charset = "UTF-16LE";
                checked = true;
            } else if (first3Bytes[0] == (byte) 0xFE
                    && first3Bytes[1] == (byte) 0xFF) {
                charset = "UTF-16BE";
                checked = true;
            } else if (first3Bytes[0] == (byte) 0xEF
                    && first3Bytes[1] == (byte) 0xBB
                    && first3Bytes[2] == (byte) 0xBF) {
                charset = "UTF-8";
                checked = true;
            }else if (first3Bytes[0] == (byte) 0xA
                    && first3Bytes[1] == (byte) 0x5B
                    && first3Bytes[2] == (byte) 0x30) {
                charset = "UTF-8";
                checked = true;
            }else if (first3Bytes[0] == (byte) 0xD
                    && first3Bytes[1] == (byte) 0xA
                    && first3Bytes[2] == (byte) 0x5B) {
                charset = "GBK";
                checked = true;
            }else if (first3Bytes[0] == (byte) 0x5B
                    && first3Bytes[1] == (byte) 0x54
                    && first3Bytes[2] == (byte) 0x49) {
                charset = "windows-1251";
                checked = true;
            }
            //bis.reset();
            InputStream istmp = new FileInputStream(file);
            if (!checked) {
                int loc = 0;
                while ((read = istmp.read()) != -1) {
                    loc++;
                    if (read >= 0xF0)
                        break;
                    if (0x80 <= read && read <= 0xBF)
                        break;
                    if (0xC0 <= read && read <= 0xDF) {
                        read = istmp.read();
                        if (0x80 <= read && read <= 0xBF)
                            continue;
                        else
                            break;
                    } else if (0xE0 <= read && read <= 0xEF) {
                        read = istmp.read();
                        if (0x80 <= read && read <= 0xBF) {
                            read = istmp.read();
                            if (0x80 <= read && read <= 0xBF) {
                                charset = "UTF-8";
                                break;
                            } else
                                break;
                        } else
                            break;
                    }
                }
            }
            is.close();
            istmp.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return charset;
    }
}
