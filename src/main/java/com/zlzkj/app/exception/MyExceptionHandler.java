package com.zlzkj.app.exception;

import com.alibaba.fastjson.JSONObject;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.UnauthenticatedException;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.session.UnknownSessionException;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;


public class MyExceptionHandler implements HandlerExceptionResolver {

    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
                                         Exception ex) {
        Map<String, Object> model = new HashMap<String, Object>();

        model.put("ex", ex);

        if (ex instanceof UnauthenticatedException) {
            return new ModelAndView("redirect:/", model);
        } else if (ex instanceof AuthorizationException || ex instanceof UnauthorizedException) {
            if ("XMLHttpRequest".equals(request.getHeader("x-requested-with"))) {
                try {
                    response.setStatus(403); //设置状态码
                    response.setContentType(MediaType.APPLICATION_JSON_VALUE); //设置ContentType
                    response.setCharacterEncoding("UTF-8"); //避免乱码
                    response.setHeader("Cache-Control", "no-shiro, must-revalidate");
                    return new ModelAndView("redirect:/json/nonauthority", model);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                return new ModelAndView("redirect:/nonauthorize", model);
            }
        } else if (ex instanceof UnknownSessionException) {
            return new ModelAndView("redirect:/", model);
        }
        return null;
    }
}


//~ Formatted by Jindent --- http://www.jindent.com
