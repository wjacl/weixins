package com.wja.wechat.media;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;

import com.wja.base.util.Log;
import com.wja.wechat.WechatConfig;
import com.wja.wechat.WechatConstants;

public class MediaManager
{
    private static final String MEDIA_DOWN_HTTPS_URL = "%s://api.weixin.qq.com/cgi-bin/media/get?access_token=%s&media_id=%s";
    
    private static String getDownUrl(String protocl,String mediaId){
        return String.format(MEDIA_DOWN_HTTPS_URL, (StringUtils.isBlank(protocl) ? "http" : protocl),WechatConfig.getAccessToken(),mediaId);
    }
    
    /**
     * 
     * 微信图片下载
     * @param mediaId
     * @param savePath
     * @throws Exception
     * @see [类、类#方法、类#成员]
     * 
     * 
            获取临时素材
            
            公众号可以使用本接口获取临时素材（即下载临时的多媒体文件）。请注意，视频文件不支持https下载，调用该接口需http协议。
            
            本接口即为原“下载多媒体文件”接口。
            
            接口调用请求说明
            
            http请求方式: GET,https调用
            https://api.weixin.qq.com/cgi-bin/media/get?access_token=ACCESS_TOKEN&media_id=MEDIA_ID
            请求示例（示例为通过curl命令获取多媒体文件）
            curl -I -G "https://api.weixin.qq.com/cgi-bin/media/get?access_token=ACCESS_TOKEN&media_id=MEDIA_ID"
            参数说明
            
            参数  是否必须    说明
            access_token    是   调用接口凭证
            media_id    是   媒体文件ID
            返回说明
            
            正确情况下的返回HTTP头如下：
            
            HTTP/1.1 200 OK
            Connection: close
            Content-Type: image/jpeg
            Content-disposition: attachment; filename="MEDIA_ID.jpg"
            Date: Sun, 06 Jan 2013 10:20:18 GMT
            Cache-Control: no-cache, must-revalidate
            Content-Length: 339721
            curl -G "https://api.weixin.qq.com/cgi-bin/media/get?access_token=ACCESS_TOKEN&media_id=MEDIA_ID"
            如果返回的是视频消息素材，则内容如下：
            
            {
             "video_url":DOWN_URL
            }
            错误情况下的返回JSON数据包示例如下（示例为无效媒体ID错误）：
            
            {"errcode":40007,"errmsg":"invalid media_id"}
     * 
     */
    public static String downImg(String mediaId,String savePath) throws Exception{
        String url = getDownUrl(WechatConstants.Protocl.HTTP, mediaId);
        HttpClient client = HttpClientBuilder.create().build();
        HttpResponse response = client.execute(new HttpGet(url));
        if(response.getStatusLine().getStatusCode() != HttpStatus.SC_OK){
            throw new Exception("网络访问响应异常，响应码为：" + response.getStatusLine().getStatusCode());
        }
        
        Header disposition = response.getFirstHeader("Content-disposition");
        if(disposition == null){
            throw new Exception("网络访问响应异常，响应头中没有Content-disposition");
        }
        String dv = disposition.getValue();
        String fileName = dv.substring(dv.indexOf("\"") + 1, dv.length() - 1);
        Log.info("********* 响应的文件名为：" + fileName);
        
        if(response.getEntity() == null){
            throw new Exception("网络访问响应异常，响应体中无内容");
        }
        
        File dir = new File(savePath);
        if(!dir.exists()){
            dir.mkdirs();
        }
        
        File f = new File(dir,fileName);
        
        byte[] buff = new byte[8096];
        try(
            OutputStream out = new FileOutputStream(f);
            InputStream in = response.getEntity().getContent();){
            int count = 0;
            while((count = in.read(buff)) != -1) {
                out.write(buff, 0, count);
            }
        }
        
        return fileName;
    }
}
