<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://zlzkj.com/tags" prefix="z" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html>
<head>
    <title>鼎研WMS仓储管理系统登录</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="${__static__}/css/bootstrap-datetimepicker.css" rel="stylesheet" media="screen">
    <link rel="stylesheet" href="${__static__}/js/fancybox/source/jquery.fancybox.css?v=2.1.2"/>
    <link rel="stylesheet" href="${__static__}/js/fancybox/source/helpers/jquery.fancybox-buttons.css?v=1.0.5"/>
    <link rel="stylesheet" href="${__static__}/js/fancybox/source/helpers/jquery.fancybox-thumbs.css?v=1.0.7"/>

    <link rel="stylesheet" href="${__static__}/css/confirm/jquery-confirm.css"/>
</head>

<body>
<div class="templatemo-content col-1 light-gray-bg">
    <div class="templatemo-content-container">
        <div class="templatemo-content-widget no-padding">
            <div class="zlzkj_item_content table-responsive">
                <div class="modal-header">
                    <div class="text-info"><p>人员管理</p></div>
                </div>
                <div class="col-sm-12">
                    <form id="search-form">
                        <input type="hidden" name="nowPage">
                        <div class="zlzkj_tool_bar">
                            <div class="zlzkj_left_tool_bar">
                                <input placeholder="用户名称" name="keyword">
                                <select name="isLocked" class="status_choose">
                                    <option value="">全部</option>
                                    <option value="0">启用</option>
                                    <option value="1">禁用</option>
                                </select>
                                <a class="searchUser btn btn-primary btm-sm"><i class="fa fa-search fa-fw"></i>搜索</a>
                            </div>
                            <div class="zlzkj_right_tool_bar">
                                <a class="createUser btn btn-primary btm-sm"><i class="fa fa-plus fa-fw"></i>添加</a>
                                <a class="batchDeleteUser btn btn-danger btm-sm"><i
                                        class="fa fa-trash-o fa-fw"></i>删除</a>
                            </div>
                        </div>
                    </form>
                    <div id="user-view">
                        <form class="ids-form">
                            <table class="zlzkj_table table table-striped table-hover"><%--table-bordered--%>
                                <thead>
                                <tr>
                                    <th width="5%"><a href="javascript:void(0)" class="checkall">全选</a></th>
                                    <th width="5%">头像</th>
                                    <th width="10%">用户名称</th>
                                    <th width="10%">角色</th>
                                    <th width="10%">电话</th>
                                    <%--<th width="10%">邮箱</th>--%>
                                    <th width="10%">创建时间</th>
                                    <th width="5%">状态</th>
                                    <th width="10%">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="v" items="${pageView.page.items}">
                                    <tr data-id="${v.id}" data-name="${v.name}">
                                        <td><input type="checkbox" name="id" value="${v.id}"></td>
                                        <td>
                                            <a class="fancybox" data-fancybox-group="button"
                                               href="${z:u('file/openfile')}?filepath=${v.avatar==null?'default/default.jpg':v.avatar}">
                                                <img width="30" height="30" src="${z:u('file/openfile')}?filepath=${v.avatar==null?'default/default.jpg':v.avatar}"
                                                     onerror="this.src='${__static__}/images/default/default.jpg';
                                                     this.parentNode.href='${__static__}/images/default/default.jpg'"/>
                                            </a>
                                        </td>
                                        <td>${v.name}</td>
                                        <td>${v.role_name}</td>
                                        <td>${v.phone}</td>
                                            <%--<td>${v.email}</td>--%>
                                        <td><fmt:formatDate value="${v.created_time}" pattern="yyyy/M/dHH:mm"/></td>
                                        <td>
                                            <c:if test="${v.is_locked == 0}">
                                                <span class="tag-success">启用</span>
                                            </c:if>
                                            <c:if test="${v.is_locked == 1}">
                                                <span class="tag-danger">禁用</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <input type="button" class="btn btn-default btn-sm editUser" value="编辑">
                                            <input type="button" class="btn btn-default btn-sm deleteUser" value="删除">
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${pageView.page.items.size() == 0}">
                                    <tr>
                                        <td colspan="8" align="center">暂无数据</td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                        </form>

                        <c:set var="page" value="${pageView.getPage() }"></c:set>
                        <div id="page-view">
                            <nav class="zlzkj_pagination">
                                <ul class="pagination">
                                    <c:choose>
                                        <c:when test="${page.currentPage() == page.firstPage()}">
                                            <li class="disabled"><a href="javascript:void(0);"><span>上一页</span></a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li>
                                                <a href="javascript:refreshTable('${page.previousPage()}')"><span>上一页</span></a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:forEach var="p" items="${pageView.showPages()}" varStatus="s">
                                        <c:choose>
                                            <c:when test="${p == page.currentPage()}">
                                                <li class="active"><a href="javascript:void(0);">${p}</a></li>
                                            </c:when>
                                            <c:when test="${p == 0}">
                                                <li><a>...</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li>
                                                    <a href="javascript:refreshTable('${p}')"><span>${p}</span></a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${page.currentPage() == page.lastPage()}">
                                            <li class="disabled"><a href="javascript:void(0);"><span>下一页</span></a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li>
                                                <a href="javascript:refreshTable('${page.nextPage()}')"><span>下一页</span></a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div id="reportview"></div>

        <footer class="zlzkj_footer">
            <p>Copyright &copy; HangZhou DingYan Tech
                | 杭州鼎研科技有限公司版权所有</p>
        </footer>
    </div>
