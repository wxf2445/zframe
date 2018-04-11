zframe-ssi JAVA快速开发框架
===============

本框架基于SpringMVC+Spring+MyBatis3整合，提供了一些快速开发特性，具体如下描述：



###1.针对前端页面快速开发
说明：前台页面采用JSP作为视图
#####1.1提供了jsp页面继承标签，\<z:block\>和\<z:override\>两个自定义标签
在WEB-INF/views目录新建jsp页面public/base.jsp，内容如下
```java
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://zlzkj.com/tags" prefix="z" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<link rel="stylesheet" href="${__static__}/app/app.css?v=1.0">
	<script type="text/javascript" src="${__static__}/app/app.js?v=2.1.1"></script>
	<z:block name="css">
	</z:block>
	<script type="text/javascript">
		var ZLZ = window.ZLZ = {
			"ROOT"   : "${__root__}",
			"URL"    : "${__url__}",
			"STATIC" : "${__static__}"
		}
	</script>
</head>
<body>
<!-- 头部 -->
<div id="header"></div>
<!-- 主体内容 -->
<div id="content">
	<z:block name="content">
		<!-- 可以有默认内容，重写后默认内容将被替换 -->
	</z:block>
</div>
<!-- 头部 -->
<div id="footer"></div>
<!-- 自定义JS添加到尾部 -->
<z:block name="js">
</z:block>
</body>
</html>
```
再新建index/index.jsp，站点首页，来继承public/base.jsp
```java
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://zlzkj.com/tags" prefix="z" %>

<z:override name="content">  
	真正的首页内容
</z:override>
<z:override name="js">
	<script>
		/* 写一些js代码 */
	</script>
</z:override>
<!-- 模板继承写在最下面 -->
<%@ include file="../public/base.jsp" %>
```
#####1.2提供了几个模板路径常量
看上面的base.jsp中的头部css和js路径
```java
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<link rel="stylesheet" href="${__static__}/app/app.css?v=1.0">
	<script type="text/javascript" src="${__static__}/app/app.js?v=2.1.1"></script>
	<z:block name="css">
	</z:block>
	<script type="text/javascript">
		var ZLZ = window.ZLZ = {
			"ROOT"   : "${__root__}",
			"URL"    : "${__url__}",
			"STATIC" : "${__static__}"
		}
	</script>
</head>

//${__static__}代表静态资源跟目录，默认是src/main/webapp/static目录，网络访问路径为http://IP:8080/项目名/static/
//${__root__}代表当前项目的网址根路径，即http://IP:8080/项目名/
//${__url__}代表当前页面的带参数的url
```
#####1.3提供jsp快速生成url的标签${z:u("控制器/方法")}
我们的url映射习惯：类名和方法名都由驼峰变下划线，如...class ActionNode{... function delete ...}映射成url，我们就写@RequestMapping(value={"action_node/delete"})
```java
<a href='${z:u("action_node/detele")}?id=1' />
```
###2.针对后端快速开发
#####2.1提供ajax的json快速返回操作，ajaxReturn方法
使用方式如下：
```java
  @RequestMapping(value={"admin/delete"},method=RequestMethod.POST)
	public String adminDelete(HttpServletResponse response,Integer id) {
		adminService.delete(id);
		return ajaxReturn(response, null,"删除成功",1);
	}
```
ajaxReturn方法源码，重载了2个
```java
/**
	 * ajax返回json数据
	 * @param response
	 * @param data 要返回的数据
	 */
	public static String ajaxReturn(HttpServletResponse response,Object data){
		render(response,JSON.toJSONString(data),"json");
		return null;
	}
	
	
	/**
	 * ajax返回json数据，参数重载
	 * @param response
	 * @param data 要返回的数据
	 * @param info 返回的信息
	 * @param status 返回的状态
	 * @return
	 */
	public static String ajaxReturn(HttpServletResponse response,Object data,String info,int status){
		Map<String, Object> jsonData = new HashMap<String,Object>();
		jsonData.put("data", data);
		jsonData.put("info", info);
		jsonData.put("status", status);
		
		render(response,JSON.toJSONString(jsonData),"json");
		return null;
	}
```
#####2.2提供sql查询链式操作，非常便捷
提供一个SQLBuilder类，一个SQLRunner的服务类，使用非常简单，复杂查询的利器。先贴一段用法介绍
```java
/**
 * sql查询语句生成器，用于简化复杂查询，采用连贯操作方式
 * ;mysql驱动
 * 使用示例:
 * SQLBuilder(User.class).fields("name","sex","dept_name").join(Dept.class,"User.did=Dept.id").where(HashMap).order("name","desc").page(1,10).buildSql();
 * 说明：
 * 		where的用法：
 * 			Map<String,Object> map = new HashMap<String,Object>();
 * 			map.put("name","Simon"); //变成name='Simon'
 * 			map.put("name",new String[]{"like","%Sim%"});
 * 		where(map,"AND");
 * 		where(map,"OR"); //where可以多次使用
 * @author Simon
 */
```
再来一个使用实例
```java
@Service
@Transactional
public class AdminService {

	@Autowired
	private SqlRunner sqlRunner;
	
	public List<Row> findBySQL(){
		
		String sql = SQLBuilder.getSQLBuilder(Admin.class).fields("nickname,login_name,add_time").where("id=#{0}").buildSql();
		return sqlRunner.select(sql,1);
	}
}
```
getSQLBuilder方法传入实体类class，自动解析表名的规则有2个：1是在Admin实体类中写一个@table(name="z_admin")注解，2是在jdbc.propertites中配置数据库表前缀,如"jdbc.prefix=z_",则会自动将Admin类名又驼峰变成下划线，然后加上表前缀。传入ActionNode.class则自动对应表z_action_node，所以你的表名要规范全部采用小写+下划线才行。
