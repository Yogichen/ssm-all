package cn.facilityone.controller;

import cn.facilityone.entity.User;
import cn.facilityone.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by Yogi on 2016/7/27.
 * 主菜单
 */
@Controller
@RequestMapping("/main")
public class MainController {

    @Autowired
    MenuService menuService;

    @RequestMapping("/list")
    public ModelAndView getMainList(
            HttpServletRequest request,
            HttpSession session
    ) {
        ModelAndView mav = new ModelAndView();
        User user = (User)session.getAttribute("user");
        if(user == null){
            mav.setViewName("redirect: /user/login");
            return mav;
        }
        mav.setViewName("main");
        mav.addObject("user", user);
        mav.addObject("menu", menuService.findMenusByUserName(user.getUserName()));
        return mav;
    }
}