</div>
<!-- scripts -->
<script src="${__static__}/js/fancybox/lib/jquery-1.8.2.min.js"></script>
<script src="${__static__}/js/jquery.tmpl.js"></script>
<script src="${__static__}/js/jquery.validate.js"></script>
<script src="${__static__}/js/bootstrap.min.js"></script>
<%--<script src="${__static__}/js/bootstrap-datetimepicker.js"></script>--%>
<script src="${__static__}/js/jquery-form.js"></script>


<script src='${__static__}/js/noty/jquery.noty.js'></script>
<script src='${__static__}/js/noty/layouts/topCenter.js'></script>
<script src='${__static__}/js/noty/themes/default.js'></script>

<script src="${__static__}/js/confirm/jquery-confirm.js"></script>
<%-- image show --%>
<script src="${__static__}/js/fancybox/source/jquery.fancybox.js?v=2.1.3"></script>
<script src="${__static__}/js/fancybox/source/helpers/jquery.fancybox-buttons.js?v=1.0.5"></script>
<script src="${__static__}/js/fancybox/source/helpers/jquery.fancybox-thumbs.js?v=1.0.7"></script>
<script src="${__static__}/js/fancybox/source/helpers/jquery.fancybox-media.js?v=1.0.5"></script>

<script type="text/javascript">

    $(document).ready(function () {
        //图片预览
        $('.fancybox').fancybox();

        //添加点击事件
        initOperation();

        //header 用户下拉重新
        $('.dropdown-toggle').dropdown();


        $(".searchUser").off("click").on("click", function () {
            refreshTable(0);
        });
    });

    //刷新数据
    function refreshTable(nowPage) {
        if (nowPage != 0)
            $("#search-form [name=nowPage]").val(nowPage);
        $.ajax({
            type: "POST",
            url: "${z:u('user/list')}",
            data: $("#search-form").serialize(),
            success: function (result) {
                $.each(result.pageView.page.items, function (index, content) {
                    if (content == null) {
                        result.page.items = [];
                        return false;
                    }
                    content.created_time = new Date(content.created_time).Format("yyyy-MM-dd HH:mm");// HH:mm:ss
                });
                $("#user-view").html($("#userViewTemplate").tmpl(result.pageView));
                initOperation();
            }
        });
    }

    function initOperation() {
        $(".createUser").off("click").on("click", function () {
            $.ajax({
                type: "POST",
                url: "${z:u('user/toCreate')}",
                data: {},
                success: function (result) {
                    var obj = {id: 0, email: '', phone: '', address: '', description: ''};
                    //console.log(obj)
                    $("#commonModal .modal-content").html($("#userTemplate").tmpl({obj: obj, roles: result.roles}));
                    userFormValidate();
                }
            });
        });

        $(".editUser").off("click").on("click", function () {
            $.ajax({
                type: "POST",
                url: "${z:u('user/toEdit')}",
                data: {id: $(this).closest("tr").data("id")},
                success: function (result) {
                    $("#commonModal .modal-content").html($("#userTemplate").tmpl(result));
                    userFormValidate();
                }
            });
        });

        $(".deleteUser").off("click").on("click", function () {
            var id = $(this).closest("tr").data("id");
            $.confirm({
                title: '系统提示',
                content: "确认要删除'<font color='#f00'>" + $(this).closest("tr").data("name") + "</font>'吗？",
                buttons: {
                    ok: {
                        text: '确认',
                        btnClass: 'btn-primary',
                        action: function () {
                            $.post("${z:u('user/delete')}", {id: id}, function (data, textStatus, xhr) {
                                if (data > 0) {
                                    refreshTable(0);
                                    noty({
                                        dismissQueue: true,
                                        force: true,
                                        timeout: 1000,
                                        layout: 'topCenter',
                                        theme: 'default',
                                        text: '删除成功',
                                        type: 'success'
                                    });
                                } else {
                                    noty({
                                        dismissQueue: true,
                                        force: true,
                                        timeout: 1000,
                                        layout: 'topCenter',
                                        theme: 'default',
                                        text: '删除失败',
                                        type: 'error'
                                    });
                                }
                            });
                        }
                    },
                    cancel: {
                        text: '取消',
                        btnClass: 'btn-primary',
                        action: function () {
                            // button action.
                        }
                    },
                }
            });
        });

        $(".batchDeleteUser").off("click").on("click", function () {
            var checkbox = $("input[type=checkbox]:checked");
            if (checkbox.length == 0) return;
            var content = "";
            for (var i = 0; i < checkbox.length; i++) {
                content += "'<font color='#f00'>" + checkbox.eq(i).closest("tr").data("name") + "</font>'&nbsp;";
            }
            $.confirm({
                title: '系统提示',
                content: "确认要删除" + content + ",这<font color='#f00'>" + checkbox.length + "</font>条数据吗？",
                buttons: {
                    ok: {
                        text: '确认',
                        btnClass: 'btn-primary',
                        action: function () {
                            $.post("${z:u('user/delete')}", $(".ids-form").serialize(), function (data, textStatus, xhr) {
                                if (data > 0) {
                                    refreshTable(0);
                                    noty({
                                        dismissQueue: true,
                                        force: true,
                                        timeout: 1000,
                                        layout: 'topCenter',
                                        theme: 'default',
                                        text: '删除成功',
                                        type: 'success'
                                    });
                                } else {
                                    noty({
                                        dismissQueue: true,
                                        force: true,
                                        timeout: 1000,
                                        layout: 'topCenter',
                                        theme: 'default',
                                        text: '删除失败',
                                        type: 'error'
                                    });
                                }
                            });
                        }
                    },
                    cancel: {
                        text: '取消',
                        btnClass: 'btn-primary',
                        action: function () {
                            // button action.
                        }
                    },
                }
            });
        });
    }

    //用户表单验证
    function userFormValidate() {
        $("#commonModal").modal('show');
        $('#user-form').validate(
            {
                submitHandler: function (form) {
                    $(".confirm").button('loading');
                    $(form).ajaxSubmit({
                        dataType: "json",
                        type: "post",
                        success: function (data, s, xhr) {
                            if (data == 1) {
                                refreshTable(0);
                                $(".confirm").button('reset');
                                $("#commonModal").modal('hide');
                            }
                        }
                    });
                },
                errorPlacement: function (error, element) {
                    error.replaceAll($(element).next());
                },
                rules: {
                    name: {
                        maxlength: 30,
                        required: true
                    },
                    username: {
                        maxlength: 30,
                        required: true,
                        remote: {
                            url: '${z:u('user/checkUsername')}',
                            type: 'post',
                            dataType: 'json',
                            data: {
                                name: function () {
                                    return $("[name='username']").val();
                                },
                                originalname: ""
                            }
                        }
                    },
                    password: {
                        maxlength: 30,
                        required: true
                    },
                    roleId: {
                        required: true
                    },
                    phone: {
                        maxlength: 100,
                        required: true,
                        confirmPhone: true
                    },
                    email: {
                        email: true
                    },
                    description: {
                        maxlength: 100
                    }
                },
                messages: {
                    name: {
                        required: "必填！"
                    },
                    username: {
                        required: "必填！",
                        remote: "已存在！"
                    },
                    password: {
                        required: "必填！"
                    },
                    roleId: {
                        required: "请选择！"
                    },
                    phone: {
                        required: "必填！"
                    },
                    email: {
                        email: "邮箱格式错误！"
                    }
                },
                success: function (label) {
                    label.hide();
                }
            });

        /*$('[name=startTime]').datetimepicker({
            format: 'yyyy-mm-dd',
            language: 'zh',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 3,
            forceParse: 0
        });*/
    }

