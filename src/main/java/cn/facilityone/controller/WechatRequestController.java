package cn.facilityone.controller;

import cn.facilityone.common.utils.CheckUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Yogi on 2016/8/31.
 */
@Controller
@RequestMapping("/wechat")
public class WechatRequestController {

    @RequestMapping(method = RequestMethod.GET)
    public void doCheckToken(
            @RequestParam("signature") String signature,
            @RequestParam("timestamp") String timestamp,
            @RequestParam("nonce") String nonce,
            @RequestParam("echostr") String echostr,
            HttpServletRequest request,
            HttpServletResponse response
    ) throws Exception {
        //从配置文件中获取校验token
        final String token = "helpwechat";

        boolean ok = CheckUtils.checkAuth(token, signature, timestamp, nonce);
        if(ok){
            ServletOutputStream sos = response.getOutputStream();
            sos.print(echostr);
            sos.flush();
            sos.close();
        }
    }
}
