<%--
  Created by IntelliJ IDEA.
  User: Yogi
  Date: 2016/8/4
  Time: 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="/html/help/css/base.css"/>
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
    </div>
</div>

<div class="wrap help-article">
    <div class="help-aside-wrap">
        <div class="help-aside">
            <ul class="nav">
                <h3>更多帮助</h3>
                <c:if test="${!empty categories}">
                    <c:forEach items="${categories}" var="category">
                        <c:choose>
                            <c:when test="${category.id == articles.id}">
                                <li class="item"><a href="/help/category/${category.id}" class="active edit-catalog"
                                                    title="${category.name}">${category.name}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="item"><a href="/help/category/${category.id}" class="edit-catalog"
                                                    title="${category.name}">${category.name}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:if>
            </ul>
        </div>
    </div>
    <div class="help-main-wrap">
        <div class="article-list">
            <div class="tit">
                <h1><c:out value="${articles.name}"></c:out></h1>
            </div>
            <ul class="list">
                <c:choose>
                    <c:when test="${!empty articles.publishedArticles}">
                        <c:forEach var="article" items="${articles.publishedArticles}">
                            <li class="item">
                                <a href="/help/article/${article.id}" title="${article.title}">${article.title}
                                </a>
                                <div class="j_content content">${article.introduce}</div>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div>暂无文章</div>
                    </c:otherwise>
                </c:choose>
            </ul>
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
