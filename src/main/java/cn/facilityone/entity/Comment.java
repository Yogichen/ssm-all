package cn.facilityone.entity;

import java.util.Date;

/**
 * Created by Yogi on 2016/7/26.
 */
public class Comment {
    private Long id;

    private String content;

    private Long pid;

    private Long publishedArticleId;

    private Date commentDate;

    private String status;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public Long getPublishedArticleId() {
        return publishedArticleId;
    }

    public void setPublishedArticleId(Long publishedArticleId) {
        this.publishedArticleId = publishedArticleId;
    }

    public Date getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }
}