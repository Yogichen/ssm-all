package cn.facilityone.dao;

import cn.facilityone.entity.Role;

import java.util.List;

/**
 * Created by Yogi on 2016/7/26.
 */
public interface RoleDAO extends BaseDAO<Role> {

    List<Role> findAll();
}