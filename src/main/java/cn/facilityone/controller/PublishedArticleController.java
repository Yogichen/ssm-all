package cn.facilityone.controller;

import cn.facilityone.common.Result;
import cn.facilityone.entity.Comment;
import cn.facilityone.service.PublishedArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Yogi on 2016/8/15.
 */
@Controller
@RequestMapping("/publishedArticle")
public class PublishedArticleController {

    @Autowired
    PublishedArticleService publishedArticleService;

    @RequestMapping("/{publishedArticleId}/increaseLikeNum")
    @ResponseBody
    public Result increaseLikeNum(
            @PathVariable Long publishedArticleId

    ) {
        publishedArticleService.increaseLikeNum(publishedArticleId);
        return new Result(null, "success", null, null);
    }

    @RequestMapping("/addComment")
    @ResponseBody
    public Result addComment(
            @RequestBody Comment comment
    ) {
        publishedArticleService.addComment(comment);
        return new Result(null);
    }
}
