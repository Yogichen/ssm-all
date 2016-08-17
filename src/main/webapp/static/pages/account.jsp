<%--
  Created by IntelliJ IDEA.
  User: Yogi
  Date: 2016/8/3
  Time: 19:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    var accountController = {
        datatable: null,

        init: function () {
            accountController.initDataTable();
            accountController.initAddBtn();
            accountController.initRoleTypeSelect();
        },

        initRoleTypeSelect: function () {
            $.ajax({
                url: "/role/all",
                type: "get",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    var data = data.data;
                    var thtml = "<option value=''></option>";
                    for (var i in data) {
                        thtml += "<option value=" + data[i].id + ">" + data[i].name + "</option>"
                    }
                    $('#select-add').append(thtml);
                    $('#select-edit').append(thtml);

                }
            })
        },

        initAddBtn: function () {
            $('#add').on('click', function () {

                layer.open({
                    type: 1,
                    title: "添加用户",
                    area: ['500px', '380px'],
                    offset: ["150px"],
                    shadeClose: false, //点击遮罩关闭
                    content: $('#add-modal'),
                    btn: ["创建", "取消"],
                    //按钮1
                    yes: function (index, layero) {
                        var name = $('#account-name-add').val();
                        var pwd = $('#account-pwd-add').val();
                        var realName = $('#account-realname-add').val();
                        var contact = $('#account-contact-add').val();
                        var roleId = $('#select-add').find('option:selected').val();
                        var jsonObj = {
                            userName: name,
                            password: pwd,
                            realName: realName,
                            roleId: roleId,
                            contact: contact
                        }
                        if (!name) {
                            layer.msg("请正确输入", {offset:["150px"],time: 1000})
                        } else {
                            $.ajax({
                                url: "/account/add",
                                type: 'post',
                                dataType: "json",
                                contentType: "application/json",
                                data: JSON.stringify(jsonObj),
                                success: function (data) {
                                    if (data.status == 'fail') {
                                        layer.msg("用户已存在", {offset:["150px"],time: 1000})
                                    } else if (data.status == 'success') {
                                        layer.msg("添加成功", {offset:["150px"],time: 1000});
                                        accountController.clearAddContent();
                                        //yes callback needs to close manually
                                        layer.close(index);
                                        accountController.datatable.ajax.reload();
                                    }
                                },
                                error: function () {
                                    layer.msg("后台错误", {offset:["150px"],time: 2000});
                                }
                            })
                        }
                    },
                    //按钮2
                    btn2: function (index, layero) {
                        accountController.clearAddContent();
                    },
                    //关闭按钮
                    cancel: function (index, layero) {
                        accountController.clearAddContent();
                    }
                });
            });
        },

        initDataTable: function () {
            accountController.datatable = $('table').DataTable({
                "autoWidth": true,
                "searching": false,
                "pageLength": 10,
                "lengthChange": false,
                "scrollX": true,
                "sort": false,
                "bprocessing": true,
                "serverSide": true,
                "language": {
                    "lengthMenu": "每页 _MENU_ 条记录",
                    "zeroRecords": "没有找到记录",
                    "info": "第 _PAGE_ 页 ( 总共 _PAGES_ 页 )",
                    "infoEmpty": "无记录",
                    "infoFiltered": "(从 _MAX_ 条记录过滤)",
                    "paginate": {
                        "first": "首页",
                        "last": "末页",
                        "next": "下一页",
                        "previous": "上一页"
                    }
                },
                ajax: {
                    url: "/account/grid",
                    contentType: "application/json",
                    type: 'POST',
                    dataType: "json",
                    data: function (d) {
                        return d;
                    }
                },

                columns: [
                    {title: "用户名", data: "userName"},
                    {title: "真实姓名", data: "realName"},
                    {title: "用户类型", data: "role.name"},
                    {title: "联系电话", data: "contact"},
                    {title: "操作"}
                ],

                columnDefs: [

                    {
                        "targets": [4], // 目标列位置，下标从0开始
                        "data": function (source, type, val) {
                            return 1;

                        },
                        "render": function (data, type, full) { // 返回自定义内容
                            return "<a href='javascript:void(0)' class='data-edit' alt='" + data + "'>编辑</a>&nbsp;&nbsp;<a href='javascript:void(0)' class='data-del' alt='" + data + "'>删除</a>"
                        }
                    }
                ],

                fnDrawCallback: function () {
                    accountController.initEditModal();
                    accountController.initDelBtn();

                }
            })
        },

        initEditModal: function(){
            $('.data-edit').on('click', function () {
                var userName = accountController.datatable.row($(this).parents('tr')).data().userName;
                $.ajax({
                    url: "/account/edit/" + userName,
                    type: 'get',
                    dataType: "json",
                    contentType: "application/json",
                    success: function (data) {
                        var data = data.data;
                        $('#account-pwd-edit').val(data.password);
                        $('#account-name-edit').val(data.userName);
                        $('#account-contact-edit').val(data.contact);
                        $('#account-realname-edit').val(data.realName);
                        $('#select-edit option[value=' + data.roleId + ']').prop("selected", true);

                        //加载layer弹出层
                        layer.open({
                            type: 1,
                            title: "编辑",
                            area: ['500px', '380px'],
                            offset:["150px"],
                            shadeClose: false, //点击遮罩关闭
                            content: $('#edit-modal'),
                            btn: ["保存", "取消"],
                            btn1: function (index, layero) {
                                var name = $('#account-name-edit').val();
                                var pwd = $('#account-pwd-edit').val();
                                var contact = $('#account-contact-edit').val();
                                var realName = $('#account-realname-edit').val();
                                var roleId = $('#select-edit').find('option:selected').val();

                                var jsonObj = {
                                    userName: name,
                                    password: pwd,
                                    contact: contact,
                                    realName: realName,
                                    roleId: roleId
                                }

                                if (!pwd || !roleId) {
                                    layer.msg("密码和用户类型不能为空", {offset:["150px"],time: 1000})
                                } else {
                                    $.ajax({
                                        url: "/account/saveEdit",
                                        type: 'post',
                                        dataType: "json",
                                        contentType: "application/json",
                                        data: JSON.stringify(jsonObj),
                                        success: function () {
                                            layer.msg("保存成功", {offset:["150px"],time: 1000});
                                            accountController.datatable.ajax.reload();
                                        },
                                        error: function () {
                                            layer.msg("后台错误", {offset:["150px"],time: 2000})
                                        }
                                    });
                                    layer.close(index);
                                }
                            },
                            btn2: function () {
                            },
                            cancel: function (index, layero) {
                                //do something
                            }
                        });
                    },
                    error: function () {
                        layer.msg("后台错误", {offset:["150px"],time:2000})
                    }
                });
            });
        },

        initDelBtn: function () {
            $('.data-del').on('click', function () {
                var userName = accountController.datatable.row($(this).parents('tr')).data().userName;
                layer.confirm('确定要删除该用户？', {
                    offset:["150px"],
                    btn: ["确定", "取消"],
                    btn1: function () {
                        $.ajax({
                            url: "/account/" + userName + "/del",
                            type: 'get',
                            dataType: "json",
                            contentType: "application/json",
                            success: function () {
                                layer.msg("删除成功", {offset:["150px"],time: 1000});
                                layer.close();
                                accountController.datatable.ajax.reload();
                            }
                        });
                    },
                    btn2: function () {
                    }
                });
            })
        },

        clearAddContent: function(){
            //清除用户名
            $('#account-name-add').val('');
            //清除真实姓名
            $('#account-realname-add').val('');
            //清除密码
            $('#account-pwd-add').val('');
            //清除联系方式
            $('#account-contact-add').val('');
            //清除用户类型
            $('#select-add option[value=""]').prop("selected", true);

        }

    }

    $(document).ready(function () {
        accountController.init();
    })
