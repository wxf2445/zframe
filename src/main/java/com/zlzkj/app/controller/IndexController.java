package com.zlzkj.app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import org.json.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zlzkj.app.service.UserService;
import com.zlzkj.core.base.BaseController;
import com.zlzkj.core.sql.Row;

@Controller
public class IndexController extends BaseController{
	
	@Autowired
	private UserService userService;

	@RequestMapping(value={"/","/login"})
	public String login(Model model,HttpServletRequest request,HttpServletResponse response) {
		return "index/login";
	}

	@RequestMapping(value={"/nonauthority"})
	public String nonauthority(Model model,HttpServletRequest request,HttpServletResponse response) {
		return "index/login";
	}

	@RequiresPermissions(value = {"delete_file"})
	@RequestMapping(value={"test/test2"})
	public void test2(Model model,HttpServletRequest request,HttpServletResponse response) throws IOException {
		
		PrintWriter out = response.getWriter();  
		List<Row> userList = userService.findAllBySQL();
		/*JSONObject jo = new JSONObject();
		jo.put("all_user", userList);

		out.write(jo.toString());*/
		//return ajaxReturn(response, jo,"",1);
	}
	

	@RequestMapping(value={"delete/user"})
	public String deleteUser(Model model,HttpServletRequest request,HttpServletResponse response,String userId) throws IOException {
		return ajaxReturn(response, userService.delete(userId),"",1);
	}

	@RequestMapping(value={"login/login"})
	public String login(Model model,HttpServletRequest request,HttpServletResponse response,String account,String password) {

		Subject user = SecurityUtils.getSubject();

        /*
         * if (user.isAuthenticated()) {
         *       user.logout();
         * }
         */
		UsernamePasswordToken token = new UsernamePasswordToken(account, password);

		//token.setRememberMe(rememberMe);
		try {
			user.login(token);
			System.out.println("Login success!");
			return "index/index";
		} catch (AuthenticationException e) {
			e.printStackTrace();
			return "index/login";
		}
	}
	
}
