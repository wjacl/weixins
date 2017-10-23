package com.wja.base.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wja.base.util.Log;
import com.wja.base.web.AppContext;

/**
 * 
 * 提供公开的文件、图片获取
 * 
 * @author wja
 * @version [v1.0, 2017年10月23日]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
@Controller
public class PubGet
{
    private static String rootDir = AppContext.getSysParam("wx.upload.save.rootdir");
    
    @RequestMapping(value = "/wx/pubget/**/*")
    public void getFile(HttpServletRequest request, HttpServletResponse response)
        throws IOException
    {
        
        String reqUri = request.getRequestURI();
        int sindex = (request.getContextPath() + "/wx/pubget").length();
        String filePath = reqUri.substring(sindex);
        
        File file = new File(rootDir + filePath);
        
        this.responseFile(file, response);
    }
    
    private void responseFile(File file, HttpServletResponse response)
    {
        if (file.exists())
        {
            String mimeType = URLConnection.guessContentTypeFromName(file.getName());
            if (mimeType != null)
            {
                response.setContentType(mimeType);
            }
            try (InputStream in = new FileInputStream(file); OutputStream os = response.getOutputStream();)
            {
                byte[] bf = new byte[1024 * 8];
                int count = 0;
                while ((count = in.read(bf)) != -1)
                {
                    os.write(bf, 0, count);
                    os.flush();
                }
            }
            catch (Exception e)
            {
                Log.LOGGER.error("文件获取，读取文件异常", e);
            }
        }
    }
}
