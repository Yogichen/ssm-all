<%--
  Created by IntelliJ IDEA.
  User: Yogi
  Date: 2016/8/1
  Time: 18:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String contextPath = "http://"+request.getServerName()+":"+request.getLocalPort()+request.getContextPath();%>
<script>
    var articleController = {
        datatable: null,
        articleId: null,
        categoryId: null,
        ue: null,
        editUe: null,
        toolbars: [
            [   'fullscreen', //全屏
                'source', //html
                'undo', //撤销
                'redo', //重做
                'bold', //加粗
                'fontsize', //字号
                'fontfamily', //字体
                'paragraph', //段落格式
                'indent', //首行缩进
                'lineheight', //行间距
                'rowspacingtop', //段前距
                'rowspacingbottom', //段后距
                'justifyleft', //居左对齐
                'justifyright', //居右对齐
                'justifycenter', //居中对齐
                'justifyjustify', //两端对齐
                'forecolor', //字体颜色
                'backcolor', //背景色
                'horizontal', //分隔线
                'simpleupload', //单图上传
                'insertorderedlist', //有序列表
                'insertunorderedlist', //无序列表
                'edittable', //表格属性
                'edittd', //单元格属性
                'indent', //首行缩进
                'italic', //斜体
                'underline', //下划线
                'strikethrough', //删除线
                'formatmatch', //格式刷
                'blockquote', //引用
                'link', //超链接
                'unlink', //取消超链接
                'selectall', //全选
                'pasteplain', //纯文本粘贴模式
                'removeformat', //清除格式
                'mergeright', //右合并单元格
                'mergedown', //下合并单元格
                'deleterow', //删除行
                'deletecol', //删除列
                'splittorows', //拆分成行
                'splittocols', //拆分成列
                'splittocells', //完全拆分单元格
                'deletecaption', //删除表格标题
                'inserttitle', //插入标题
                'mergecells', //合并多个单元格
                'deletetable', //删除表格
                'spechars', //特殊字符
                'charts', // 图表
                'preview'//预览
            ]
        ],

        init: function () {
            articleController.initDataTable();
            articleController.initAddBtn();
            articleController.initBtn();
            articleController.initAllCategory();
            articleController.initOptionChanged();
        },

        initAllCategory: function () {
            $.ajax({
                url: "/category/all",
                type: "get",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    var data = data.data;
                    var thtml = "<option value=''></option>";
                    for (var i in data) {
                        thtml += "<option id=" + data[i].id + ">" + data[i].name + "</option>";
                    }
                    $('#select-add').append(thtml);
                    $('#select-edit').append(thtml);
                    $('#category-select').append(thtml);
                }
            })

        },

        initBtn: function () {
            $('#back').on('click', function () {
                $('#first-page').removeAttr('style');
                $('#sec-page').attr('style', 'display:none');
                articleController.cleanAddForm();
                articleController.datatable.ajax.reload();
            });

            $('#add-new').on('click', function () {
                articleController.saveNewArt();
            })

            $('#edit-save').on('click', function () {
                articleController.saveEdit();
            });

            $('#edit-back').on('click', function () {
                $('#first-page').removeAttr('style');
                $('#third-page').attr('style', 'display:none');
                articleController.datatable.ajax.reload();
            })
        },

        initDataTable: function () {
            articleController.datatable = $('table').DataTable({
                "autoWidth": false,
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
                    url: "/article/grid",
                    contentType: "application/json",
                    type: 'POST',
                    dataType: "json",
                    data: function (d) {
                        d.columns[2].search.value = articleController.categoryId;
                    }
                },

                columns: [
                    {title: "排序"},
                    {
                        title: "标题",
                        data: "title",
                        render:function(data, type, row, meta){
                            return '<div style="text-align:left;width: 450px;white-space:nowrap;overflow: hidden;' +
                                    'text-overflow: ellipsis;" '+'title="'+data +'">'+data +'</div>';
                        }
                    },
                    {
                        title: "分类",
                        data: "category.name",
                        render:function(data, type, row, meta){
                            return '<div style="width: 170px;white-space:nowrap;overflow: hidden;' +
                                    'text-overflow: ellipsis;" '+'title="'+data +'">'+data +'</div>';
                        }
                    },
                    {title: "创建人", data: "createdBy"},
                    {title: "操作"}
                ],

                columnDefs: [

                    {
                        "targets": [0], // 目标列位置，下标从0开始
                        "width": "15%",
                        "data": function (source, type, val) {
                            return 1;

                        },
                        "render": function (data, type, full) { // 返回自定义内容
                            return "<a href='javascript:void(0)' class='data-up' alt='" + data + "'>上移</a>&nbsp;&nbsp;" +
                                    "<a href='javascript:void(0)' class='data-down' alt='" + data + "'>下移</a>"
                        }
                    },

                    {
                        "targets": [1], // 目标列位置，下标从0开始
                        "width":"30%"
                    },

                    {
                        "targets": [2], // 目标列位置，下标从0开始
                        "width":"15%"
                    },

                    {
                        "targets": [3], // 目标列位置，下标从0开始
                        "width":"10%"
                    },

                    {
                        "targets": [4], // 目标列位置，下标从0开始
                        "width": "15%",
                        "data": function (source, type, val) {
                            return 1;

                        },
                        "render": function (data, type, full) { // 返回自定义内容
                            return "<a href='javascript:void(0)' class='data-publish' alt='" + data + "'>发布</a>&nbsp;&nbsp;" +
                                    "<a href='javascript:void(0)' class='data-edit' alt='" + data + "'>编辑</a>&nbsp;&nbsp;" +
                                    "<a href='javascript:void(0)' class='data-del' alt='" + data + "'>删除</a>"
                        }
                    }
                ],

                fnDrawCallback: function () {
                    articleController.initMoveUp();
                    articleController.initMoveDown();
                    articleController.initPublishBtn();
                    articleController.initEditModal();
                    articleController.initDelBtn();
                }
            })
        },

        initAddBtn: function () {
            $('#add').on('click', function () {
                $('#first-page').attr('style', 'display:none');
                $('#sec-page').removeAttr('style');
                UE.delEditor('editor');
                articleController.ue = UE.getEditor('editor', {
                    toolbars: articleController.toolbars,
                    autoHeightEnabled: false,
                    autoFloatEnabled: false,
                    initialFrameHeight: 500,
                    enableAutoSave: false
                });
            })
        },

        saveNewArt: function () {
            var ue = articleController.ue;
            var html = ue.getContent();
            var plainText = ue.getContentTxt();
            var articleTitle = $('#article-title-add').val();
            var category = $('#select-add').find('option:selected').attr('id');
            var introduce = $('#article-introduce-add').val();

            //构建json
            var jsonObj = {
                title: articleTitle,
                categoryId: category,
                introduce: introduce,
                plainText: plainText,
                fullHtml: html,
                createDate: new Date()
            };

            if (!articleTitle || !category) {
                layer.msg("分类和标题不能为空", {time: 1000})
            } else {
                $.ajax({
                    url: "/article/add",
                    type: 'post',
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(jsonObj),
                    success: function () {
                        articleController.cleanAddForm();
                        $('#first-page').removeAttr('style');
                        $('#sec-page').attr('style', 'display:none');
                        articleController.datatable.ajax.reload();
                        layer.msg("保存成功", {time: 1000});
                    },

                    error: function(){
                        layer.msg("后台错误", {time: 1000})
                    }
                })
            }
        },

        cleanAddForm: function () {
            articleController.ue.setContent("", false);
            $('#article-title-add').val('');
            $('#article-introduce-add').val('')
            $('#select-add option[value=""]').prop("selected", true);
        },

        initPublishBtn: function () {
            $('.data-publish').on('click', function () {
                var articleId = articleController.datatable.row($(this).parents('tr')).data().id;
                layer.confirm("确认发布？", {
                    offset: ["150px"],
                    btn: ["确定", "取消"],
                    btn1: function () {
                        //获得该行数据
                        articleController.articleId = articleId;
                        $.ajax({
                            url: "/article/publish/" + articleId,
                            type: "get",
                            dataType: "json",
                            contentType: "application/json",
                            success: function (data) {
                                layer.msg("发布成功", {time: 1000});
                                layer.close();
                            }
                        })
                    },
                    btn2: function () {

                    }
                });
            })
        },

        initEditModal: function () {
            $('.data-edit').on('click', function () {
                $('#first-page').attr('style', 'display:none');
                $('#third-page').removeAttr('style');

                //  注意此处，在调用UE.getEditor(id)初始化UEditor时，先从放置编辑器的容器instances中获取，没有实例才实例化一个Editor，
                //  在第一次跳转到编辑器界面时，正常的实例化了一个新的编辑器对象，并放入instances，调用editor.render(id)渲染编辑器的DOM；
                //  第二次初始化时却仅从容器中取到实例：var editor = instances[id]; 直接返回了editor对象，而编辑器的DOM并没有渲染。
                //  造成不刷新页面的话，第一次可以正常加载，点击左侧bar之后无法正常加载的问题
                UE.delEditor('edit-editor');
                articleController.editUe = UE.getEditor('edit-editor', {
                    toolbars: articleController.toolbars,
                    autoHeightEnabled: false,
                    autoFloatEnabled: false,
                    initialFrameHeight: 500,
                    enableAutoSave: false
                });

                //加载文章数据
                var articleId = articleController.datatable.row($(this).parents('tr')).data().id;
                articleController.articleId = articleId;
                $.ajax({
                    url: "/article/info/" + articleId,
                    type: "get",
                    dataType: "json",
                    contentType: "application/json",
                    success: function (data) {
                        var data = data.data;
                        var categoryId = data.categoryId;
                        var title = data.title;
                        var editUe = articleController.editUe;

                        //设置标题
                        $('#article-title-edit').val(data.title);

                        $('#select-edit option[id=' + categoryId + ']').prop('selected', true);

                        //设置简介
                        $('#article-introduce-edit').val(data.introduce);

                        //设置ueditor内容
                        editUe.ready(function () {
                            editUe.setContent(data.fullHtml, false);
                        });
                    }
                })
            })
        },

        saveEdit: function () {
            var ue = articleController.editUe;
            var articleTitle = $('#article-title-edit').val();
            var introduce = $('#article-introduce-edit').val();
            var category = $('#select-edit').find('option:selected').attr('id');

            var jsonObj = {
                id: articleController.articleId,
                title: articleTitle,
                fullHtml: ue.getContent(),
                plainText: ue.getContentTxt(),
                categoryId: category,
                introduce: introduce,
                modifiedDate: new Date()
            };

            if (!articleTitle || !category) {
                layer.msg("分类和标题不能为空", {time: 1000});
            } else {
                $.ajax({
                    url: "/article/saveEdit",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(jsonObj),
                    success: function () {
                        layer.msg("保存成功", {time: 1000})
                    }
                })
            }
        },

        initDelBtn: function () {
            $('.data-del').on('click', function () {
                var articleId = articleController.datatable.row($(this).parents('tr')).data().id;
                layer.confirm("确定删除该文章？", {
                    btn: ["确定", "取消"],
                    btn1: function () {
                        $.ajax({
                            url: "/article/del/" + articleId,
                            type: "get",
                            contentType: "application/json",
                            dataType: "json",
                            success: function () {
                                articleController.datatable.ajax.reload();
                                layer.msg("删除成功", {time: 1000})
                            }
                        })
                    },
                    btn2: function () {

                    }
                })
            })
        },

        initMoveUp: function(){
            $('.data-up').click(function(){
                if(articleController.categoryId){
                    //获得该行数据
                    var categoryId = articleController.categoryId;
                    var currentId = articleController.datatable.row($(this).parents('tr')).data().id;
                    var currentOrder = articleController.datatable.row($(this).parents('tr')).data().sortOrder;

                    $.ajax({
                        url: "/article/moveUp/categoryId/" + categoryId +"/currentId/" + currentId + "/currentOrder/" + currentOrder,
                        type: 'get',
                        dataType: "json",
                        contentType: "application/json",
                        success: function (data) {
                            layer.msg("上移成功", {time: 1000});
                            articleController.datatable.ajax.reload(null, false);
                        },
                        error: function () {
                            layer.msg("后台错误", {time: 1000})
                        }
                    });
                }else{
                    layer.msg("请先选择分类", {time:1000})
                }
            })
        },

        initMoveDown: function(){
            $('.data-down').click(function(){
                if(articleController.categoryId){
                    //获得该行数据
                    var categoryId = articleController.categoryId;
                    var currentId = articleController.datatable.row($(this).parents('tr')).data().id;
                    var currentOrder = articleController.datatable.row($(this).parents('tr')).data().sortOrder;

                    $.ajax({
                        url: "/article/moveDown/categoryId/" + categoryId +"/currentId/" + currentId + "/currentOrder/" + currentOrder,
                        type: 'get',
                        dataType: "json",
                        contentType: "application/json",
                        success: function (data) {
                            layer.msg("下移成功", {time: 1000});
                            articleController.datatable.ajax.reload(null, false);
                        },
                        error: function () {
                            layer.msg("后台错误", {time: 1000})
                        }
                    });
                }else{
                    layer.msg("请先选择分类", {time:1000})
                }
            })
        },

        initOptionChanged: function(){
            $('#category-select').on('change', function(){
                articleController.categoryId = $('#category-select').find('option:selected').attr('id');
                articleController.datatable.ajax.reload();
            });
        },

        //复写UEDITOR的getActionUrl 方法,定义自己的Action
        overwriteGetActionUrl: function(){
            UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
            UE.Editor.prototype.getActionUrl = function(action) {
                if (action == 'uploadimage' || action == 'uploadfile') {
                    return '<%=contextPath %>/ueditor/fileupload/upload.do';
                } else {
                    return this._bkGetActionUrl.call(this, action);
                }
            };
        }

    }

    $(document).ready(function () {
        if(window.isUeditorInited == false){
            articleController.overwriteGetActionUrl();
            window.isUeditorInited = true;
        }
        articleController.init();
    })
