package com.zlzkj.app.controller;

import com.alibaba.fastjson.JSONObject;
import com.google.code.kaptcha.Constants;
import com.zlzkj.app.service.UserService;
import com.zlzkj.core.base.BaseController;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

//import org.json.JSONObject;

@Controller
public class UserController extends BaseController{

	@Value("${PAGE_SIZE}")
	private int PAGE_SIZE;

	@Autowired
	private UserService userService;

	@RequestMapping(value={"/user/index"})
	public String login(Model model,HttpServletRequest request,HttpServletResponse response) {
		/*Subject user = SecurityUtils.getSubject();*/
		return "user/index";
	}

}
