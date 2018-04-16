<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://zlzkj.com/tags" prefix="z" %>
<html>
<head>
    <base href="<%=basePath%>">
    <title>common</title>
    <script type="text/javascript" src="${__static__}/js/jquery-latest.js"></script>
    <script type="text/javascript" src="${__static__}/js/common/common.js"></script>

</head>
<style>
    body {
        margin: 0 auto;
        padding: 0;
        font-size: 14px;
        color: #666;
        font-family: "Lucida Grande", Verdana, Lucida, Helvetica, Arial, "寰蒋闆呴粦" ,sans-serif;
    }
</style>
<script>
    $.ajaxSetup({
        contentType:"application/x-www-form-urlencoded;charset=utf-8",
        complete:function(XMLHttpRequest,textStatus){

            //通过XMLHttpRequest取得响应结果
            var res = XMLHttpRequest.responseText;
            try{
                var jsonData = JSON.parse(res);
                if(jsonData.status === -1){
                    //如果超时就处理 ，指定要跳转的页面(比如登陆页)
                    if(jsonData.data.hasNoPermission == true){
                        alert("无权限该操作");
                    }
                    //window.location.replace("/login/index.php");
                }else{
                    //正常情况就不统一处理了
                }
            }catch(e){
            }
        }
    });
</script>


<div class="modal fade" id="commonModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" style="width:800px;">
        <div class="modal-content">

        </div>
    </div>
</div>
<body>
</body>
</html>
