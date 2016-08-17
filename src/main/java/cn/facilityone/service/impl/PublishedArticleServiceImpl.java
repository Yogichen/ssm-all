package cn.facilityone.service.impl;

import cn.facilityone.dao.ArticleDAO;
import cn.facilityone.dao.CommentDAO;
import cn.facilityone.dao.PublishedArticleDAO;
import cn.facilityone.entity.Article;
import cn.facilityone.entity.Comment;
import cn.facilityone.entity.PublishedArticle;
import cn.facilityone.service.PublishedArticleService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by Yogi on 2016/8/8.
 */
@Service
public class PublishedArticleServiceImpl implements PublishedArticleService {

    private static final String FAQ = "FAQ";

    @Autowired
    PublishedArticleDAO publishedArticleDAO;

    @Autowired
    ArticleDAO articleDAO;

    @Autowired
    CommentDAO commentDAO;

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void publish(Long tempArticleId) {
        PublishedArticle article = publishedArticleDAO.selectByTempArticleId(tempArticleId);
        Article tempArticle = articleDAO.selectByPrimaryKey(tempArticleId);
        PublishedArticle toPublish = new PublishedArticle();
        if(article == null){
            toPublish.setTitle(tempArticle.getTitle());
            toPublish.setCategoryId(tempArticle.getCategoryId());
            toPublish.setPlainText(tempArticle.getPlainText());
            toPublish.setFullHtml(tempArticle.getFullHtml());
            if(StringUtils.isNotBlank(tempArticle.getIntroduce())){
                toPublish.setIntroduce(tempArticle.getIntroduce());
            }
            toPublish.setCreatedBy(tempArticle.getCreatedBy());
            toPublish.setCreateDate(new Date());
            toPublish.setStatus(tempArticle.getStatus());
            toPublish.setTempArticleId(tempArticleId);
            publishedArticleDAO.insert(toPublish);
        }else{
            toPublish.setTitle(tempArticle.getTitle());
            toPublish.setCategoryId(tempArticle.getCategoryId());
            toPublish.setPlainText(tempArticle.getPlainText());
            toPublish.setFullHtml(tempArticle.getFullHtml());
            if(StringUtils.isNotBlank(tempArticle.getIntroduce())){
                toPublish.setIntroduce(tempArticle.getIntroduce());
            }
            toPublish.setCreatedBy(tempArticle.getCreatedBy());
            toPublish.setModifiedDate(new Date());
            toPublish.setStatus(tempArticle.getStatus());
            toPublish.setTempArticleId(tempArticleId);
            publishedArticleDAO.updateByTempArticleId(toPublish);
        }
    }

    public List<PublishedArticle> getArticleByCategoryName() {
        return publishedArticleDAO.getArticlesByCategoryName(FAQ);
    }

    public PublishedArticle getArticleById(Long id) {
        int commentNum = commentDAO.sumCommentByPublishedArticleId(id);
        PublishedArticle publishedArticle = publishedArticleDAO.selectWithCommentByPrimaryKey(id);
        publishedArticle.setTemp(commentNum);
        return publishedArticle;
    }

    public List<PublishedArticle> getArticleByTitleOrText(String content) {
        return publishedArticleDAO.getArticlesByLikeSearch(content);
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void increaseLikeNum(Long publishedArticleId) {
        publishedArticleDAO.updateLikeNum(publishedArticleId);
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void addComment(Comment comment) {
        commentDAO.insert(comment);
    }
}
