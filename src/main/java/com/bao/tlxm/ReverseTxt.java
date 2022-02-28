package com.bao.tlxm;

import com.bao.util.Utils;

public class ReverseTxt {
    public static void main(String[] args) throws Exception {
        String result = "";
        String fileName = "存入锦囊";
        String fileContent = Utils.getFileContent("/Users/nirvana/Desktop/Nirvana/destroy/destroy.txt");
        String[]lines = fileContent.split("\r\n");
        for(String line:lines){
            if(line.indexOf(fileName)>-1 || (line.length()<6 && line.length()>0)){
                result+=(line+"\r\n");
                System.out.println(line);
            }
        }
//        Utils.saveToFile(result,"/Users/nirvana/Desktop/Nirvana/destroy/"+fileName+".txt");

//删除一行快捷键，command+删除

//        for(int i = arrayList.size()-1;i>=0;i--){
//            content+=(arrayList.get(i)+"\r\n");
//        }

//        System.out.println(content);


    }
}
