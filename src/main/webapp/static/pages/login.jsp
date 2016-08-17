<%--
  Created by IntelliJ IDEA.
  User: Yogi
  Date: 2016/7/20
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="/html/help/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/html/help/css/login.css"/>
</head>
<body>
<div class="site-head ">
    <div class="head-inner">
        <div class="eteams fl"><a href="/" class="eteams-link"></a></div>
    </div>
</div>

<section class="container">
    <div class="g-600 login-panel" id="login-wrapper">
        <div class="box-shadow">
            <h1 class="singleHead">用户登录</h1>

            <form id="loginForm" class="ui-form" method="post" action="<%=request.getContextPath()%>/user/index">
                <div class="ui-form-item">
                    <label for="username" class="ui-label">账号：</label>
                    <input type="text" class="ui-input" id="username" name="userName" value="" placeholder="请输入帐号"/>
                </div>
                <div class="ui-form-item">
                    <label for="password" class="ui-label">密码：</label>
                    <input type="password" class="ui-input" name="password" id="password" placeholder="请输入密码"/>
                </div>
                <div class="fmes-bar">
                    <button type="submit" class="btn btn-lg btn-primary mgr1160">登录</button>
                </div>
            </form>
        </div>
    </div>
</section>

<footer>
    <div class="footer">
        <div class="copyright">Copyright ©2006-2016 FacilityONE All Right Reserved&nbsp;&nbsp;沪ICP备07008410号</div>
    </div>
</footer>
</body>
</html>

