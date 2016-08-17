<%--
  Created by IntelliJ IDEA.
  User: Yogi
  Date: 2016/8/4
  Time: 22:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <span class="arr">&gt;</span>搜索结果
    </div>
</div>

<div class="wrap help-search help-article">
    <div class="help-search-resul">
        <div class="article-list">
            <div class="tit">
                <h1>“<c:out value="${content}"></c:out>”的搜索结果</h1>
            </div>
            <c:choose>
                <c:when test="${empty articles}">
                    <ul class="list">
                        <div class="no-result">没有“<c:out value="${content}"></c:out>”的相关结果，您可以试着使用其他关键字搜索或回到 <a
                                href="/help/index">主页</a></div>
                    </ul>
                </c:when>
                <c:otherwise>
                    <ul class="list">
                        <c:forEach var="article" items="${articles}">
                            <li class="item"><h3><a href="/help/article/${article.id}"
                                                    title="${article.title}">${article.title}</a></h3></li>
                        </c:forEach>
                    </ul>
                </c:otherwise>
            </c:choose>

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
