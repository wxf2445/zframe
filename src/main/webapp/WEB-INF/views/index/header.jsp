<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://zlzkj.com/tags" prefix="z" %>
<html>
<head>
    <title>鼎研WMS仓储管理系统</title>
</head>
<body class="light-gray-bg">
<div class="zlzkj_header">
    <div class="logo_name">
        <div class="top_logo">
            <img src="${__static__}/images/skin/small_logo.png" width="30" height="30" style="margin-top: 10px">
            <div class="company_name">鼎力信安&nbsp;|&nbsp;WMS仓储管理系统</div>
        </div>
    </div>
    <div id="user_info">
        <div class="user_name">
            <div class="profile-photo-container">
                <div class="dropdown">
                    <a class="dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown"><span
                            class="username"><shiro:principal/></span>
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" style="margin-left: -10px">
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="javascript:updateUser()">修改个人信息</a>
                        </li>
                        <li role="presentation" class="divider"></li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="${z:u('logout')}">注销</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="user_avatar">
            <img src="${z:u('file/openfile')}?filepath=${CUR_USER.avatar==null?'default/default.jpg':CUR_USER.avatar}" onerror="this.src='${__static__}/images/default/default.jpg'"/>
        </div>
        <div style="clear:both; float:none; height:0; overflow:hidden"></div>
    </div>
    <div class="title_date"><fmt:formatDate value="${now}" pattern="yyyy年M月d日 E"/></div>
</div>

</body>

<script src="${__static__}/js/jquery.tmpl.js"></script>
<script src="${__static__}/js/jquery.validate.js"></script>
<script src="${__static__}/js/jquery-form.js"></script>
<script src='${__static__}/js/noty/jquery.noty.js'></script>
<script src='${__static__}/js/noty/layouts/topCenter.js'></script>
<script src='${__static__}/js/noty/themes/default.js'></script>
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
            url: "${z:u('user/toEdit')}",
            data: {id: '${CUR_USER.id}'},
            success: function (result) {
                $("#commonModal .modal-content").html($("#curUserTemplate").tmpl(result));
                userFormValidate();
            }
        });
    }


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
                            if (data === 1) {
                                noty({
                                    dismissQueue: true,
                                    force: true,
                                    timeout: 1000,
                                    layout: 'topCenter',
                                    theme: 'default',
                                    text: '保存成功',
                                    type: 'success'
                                });
                                $(".confirm").button('reset');
                                $("#commonModal").modal('hide');
                            }else{
                                if(data != 1){
                                    noty({
                                        dismissQueue: true,
                                        force: true,
                                        timeout: 1000,
                                        layout: 'topCenter',
                                        theme: 'default',
                                        text: '保存失败',
                                        type: 'error',
                                        onClose: function () {
                                            $(".confirm").button('reset');
                                            $("#commonModal").modal('hide');
                                        }
                                    });
                                }
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
    }
</script>

<script type="text/html" id="curUserTemplate">
    <form id="user-form" method="post" class="form-horizontal" role="form"
          action="${z:u('user/updateImage')}" autocomplete="off"
    >
        <input name="id" type="hidden" value="{%= obj.id %}">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>
            <h4 class="head">修改个人信息</h4>
        </div>
        <div class="modal-body">
            <div class="form-group col-sm-12 ">
                <label class="col-sm-2 control-label">头像：</label>
                <div class="col-sm-4">
                    <img id="avatar_img" width="100" height="100" src="${__static__}/images/default/default.jpg" onclick="$('[name=file]').click()">
                    <input name="file" style="display: none" type="file" class="form-control">
                </div>
            </div>
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
</html>