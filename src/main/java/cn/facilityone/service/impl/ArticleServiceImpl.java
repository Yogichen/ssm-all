package cn.facilityone.service.impl;

import cn.facilityone.common.Paging;
import cn.facilityone.common.datatable.DataTableColumn;
import cn.facilityone.common.datatable.DataTableRequest;
import cn.facilityone.dao.ArticleDAO;
import cn.facilityone.dao.PublishedArticleDAO;
import cn.facilityone.entity.Article;
import cn.facilityone.service.ArticleService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Yogi on 2016/8/1.
 */
@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    ArticleDAO articleDAO;

    @Autowired
    PublishedArticleDAO publishedArticleDAO;

    private static final String FAQ = "FAQ";

    public Paging getGrid(DataTableRequest dataTableRequest) {
        int start = dataTableRequest.getStart() <= 0 ? 0 : dataTableRequest.getStart();
        int limit = dataTableRequest.getLength() <= 0 ? 10 : dataTableRequest.getLength();
        //TODO 根据分类id搜索
        List<DataTableColumn> columns = dataTableRequest.getColumns();
        //分类id
        String categoryValue = columns.get(2).getSearch().getValue();
        Long categoryId = 0L;
        if(StringUtils.isNotBlank(categoryValue)){
            categoryId = Long.parseLong(categoryValue);
        }
        List<Article> articles = articleDAO.findPageByCategory(start, limit, categoryId);
        int count = articleDAO.count(categoryId);
        return new Paging(start, limit, count, articles);
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void addArticle(Article article) {
        //获得该分类最大的文章排序号
        int order =  articleDAO.getMaxSortOrderByCategoryId(article.getCategoryId());

        //手动自增
        article.setSortOrder(order + 1);
        articleDAO.insert(article);
    }

    public Article getArticleById(Long id) {
        return articleDAO.selectByPrimaryKey(id);
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void saveArticle(Article article) {
        articleDAO.updateByPrimaryKey(article);
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void delArticle(Long id) {
//        articleDAO.updateArticleStatus(id);
        publishedArticleDAO.deleteArticleByTempArticleId(id);
        articleDAO.deleteByPrimaryKey(id);
    }

    public List<Article> getArticleByCategoryName() {
        return articleDAO.getArticlesByCategoryName(FAQ);
    }

    public List<Article> getArticleByTitleOrText(String content) {
        return articleDAO.getArticlesByLikeSearch(content);
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void moveUp(Long categoryId, Long currentId, int sortOrder) {
        //上一条数据
        Article preArticle = articleDAO.findPreBySortOrderAndCategoryId(sortOrder, categoryId);

        if(preArticle != null){
            //当前数据排序号换成上一条的
            articleDAO.updateSortOrder(currentId, preArticle.getSortOrder());
            //上一条数据排序号换成当前的
            articleDAO.updateSortOrder(preArticle.getId(), sortOrder);
        }
    }

    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void moveDown(Long categoryId, Long currentId, int sortOrder) {
        //下一条数据
        Article nextArticle = articleDAO.findNextBySortOrderAndCategoryId(sortOrder, categoryId);

        if(nextArticle != null){
            //当前数据排序号换成下一条的
            articleDAO.updateSortOrder(currentId, nextArticle.getSortOrder());
            //下一条数据排序号换成当前的
            articleDAO.updateSortOrder(nextArticle.getId(), sortOrder);
        }
    }
}
