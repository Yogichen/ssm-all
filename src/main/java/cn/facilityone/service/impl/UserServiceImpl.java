package cn.facilityone.service.impl;

import cn.facilityone.common.utils.FileUtils;
import cn.facilityone.dao.UserDAO;
import cn.facilityone.entity.User;
import cn.facilityone.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * Created by Yogi on 2016/7/18.
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    UserDAO userDAO;

    public User getUser(String userName, String pwd) {
        return userDAO.selectUserByNameAndPwd(userName, FileUtils.toMD5(pwd));
    }
}
