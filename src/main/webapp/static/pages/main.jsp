<%--
  Created by IntelliJ IDEA.
  User: Yogi
  Date: 2016/7/27
  Time: 9:04
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>shang帮助中心</title>
    <link rel="stylesheet" type="text/css" href="/html/help-Backstage/css/helpBackstage.css"/>
    <link rel="stylesheet" href="/static/css/plugins/datatables/jquery.dataTables.css"/>
    <link rel="stylesheet" href="/static/js/plugins/layer/skin/layer.css"/>
    <link rel="stylesheet" href="/static/js/plugins/uploadify/uploadify.css">
    <link rel="stylesheet" href="/static/js/plugins/ueditor/themes/default/css/ueditor.css">
    <script src="/static/js/plugins/jquery/jquery-2.0.0.js"></script>
    <script src="/static/js/plugins/datatables/jquery.dataTables.js"></script>
    <script src="/static/js/plugins/layer/layer.js"></script>
    <script src="/static/js/plugins/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/static/js/plugins/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/static/js/plugins/ueditor/ueditor.all.js"></script>
    <script>
        $(document).ready(function () {
            $('.sidebar-menu span').on('click', function (e) {
                toLink($(e.target).attr('href'))
                $('#sidebar .click-active').removeClass("click-active");
                $(this).parent('li').addClass('click-active');
            });

            $('.navbar a').hover(function(){
                $('.dropdown-menu').show();
            }, function(){
                $('.dropdown-menu').hide();
            });

            $('.fa-power-off').parent('a').click(function(){
                location.href = '/user/logout';
            })

            function toLink(link) {
                $('#content').load(link, function () {

                })
            }
        })

        window.isUeditorInited = false;
    </script>
</head>
<body style="background: #f3f3f3">

<!-- header -->
<div class="header">
    <div class="logo">
        <div class="logo_facilityone"></div>
    </div>
    <div class="navbar">
        <a href='javascript:void(0)'>
            <b class="head"></b>
            <span id="username"><c:out value="${user.userName}"></c:out> </span>
            <img src="/html/help-Backstage/img/xia.png">
        </a>
        <ul class="dropdown-menu" style="display: none;z-index:500;position: fixed;">
            <li>
                <a href='javascript:void(0)'><i class="fa fa-power-off"></i> 退出</a>
            </li>
        </ul>
    </div>
</div>

<!-- leftNav -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-menu">
        <ul class="mymenu">
            <c:forEach var="menu" items="${menu}">
                <li class="has-sub">
                    <i class="${menu.iconClass}"></i>
                    <span class="menu-text" style="cursor: pointer" href="${menu.link}">${menu.name}</span>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>

<!--- content -->
<div id="content" class="container"></div>

</body>
</html>
