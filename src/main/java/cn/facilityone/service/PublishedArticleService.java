package cn.facilityone.service;

import cn.facilityone.entity.Comment;
import cn.facilityone.entity.PublishedArticle;

import java.util.List;

/**
 * Created by Yogi on 2016/8/8.
 */
public interface PublishedArticleService {

    void publish(Long tempArticleId);

    List<PublishedArticle> getArticleByCategoryName();

    PublishedArticle getArticleById(Long id);

    List<PublishedArticle> getArticleByTitleOrText(String content);

    void increaseLikeNum(Long publishedArticleId);

    void addComment(Comment comment);
}
