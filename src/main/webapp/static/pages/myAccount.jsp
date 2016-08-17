<%@ page import="cn.facilityone.entity.User" %>
<%--
  Created by IntelliJ IDEA.
  User: Yogi
  Date: 2016/8/4
  Time: 0:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    var myAccountController = {

        roleId:null,

        init: function () {
            myAccountController.initMyInfo();
            myAccountController.initSaveBtn();
        },

        initMyInfo: function () {
            $.ajax({
                url: "/account/edit/" + "<%User user = (User)session.getAttribute("user");%><%=user.getUserName()%>",
                type: 'get',
                dataType: "json",
                contentType: "application/json",
                success: function (data) {
                    var data = data.data;
                    $('#pwd').val(data.password);
                    $('#user-name').val(data.userName);
                    $('#contact').val(data.contact);
                    $('#real-name').val(data.realName);
                    $('#account-type').val(data.role.name);
                    myAccountController.roleId = data.roleId;
                },
                error: function () {
                    layer.msg("后台错误", {offset: ["150px"], time: 2000})
                }
            });
        },

        initSaveBtn: function () {
            $('#save').click(function () {
                var name = $('#user-name').val();
                var pwd = $('#pwd').val();
                var contact = $('#contact').val();
                var realName = $('#real-name').val();
                var roleId = myAccountController.roleId;

                var jsonObj = {
                    userName: name,
                    password: pwd,
                    contact: contact,
                    realName: realName,
                    roleId: roleId
                }

                if (!pwd || !roleId) {
                    layer.msg("密码和用户类型不能为空", {offset: ["150px"], time: 1000})
                } else {
                    $.ajax({
                        url: "/account/saveEdit",
                        type: 'post',
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify(jsonObj),
                        success: function () {
                            layer.msg("保存成功", {offset: ["150px"], time: 1000});
                            accountController.datatable.ajax.reload();
                        },
                        error: function () {
                            layer.msg("后台错误", {offset: ["150px"], time: 2000})
                        }
                    });
                    layer.close(index);
                }
            })
        }
    }

    $(document).ready(function () {
        myAccountController.init();
    })
</script>


<div class="datapanel" style="height: 919px;">
    <div class="operatePanel">
        <h2 class="operatePanel-title">我的账号</h2>

        <div class="operatePanel-btnBar">
            <button class="button-public btn-save" id="save">保存</button>
        </div>
    </div>

    <form class="form-active" method="post" style="margin-top: 46px;">
        <div class="form-div">
            <label class="label-text">用户名：</label>
            <input type="text" id="user-name" disabled>
        </div>
        <div class="form-div">
            <label class="label-text">密码：</label>
            <input type="password" id="pwd">
        </div>
        <div class="form-div">
            <label class="label-text">真实姓名：</label>
            <input type="text" id="real-name"/>
        </div>
        <div class="form-div">
            <label class="label-text">用户类型：</label>
            <input id="account-type" disabled/>
        </div>
        <div class="form-div" style="margin-bottom: 29px;">
            <label class="label-text">联系电话：</label>
            <input type="text" id="contact"/>
        </div>
    </form>
</div>
