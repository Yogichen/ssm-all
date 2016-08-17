package cn.facilityone.controller;

import cn.facilityone.common.utils.FileUtils;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
@Controller
@RequestMapping("/ueditor/fileupload")
public class FileUpLoadController {

    // 文件上传路径
    @Resource(name="ueditorFileUploadPath")
    private String ueditorFileUploadPath;

    // 文件读取路径
    @Resource(name="ueditorHttpPath")
    private String ueditorHttpPath;


    /**
     * 文件上传Action
     * @param req
     * @return UEDITOR 需要的json格式数据
     */
    @RequestMapping(value="upload",method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String,Object> upload(HttpServletRequest req){
        Map<String,Object> result = new HashMap<String, Object>();

        MultipartHttpServletRequest mReq  =  null;
        MultipartFile file = null;
        InputStream is = null ;
        String fileName = "";
        // 原始文件名   UEDITOR创建页面元素时的alt和title属性
        String originalFileName = "";
        String filePath = "";

        try {
            mReq = (MultipartHttpServletRequest)req;
            // 从config.json中取得上传文件的ID
            file = mReq.getFile("upfile");
            // 取得文件的原始文件名称
            fileName = file.getOriginalFilename();

            originalFileName = fileName;

            if(!StringUtils.isEmpty(fileName)){
                is = file.getInputStream();
                fileName = FileUtils.reName(fileName);
                filePath = FileUtils.saveFile(fileName, is, ueditorFileUploadPath);
            } else {
                throw new IOException("文件名为空!");
            }

            result.put("state", "SUCCESS");// UEDITOR的规则:不为SUCCESS则显示state的内容
            result.put("url",ueditorHttpPath + filePath);
            result.put("title", originalFileName);
            result.put("original", originalFileName);
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
            result.put("state", "文件上传失败!");
            result.put("url","");
            result.put("title", "");
            result.put("original", "");
            System.out.println("文件 "+fileName+" 上传失败!");
        }
        
        return result;
    }
}

