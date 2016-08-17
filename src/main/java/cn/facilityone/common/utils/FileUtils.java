package cn.facilityone.common.utils;

import java.io.*;
import java.security.MessageDigest;
import java.util.Date;

public class FileUtils {
    /**
     * 文件copy方法
     * @param src
     * @param dest
     */
    public static void copy(InputStream src, OutputStream dest) {
        try {
            byte[] tmp = new byte[1024];
            int len = -1;
            while ((len = src.read(tmp)) != -1)
                dest.write(tmp, 0, len);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 给文件重命名 防止覆盖
     * @param fileName
     * @return 时间戳+原始文件的后缀
     */
    public static String reName(String fileName){
        return new StringBuffer().append(new Date().getTime()).append(fileName.substring(fileName.indexOf("."))).toString();
    }

    /**
     * 文件保存
     * @param fileName reName之后的文件名称
     * @param content
     * @param filePath 文件保存路径
     * @return
     * @throws IOException
     */
    public static String saveFile(String fileName,InputStream content,String filePath) throws IOException {
        FileOutputStream fos = null;
        StringBuffer contentPath =  new StringBuffer("");// 上下文地址
        try {
            contentPath.append("/");
            contentPath.append(fileName);

            File pictureFile = new File(filePath + contentPath.toString());// 存储路径/文件名
            File pf = pictureFile.getParentFile();
            if(!pf.exists()){
                pf.mkdirs();
            }
            pictureFile.createNewFile();    // 创建文件
            fos = new FileOutputStream(pictureFile);
            FileUtils.copy(content, fos);
        } catch (Exception e) {
            throw new IOException("文件保存失败!");
        } finally {
            if (fos != null) {
                try {
                    fos.close();
                } catch (Exception e) {
                    throw new IOException("文件保存失败!");
                }
            }
        }
        return contentPath.toString();
    }

    public static String toMD5(String plainText) {
        StringBuffer buf = new StringBuffer("");
        try {
            //生成实现指定摘要算法的 MessageDigest 对象。
            MessageDigest md = MessageDigest.getInstance("MD5");
            //使用指定的字节数组更新摘要。
            md.update(plainText.getBytes("UTF-8"));
            //通过执行诸如填充之类的最终操作完成哈希计算。
            byte b[] = md.digest();
            //生成具体的md5密码到buf数组
            int i;
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
//            System.out.println("32位: " + buf.toString());// 32位的加密
//            System.out.println("16位: " + buf.toString().substring(8, 24));// 16位的加密，其实就是32位加密后的截取
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return buf.toString();
    }
}

