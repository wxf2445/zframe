<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://zlzkj.com/tags" prefix="z" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>
    <base href="<%=basePath%>">

    <title>WMS</title>

</head>
<%@ include file="common.jsp"%>
<script>
    $.post("${z:u('test/test2')}", {}, function (result) {
        console.log(result);
    }, "json");
</script>

<body>
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
</body>
</html>
