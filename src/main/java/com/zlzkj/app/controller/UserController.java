package com.zlzkj.app.controller;

import com.alibaba.fastjson.JSONObject;
import com.zlzkj.app.model.User;
import com.zlzkj.app.service.RoleService;
import com.zlzkj.app.service.ShiroUserService;
import com.zlzkj.app.service.UserService;
import com.zlzkj.app.util.MapUtil;
import com.zlzkj.app.util.PageView;
import com.zlzkj.core.base.BaseController;
import com.zlzkj.core.sql.Row;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.HashMap;
import java.util.Map;

//import org.json.JSONObject;

@Controller
@RequestMapping(value = "/user")
public class UserController extends BaseController {

    @Value("${PAGE_SIZE}")
    private int PAGE_SIZE;

    @Value("${FILE_REPOSITORY}")
    private String FILE_REPOSITORY;

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;
    @Autowired
    private ShiroUserService shiroUserService;

    @RequestMapping(value = {"/index"})
    public String index(Model model, HttpServletRequest request, HttpServletResponse response, Integer nowPage) {
        Map map = MapUtil.convert(request.getParameterMap());
        model.addAttribute("pageView", new PageView(userService.findByMap(map, nowPage)));
        return "user/index";
    }

    @RequestMapping(value = {"/create"}, method = RequestMethod.POST)
    public String create(Model model, HttpServletRequest request, HttpServletResponse response, User user) {
        return ajaxReturn(response, userService.save(user));
    }

    @RequestMapping(value = {"/update"}, method = RequestMethod.POST)
    public String edit(Model model, HttpServletRequest request, HttpServletResponse response, User user) {
        return ajaxReturn(response, userService.update(user));
    }


    @RequiresRoles("SUPER_ADMIN")
    @ResponseBody
    @RequestMapping(value = {"/delete"}, method = RequestMethod.POST)
    public String delete(Model model, HttpServletRequest request, HttpServletResponse response, String[] id) {
        return ajaxReturn(response, userService.deletebyIds(id));
    }

    //json 用户列表
    @ResponseBody
    @RequestMapping(value = {"/list"}, method = RequestMethod.POST)
    public Map<String, Object> userList(HttpServletRequest request, Integer nowPage) {
        Map<String, Object> result = new HashMap();
        Map map = MapUtil.convert(request.getParameterMap());
        result.put("pageView", new PageView(userService.findByMap(map, nowPage)));
        return result;
    }

    @ResponseBody
    @RequestMapping(value = {"/to_create"}, method = RequestMethod.POST)
    public Map<String, Object> toCreate(HttpServletRequest request) {
        Map<String, Object> result = new HashMap();
        result.put("roles", roleService.findByMap(new HashMap<String, Object>()));
        return result;
    }

    @ResponseBody
    @RequestMapping(value = {"/to_edit"}, method = RequestMethod.POST)
    public Map<String, Object> toEdit(HttpServletRequest request, String id) {
        Map<String, Object> result = new HashMap();
        result.put("roles", roleService.findByMap(new HashMap<String, Object>()));
        result.put("obj", userService.findById(id));
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/check_username")
    public boolean checkAccount(String name, String originalname, HttpSession session) {
        Map<String, Object> paraMap = new HashMap();
        paraMap.put("username", name);
        if (userService.findByMap(paraMap).size() > 0 && !name.equals(originalname)) {
            return false;
        }
        return true;

    }

    @RequestMapping(value = {"update_image"})
    public String fileUpload(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session,User user, @RequestParam MultipartFile file) throws IOException {

        User curUser = shiroUserService.getLoginUser();

        if (!user.getId().equals(curUser.getId()))
            return ajaxReturn(response, -1);

        File f = new File(FILE_REPOSITORY + user.getId());
        if (!f.exists()) {
            f.mkdirs();
        }
        FileOutputStream fos;
        String fileName = "";
        try {
            InputStream is = file.getInputStream();
            fileName = user.getId() + "/" + System.currentTimeMillis() + ".png";
            fos = new FileOutputStream(FILE_REPOSITORY + fileName);

            byte[] b = new byte[1024];

            while ((is.read(b)) != -1) {
                fos.write(b);
            }

            is.close();
            fos.close();

            curUser.setAvatar(fileName);
            session.setAttribute("CUR_USER",curUser);
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return ajaxReturn(response, userService.update(user));
    }

}
