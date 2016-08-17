package cn.facilityone.dao;

import cn.facilityone.entity.Menu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Yogi on 2016/7/27.
 */
public interface MenuDAO extends BaseDAO<Menu> {

    /**
     * 通过用户名获取menu
     *
     * @param userName
     * @return
     */
    List<Menu> findMenuByUserName(@Param("userName") String userName);
}