</script>


<div class="datapanel" style="min-height: 919px;">
    <div class="operatePanel">
        <h2 class="operatePanel-title">帐号管理</h2>

        <div class="operatePanel-btnBar">
            <button type="button" class="button-public btn-add" id="add">添加</button>
        </div>
    </div>

    <div>
        <table id="table" width=100%"></table>
    </div>

    <div id="add-modal" style="display: none">
        <form id="form-add" class="form-active">
            <div class="form-div">
                <label class="label-text">用户名:</label>
                <input type="text" id="account-name-add"/>
            </div>
            <div class="form-div">
                <label class="label-text">密码:</label>
                <input type="text" id="account-pwd-add"/>
            </div>
            <div class="form-div">
                <label class="label-text">真实姓名:</label>
                <input type="text" id="account-realname-add"/>
            </div>
            <div class="form-div">
                <label class="label-text">用户类型:</label>
                <select id="select-add"></select>
            </div>
            <div class="form-div">
                <label class="label-text">联系方式:</label>
                <input type="text" id="account-contact-add"/>
            </div>
        </form>
    </div>

    <div id="edit-modal" style="display: none">
        <form id="form-edit" class="form-active">
            <div class="form-div">
                <label class="label-text">用户名:</label>
                <input type="text" id="account-name-edit" disabled/>
            </div>
            <div class="form-div">
                <label class="label-text">密码:</label>
                <input type="password" id="account-pwd-edit"/>
            </div>
            <div class="form-div">
                <label class="label-text">真实姓名:</label>
                <input type="text" id="account-realname-edit"/>
            </div>
            <div class="form-div">
                <label class="label-text">用户类型:</label>
                <select id="select-edit"></select>
            </div>
            <div class="form-div">
                <label class="label-text">联系方式:</label>
                <input type="text" id="account-contact-edit"/>
            </div>
        </form>
    </div>
</div>
