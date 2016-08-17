<%--
  Created by IntelliJ IDEA.
  User: Yogi
  Date: 2016/7/27
  Time: 14:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    var controller = {
        datatable: null,
        type: null,
        iconPath: null,
        iconPathToEdit: null,
        init: function () {
            controller.initDataTable();
            controller.initAddBtn();
            controller.initTypeSelect();
        },

        initAddBtn: function () {
            $('#add').on('click', function () {

                layer.open({
                    type: 1,
                    title: "新增分类",
                    area: ['500px', '400px'],
                    offset: ["150px"],
                    shadeClose: false, //点击遮罩关闭
                    content: $('#add-modal'),
                    btn: ["创建", "取消"],
                    //按钮1
                    yes: function (index, layero) {
                        var name = $('#category-name-new').val();
                        var type = $('#select-add').find('option:selected').val();
                        var jsonObj = {
                            name: name,
                            type: type,
                            iconPath: controller.iconPath,
                            createDate: new Date()
                        }
                        if (!name || !type) {
                            layer.msg("分类名称和主题不能为空", {time: 1000})
                        } else {
                            $.ajax({
                                url: "/category/save",
                                type: 'post',
                                dataType: "json",
                                contentType: "application/json",
                                data: JSON.stringify(jsonObj),
                                success: function (data) {
                                    layer.msg("添加成功", {time: 1000});
                                    controller.clearAddContent();
                                    //yes callback needs to close manually
                                    layer.close(index);
                                    controller.datatable.ajax.reload(null, false);
                                },
                                error: function () {
                                    layer.msg("后台错误", {time: 2000});
                                }
                            })
                        }
                    },
                    //按钮2
                    btn2: function (index, layero) {
                        controller.clearAddContent();
                    },
                    //关闭按钮
                    cancel: function (index, layero) {
                        controller.clearAddContent();
                    }
                });
            });
            controller.uploadIfyToSave();
        },

        initTypeSelect: function () {
            $.ajax({
                url: "/category/type",
                type: "get",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    var data = data.data;
                    var thtml = "<option value=''></option>";
                    for (var i in data) {
                        thtml += "<option value=" + data[i] + ">" + data[i] + "</option>"
                    }
                    $('#select-add').append(thtml);
                    $('#select-edit').append(thtml);

                }
            })
        },

        uploadIfyToSave: function () {
            $("#uploadFile").uploadify({
                'debug': false,
                'method': 'post',
                'file_post_name': 'uploadFile',
                'buttonText': '选择文件',
                'width': '80',
                'height': '25',
                'swf': '/static/js/plugins/uploadify/uploadify.swf',
                'uploader': '/category/saveToTemp;jsessionid=${pageContext.session.id}',
                'queueID': 'uploadFileQueue',
                'onUploadStart': function (file) {
                    //if (1 == 1) {
                    //alert('这里可以做些上传前的校验或你需要的操作，类似的函数还有好几个，可看官网文档');
                    // 如果判断不符合要求，可设置取消上传
                    //$('#uploadFile').uploadify('cancel');
                    // }
                },
                'onUploadSuccess': function (file, json, response) {
                    var data = eval("(" + json + ")");
                    controller.iconPath = data.path;
                    $('#img-container').html('');
                    if (file.name) {
                        $('#img-container').append('<img src="/category/upload/' + data.name + '">');
                    }
                }
            });
        },

        initDataTable: function () {
            controller.datatable = $('table').DataTable({
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
                    url: "/category/grid",
                    contentType: "application/json",
                    type: 'POST',
                    dataType: "json",
                    data: function (d) {
                        return $.extend(d, controller.type);
                    }
                },

                columns: [
                    {title: "排序"},
                    {
                        title: "类别",
                        data: "name"
//                        render: function(data, type, row, meta){
//                            return '<div style="text-align:left;width: 150px;white-space:nowrap;overflow: hidden;' +
//                                    'text-overflow: ellipsis;" '+'title="'+data +'">'+data +'</div>';
//                        }
                    },
                    {title: "主题", data: "type"},
                    {title: "文章数量", data: "temp"},
                    {title: "操作"}
                ],

                columnDefs: [

                    {
                        "targets": [0], // 目标列位置，下标从0开始
                        "width": "20%",
                        "data": function (source, type, val) {
                            return 1;

                        },
                        "render": function (data, type, full) { // 返回自定义内容
                            return "<a href='javascript:void(0)'class='order-up' alt=''>上移</a>&nbsp;&nbsp;<a href='javascript:void(0)' class='order-down' alt=''>下移</a>"
                        }
                    },

                    {
                        "targets": [1], // 目标列位置，下标从0开始
                        "width": "20%"
                    },

                    {
                        "targets": [2], // 目标列位置，下标从0开始
                        "width": "20%"
                    },

                    {
                        "targets": [3], // 目标列位置，下标从0开始
                        "width": "20%"
                    },

                    {
                        "targets": [4], // 目标列位置，下标从0开始
                        "width": "20%",
                        "data": function (source, type, val) {
                            if('常见问题' == source.type){
                                return 1;
                            }
                            return source;
                        },
                        "render": function (data, type, full) { // 返回自定义内容
                            if(data == 1){
                                return "";
                            }
                            return "<a href='javascript:void(0)' class='data-edit' alt=''>编辑</a>&nbsp;&nbsp;<a href='javascript:void(0)' class='data-del' alt=''>删除</a>"
                        }
                    }
                ],

                fnDrawCallback: function () {
                    controller.initOrderUp();
                    controller.initOrderDown();
                    controller.initEditModal();
                    controller.initDelBtn();
                }
            })
        },

        initEditModal: function () {
            $('.data-edit').on('click', function () {
                //获取该行数据
                var dataId = controller.datatable.row($(this).parents('tr')).data().id;
                $.ajax({
                    url: "/category/edit/" + dataId,
                    type: 'get',
                    dataType: "json",
                    contentType: "application/json",
                    success: function (data) {
                        var data = data.data;
                        console.log(data.type);
                        //初始化modal数据
                        $('#img-container-edit').html('');
                        if (data.iconPath) {
                            $('#img-container-edit').append('<img src=' + data.iconPath + '>');
                        }
                        $('#category-name-edit').val(data.name);
                        $('#select-edit option[value=' + data.type + ']').prop("selected", true);

                        //加载uploadify
                        controller.uploadIfyToEdit();

                        //加载layer弹出层
                        layer.open({
                            type: 1,
                            title: "编辑",
                            area: ['500px', '400px'],
                            offset: ["150px"],
                            shadeClose: false, //点击遮罩关闭
                            content: $('#edit-modal'),
                            btn: ["保存", "取消"],
                            btn1: function (index, layero) {
                                var name = $('#category-name-edit').val();
                                var type = $('#select-edit').find('option:selected').val();
                                console.log(type)
                                var jsonObj = {
                                    id: dataId,
                                    name: name,
                                    type: type,
                                    iconPath: controller.iconPathToEdit,
                                    modifiedDate: new Date()
                                };
                                if (!name || !type) {
                                    layer.msg("分类名称和主题不能为空", {time: 1000})
                                } else {
                                    $.ajax({
                                        url: "/category/saveEdit",
                                        type: 'post',
                                        dataType: "json",
                                        contentType: "application/json",
                                        data: JSON.stringify(jsonObj),
                                        success: function () {
                                            layer.msg("保存成功", {time: 1000})
                                            controller.datatable.ajax.reload(null, false);
                                        },
                                        error: function () {
                                            layer.msg("后台错误", {time: 2000})
                                        }
                                    });
                                    layer.close(index);
                                }
                            },
                            btn2: function () {
                            },
                            cancel: function (index, layero) {
                                //do something
                                controller.iconPathToEdit = null;
                            }
                        });
                    },
                    error: function () {

                    }
                });
            });
        },

        uploadIfyToEdit: function () {
            $("#uploadFile2Edit").uploadify({
                'debug': false,
                'method': 'post',
                'file_post_name': 'uploadFile',
                'buttonText': '选择文件',
                'width': '80',
                'height': '25',
                'swf': '/static/js/plugins/uploadify/uploadify.swf',
                'uploader': '/category/saveToTemp;jsessionid=${pageContext.session.id}',
                'queueID': 'uploadFileQueue2Edit',
                'onUploadSuccess': function (file, json, response) {
                    var data = eval("(" + json + ")");
                    controller.iconPathToEdit = data.path;
                    $('#img-container-edit').html('');
                    if (file.name) {
                        $('#img-container-edit').append('<img src="/category/upload/' + data.name + '">');
                    }
                }
            });
        },

        initDelBtn: function () {
            $('.data-del').on('click', function () {
                var dataId = controller.datatable.row($(this).parents('tr')).data().id;
                layer.confirm('确定要删除该分类？', {
                    btn: ["确定", "取消"],
                    btn1: function () {
                        $.ajax({
                            url: "/category/delete/" + dataId,
                            type: 'get',
                            dataType: "json",
                            contentType: "application/json",
                            success: function () {
                                layer.msg("删除成功", {time: 1000});
                                layer.close();
                                controller.datatable.ajax.reload(null, false);
                            }
                        });
                    },
                    btn2: function () {
                    }
                });
            })
        },

        clearAddContent: function () {
            //清除分类名称
            $('#category-name-new').val('');
            //清除主题
            $('#select-add option[value=""]').prop("selected", true);
            //清除图片
            $('#img-container').html('');
            //清除iconPath
            controller.iconPath = null;
        },

        initOrderUp: function () {
            $('.order-up').on('click', function () {
                //获得该行数据
                var currentId = controller.datatable.row($(this).parents('tr')).data().id;
                var currentOrder = controller.datatable.row($(this).parents('tr')).data().sortOrder;

                $.ajax({
                    url: "/category/moveUp/currentId/" + currentId + "/currentOrder/" + currentOrder,
                    type: 'get',
                    dataType: "json",
                    contentType: "application/json",
                    success: function (data) {
                        layer.msg("上移成功", {time: 1000});
                        controller.datatable.ajax.reload(null, false);
                    },
                    error: function () {
                        layer.msg("后台错误", {time: 1000})
                    }
                });
            })
        },

        initOrderDown: function () {
            $('.order-down').on('click', function () {
                //获得该行数据
                var currentId = controller.datatable.row($(this).parents('tr')).data().id;
                var currentOrder = controller.datatable.row($(this).parents('tr')).data().sortOrder;

                $.ajax({
                    url: "/category/moveDown/currentId/" + currentId + "/currentOrder/" + currentOrder,
                    type: 'get',
                    dataType: "json",
                    contentType: "application/json",
                    success: function (data) {
                        layer.msg("下移成功", {time: 1000});
                        controller.datatable.ajax.reload(null, false);
                    },
                    error: function () {
                        layer.msg("后台错误", {time: 1000})
                    }
                });

            })
        }

    }

    $(document).ready(function () {
        controller.init();
    });
