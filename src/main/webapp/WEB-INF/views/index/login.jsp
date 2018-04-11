<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://zlzkj.com/tags" prefix="z" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="${__static__}/js/jquery-1.9.0.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>test</title>
	<script type="text/javascript">
		var ZLZ = window.ZLZ = {
			"ROOT"   : "${__root__}",
			"URL"    : "${__url__}",
			"STATIC" : "${__static__}"
		}
function getTest(){
	$("#div").html("");
	$.post("${z:u('test/test2')}",{},function(result){
		$.each(result.all_user,function(index,content){
			var div_ = "<div userId="+content.id+" >"+
							"<div>"+
								"id :"+content.id+"&nbsp;&nbsp;name: "+content.username+
							"</div>"+
							"<div><input type=\"button\" onclick=\"deleteUser(this,"+content.id+")\" value=\"删除\" /></div>"+
						"</div>";
			$("#div").append(div_);
		});
	},"json");
}
function deleteUser(this_,userId){
 	if(confirm("确定删除这条数据吗？")){
		 $.post("${z:u('delete/user')}",{userId:userId},function(result){
				if(result.data>0){
					alert("操作成功");
					//getTest();
					$(this_).parent().parent().remove();
				}
		},"json");
	 }
}		
function getLastUserId(){
	//alert($("#div").find("div:last").attr("userId"));
	alert($("#div").children("div:last").attr("userId"));
}
/* $(document).on("click", "input[type=button]", function() {  
	alert($(this).parent().parent().attr("userId"));
    //...  
});   */
	</script>
	<style type="text/css">
	#div {height:400px;width:800px;border:1px #000 solid}
	#div div{height:35px;width:798px;float:left}
	#div div div{height:35px;width:390px}
	</style>
</head>
<body>
<!-- 	<div id="div">
	</div> -->
<!-- 	<button onclick=" getTest()">获取</button>
	<button onclick=" getLastUserId()">获取最后一条Id</button> -->
	<form action="${z:u('login/login')}" method="post">
	<input type="text" name="account">
	<input type="password" name="password">
	<input type="submit" value="submit">
	</form>
</body>
</html>