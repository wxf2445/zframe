package com.zlzkj.app.service;

import com.zlzkj.app.model.Authority;
import com.zlzkj.app.model.User;
import com.zlzkj.app.util.Md5Util;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class ShiroUserService {
    @Resource
    private UserService userService;
    
    public User getAuthenticatedUser(AuthenticationToken authcToken) {

        // TODO Auto-generated method stub
        UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
        //String md5password = Md5Util.getMD5(token.getUsername() + String.valueOf(token.getPassword()));
        User user = userService.findByUserName(token.getUsername());

        if (user == null) {
            throw new AuthenticationException("usernameorpassword.not.match");
        } else if (!user.getPassword().equals(String.valueOf(token.getPassword()))) {
            throw new AuthenticationException("usernameorpassword.not.match");
        } else if ((user.getLocked() == true)) {
            throw new AuthenticationException("account.not.activate");
        }

        return user;
    }

    
    public User getLoginUser() {

        // TODO Auto-generated method stub
        org.apache.shiro.subject.Subject my = SecurityUtils.getSubject();

        String username = (String) my.getPrincipal();

        if (username == null) {
            return null;
        }

        return userService.findByUserName(username);
    }

    /*public User getSuperUser() {

        // TODO Auto-generated method stub
        List<User> users = userService.findByRoleId("1");

        if (users.size() == 1) {
            return users.get(0);
        }

        return null;
    }*/

    public void setUserSessionPermission(List<Authority> permissions) {
        org.apache.shiro.subject.Subject my = SecurityUtils.getSubject();
        my.getSession(true).setAttribute("permissions",permissions);
    }

    public List<Authority> getUserSessionPermission() {
        org.apache.shiro.subject.Subject my = SecurityUtils.getSubject();
        return (List<Authority>) my.getSession().getAttribute("permissions");
    }

/*   
    }*/

	/*public List<String> getCode(String userid,String recordtypeid) {
		return userService.getCode(userid,recordtypeid);
	}*/

    public void logout () {
        SecurityUtils.getSubject().logout();
    }

/*
	public boolean checkPermission(String code) {
        org.apache.shiro.subject.Subject my = SecurityUtils.getSubject();
        List<Authority> as = (List<Authority>) my.getSession().getAttribute("permissions");
		 for(Authority a:as){
	    	if(a.getCode().equals(code))
	    		return true;
		 }
		return false;
	}*/
}


//~ Formatted by Jindent --- http://www.jindent.com
