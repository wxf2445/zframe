<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://zlzkj.com/tags" prefix="z" %>


<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="${__static__}/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">

</head>

<body>
<div class="templatemo-content col-1 light-gray-bg">
    <div class="templatemo-content-container">
        <div class="templatemo-content-widget no-padding">
            <div class="panel panel-default table-responsive">
                <div class="modal-header" style="border:none">
                    <div class="text-info" style="font-size: 18px"><p>发布的任务</p></div>
                </div>
                <div class="col-sm-12">
                    <a class="createMission btn btn-primary btm-sm"><i class="fa fa-plus fa-fw"></i>添加</a>
                    <div id="missionview"></div>
                    <div id="pageview" style="margin-top: 5px"></div>
                </div>
            </div>

        </div>
        <div id="reportview"></div>

        <footer class="text-right">
            <p>Copyright &copy; HangZhou DingYan Tech
                | 杭州鼎研科技科技有限公司版权所有</p>
        </footer>
    </div>
</div>


<div class="modal fade" id="commonModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" style="width:800px;">
        <div class="modal-content">

        </div>
    </div>
</div>

<!-- scripts -->
<script src="${__static__}/js/jquery-latest.js"></script>
<script src="${__static__}/js/jquery.tmpl.js"></script>
<script src="${__static__}/js/bootstrap.min.js"></script>
<script src="${__static__}/js/bootstrap-datetimepicker.js"></script>

