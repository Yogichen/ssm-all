package cn.facilityone.dao;

import cn.facilityone.entity.PublishedArticle;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Yogi on 2016/7/26.
 */
public interface PublishedArticleDAO extends BaseDAO<PublishedArticle> {

    PublishedArticle selectByTempArticleId(Long tempArticleId);

    void updateByTempArticleId(PublishedArticle publishedArticle);

    PublishedArticle getArticleWithCategory(@Param("articleId") Long articleId);

    List<PublishedArticle> getArticlesByCategoryName(@Param("categoryName") String categoryName);

    List<PublishedArticle> getArticlesByLikeSearch(@Param("content") String content);

    void deleteArticleByTempArticleId(@Param("tempArticleId") Long tempArticleId);

    void updateArticleStatusByCategoryId(@Param("categoryId") Long categoryId);

    void updateLikeNum(@Param("id") Long id);

    PublishedArticle selectWithCommentByPrimaryKey(Long id);
}