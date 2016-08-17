package cn.facilityone.service.impl;

import cn.facilityone.dao.MenuDAO;
import cn.facilityone.entity.Menu;
import cn.facilityone.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Yogi on 2016/7/27.
 */
@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    MenuDAO menuDAO;

    public List<Menu> findMenusByUserName(String userName) {
        return menuDAO.findMenuByUserName(userName);
    }
}
