package com.zlzkj.app.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import org.json.JSONObject;
import com.alibaba.fastjson.JSONObject;
import com.google.code.kaptcha.Constants;
import com.zlzkj.app.service.ShiroUserService;
import com.zlzkj.app.util.Md5Util;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zlzkj.app.service.UserService;
import com.zlzkj.core.base.BaseController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class IndexController extends BaseController{

	@Value("${PAGE_SIZE}")
	private int PAGE_SIZE;

	@Autowired
	private UserService userService;
	@Autowired
	private ShiroUserService shiroUserService;

	@RequestMapping(value={"/"})
	public String login(Model model,HttpServletRequest request,HttpServletResponse response) {
		Subject user = SecurityUtils.getSubject();
		if(user.isRemembered()||user.isAuthenticated()){
			return "index/index";
		}

		return "index/login";
	}

	@RequestMapping(value={"/nonauthority"})
	public String nonauthority(Model model,HttpServletRequest request,HttpServletResponse response) {
		return "redirect:/";
	}

	@RequiresPermissions(value = {"delete_file"})
	@RequestMapping(value={"test/test2"})
	public void test2(Model model,HttpServletRequest request,HttpServletResponse response) throws IOException {
		
		PrintWriter out = response.getWriter();  
		/*List<Row> userList = userService.findAllBySQL();*/
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
	public String login(Model model,HttpServletRequest request,HttpServletResponse response,HttpSession session,
						String account,String password,boolean rememberMe,String submitCode,
						final RedirectAttributes redirectAttributes) {

		Subject user = SecurityUtils.getSubject();

		UsernamePasswordToken token = new UsernamePasswordToken(account, Md5Util.getMD5(account+password));

		token.setRememberMe(rememberMe);
		String code = (String) session.getAttribute(Constants.KAPTCHA_SESSION_KEY);
		if(!submitCode.equals(code)){
			redirectAttributes.addFlashAttribute("errors", "submit_code_error");
			return "redirect:/";
		}
		try {
			user.login(token);

			session.setAttribute("CUR_USER",shiroUserService.getLoginUser());
			System.out.println("Login success!");
		} catch (AuthenticationException e) {
			redirectAttributes.addFlashAttribute("errors", "account_or_password_error");
			//e.printStackTrace();
		}
		return "redirect:/";
	}
	@RequestMapping(value={"logout"})
	public String logout() {

		Subject user = SecurityUtils.getSubject();

		try {
			user.logout();
			System.out.println("Logout success!");
		} catch (AuthenticationException e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}

	@RequestMapping(value={"/json/nonauthority"})
	public String jsonNonauthority(Model model,HttpServletRequest request,HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("hasNoPermission",true);
		return ajaxReturn(response, jsonObject,"",-1);
	}

	@RequestMapping(value={"/error/404"})
	public String error404(Model model,HttpServletRequest request,HttpServletResponse response) {
		return "error/404";
	}
}