</script>

<script type="text/html" id="userTemplate">
    <form id="user-form" method="post" class="form-horizontal" role="form"
          action="{%= obj.id == 0 ? '${z:u('user/create')}':'${z:u('user/update')}'%}" autocomplete="off"
    >
        <input name="id" type="hidden" value="{%= obj.id %}">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>
            {%if obj.id == 0 %}
            <h4 class="head">添加用户</h4>
            {%else%}
            <h4 class="head">修改个人信息</h4>
            {%/if%}
        </div>
        <div class="modal-body">
            <div class="form-group col-sm-12 ">
                <label class="col-sm-2 control-label">名称：</label>
                <div class="col-sm-4">
                    <input name="name" class="form-control" value="{%= obj.name %}">
                    <label id="name-error" class="control-label"></label>
                </div>

                <label class="col-sm-2 control-label">角色：</label>
                <div class="col-sm-4">
                    <select class="form-control" name="roleId">
                        {%each roles %}
                        <option value="{%= id %}">{%= name%}</option>
                        {%/each%}
                    </select>
                    <label id="roleId-error" class="control-label"></label>
                </div>
            </div>
            {%if obj.id == 0 %}
            <div class="form-group col-sm-12 ">

                <label class="col-sm-2 control-label">账号：</label>
                <div class="col-sm-4">
                    <input type="hidden">
                    <input name="username" type="text" class="form-control" autocomplete="off"/>
                    <label id="username-error" class="control-label"></label>
                </div>
                <label class="col-sm-2 control-label">密码：</label>
                <div class="col-sm-4">
                    <input type="hidden">
                    <input name="password" type="text" class="form-control" onfocus="this.type='password'"
                           autocomplete="off">
                    <label id="password-error" class="control-label"></label>
                </div>
            </div>
            {%/if%}
            <div class="form-group col-sm-12 ">

                <label class="col-sm-2 control-label">电话：</label>
                <div class="col-sm-4">
                    <input type="text" name="phone" class="form-control" value="{%= obj.phone %}"/>
                    <label id="phone-error" class="control-label"></label>
                </div>
                <label class="col-sm-2 control-label">邮箱：</label>
                <div class="col-sm-4">
                    <input name="email" class="form-control" value="{%= obj.email %}">
                    <label id="email-error" class="control-label"></label>
                </div>
            </div>
            <div class="form-group col-sm-12 ">

                <label class="col-sm-2 control-label">住址：</label>
                <div class="col-sm-4">
                    <input type="text" name="address" class="form-control" value="{%= obj.address %}"/>
                    <label id="address-error" class="control-label"></label>
                </div>
            </div>

            <div class="form-group col-sm-12 ">
                <label class="col-sm-2 control-label">备注：</label>
                <div class="col-sm-10">
                    <textarea class="form-control" name="description"
                              style="height:120px;">{%= obj.description %}</textarea>
                    <label id="description-error" class="control-label"></label>
                </div>
            </div>
        </div>
        <div style="clear: both;"></div>
        <div class="modal-footer">
            <input type="submit" class="btn btn-primary confirm btn-sm" data-loading-text="加载中.." value="提交"/>
            <a class="btn btn-primary common-modal-cancel btn-sm">取消</a>
        </div>
    </form>
