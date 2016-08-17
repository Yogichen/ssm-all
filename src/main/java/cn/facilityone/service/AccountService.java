package cn.facilityone.service;

import cn.facilityone.common.Paging;
import cn.facilityone.common.datatable.DataTableRequest;
import cn.facilityone.entity.User;

/**
 * Created by Yogi on 2016/8/3.
 */
public interface AccountService {

    Paging getGrid(DataTableRequest dataTableRequest);

    String addAccount(User user);

    User getAccount(String userName);

    void updateAccount(User user);

    void delAccount(String userName);
}
