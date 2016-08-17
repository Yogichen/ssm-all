package cn.facilityone.dao;

import cn.facilityone.entity.Article;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Yogi on 2016/7/26.
 */
public interface ArticleDAO extends BaseDAO<Article> {

    List<Article> findPageByCategory(@Param("start") int start, @Param("limit") int limit, @Param("categoryId") Long categoryId);

    int count(@Param("categoryId") Long categoryId);

    void updateArticleStatus(@Param("articleId") Long articleId);

    void updateArticleStatusByCategoryId(@Param("categoryId") Long categoryId);

    Article getArticleWithCategory(@Param("articleId") Long articleId);

    List<Article> getArticlesByCategoryName(@Param("categoryName") String categoryName);

    List<Article> getArticlesByLikeSearch(@Param("content") String content);

    int getMaxSortOrderByCategoryId(@Param("categoryId") Long categoryId);

    void updateSortOrder(@Param("id") Long id, @Param("order") int order);

    /**
     * 获得该类别上一条status为1的记录
     * @param order
     * @return
     */
    Article findPreBySortOrderAndCategoryId(@Param("order") int order, @Param("categoryId") Long categoryId);

    /**
     * 获得该类别下一条status为1的记录
     * @param order
     * @return
     */
    Article findNextBySortOrderAndCategoryId(@Param("order") int order, @Param("categoryId") Long categoryId);
}