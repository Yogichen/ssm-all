<%--
  Created by IntelliJ IDEA.
  User: Yogi
  Date: 2016/8/4
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="/static/js/plugins/layer/skin/layer.css"/>
    <link rel="stylesheet" type="text/css" href="/html/help/css/base.css"/>
    <script src="/static/js/plugins/jquery/jquery-2.0.0.js"></script>
    <script src="/static/js/plugins/layer/layer.js"></script>
    <script>
        $(document).ready(function(){
            var like = false;
            var hasReplyed = false;
            $("#like").click(function(){
                if(like == false){
                    $.ajax({
                        url: "/publishedArticle/" + <c:out value="${article.id}"></c:out> + "/increaseLikeNum",
                        contentType: "application/json",
                        success: function(){
                            $('.article-top').html('').append(<c:set value="${article.likeNum + 1}" var="likeNum" /><c:out value="${likeNum}" /> + "人觉得有帮助");
                            layer.msg("点赞成功", {time:1000, offset:500});
                            like = true;
                        },
                        error: function(){
                            layer.msg("哦no，出错了", {time:1000, offset:500})
                        }
                    })
                }else{
                    console.log("xx")
                    layer.msg("已点赞", {time: 1000, offset:500})
                }
            })

            $("#reply").click(function(){
                if(hasReplyed == false){
                    layer.open({
                        type: 1,
                        title: "回复",
                        area: ['800px', '480px'],
                        offset: ["150px"],
                        shadeClose: false, //点击遮罩关闭
                        content: '<textarea id="comment-add" style="resize: none;width: 700px;height: 300px;margin-left: 45px;margin-top: 30px;"/>',
                        btn: ["回复", "取消"],
                        btn1: function (index, layero) {
                            var jsonObj = {
                                publishedArticleId: <c:out value="${article.id}" />,
                                content: $('#comment-add').val(),
                                commentDate: new Date()
                            };
                            if(jsonObj.content != ""){
                                $.ajax({
                                    url: "/publishedArticle/addComment",
                                    contentType: "application/json",
                                    dataType: "json",
                                    type: "post",
                                    data: JSON.stringify(jsonObj),
                                    success: function(){
                                        var html = "<li class=article-head></li>"
                                        html += "<li class=article-item><div class=comment-div1>发表于&nbsp;&nbsp;"+ getNowFormatDate(jsonObj.commentDate)+ "</div>";
                                        html += "<div class=comment-div2>"+ jsonObj.content +"</div></li>";
                                        $('.comment-list').append(html);
                                        $('.article-reply').html('').append("回复(" + <c:set value="${article.temp + 1}" var="reply" /><c:out value="${reply}" /> + ")");
                                        layer.msg("回复成功", {time: 1000, offset:500});
                                        hasReplyed = true;
                                    },
                                    error: function(){
                                        layer.msg("哦no，出错了", {time:1000, offset:500})
                                    }
                                });
                                layer.close(index);
                            }else{
                                layer.msg("内容不能为空", {time:1000, offset:500});
                            }
                        },
                        btn2: function () {
                        },
                        cancel: function (index, layero) {
                            //do something
                        }
                    });
                }else{
                    layer.msg("已回复", {time:1000, offset:500});
                }
            })

            function getNowFormatDate(date) {
                var seperator1 = "-";
                var seperator2 = ":";
                var month = date.getMonth() + 1;
                var strDate = date.getDate();
                if (month >= 1 && month <= 9) {
                    month = "0" + month;
                }
                if (strDate >= 0 && strDate <= 9) {
                    strDate = "0" + strDate;
                }
                var currentDate = date.getFullYear() + seperator1 + month + seperator1 + strDate
                        + " " + date.getHours() + seperator2 + date.getMinutes()
                        + seperator2 + date.getSeconds();
                return currentDate;
            }
        })
    </script>
</head>
<body class="body-help">
<input id="module" type="hidden" value="help">

<div class="site-head site-head-fixed">
    <div class="head-inner">
        <div class="eteams fl"><a href="/help/index" class="eteams-link"></a></div>
    </div>
</div>

<div class="masthead masthead-help-int">
    <div class="wrap">
        <div class="caption">
            <h1>帮助中心</h1>
            <h5>Help center</h5>
            <p>F-ONE帮助手册，找到您所需要的答案</p>
        </div>
        <div class="mod-sbox">
            <form class="form-search" id="searchForm" action="/help/search" method="post">
                <input id="search" class="text" type="text" name="content" placeholder="请输入搜索内容">
                <button id="search-btn" class="send">搜索</button>
            </form>
        </div>
    </div>
</div>

<div class="wrap">
    <div class="help-breadcrumb">
        <a href="/help/index">帮助主页</a>
        <span class="arr">></span>
        <a href="/help/category/<c:out value="${articles.id}"></c:out>" class="current"><c:out
                value="${articles.name}"></c:out></a>
    </div>
</div>

<div class="wrap help-article">
    <div class="help-aside-wrap" id="help-aside">
        <div class="help-aside">
            <ul class="nav">
                <h3><c:out value="${articles.name}"></c:out>
                </h3>
                <c:forEach var="publishedArticle" items="${articles.publishedArticles}">
                    <c:choose>
                        <c:when test="${publishedArticle.id == article.id}">
                            <li class="item"><a href="/help/article/${publishedArticle.id}"
                                                title="${publishedArticle.title}" class="active">${publishedArticle.title}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="item"><a href="/help/article/${publishedArticle.id}"
                                                title="${publishedArticle.title}">${publishedArticle.title}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="help-main-wrap" id="help-main">
        <div class="help-main">
            <div class="article-info">
                <div class="article-legend">
                    <h2 title="<c:out value="${article.title}"></c:out> "><c:out value="${article.title}"></c:out>
                    </h2>

                    <div class="info">
                        <span class="author">作者：<c:out value="${article.createdBy}"></c:out></span>
                        <span class="time"><fmt:formatDate value="${article.createDate}"
                                                           pattern="yyyy-MM-dd HH:mm:ss"/></span>
                    </div>
                </div>

                <div class="article-bd">
                    <c:out value="${article.fullHtml}" escapeXml="false"></c:out>
                </div>

                <div class="article-comment">
                    <div class="comment">
                        <span class="article-top"><c:out value="${article.likeNum}"></c:out>人觉得有帮助</span>
                        <img src="/html/help/img/dz.png" id="like" width="25px" height="25px">
                    </div>
                    <div class="comment">
                        <b class="article-reply">回复(<c:out value="${article.temp}"></c:out>)</b>
                        <%--<span class="reply-icon"></span>--%>
                        <img id="reply" src="/html/help/img/hf.png" width="25px" height="25px"/>
                    </div>

                    <ul class="comment-list">
                        <c:forEach items="${article.comments}" var="comment">

                            <li class="article-head"></li>
                            <li class="article-item">
                                <div class="comment-div1">发表于&nbsp;&nbsp;<fmt:formatDate value="${comment.commentDate}"
                                                                                         pattern="yyyy-MM-dd HH:mm:ss"/></div>
                                <div class="comment-div2">${comment.content}</div>
                            </li>
                        </c:forEach>
                    </ul>

                    <div class="footer"><span>FacilityONE@2006-2016</span></div>
                </div>

            </div>
        </div>
    </div>
</div>
<div class="site-footer">
    <div class="footer-inner">

        <div class="copyright clearfix">
            <p class="g-site">Copyright &copy;2006-2016 FacilityONE All Right Reserved&nbsp;&nbsp;沪ICP备07008410号</p>
        </div>
    </div>
</div>
</body>
</html>