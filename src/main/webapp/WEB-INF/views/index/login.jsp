<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://zlzkj.com/tags" prefix="z" %>
<html>
<head>
    <title>zlzkj</title>
    <link href="${__static__}/css/font-awesome.min.css" rel="stylesheet">
    <link href="${__static__}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${__static__}/css/templatemo-style.css" rel="stylesheet">
    <![endif]-->
    <script type="text/javascript" src="${__static__}/js/jquery-1.9.0.js"></script>

    <script !src="">
        function reloadValidateCode() {
            $("#validateCodeImg").attr("src", "Kaptcha.jpg?" + new Date() + Math.floor(Math.random() * 24));
        }

        /* $.post("{z:u('delete/user')}", {userId: userId}, function (result) {
             if (result.data > 0) {
                 alert("操作成功");
                 //getTest();
                 $(this_).parent().parent().remove();
             }
         }, "json");*/
    </script>
    <style>
        .submit-code-div {
            width: calc(100% - 139px);
        }

        .img-validate-code {
            height: 34px;
            border: 1px solid #ccc;
            border-left: none;
            border-radius: 4px;
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }

        .login-error-div {
            padding: 10px 10px 10px 20px;
            border-radius: 4px;
            margin-bottom: 10px
        }

    </style>
</head>
<body class="light-gray-bg">
<div class="templatemo-content-widget templatemo-login-widget white-bg">
    <header class="text-center">
        <div class="square"></div>
        <h1>致良知科技登录</h1>
    </header>
    <c:if test="${errors != null}">
        <div class="alert-danger login-error-div">
                ${errors == 'submit_code_error'?'验证码错误！':''}
                ${errors == 'account_or_password_error'?'账号或密码错误！':''}
        </div>
    </c:if>
    <%--<%=request.getParameter("errors") %>--%>
    <form action="${z:u('login/login')}" method="post">
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon"><i class="fa fa-user fa-fw"></i></div>
                <input type="text" class="form-control" id="account" placeholder="账号">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon"><i class="fa fa-key fa-fw"></i></div>
                <input type="password" class="form-control" id="password" placeholder="******">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon"><i class="fa fa-check fa-fw"></i></div>
                <div class="submit-code-div">
                    <input type="text" class="form-control" name="submitCode" placeholder="输入验证码">
                </div>
                <a href="javascript:void(0);" onclick="javascript:reloadValidateCode();">
                    <img id="validateCodeImg" class="img-validate-code" src="Kaptcha.jpg"
                         data-toggle="tooltip" data-original-title="点击刷新"/>
                </a>
            </div>
        </div>
        <div class="form-group">
            <input type="checkbox" id="rememberMe" name="rememberMe"/>
            <label for="rememberMe"><span style="font-weight: normal">记住密码</span></label>
        </div>
        <div class="form-group">
            <input type="submit" class="templatemo-blue-button width-100 " value="登录">
        </div>
        <p>还没账号? <strong style="cursor: hand;"><a href="#" class="blue-text"></a>点击注册</strong></p>
    </form>
</div>
<%--<div class="templatemo-content-widget templatemo-login-widget templatemo-register-widget white-bg">
</div>--%>
</body>

</body>
</html>