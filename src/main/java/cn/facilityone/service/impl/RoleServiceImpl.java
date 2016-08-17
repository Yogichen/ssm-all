package cn.facilityone.service.impl;

import cn.facilityone.dao.RoleDAO;
import cn.facilityone.entity.Role;
import cn.facilityone.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Yogi on 2016/8/3.
 */
@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    RoleDAO roleDAO;

    public List<Role> getAll() {
        return roleDAO.findAll();
    }
}
