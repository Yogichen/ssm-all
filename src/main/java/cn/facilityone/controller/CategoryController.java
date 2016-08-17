package cn.facilityone.controller;

import cn.facilityone.common.Attachment;
import cn.facilityone.common.Paging;
import cn.facilityone.common.Result;
import cn.facilityone.common.datatable.DataTableRequest;
import cn.facilityone.common.datatable.DataTableResponse;
import cn.facilityone.entity.Category;
import cn.facilityone.entity.User;
import cn.facilityone.service.CategoryService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.nio.charset.Charset;
import java.util.Date;

/**
 * Created by Yogi on 2016/7/27.
 * 分类管理
 */
@Controller
@RequestMapping("/category")
public class CategoryController {

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    CategoryService categoryService;

    // 文件上传路径
    @Resource(name="categoryFileUploadPath")
    private String categoryFileUploadPath;

    // 文件读取路径
    @Resource(name="categoryHttpPath")
    private String categoryHttpPath;

    @RequestMapping("/view")
    public String getView() {
        return "category";
    }

    @RequestMapping(value = "/grid", method = RequestMethod.POST, produces = "application/json", consumes = "application/json")
    @ResponseBody
    public DataTableResponse getCategoryGrid(
            HttpServletRequest request,
            HttpServletResponse response,
            @RequestBody DataTableRequest dataTableRequest
    ) {
        Paging paging = categoryService.getGrid(dataTableRequest);
        DataTableResponse dataTableResponse = new DataTableResponse();
        dataTableResponse.setData(paging.getList());
        dataTableResponse.setDraw(dataTableRequest.getDraw());
        dataTableResponse.setRecordsFiltered(paging.getTotal());
        dataTableResponse.setRecordsTotal(paging.getTotal());
        return dataTableResponse;
    }

    //临时存储
    @RequestMapping("/saveToTemp")
    public
    @ResponseBody
    ResponseEntity<String> saveToTemp(
            @RequestParam(value = "uploadFile", required = false) MultipartFile file) {

        // 上传图片
        String path = categoryFileUploadPath;
        String fileName = new Date().getTime() + file.getOriginalFilename();//文件名：当前时间+文件原名
        File targetFile = new File(path, fileName);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }
        // 保存
        try {
            file.transferTo(targetFile);//保存到一个目标文件中。
        } catch (Exception e) {
            logger.error("保存文件出错");
        }

        //构建回传对象attachment，构建回传json
        Attachment attachment = new Attachment();
        attachment.setName(fileName);
        // 图标存储路径放置在webapp外，防止重新部署丢失。
        // 注意,配置tomcat静态目录，idea必须配置catalina_base，否则会覆盖tomcat的server.xml中配置过的context
        // 导致配置无误，但是就是读取不到虚拟目录
        attachment.setPath(categoryHttpPath + fileName);
        attachment.setSize(FileUtils.byteCountToDisplaySize(file.getSize()));
//        attachment.setCreateTime(new Date());// 这里为方便演示，虚拟个时间

        // uploadify 由flash发出请求，和常规ajax不太一样，需要如下处理，防止中文乱码。
        String body = StringUtils.EMPTY;
        try {
            body = new ObjectMapper().writeValueAsString(attachment);//转json
        } catch (Exception e) {
            logger.error("上传附件时写json错误", e);
        }
        HttpHeaders responseHeaders = new HttpHeaders();
        MediaType mediaType = new MediaType("text", "html",
                Charset.forName("UTF-8"));
        responseHeaders.setContentType(mediaType);
        ResponseEntity<String> responseEntity = new ResponseEntity<String>(
                body, responseHeaders, HttpStatus.CREATED);

        return responseEntity;
    }

    //确认存储
    @RequestMapping("/save")
    public
    @ResponseBody
    Result save(
            HttpServletRequest request,
            HttpServletResponse response,
            HttpSession session,
            @RequestBody Category category
    ) {
        // TODO 确认创建后，存储到数据库
        User user = (User)session.getAttribute("user");
        category.setCreatedBy(user.getUserName());
        categoryService.addCategory(category);
        return new Result(null, "success", null, null);
    }

    //获取编辑内容
    @RequestMapping("/edit/{categoryId}")
    public
    @ResponseBody
    Result edit(
            HttpServletRequest request,
            HttpServletResponse response,
            @PathVariable Long categoryId
    ) {
        Category category = categoryService.findCategoryById(categoryId);
        return new Result(category);
    }

    //保存编辑内容
    @RequestMapping("/saveEdit")
    public
    @ResponseBody
    Result saveEdit(
            HttpServletRequest request,
            HttpServletResponse response,
            @RequestBody Category category
    ) {
        categoryService.updateCategory(category);
        return new Result(null, "success", null, null);
    }

    //删除
    @RequestMapping("/delete/{categoryId}")
    public
    @ResponseBody
    Result delete(
            HttpServletRequest request,
            HttpServletResponse response,
            @PathVariable Long categoryId
    ) {
        categoryService.deleteCategory(categoryId);
        return new Result(null, "success", null, null);
    }

    @RequestMapping("/all")
    @ResponseBody
    public Result getAll(
            HttpServletRequest request,
            HttpServletResponse response
    ) {
        return new Result(categoryService.getAllCategory());
    }

    @RequestMapping("/type")
    @ResponseBody
    public Result getAllType(
            HttpServletRequest request,
            HttpServletResponse response
    ) {
        return new Result(categoryService.getTypes());
    }

    @RequestMapping("/moveUp/currentId/{currentId}/currentOrder/{currentOrder}")
    @ResponseBody
    public Result moveUpOrder(
            HttpServletRequest request,
            HttpServletResponse response,
            @PathVariable Long currentId,
            @PathVariable int currentOrder
    ) {
        categoryService.moveUpOrder(currentId, currentOrder);
        return new Result(null);
    }

    @RequestMapping("/moveDown/currentId/{currentId}/currentOrder/{currentOrder}")
    @ResponseBody
    public Result moveDownOrder(
            HttpServletRequest request,
            HttpServletResponse response,
            @PathVariable Long currentId,
            @PathVariable int currentOrder
    ) {
        categoryService.moveDownOrder(currentId, currentOrder);
        return new Result(null);
    }
}