</script>

<div class="datapanel" style="min-height: 919px;overflow: hidden">

    <div id="first-page">
        <div class="operatePanel">
            <h2 class="operatePanel-title">文章管理</h2>

            <div class="operatePanel-btnBar">
                <button type="button" class="button-public btn-add" id="add">添加</button>
            </div>

            <div style="margin-top: 15px">
                <label style="margin-left: 10px">分类名称：</label>
                <select id="category-select" style="width: 312px;height: 35px;outline: none"></select>
            </div>
            <div style="margin-top:-20px">
                <table id="table" width=100%"></table>
            </div>
        </div>
    </div>

    <div id="sec-page" style="display: none">
        <div class="operatePanel">
            <h2 class="operatePanel-title">文章管理</h2>

            <div class="operatePanel-btnBar btnbar-btn" >
                <button type="button" class="button-public btn-add" id="add-new">保存</button>
                <button type="button" class="button-public btn-add" id="back">返回</button>
            </div>
            <div class="form-article" style="margin-top: 20px">
                <label class="label-text" >分类：</label>
                <select id="select-add">

                </select>
            </div>
            <div>
                <label class="label-text">标题：</label>
                <input type="text" id="article-title-add"/>
            </div>
            <div>
                <label class="label-text text-indc">简介：</label>
                <textarea id="article-introduce-add" style="resize: none"
                          cols="40" rows="2"/>
            </div>
            <div>
                <label class="label-text">内容：</label>

                <form>
                    <div>
                        <div id="editor"></div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="third-page" style="display: none">
        <div class="operatePanel">
            <h2 class="operatePanel-title">文章管理</h2>

            <div class="operatePanel-btnBar" style="margin-top: 0px">
                <button type="button" class="button-public btn-add" id="edit-save">保存</button>
                <button type="button" class="button-public btn-add" id="edit-back">返回</button>
            </div>
            <div style="margin-top: 20px">
                <label class="label-text">分类：</label>
                <select id="select-edit">

                </select>
            </div>
            <div>
                <label class="label-text">标题：</label>
                <input type="text" id="article-title-edit"/>
            </div>
            <div>
                <label class="label-text text-indc">简介：</label>
                <textarea id="article-introduce-edit" style="resize: none" cols="40" rows="2"/>
            </div>
            <div>
                <label class="label-text">内容：</label>

                <form>
                    <div>
                        <div id="edit-editor"></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>