<script type="text/javascript">

    $(".createMission").off("click").on("click", function () {
        /*$.ajax({
            type: "POST",
            url: "${z:u('mission/addChildren')}",
            data: {id: $(this).closest("tr").attr("missionid")},
            success: function (result) {
                if (result == '') return;
                if (result.obj.startTime != null) result.obj.startTime = new Date(result.obj.startTime).Format("yyyy-MM-dd");
                if (result.obj.endTime != null) result.obj.endTime = new Date(result.obj.endTime).Format("yyyy-MM-dd");
                $("#commonModal .modal-content").html($("#missionTemplate").tmpl(result));
                missionFormValidate();
            }
        });*/
        $("#commonModal .modal-content").html($("#missionTemplate").tmpl());
        $("#commonModal").modal("show");
    });

    function missionFormValidate() {
        $("#commonModal").modal('show');
        $('#cur-form').validate(
            {
                submitHandler: function (form) {
                    if ($("[name=startTime]").valid() && $("[name=endTime]").valid()) {
                        $(form).ajaxSubmit({
                            dataType: "json",
                            type: "post",
                            success: function (data, s, xhr) {
                                if (data == 1) {
                                    noty({
                                        dismissQueue: true,
                                        force: true,
                                        timeout: true,
                                        layout: 'topCenter',
                                        theme: 'default',
                                        text: '操作成功',
                                        type: 'success'
                                    });

                                    $("#commonModal").modal('hide');
                                    getMission(now_mission_page);
                                    getTable(now_page);
                                }
                            }
                        });
                    }
                },
                errorPlacement: function (error, element) {
                    error.replaceAll($(element).next());
                },
                rules: {
                    title: {
                        maxlength: 30,
                        required: true
                    },
                    content: {
                        maxlength: 100,
                        required: true
                    },
                    startTime: {
                        required: true
                    },
                    endTime: {
                        required: true
                    },
                    memo: {
                        maxlength: 100
                    }
                },
                messages: {
                    title: {
                        required: "必填！"
                    },
                    content: {
                        required: "必填！"
                    },
                    startTime: {
                        required: "必填！"
                    },
                    endTime: {
                        required: "必填！"
                    }
                },
                success: function (label) {
                    label.hide();
                }
            });

        $('[name=startTime]').datetimepicker({
            format: 'yyyy-mm-dd',
            language: 'zh',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 3,
            forceParse: 0
        });

        $('[name=endTime]').datetimepicker({
            format: 'yyyy-mm-dd',
            language: 'zh',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 3,
            forceParse: 0
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

<script type="text/html" id="pageTemplate">
    {%if page.totalPage != 1 %}
    <nav class="center">
        <ul class="pagination">
            {%if page.pageNum == 1 %}
            <li class="disabled"><a href="#">上一页</a></li>
            {%else%}
            <li><a href="#" onclick="getTable('{%= (page.pageNum-1)%}')"><span>上一页</span></a></li>
            {%/if%}

            {%each(i,v) showPages %}
            {%if v == page.pageNum %}
            <li class="active"><a href="#">{%= v %}</a></li>
            {%elseif v == 0 %}
            <li><a>...</a></li>
            {%else%}
            <li><a href="#" onclick="getTable('{%= v %}')"><span>{%= v %}</span></a></li>
            {%/if%}
            {%/each%}

            {%if page.pageNum == page.totalPage %}
            <li class="disabled"><a href="#">下一页</a></li>
            {%else%}
            <li><a href="#" onclick="getTable('{%= (page.pageNum+1)%}')"><span>下一页</span></a></li>
            {%/if%}
        </ul>
    </nav>
    {%/if%}
</script>
<script type="text/html" id="missionViewTemplate">
    <table class="table table-striped table-bordered" style="margin-top: 5px">
        <thead>
        <tr>
            <td width="16%">任务标题</td>
            <td width="20%">任务内容</td>
            <td width="11%">执行部门</td>
            <td width="11%">发布时间</td>
            <td width="11%">截止时间</td>
            <td width="7%">
                <select class="status_choose">
                    <option value="0" {%=status=='0'?'selected':''%}>进行中</option>
                    <option value="1" {%=status=='1'?'selected':''%}>已结束</option>
                    <option value="-1" {%=status=='-1'?'selected':''%}>已隐藏</option>
                </select>
            </td>
            <td width="18%">操作</td>
        </tr>
        </thead>
        <tbody>
        {%each(i,v) items %}
        <tr missionid="{%= v.id %}" missiontitle="{%= v.title%}">
            <td>{%= v.title%}</td>
            <td>{%= v.content%}</td>
            <td>{%each departments%}
                <div class="alert-info" style="float: left;margin-left: 10px;margin-top: 3px">{%= name %}</div> &nbsp;{%/each%}
            </td>
            <td>{%= v.startTime%}</td>
            <td>{%= v.endTime%}</td>
            <td>{%if v.status == 0%}
                <span class="alert-success">进行中</span>
                {%elseif v.status == 1%}
                <span class="alert-warning">
                        已结束
                    </span>
                {%elseif v.status == -1%}
                <span class="default-color0">
                        已隐藏
                    </span>
                {%/if%}
            </td>
            <td>
                {%if v.status == 0%}
                <button class="btn btn-default btn-sm edit"><i class="fa fa-edit fa-fw"></i>编辑</button>
                <button class="btn btn-danger btn-sm status" data-status="1"><i class="fa fa-stop fa-fw"></i>结束</button>
                {%elseif v.status == 1%}
                <button class="btn btn-danger btn-sm status" data-status="-1"><i class="fa fa-trash fa-fw"></i>隐藏
                </button>
                {%elseif v.status == -1%}
                <button class="btn btn-default btn-sm status" data-status="-1"><i class="fa fa-circle-o fa-fw"></i>恢复
                </button>
                <button class="btn btn-danger btn-sm delete"><i class="fa fa-trash fa-fw"></i>删除</button>
                {%/if%}
                <button class="btn btn-default btn-sm report" data-loading-text="加载中..."><i
                        class="fa fa-pie-chart fa-fw"></i>报表
                </button>
            </td>
        </tr>
        {%/each%}
        {%if items.length == 0%}
        <tr>
            <td colspan="7" align="center">暂无数据</td>
        </tr>
        {%/if%}
        </tbody>
    </table>
    <br>
</script>
</body>
</html>