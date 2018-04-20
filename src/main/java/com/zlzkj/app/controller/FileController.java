package com.zlzkj.app.controller;

import com.zlzkj.core.base.BaseController;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;

/**
 * 首页控制器
 */
@Controller
@RequestMapping(value={"file"})
public class FileController extends BaseController {

    @Value("${FILE_REPOSITORY}")
    private String FILE_REPOSITORY;

    @ResponseBody
	@RequestMapping(value={"openfile"})
	public void getFile(Model model, HttpServletRequest request, HttpServletResponse response, String filepath) {
		response.setHeader("Access-Control-Allow-Origin", "*");

	    File file = new File(FILE_REPOSITORY + filepath);
        //System.out.println(FILE_REPOSITORY + filepath);
        try{
            FileInputStream in = new FileInputStream(file);
            OutputStream o = response.getOutputStream();
            response.setHeader("Content-Disposition","attachment;filename=" + file.getName());
            response.setHeader("Content-Length",String.valueOf(file.length()));

            byte[] b = null;
            while(in.available() >0) {
                if(in.available()>10240) {
                    b = new byte[10240];
                }else {
                    b = new byte[in.available()];
                }
                in.read(b, 0, b.length);
                o.write(b, 0, b.length);
            }
            in.close();
            o.flush();
            o.close();
        }catch (IOException e){
            e.printStackTrace();
        }

    }

    @RequestMapping(
            value = "/downloadfile",
            method = RequestMethod.GET
    )
    public ResponseEntity<byte[]> downloadfile(@RequestParam(
            value = "filepath",
            required = true
    ) String filepath, HttpServletRequest request){
        try {

            filepath = URLDecoder.decode(filepath, "utf-8");
            //filepath = new String(filepath.getBytes("iso-8859-1"), "utf-8");
            File file = new File(FILE_REPOSITORY + filepath);
            HttpHeaders headers = new HttpHeaders();
            //String fileName=new String("你好.xlsx".getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题
            //filepath = new String( filepath.substring(filepath.lastIndexOf("/") + 1).getBytes("utf-8"),"iso-8859-1");

            filepath = filepath.substring(filepath.lastIndexOf("/") + 1);

            //解决文件中文乱码
            String agent = request.getHeader("USER-AGENT");

            if (null != agent && -1 != agent.indexOf("MSIE") || null != agent && -1 != agent.indexOf("Trident")){
                filepath = URLEncoder.encode(filepath, "UTF-8");//IE浏览器
            }else{
                filepath = new String(filepath.getBytes("UTF-8"), "ISO8859-1");
            }


            headers.set(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filepath + "\"");
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
                    headers, HttpStatus.OK);

        } catch (Exception e) {
            //e.printStackTrace();
        }
        return null;

    }

}
