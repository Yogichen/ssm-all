package cn.facilityone.service;


import cn.facilityone.entity.User;

/**
 * Created by Yogi on 2016/7/18.
 */
public interface UserService {
    User getUser(String userName, String pwd);
}
