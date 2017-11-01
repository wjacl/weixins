package com.wja.base.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.apache.commons.lang3.StringUtils;

public class IDGenerater
{
    private static SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
    
    private static Calendar lastCa = Calendar.getInstance();
    
    private static String lastTimeStr = yyyyMMddHHmmss.format(lastCa.getTime());
    
    private static int seqNo = 0;
    
    /**
     * 
     * 获取一个yyyyMMddHHmmss+6位序号的ID
     * 
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static synchronized String getAnYMDHMSid()
    {
        Calendar ca = Calendar.getInstance();
        if (ca.equals(lastCa))
        {
            seqNo++;
        }
        else
        {
            lastCa = ca;
            lastTimeStr = yyyyMMddHHmmss.format(lastCa.getTime());
            seqNo = 1;
        }
        
        return lastTimeStr + StringUtils.leftPad("" + seqNo, 6, '0');
    }
}
