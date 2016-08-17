package cn.facilityone.service;

import cn.facilityone.entity.Menu;

import java.util.List;

/**
 * Created by Yogi on 2016/7/27.
 */
public interface MenuService {
    List<Menu> findMenusByUserName(String userName);
}
