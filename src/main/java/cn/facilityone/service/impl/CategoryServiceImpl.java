package cn.facilityone.service.impl;

import cn.facilityone.common.Paging;
import cn.facilityone.common.datatable.DataTableRequest;
import cn.facilityone.dao.ArticleDAO;
import cn.facilityone.dao.CategoryDAO;
import cn.facilityone.dao.PublishedArticleDAO;
import cn.facilityone.entity.Article;
import cn.facilityone.entity.Category;
import cn.facilityone.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Yogi on 2016/7/27.
 */
@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    CategoryDAO categoryDAO;

    @Autowired
    ArticleDAO articleDAO;

    @Autowired
    PublishedArticleDAO publishedArticleDAO;

    public Paging getGrid(DataTableRequest dataTableRequest) {
        int start = dataTableRequest.getStart() <= 0 ? 0 : dataTableRequest.getStart();
        int limit = dataTableRequest.getLength() <= 0 ? 10 : dataTableRequest.getLength();
        List<Category> categories = categoryDAO.findPageByType(null, start, limit);
        int count = categoryDAO.count(null);
        return new Paging(start, limit, count, categories);
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void addCategory(Category category) {
        //获取最大的sort_order
        int sortOrder = categoryDAO.findMaxSortOrder();

        //手动自增sort_order
        category.setSortOrder(sortOrder + 1);
        categoryDAO.insert(category);
    }

    public Category findCategoryById(Long id) {
        return categoryDAO.selectByPrimaryKey(id);
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void updateCategory(Category category) {
        categoryDAO.updateByPrimaryKey(category);
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void deleteCategory(Long id) {
        categoryDAO.updateCategoryStatus(id);
        articleDAO.updateArticleStatusByCategoryId(id);
        publishedArticleDAO.updateArticleStatusByCategoryId(id);
    }

    public List<Category> getAllCategory() {
        return categoryDAO.findAll();
    }

    public List<String> getTypes() {
        return categoryDAO.findTypes();
    }

    public Category getArticles(Long categoryId) {
        Category category = categoryDAO.findArticlesByCategoryId(categoryId);
        if(category == null){
            category = categoryDAO.selectByPrimaryKey(categoryId);
        }
        return category;
    }

    public Category getPublishedArticles(Long categoryId) {
        Category category = categoryDAO.findPublishedArticleByCategoryId(categoryId);
        if(category == null){
            category = categoryDAO.selectByPrimaryKey(categoryId);
        }
        return category;
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void moveUpOrder(Long currentId, int currentOrder) {

        //获得上一行数据，status为1
        Category preCategory = categoryDAO.findPreBySortOrder(currentOrder);

        if(preCategory != null){
            //当前数据排序号换成上一条的
            categoryDAO.updateSortOrder(currentId, preCategory.getSortOrder());
            //上一条数据排序号换成当前的
            categoryDAO.updateSortOrder(preCategory.getId(), currentOrder);
        }
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void moveDownOrder(Long currentId, int currentOrder) {

        //获得下一行数据，status为1
        Category nextCategory = categoryDAO.findNextBySortOrder(currentOrder);

        if(nextCategory != null){
            //当前数据排序号换成下一条的
            categoryDAO.updateSortOrder(currentId, nextCategory.getSortOrder());
            //下一条数据排序号换成当前的
            categoryDAO.updateSortOrder(nextCategory.getId(), currentOrder);
        }
    }
}
