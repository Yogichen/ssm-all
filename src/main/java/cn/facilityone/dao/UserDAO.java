package cn.facilityone.dao;


import cn.facilityone.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Yogi on 2016/7/20.
 */
public interface UserDAO extends BaseDAO<User> {

    User selectUserByPK(@Param("userName") String userName);

    User selectUserWithRoleByPk(@Param("userName") String userName);

    List<User> findByPage(@Param("start") int start, @Param("limit") int limit);

    int count();

    void updateUserStatus(@Param("userName") String userName);

    User selectUserByNameAndPwd(@Param("userName") String userName, @Param("password") String password);
}
