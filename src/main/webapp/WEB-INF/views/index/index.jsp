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

    <title>My JSP 'index.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->

</head>

<body>
    <shiro:user/>！<br>
    <shiro:principal/>！<br>
    This is my JSP page. <br>
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
