package cn.facilityone.controller;

import cn.facilityone.common.Paging;
import cn.facilityone.common.Result;
import cn.facilityone.common.datatable.DataTableRequest;
import cn.facilityone.common.datatable.DataTableResponse;
import cn.facilityone.entity.Article;
import cn.facilityone.entity.User;
import cn.facilityone.service.ArticleService;
import cn.facilityone.service.PublishedArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Yogi on 2016/8/1.
 */
@Controller
@RequestMapping("/article")
public class ArticleController {
    @Autowired
    ArticleService articleService;
    @Autowired
    PublishedArticleService publishedArticleService;

    @RequestMapping("/view")
    public String getView(
            HttpServletRequest request,
            HttpServletResponse response
    ) {
        return "article";
    }

    @RequestMapping(value = "/grid", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
    @ResponseBody
    public DataTableResponse getGrid(
            @RequestBody DataTableRequest dataTableRequest
    ) {
        Paging paging = articleService.getGrid(dataTableRequest);
        DataTableResponse dataTableResponse = new DataTableResponse();
        dataTableResponse.setData(paging.getList());
        dataTableResponse.setDraw(dataTableRequest.getDraw());
        dataTableResponse.setRecordsFiltered(paging.getTotal());
        dataTableResponse.setRecordsTotal(paging.getTotal());
        return dataTableResponse;
    }

    @RequestMapping("/add")
    @ResponseBody
    public Result addArticle(
            HttpServletRequest request,
            HttpServletResponse response,
            HttpSession session,
            @RequestBody Article article
    ){
        User user = (User)session.getAttribute("user");
        article.setCreatedBy(user.getUserName());
        articleService.addArticle(article);
        return new Result(null);
    }

    @RequestMapping("/info/{articleId}")
    @ResponseBody
    public Result getArticleInfo(
            HttpServletRequest request,
            HttpServletResponse response,
            @PathVariable Long articleId
    ){
        return new Result(articleService.getArticleById(articleId));
    }

    @RequestMapping("/saveEdit")
    @ResponseBody
    public Result saveEdit(
            HttpServletRequest request,
            HttpServletResponse response,
            @RequestBody Article article
    ){
        articleService.saveArticle(article);
        return new Result(null);
    }

    @RequestMapping("/del/{articleId}")
    @ResponseBody
    public Result delArticle(
            HttpServletRequest request,
            HttpServletResponse response,
            @PathVariable Long articleId

    ){
        articleService.delArticle(articleId);
        return new Result(null);
    }

    @RequestMapping("/publish/{articleId}")
    @ResponseBody
    public Result publishArticle(
            HttpServletRequest request,
            HttpServletResponse response,
            @PathVariable Long articleId

    ){
        publishedArticleService.publish(articleId);
        return new Result(null);
    }

    @RequestMapping("/moveUp/categoryId/{categoryId}/currentId/{currentId}/currentOrder/{currentOrder}")
    @ResponseBody
    public Result moveUpOrder(
            HttpServletRequest request,
            HttpServletResponse response,
            @PathVariable Long categoryId,
            @PathVariable Long currentId,
            @PathVariable int currentOrder
    ) {
        articleService.moveUp(categoryId, currentId, currentOrder);
        return new Result(null);
    }

    @RequestMapping("/moveDown/categoryId/{categoryId}/currentId/{currentId}/currentOrder/{currentOrder}")
    @ResponseBody
    public Result moveDownOrder(
            HttpServletRequest request,
            HttpServletResponse response,
            @PathVariable Long categoryId,
            @PathVariable Long currentId,
            @PathVariable int currentOrder
    ) {
        articleService.moveDown(categoryId, currentId, currentOrder);
        return new Result(null);
    }

}
