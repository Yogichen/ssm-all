package cn.facilityone.dao;

import cn.facilityone.entity.Comment;
import org.apache.ibatis.annotations.Param;

/**
 * Created by Yogi on 2016/7/26.
 */
public interface CommentDAO extends BaseDAO<Comment> {

    int sumCommentByPublishedArticleId(@Param("publishedArticleId") Long publishedArticleId);
}