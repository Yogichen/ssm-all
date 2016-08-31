package cn.facilityone.common.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

/**
 * Created by Yogi on 2016/8/31.
 */
public class CheckUtils {
    public static boolean checkAuth(String token, String signature, String timestamp, String nonce) {
        boolean result = false;

        if(token == null || signature == null || timestamp == null || nonce == null){
            return result;
        }

        String[] ArrTmp = {token, timestamp, nonce};
        Arrays.sort(ArrTmp);
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < ArrTmp.length; i++) {
            sb.append(ArrTmp[i]);
        }

        String pwd = Encrypt(sb.toString());
        if(pwd == null){
            return result;
        }

        if (pwd.equals(signature)) {
            try {
                result = true;
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
        }
        return result;
    }

    private static String Encrypt(String strSrc) {
        MessageDigest md = null;
        String strDes = null;
        byte[] bt = strSrc.getBytes();
        try {
            md = MessageDigest.getInstance("SHA-1");
            md.update(bt);
            strDes = bytes2Hex(md.digest());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
        return strDes;
    }

    private static String bytes2Hex(byte[] bts) {
        String des = "";
        String tmp = null;
        for (int i = 0; i < bts.length; i++) {
            tmp = (Integer.toHexString(bts[i] & 0xFF));
            if (tmp.length() == 1) {
                des += "0";
            }
            des += tmp;
        }
        return des;
    }
}
