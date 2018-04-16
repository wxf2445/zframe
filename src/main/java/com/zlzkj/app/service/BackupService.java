package com.zlzkj.app.service;


import com.zlzkj.app.mapper.BackupMapper;
import com.zlzkj.app.model.Backup;
import com.zlzkj.app.model.User;
import com.zlzkj.app.util.IDGenerator;
import com.zlzkj.app.util.Page;
import com.zlzkj.app.util.ZipUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;


@Transactional
@Service
public class BackupService {
    @Value("${PAGE_SIZE}")
    private int PAGE_SIZE;
    @Value("${FILE_REPOSITORY}")
    private String fileServerPath;
    @Value("${FILE_COPY_REPOSITORY}")
    private String FileCopyPath;
    @Value("${jdbc.username}")
    private String username;
    @Value("${jdbc.password}")
    private String password;
    @Resource
    private BackupMapper mapper;
    @Resource
    private FileService fileService;

    public void executeCommand(String command, String param) throws IOException, InterruptedException {
        StringBuffer sb = new StringBuffer();
        //work directory
        String dir = this.getClass().getResource("/").getPath();
        System.out.println("rootPath:" + dir);
        /*File file = new File(dir + "/" + appid);
        if (file.exists()) {
            file.mkdirs();
        }*/
        //String commandPath = this.getClass().getResource("/script/backupnow.sh").getPath();
        //String sqlpath = dir + "/sql/recordms_" + System.currentTimeMillis() + ".sql";
        System.out.println("command:" + command);
        Process p = RuntimeUtils.exec(command, "", dir);
        p.waitFor();
        System.out.println("Waiting over.");
    }

    public String exportDumpFile() throws IOException, InterruptedException {
        //work directory
        System.out.println("rootPath:" + fileServerPath);
        String sqlPrefix = fileServerPath.endsWith("/") ? fileServerPath + "sql" : fileServerPath + "/sql";
        String sqlpath = sqlPrefix + "/recordms_" + System.currentTimeMillis() + ".sql";
        System.out.println("sqlpath:" + sqlpath);
        File file = new File(sqlPrefix);
        if (!file.exists()) {
            file.mkdirs();
        }
        StringBuffer sb = new StringBuffer();
        if ("/".equals(File.separator)) {
            String commandPath = this.getClass().getResource("/script/backupnow.sh").getPath();
            sb.append("sh ").append(commandPath).append(" -a ").append(username).append(" ").append(password).append(" ").append(sqlpath);
        } else {
            String commandPath = this.getClass().getResource("/script/backupnow.bat").getPath();
            sb.append(commandPath).append(" ").append(username).append(" ").append(password).append(" ").append(sqlpath);
        }
        executeCommand(sb.toString(), "");
        return sqlpath;
    }

    public void backupNowAndSave(String description) throws IOException, InterruptedException {
        String id = IDGenerator.generator();

        File fileCopy = new File(FileCopyPath);
        if (!fileCopy.exists() && !fileCopy.isDirectory()) {
            fileCopy.mkdir();
        }
        //压缩后的文件
        //File zipfile = new File(FileCopyPath+id+".zip");
        new ZipUtil().zipFiles(fileServerPath, new File(FileCopyPath + id + ".zip"));
        //ZipUtil.zipFiles(srcfile,zipfile);

        Backup backup = new Backup();
        backup.setId(id);
        backup.setSqlPath(exportDumpFile());
        //backup.setCreatedTime(new Date());
        backup.setDescription(description);
        mapper.insert(backup);
    }

    public void deleteSql(String id) {
        Backup backup = mapper.selectByPrimaryKey(id);
        fileService.removeFile(backup.getSqlPath());
        mapper.deleteByPrimaryKey(id);
    }

    public void revert(String sqlPath) throws IOException, InterruptedException {
        StringBuffer sb = new StringBuffer();
        if ("/".equals(File.separator)) {
            String commandPath = this.getClass().getResource("/script/revert.sh").getPath();
            sb.append("sh ").append(commandPath).append(" -a ").append(username).append(" ").append(password).append(" ").append(sqlPath);
        } else {
            String commandPath = this.getClass().getResource("/script/revert.bat").getPath();
            sb.append(commandPath).append(" ").append(username).append(" ").append(password).append(" ").append(sqlPath);
        }
        executeCommand(sb.toString(), "");
    }

    public Backup selectByPrimaryKey(String id) {
        return mapper.selectByPrimaryKey(id);
    }

    public List<Backup> findByMap(Map<String,Object> map){
        return mapper.selectByMap(map);
    }

    public Page findByMap(Map<String,Object> parmMap, int nowPage){
        return new Page(findByMap(parmMap),mapper.countByMap(parmMap),nowPage,PAGE_SIZE);
    }

    public Integer update(Backup entity){
        return mapper.updateByPrimaryKey(entity);
    }
}
