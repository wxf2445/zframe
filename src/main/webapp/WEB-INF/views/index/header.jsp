<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://zlzkj.com/tags" prefix="z" %>
<html>
<head>
    <title>zlzkj</title>
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
            <img src="https://gss0.bdstatic.com/70cFsj3f_gcX8t7mm9GUKT-xh_/avatar/100/r7s1g1.gif"/>
        </div>
        <div style="clear:both; float:none; height:0; overflow:hidden"></div>
    </div>
    <div class="title_date"><fmt:formatDate value="${now}" pattern="yyyy年M月d日 E"/></div>
</div>
</body>
</html>