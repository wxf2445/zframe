<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://zlzkj.com/tags" prefix="z" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>
    <base href="<%=basePath%>">

    <title>WMS仓储管理系统</title>

    <link href="${__static__}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${__static__}/css/styles.css" rel="stylesheet" type="text/css"/>
    <link href="${__static__}/css/skin/jquery-accordion-menu.css" rel="stylesheet" type="text/css"/>
    <link href="${__static__}/css/skin/default.css" rel="stylesheet">
    <link href="${__static__}/css/skin/font-awesome.css" rel="stylesheet">
</head>

<%@ include file="common.jsp" %>
<body>
<%@ include file="header.jsp" %>
<div class="zlzkj_main_content">
    <!-- Left column -->
    <div class="nav">
        <div id="jquery-accordion-menu" class="jquery-accordion-menu blue">
            <div class="jquery-accordion-menu-header" id="form"></div>
            <ul id="demo-list">
                <li><a href="javascript:void(0);"><i class="fa fa-home"></i>首页 </a></li>
                <li><a href="javascript:void(0);"><i class="fa fa-glass"></i>仓库管理 </a>
                    <ul class="submenu">
                        <li><a href="javascript:void(0);">仓库管理 </a></li>
                        <li><a href="javascript:void(0);">货位管理 </a></li>
                    </ul></li>
                <li><a href="javascript:void(0);"><i class="fa fa-file-image-o"></i>入库管理 </a>
                    <ul class="submenu">
                        <li><a href="javascript:void(0);">自动入库管理 </a></li>
                        <li><a href="javascript:void(0);">入库作业 </a></li>
                    </ul></li>
                <li><a href="javascript:void(0);"><i class="fa fa-cog"></i>出库管理 </a>
                    <ul class="submenu">
                        <li><a href="javascript:void(0);">自动出库管理 </a></li>
                        <li><a href="javascript:void(0);">出库作业 </a></li>
                    </ul>
                </li>
                <li><a href="javascript:void(0);"><i class="fa fa-home"></i>库存管理 </a>
                    <ul class="submenu">
                        <li><a href="javascript:void(0);">货物库存查询</a></li>
                        <li><a href="javascript:void(0);">货物库位查询</a></li>
                        <li><a href="javascript:void(0);">库存调整 </a></li>
                        <li><a href="javascript:void(0);">阈值预警 </a></li>
                        <li><a href="javascript:void(0);">库存报表 </a></li>
                    </ul>
                </li>
                <li><a href="javascript:void(0);"><i class="fa fa-user"></i>RFID管理 </a>
                    <ul class="submenu">
                        <li><a href="javascript:void(0);">入库验货</a></li>
                        <li><a href="javascript:void(0);">上架登记 </a></li>
                        <li><a href="javascript:void(0);">整箱登记 </a></li>
                        <li><a href="javascript:void(0);">出库确认 </a></li>
                        <li><a href="javascript:void(0);">盘点确认 </a></li>
                        <li><a href="javascript:void(0);">移库确认 </a></li>
                        <li><a href="javascript:void(0);">补货确认 </a></li>
                    </ul>
                </li>
                <li><a href="javascript:void(0);" tar-href="${z:u('system/log')}"><i class="fa fa-envelope"></i>盘点管理 </a>
                    <ul class="submenu">
                        <li><a href="javascript:void(0);">盘点计划管理</a></li>
                        <li><a href="javascript:void(0);">盘点任务管理</a></li>
                        <li><a href="javascript:void(0);">盘点管理 </a></li>
                        <li><a href="javascript:void(0);">盘点计划 </a></li>
                    </ul>
                </li>
                <li><a href="javascript:void(0);" tar-href="${z:u('system/log')}"><i class="fa fa-envelope"></i>物品管理 </a>
                    <ul class="submenu">
                        <li><a href="javascript:void(0);">权限管理</a></li>
                        <li><a href="javascript:void(0);">设备管理 </a></li>
                    </ul>
                </li>
                <li><a href="javascript:void(0);"><i class="fa fa-suitcase"></i>系统管理 </a>
                    <ul class="submenu">
                        <li><a href="javascript:void(0);">权限管理</a></li>
                        <li><a href="javascript:void(0);">设备管理 </a></li>
                        <li><a href="javascript:void(0);">标签管理 </a></li>
                        <li><a href="javascript:void(0);" tar-href="${z:u('user/index')}">人员管理 </a></li>
                    </ul>
                </li>
                <%--<li><a href="javascript:void(0);"><i class="fa fa-user"></i>About </a></li>--%>
                <%--<li><a href="javascript:void(0);" tar-href="${z:u('system/log')}"><i class="fa fa-envelope"></i>日志管理 </a></li>--%>

            </ul>
            <%--<div class="jquery-accordion-menu-footer">
                Footer
            </div>--%>
        </div>
    </div>
        <!-- Main content -->
        <div class="zlzkj_content light-gray-bg">

            <shiro:user/>！<br>
            <shiro:principal/>！<br>
            <shiro:hasAnyRoles name="SUPER_ADMIN">
                it's superadmin!<br>
            </shiro:hasAnyRoles>
            <shiro:hasAnyRoles name="ADMIN">
                it's admin!<br>
            </shiro:hasAnyRoles>
            <shiro:hasAnyRoles name="ADMIN,SUPER_ADMIN">
                it's admin or superadmin!<br>
            </shiro:hasAnyRoles>
            <shiro:hasPermission name="create_file">
                创建文件<br>
            </shiro:hasPermission>
            <a href="${z:u('logout')}">注销登录</a>
        </div>
    </div>

