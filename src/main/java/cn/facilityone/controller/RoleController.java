package cn.facilityone.controller;

import cn.facilityone.common.Result;
import cn.facilityone.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Yogi on 2016/8/3.
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    RoleService roleService;

    @RequestMapping("/all")
    @ResponseBody
    public Result getAll(

    ) {
        return new Result(roleService.getAll());
    }
}
