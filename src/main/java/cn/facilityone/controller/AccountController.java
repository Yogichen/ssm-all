package cn.facilityone.controller;

import cn.facilityone.common.Paging;
import cn.facilityone.common.Result;
import cn.facilityone.common.datatable.DataTableRequest;
import cn.facilityone.common.datatable.DataTableResponse;
import cn.facilityone.common.utils.FileUtils;
import cn.facilityone.entity.User;
import cn.facilityone.service.AccountService;
import cn.facilityone.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

/**
 * Created by Yogi on 2016/8/3.
 * 账号管理
 */
@Controller
@RequestMapping("/account")
public class AccountController {

    @Autowired
    AccountService accountService;

    @RequestMapping("/view")
    public String getView(

    ) {
        return "account";
    }

    @RequestMapping("/myAccount/view")
    public String getMyAccountView(

    ) {
        return "myAccount";
    }

    @RequestMapping(value = "/grid", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
    @ResponseBody
    public DataTableResponse getGrid(
            @RequestBody DataTableRequest dataTableRequest
    ) {
        Paging paging = accountService.getGrid(dataTableRequest);
        DataTableResponse dataTableResponse = new DataTableResponse();
        dataTableResponse.setData(paging.getList());
        dataTableResponse.setDraw(dataTableRequest.getDraw());
        dataTableResponse.setRecordsFiltered(paging.getTotal());
        dataTableResponse.setRecordsTotal(paging.getTotal());
        return dataTableResponse;
    }

    @RequestMapping("/add")
    @ResponseBody
    public Result addAccount(
            @RequestBody User user
    ) {
        String password = FileUtils.toMD5(user.getPassword());
        user.setPassword(password);
        String status = accountService.addAccount(user);
        return new Result(null, status, null, null);
    }

    @RequestMapping("/edit/{userName}")
    @ResponseBody
    public Result saveEdit(
            @PathVariable String userName
    ) {

        return new Result(accountService.getAccount(userName));
    }

    @RequestMapping("/saveEdit")
    @ResponseBody
    public Result saveEdit(
            @RequestBody User user
    ) {
        String password = FileUtils.toMD5(user.getPassword());
        user.setPassword(password);
        accountService.updateAccount(user);
        return new Result(null, "success", null, null);
    }

    @RequestMapping("/{userName}/del")
    @ResponseBody
    public Result delAccout(
            @PathVariable String userName
    ) {
        accountService.delAccount(userName);
        return new Result(null, "success", null, null);
    }


}