</script>

<div class="datapanel" style="min-height: 919px;">
    <div class="operatePanel">
        <h2 class="operatePanel-title">分类管理</h2>

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
                <label class="label-text">图标:</label>

                <div id="category-icon-add">
                    <div id="uploadFileQueue" style="display: none"></div>
                    <div id="img-container" class="picture-icon"></div>
                    <input type="file" id="uploadFile" name="uploadFile"/>
                </div>
            </div>

            <div class="form-div">
                <label class="label-text">分类名称:</label>
                <input type="text" id="category-name-new" maxlength="10" placeholder="最多输入10个字"/>
            </div>
            <div class="form-div">
                <label class="label-text">主题:</label>
                <select id="select-add"></select>
            </div>
        </form>

    </div>

    <div id="edit-modal" style="display: none">
        <form id="form-edit" class="form-active">
            <div class="form-div">
                <label class="label-text">图标:</label>

                <div id="category-icon-edit">
                    <div id="uploadFileQueue2Edit" style="display: none"></div>
                    <div id="img-container-edit" class="picture-icon"></div>
                    <div>
                        <input type="file" id="uploadFile2Edit" name="uploadFile"/>
                    </div>
                </div>
            </div>
            <div class="form-div">
                <label class="label-text">分类名称:</label>
                <input type="text" id="category-name-edit" maxlength="10" placeholder="最多输入10个字"/>
            </div>
            <div class="form-div">
                <label class="label-text">主题:</label>
                <select id="select-edit"></select>
            </div>
        </form>
    </div>
</div>