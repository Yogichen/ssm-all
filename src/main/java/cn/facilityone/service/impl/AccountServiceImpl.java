package cn.facilityone.service.impl;

import cn.facilityone.common.Paging;
import cn.facilityone.common.datatable.DataTableRequest;
import cn.facilityone.dao.UserDAO;
import cn.facilityone.entity.User;
import cn.facilityone.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Yogi on 2016/8/3.
 */
@Service
public class AccountServiceImpl implements AccountService {

    @Autowired
    UserDAO userDAO;

    public Paging getGrid(DataTableRequest dataTableRequest) {
        int start = dataTableRequest.getStart() <= 0 ? 0 : dataTableRequest.getStart();
        int limit = dataTableRequest.getLength() <= 0 ? 10 : dataTableRequest.getLength();

        List<User> users = userDAO.findByPage(start, limit);
        int count = userDAO.count();
        return new Paging(start, limit, count, users);
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public String addAccount(User user) {
        User dbUser = userDAO.selectUserByPK(user.getUserName());
        String status;
        if(dbUser != null){
            status = "fail";
        }else{
            userDAO.insert(user);
            status = "success";
        }
        return status;
    }

    public User getAccount(String userName) {
        return userDAO.selectUserWithRoleByPk(userName);
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void updateAccount(User user) {
        userDAO.updateByPrimaryKey(user);
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void delAccount(String userName) {
        userDAO.updateUserStatus(userName);
    }
}
