package cn.facilityone.dao;

import cn.facilityone.entity.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Yogi on 2016/7/26.
 */
public interface CategoryDAO extends BaseDAO<Category> {

    /**
     * 按类别type，分页查询
     * @param type
     * @param limit
     * @param start
     * @return
     */
    List<Category> findPageByType(@Param("type") String type, @Param("start") int start, @Param("limit") int limit);

    int count(@Param("type") String type);

    void updateCategoryStatus(@Param("id") Long id);

    List<Category> findAll();

    List<String> findTypes();

    Category findArticlesByCategoryId(@Param("categoryId") Long categoryId);

    Category findPublishedArticleByCategoryId(@Param("categoryId") Long categoryId);

    int findMaxSortOrder();

    void updateSortOrder(@Param("id") Long id, @Param("order") int order);

    /**
     * 获得上一行状态为1的数据
     * @param order
     * @return
     */
    Category findPreBySortOrder(@Param("order") int order);

    /**
     * 获得下一行状态为1的数据
     * @param order
     * @return
     */
    Category findNextBySortOrder(@Param("order") int order);
}