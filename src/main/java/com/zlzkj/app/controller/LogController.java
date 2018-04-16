package com.zlzkj.app.controller;

import com.zlzkj.app.service.UserService;
import com.zlzkj.core.base.BaseController;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import org.json.JSONObject;

@Controller
public class LogController extends BaseController{

	@Autowired
	private UserService userService;

	@RequestMapping(value={"system/log"})
	public String login(Model model,HttpServletRequest request,HttpServletResponse response) {

		return "system/log";
	}

}
