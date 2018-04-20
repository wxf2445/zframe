<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://zlzkj.com/tags" prefix="z" %>
<html>
<head>
    <title>common</title>

    <script src="${__static__}/js/fancybox/lib/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="${__static__}/js/common/common.js"></script>
    <%-- button loading--%>
    <script src="${__static__}/js/button/bootstrap-tooltip.js"></script>
    <script src="${__static__}/js/button/bootstrap-popover.js"></script>
    <script src="${__static__}/js/button/bootstrap-button.js"></script>

</head>
<style>
    body {
        margin: 0 auto;
        padding: 0;
        font-size: 12px;
        color: #404040;
        font-family: "Lucida Grande", Verdana, Lucida, Helvetica, Arial, "寰蒋闆呴粦" ,sans-serif;
    }
</style>
<script>
    /*$.ajaxSetup({
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
                console.log(e);
            }
        }
    });*/
    $(document).on("click",".checkall",function () {
        var all_checkbox = $("input[type=checkbox]");
        for (i = 0; i < all_checkbox.length; i++) {
            if (!all_checkbox.eq(i).prop("checked")) {
                $("input[type=checkbox]").prop("checked", true);
                return;
            }
        }
        $("input[type=checkbox]").prop("checked",false);
    })

    $(document).on("change","[name=file]",function () {
        var preview = document.getElementById("avatar_img");
        var file  = document.querySelector('input[type=file]').files[0];
        var reader = new FileReader();
        reader.onloadend = function () {
            preview.src = reader.result;
        }
        if (file) {
            reader.readAsDataURL(file);
        } else {
            preview.src = "";
        }
    })
</script>


<div class="modal fade" id="commonModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" style="width:700px;">
        <div class="modal-content">

        </div>
    </div>
</div>
<body>
</body>
</html>