<div class="modal fade" id="commonModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" style="width:800px;">
        <div class="modal-content">

        </div>
    </div>
</div>
<!-- JS -->
<script src="${__static__}/js/bootstrap.min.js"></script>
<%--<script src='${__static__}/js/noty/jquery.noty.js'></script>
<script src='${__static__}/js/noty/layouts/topCenter.js'></script>
<script src='${__static__}/js/noty/themes/default.js'></script>--%>
<script src='${__static__}/js/skin/jquery-accordion-menu.js'></script>

<script type="text/javascript"
        src="http://api.map.baidu.com/api?v=2.0&ak=6vxe6wNIoVzqpbyAmGxYUkiobfmSyWs8"></script>
<script type="text/javascript">
    $(function () {

        jQuery("#jquery-accordion-menu").jqueryAccordionMenu();

        $(".jquery-accordion-menu li a").off('click').on("click",function(){
            $(".jquery-accordion-menu li a.active").removeClass("active");
            $(this).addClass("active");
            var tar_href = $(this).attr("tar-href");
            $(".zlzkj_content").load(tar_href,function(){

                $("#content").load(tar_href+" #content",function(result){
                    $result = $(result);
                    $result.find("script").appendTo('#content');
                });
            });
        })

        //$(".jquery-accordion-menu").load($(".jquery-accordion-menu li a.active").attr("tar-href"));
    });

    function updateUser() {
        $.ajax({
            type: "POST",
            url: "${z:u('user/detail')}",
            data: {id: '${user.id}'},
            success: function (result) {
                if (result == '') return;
                result = result.result;
                $("#commonModal .modal-content").html($("#userTemplate").tmpl({obj: result}));
                userFormValidate();
            }
        });
    }

    function userFormValidate() {

        $("#commonModal").modal('show');
        $('#user-form').validate(
            {
                submitHandler: function (form) {
                    $(form).ajaxSubmit({
                        dataType: "json",
                        type: "post",
                        success: function (data, s, xhr) {
                            if (data.status == 1) {
                                noty({
                                    dismissQueue: true,
                                    force: true,
                                    timeout: true,
                                    layout: 'topCenter',
                                    theme: 'default',
                                    text: '操作成功',
                                    type: 'success'
                                });

                                $(".username").html(data.data);

                                $("#commonModal").modal('hide');
                                getTable(now_page);
                            }
                        }
                    });
                },
                errorPlacement: function (error, element) {
                    error.replaceAll($(element).next());
                },
                rules: {
                    name: {
                        maxlength: 20,
                        required: true
                    },
                    phone: {
                        maxlength: 20
                    },
                    email: {
                        maxlength: 50
                    },
                    address: {
                        maxlength: 255
                    },
                    memo: {
                        maxlength: 100,
                    }
                },
                messages: {
                    name: {
                        required: "必填！"
                    },
                },
                success: function (label) {
                    label.hide();
                }
            });
    }
</script>

<script type="text/html" id="userTemplate">
    <form id="user-form" method="post" class="form-horizontal" role="form"
          action="${z:u('user/update')}">
        <input name="id" type="hidden" value="{%= obj.id %}">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>
            <h4 class="head">修改个人信息</h4>
        </div>
        <div class="modal-body">
            <div class="form-group col-sm-10 " style="border:none">
                <label class="col-sm-2 control-label">名称：</label>
                <div class="col-sm-4">
                    <input name="name" class="form-control" value="{%= obj.name %}">
                    <label id="name-error" class="control-label"></label>
                </div>

                <label class="col-sm-2 control-label">联系电话：</label>
                <div class="col-sm-4">
                    <input type="text" name="phone" class="form-control" value="{%= obj.phone %}"/>
                    <label id="phone-error" class="control-label"></label>
                </div>
            </div>
            <div class="form-group col-sm-10 " style="border:none">
                <label class="col-sm-2 control-label">邮箱：</label>
                <div class="col-sm-4">
                    <input name="email" class="form-control" value="{%= obj.email %}">
                    <label id="email-error" class="control-label"></label>
                </div>

                <label class="col-sm-2 control-label">住址：</label>
                <div class="col-sm-4">
                    <input type="text" name="address" class="form-control" value="{%= obj.address %}"/>
                    <label id="address-error" class="control-label"></label>
                </div>
            </div>

            <div class="form-group col-sm-10 " style="border:none">
                <label class="col-sm-2 control-label">备注：</label>
                <div class="col-sm-10">
                    <textarea class="form-control" name="memo" style="height:120px;">{%= obj.memo %}</textarea>
                    <label id="memo-error" class="control-label"></label>
                </div>
            </div>
        </div>
        <div style="clear: both;"></div>
        <div class="modal-footer">
            <a class="btn btn-primary confirm btn-sm" onclick="$('#user-form').submit()"><strong><i
                    class="glyphicon glyphicon-ok"></i> <span
                    class="btntext">确定</span></strong></a>
            <a class="btn btn-primary cancel btn-sm"
               data-dismiss="modal"><strong><i class="glyphicon glyphicon-share-alt"></i> <span
                    class="btntext">取消</span></strong></a>
        </div>
    </form>
</script>
</body>
</html>
