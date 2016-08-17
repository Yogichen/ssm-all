package cn.facilityone.service;

import cn.facilityone.common.Paging;
import cn.facilityone.common.datatable.DataTableRequest;
import cn.facilityone.entity.Article;

import java.util.List;


/**
 * Created by Yogi on 2016/8/1.
 */
public interface ArticleService {

    Paging getGrid(DataTableRequest dataTableRequest);

    void addArticle(Article article);

    Article getArticleById(Long id);

    void saveArticle(Article article);

    void delArticle(Long id);

    List<Article> getArticleByCategoryName();

    List<Article> getArticleByTitleOrText(String content);

    void moveUp(Long categoryId, Long currentId, int sortOrder);

    void moveDown(Long categoryId, Long currentId, int sortOrder);
}
