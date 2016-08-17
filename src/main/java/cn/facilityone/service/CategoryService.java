package cn.facilityone.service;

import cn.facilityone.common.Paging;
import cn.facilityone.common.datatable.DataTableRequest;
import cn.facilityone.entity.Category;

import java.util.List;

/**
 * Created by Yogi on 2016/7/27.
 * 类别相关 Service
 */
public interface CategoryService {
    Paging getGrid(DataTableRequest dataTableRequest);

    void addCategory(Category category);

    Category findCategoryById(Long id);

    void updateCategory(Category category);

    void deleteCategory(Long id);

    List<Category> getAllCategory();

    List<String> getTypes();

    Category getArticles(Long categoryId);

    Category getPublishedArticles(Long categoryId);

    void moveUpOrder(Long currentId, int currentOrder);

    void moveDownOrder(Long currentId, int currentOrder);
}
