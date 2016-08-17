package cn.facilityone.controller;

import cn.facilityone.entity.Article;
import cn.facilityone.entity.PublishedArticle;
import cn.facilityone.service.ArticleService;
import cn.facilityone.service.CategoryService;
import cn.facilityone.service.PublishedArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Yogi on 2016/8/4.
 */
@Controller
@RequestMapping("/help")
public class ShowController {

    @Autowired
    CategoryService categoryService;

    @Autowired
    ArticleService articleService;

    @Autowired
    PublishedArticleService publishedArticleService;

    @RequestMapping("/index")
    public ModelAndView getIndex(
            HttpServletRequest request

    ) {
        ModelAndView mav = new ModelAndView("helpIndex");
        mav.addObject("categories", categoryService.getAllCategory());
        mav.addObject("faq", publishedArticleService.getArticleByCategoryName());
        return mav;
    }

    @RequestMapping("/category/{categoryId}")
    public ModelAndView getArticles(
            HttpServletRequest request,
            @PathVariable Long categoryId
    ) {
        ModelAndView mav = new ModelAndView("helpArticles");
        mav.addObject("categories", categoryService.getAllCategory());
        mav.addObject("articles", categoryService.getPublishedArticles(categoryId));
        return mav;
    }

    @RequestMapping("/article/{articleId}")
    public ModelAndView getArticle(
            HttpServletRequest request,
            @PathVariable Long articleId
    ) {
        ModelAndView mav = new ModelAndView("helpArticleDetails");
        PublishedArticle article = publishedArticleService.getArticleById(articleId);
        mav.addObject("article", article);
        mav.addObject("articles", categoryService.getPublishedArticles(article.getCategoryId()));
        return mav;
    }

    @RequestMapping("/search")
    public ModelAndView search(
            HttpServletRequest request,
            @RequestParam("content") String content
    ) {
        ModelAndView mav = new ModelAndView("helpSearchResult");
        mav.addObject("articles", publishedArticleService.getArticleByTitleOrText(content));
        mav.addObject("content", content);
        return mav;
    }

}
