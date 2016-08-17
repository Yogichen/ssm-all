package cn.facilityone.controller.exception;




import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;


/**
 * Created by Yogi on 2016/7/21.
 */
public class MyExceptionHandler extends SimpleMappingExceptionResolver {


    /* (non-Javadoc)
     * @see org.springframework.web.servlet.handler.SimpleMappingExceptionResolver#doResolveException(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, java.lang.Exception)
     */
    @Override
    protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
    {
        if (ex == null)
        {
            return null;
        }

        // 打印堆栈中的错误信息
        logger.error(ex);

        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
        String viewName = determineViewName(ex, request);
        if (viewName != null)
        {
            viewName = "redirect:" + basePath + viewName;

            // JSP格式返回
            if (!(request.getHeader("accept").indexOf("application/json") > -1 || (request.getHeader("X-Requested-With") != null && request.getHeader(
                    "X-Requested-With").indexOf("XMLHttpRequest") > -1)))
            {
                // 如果不是异步请求
                Integer statusCode = determineStatusCode(request, viewName);
                if (statusCode != null)
                {
                    applyStatusCodeIfPossible(request, response, statusCode);
                }
                ModelAndView mv = new ModelAndView(viewName);
                mv.addObject("ex", ex.toString());
                return mv;
            }
            else
            {
                // JSON格式返回
                PrintWriter writer = null;
                try
                {
                    writer = response.getWriter();
                    if (ex.getMessage() != null)
                    {
                        writer.write(ex.getMessage());
                        writer.flush();
                    }
                }
                catch(Exception e)
                {
                    logger.error(e);
                }
                finally
                {
                    if (null != writer)
                    {
                        writer.close();
                    }
                }
                return null;
            }
        }
        else
        {
            return null;
        }
    }
}