</script>

<script type="text/html" id="userViewTemplate">
    <form class="ids-form">

        <table class="zlzkj_table table table-striped table-hover" style="margin-top: 5px"><%--table-bordered--%>
            <thead>
            <tr>
                <th width="5%"><a href="javascript:void(0)" class="checkall">全选</a></th>
                <th width="5%">头像</th>
                <th width="10%">用户名称</th>
                <th width="10%">角色</th>
                <th width="10%">电话</th>
                <%--<th width="10%">邮箱</th>--%>
                <th width="10%">创建时间</th>
                <th width="5%">状态</th>
                <th width="18%">操作</th>
            </tr>
            </thead>
            <tbody>
            {%each(i,v) page.items %}
            <tr data-id="{%= v.id %}" data-name="{%= v.name%}">
                <td><input type="checkbox" name="id" value="{%= v.id %}"></td>
                <td>
                    <a class="fancybox" data-fancybox-group="button"
                       href="${z:u('file/openfile')}?filepath={%= v.avatar==null?'default/default.jpg':''%}">
                        <img width="30" height="30" src="${z:u('file/openfile')}?filepath={%= v.avatar==null?'default/default.jpg':''%}"
                             onerror="this.src='${__static__}/images/default/default.jpg';this.parentNode.href='${__static__}/images/default/default.jpg'"/>
                    </a>
                </td>
                <td>{%= v.name%}</td>
                <td>{%= role_name%}</td>
                <td>{%= v.phone%}</td>
                <td>{%= v.created_time%}</td>
                <td>
                    {%if v.is_locked == 0%}
                    <span class="tag-success">启用</span>
                    {%elseif v.is_locked == 1%}
                    <span class="tag-warning">禁用</span>
                    {%/if%}
                </td>
                <td>
                    <input type="button" class="btn btn-default btn-sm editUser" value="编辑">
                    <input type="button" class="btn btn-default btn-sm deleteUser" value="删除">
                </td>
            </tr>
            {%/each%}
            {%if page.items.length == 0%}
            <tr>
                <td colspan="8" align="center">暂无数据</td>
            </tr>
            {%/if%}
            </tbody>
        </table>
    </form>

    {%if page.totalPage != 1 %}
    <nav class="zlzkj_pagination">
        <ul class="pagination">
            {%if page.pageNum == 1 %}
            <li class="disabled"><a href="javascript:void(0);">上一页</a></li>
            {%else%}
            <li><a href="javascript:void(0);" onclick="refreshTable('{%= (page.pageNum-1)%}')"><span>上一页</span></a></li>
            {%/if%}

            {%each(i,v) showPages %}
            {%if v == page.pageNum %}
            <li class="active"><a href="javascript:void(0);">{%= v %}</a></li>
            {%elseif v == 0 %}
            <li><a>...</a></li>
            {%else%}
            <li><a href="javascript:void(0);" onclick="refreshTable('{%= v %}')"><span>{%= v %}</span></a></li>
            {%/if%}
            {%/each%}

            {%if page.pageNum == page.totalPage %}
            <li class="disabled"><a href="javascript:void(0);">下一页</a></li>
            {%else%}
            <li><a href="javascript:void(0);" onclick="refreshTable('{%= (page.pageNum+1)%}')"><span>下一页</span></a></li>
            {%/if%}
        </ul>
    </nav>
    {%/if%}
</script>
</body>
</html>