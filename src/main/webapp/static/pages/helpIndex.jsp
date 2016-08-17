<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Yogi
  Date: 2016/8/4
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8"/>
    <title>shang帮助中心</title>
    <link rel="stylesheet" href="/html/help/css/base.css"/>


</head>
<body>
<input id="module" type="hidden" value="help">

<div class="site-head site-head-fixed">
    <div class="head-inner">
        <div class="eteams fl"><a href="#" class="eteams-link"></a></div>
    </div>
</div>

<div class="masthead masthead-help">
    <div class="mod-sbox">
        <form class="form-search" id="searchForm" action="/help/search" method="post">
            <input id="search" class="text" type="text" name="content" placeholder="请输入搜索内容">
            <button id="search-btn" class="send">搜索</button>
        </form>
    </div>
</div>

<div class="row row-gray help-row">
    <div class="row-head">
        <h2>使用指南</h2>
        <h5>User guide</h5>
    </div>

    <div class="mod-help-guide">
        <div class="sub-tit">
            <div class="divide"></div>
            <p><span>功能模块</span></p>
        </div>
        <ul class="clearfix">
            <c:choose>
                <c:when test="${!empty categories}">
                    <c:forEach var="category" items="${categories}">
                        <c:if test="${category.type == '功能模块'}">
                            <li>
                                <a href="/help/category/${category.id}">
                                    <img src="${category.iconPath}" class="front-img"/>

                                    <p>${category.name}
                                    </p>
                                </a>
                            </li>
                        </c:if>
                    </c:forEach>
                </c:when>
            </c:choose>
        </ul>

        <div class="sub-tit">
            <div class="divide"></div>
            <p><span>其他</span></p>
        </div>
        <ul class="clearfix guide-other">
            <c:choose>
                <c:when test="${!empty categories}">
                    <c:forEach var="category" items="${categories}">
                        <c:if test="${category.type == '其他'}">
                            <li>
                                <a href="/help/category/${category.id}">
                                    <img src="${category.iconPath}" class="front-img"/>

                                    <p>${category.name}
                                    </p>
                                </a>
                            </li>
                        </c:if>
                    </c:forEach>
                </c:when>
            </c:choose>
        </ul>
    </div>
</div>

<div class="row help-row">
    <div class="row-head">
        <h2>常见问题</h2>
        <h5>FAQ</h5>
    </div>

    <div class="mod-help-faq">
        <ul class="faq-list clearfix">
            <c:if test="${!empty faq}">
                <c:forEach var="article" items="${faq}" begin="0" end="9" step="1">
                    <li>
                        <a href="/help/article/${article.id}">${article.title}
                        </a>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
        <div class="more-btn">
            <c:if test="${!empty categories}">
                <c:forEach var="category" items="${categories}">
                    <c:if test="${category.name == 'FAQ'}">
                        <a class="btn" href="/help/category/${category.id}">更多>></a>
                    </c:if>
                </c:forEach>
            </c:if>
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
