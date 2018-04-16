package com.zlzkj.app.service;

import com.zlzkj.app.util.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * Class description
 *
 * @author zhm
 * @version 1.0.0, 16/03/31
 */
@Service
public class  FileService {
    @Resource
    private ShiroUserService shiroUserService;
    //@Value("${fileserverpath}")
    private String ROOT_PATH;

    public void writeTxt(String content, String path) throws IOException {
        //transformRuleIO.writeText(content, path);
        FileUtils.saveTxt(content, mkDirIfNotExist(path));

    }

    private String mkDirIfNotExist(String path) throws IOException {
        String prePath = path.substring(0, path.lastIndexOf("/"));
        String fileName = path.substring(path.lastIndexOf("/") + 1);
        File file = new File(prePath);
        if (!file.exists()) {
            file.mkdirs();
        }
        file = new File(path);
        file.createNewFile();
        return path;
    }

    public void writeFile(InputStream inputStream, String path) throws IOException {
        FileUtils.saveFile(inputStream, mkDirIfNotExist(path));
        //transformRuleIO.writeFile(inputStream, path);
    }

    public String readTxt(String path) throws IOException {
        //String content = transformRuleIO.readText(path);
        //return content;
        InputStream is = readFile(path);
        return FileUtils.readTxt(is);
    }

    public InputStream readFile(String path) throws IOException {
        File file = new File(path);
        return new FileInputStream(file);
        //InputStream is = transformRuleIO.readFile(path);
        //return is;
    }

    public void removeFile(String sqlpath) {
        File file = new File(sqlpath);
        file.delete();
    }

    public String writeAllFile(InputStream inputStream, String prefix, String suffix) throws IOException {
        String path = prefix + "." + suffix;
        writeFile(inputStream, mkDirIfNotExist(path));
        return path;
    }


}


//~ Formatted by Jindent --- http://www.jindent.com
