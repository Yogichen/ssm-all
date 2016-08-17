package cn.facilityone.controller;


import cn.facilityone.entity.User;
import cn.facilityone.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * Created by Yogi on 2016/7/20.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;

    @RequestMapping("/login")
    public String login(

    ) {
        return "login";
    }

    @RequestMapping("/index")
    public String getUserInfo(
            HttpSession session,
            @ModelAttribute User tuser
    ) {
        User user = userService.getUser(tuser.getUserName(), tuser.getPassword());
        session.setAttribute("user", user);
        if (user != null) {
            return "redirect: /main/list";
        } else {
            return "redirect: login";
        }
    }

    @RequestMapping("/logout")
    public String logOut(
            HttpSession session
    ) {
        session.removeAttribute("user");
        return "redirect: /user/login";
    }
}
