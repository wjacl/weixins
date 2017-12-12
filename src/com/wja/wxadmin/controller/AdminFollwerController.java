package com.wja.wxadmin.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.util.Log;
import com.wja.base.util.Page;
import com.wja.base.web.AppContext;
import com.wja.weixin.entity.Account;
import com.wja.weixin.entity.FollwerInfo;
import com.wja.weixin.entity.UpFile;
import com.wja.weixin.service.FollwerInfoService;
import com.wja.weixin.service.TradeService;
import com.wja.weixin.service.UpFileService;

@Controller
@RequestMapping("/admin")
public class AdminFollwerController {

    @Autowired 
    private FollwerInfoService follwerInfoService;
    
    @Autowired
    private UpFileService upFileService;
    
    @Autowired
    private TradeService tradeService;
    
    @RequestMapping("fuser/query")
    @ResponseBody
    public Object query(@RequestParam Map<String, Object> params, Page<FollwerInfo> page)
    {
        this.follwerInfoService.query(params, page);
        
        return FollwerHandler.follwerInfoTrans(page);
    }
   
    
    
    @RequestMapping("fuser/manage")
    public String manage(){
        return "admin/fuser";
    }
    
    @RequestMapping("fuser/view/{id}")
    public String view(@PathVariable("id") String id,Model model){
        FollwerInfo fi = this.follwerInfoService.get(FollwerInfo.class, id);
        model.addAttribute("fi", fi);
        model.addAttribute("ads", this.follwerInfoService.queryAuditRecord(id));
        return "admin/fuser_view";
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

    private static String rootDir = AppContext.getSysParam("wx.upload.save.rootdir");
    
    @RequestMapping("fuser/getImg/{id}")
    public void getById(@PathVariable("id") String id, HttpServletResponse response)
    {
        if (StringUtils.isNotBlank(id))
        {
            UpFile uf = this.upFileService.get(UpFile.class, id);
            if (uf != null)
            {
                File file = new File(rootDir + uf.getFileName());
                
                this.responseFile(file, response);
            }
        }
        
    }
    
    @RequestMapping("fuser/getTk")
    @ResponseBody
    public Object getTk(String id)
    {
        Account a = this.tradeService.getAccount(id);
        
        return a == null ? new Account() : a;
    }
    
    @RequestMapping("fuser/getTk")
    @ResponseBody
    public Object doTk(String id){
        Account a = this.tradeService.getAccount(id);
        
        //TODO  退款
        
        return null;
    }
}
