package com.bao.tlxm;

public class ReverseTxt {
    public static void main(String[] args) throws Exception {

        String fileContent = EncryAndDecry.getFileContent("/Users/baowei/Desktop/程序人生/TLZZ-ROG/TLXM/采矿采药/武夷.txt");
        String[] contents = fileContent.split("\r\n");
        System.out.println(contents.length);
//删除一行快捷键，command+删除

//        for(int i = arrayList.size()-1;i>=0;i--){
//            content+=(arrayList.get(i)+"\r\n");
//        }

//        System.out.println(content);


    }
}
