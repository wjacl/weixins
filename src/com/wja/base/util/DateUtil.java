package com.wja.base.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

import com.wja.base.web.AppContext;

public class DateUtil
{
    public static final String DATE = "yyyy-MM-dd";
    
    public static final String TIME = "HH:mm:ss";
    
    public static final String DATE_TIME = "yyyy-MM-dd HH:mm:ss";
    
    public static final String DATE_MINUTE = "yyyy-MM-dd HH:mm";
    
    /**
     * 默认的格式器 格式：yyyy-MM-dd
     */
    public static final DateFormat DEFAULT_DF = new SimpleDateFormat(DATE);
    
    /**
     * 日期分钟格式器
     */
    public static final DateFormat DATE_MINUTE_DF = new SimpleDateFormat(DATE_MINUTE);
    
    /**
     * 获取当前年份
     * 
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static final int getCurrYear()
    {
        return Calendar.getInstance().get(Calendar.YEAR);
    }
    
    /**
     * 
     * 获得当前日期的标准格式 yyyy-MM-dd字符串
     * 
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static final String getNowDateStr()
    {
        return DEFAULT_DF.format(new Date());
    }
    
    /**
     * 
     * 获取今日的上班时间字符串 yyyy-MM-dd HH:mm
     * 
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static final String getTodayWorkStartTimeStr()
    {
        String startTime = AppContext.getSysParam("work.start.time");
        int hourOfDay = 9;
        int minute = 0;
        if (StringUtils.isNotBlank(startTime))
        {
            String[] hm = startTime.trim().split(":");
            try
            {
                hourOfDay = Integer.parseInt(hm[0]);
                if (hm.length > 1)
                {
                    minute = Integer.parseInt(hm[1]);
                }
            }
            catch (Exception e)
            {
                Log.LOGGER.error("上班时间参数错误", e);
            }
            
            if (hourOfDay > 23 || hourOfDay < 0)
            {
                hourOfDay = 9;
            }
            if (minute < 0 || minute > 59)
            {
                minute = 0;
            }
        }
        
        return getNowDateMinuteStr(hourOfDay, minute);
    }
    
    /**
     * 
     * 获取当前日期、指定时分的字符串 格式：yyyy-MM-dd HH:mm
     * 
     * @param hourOfDay
     * @param minute
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static final String getNowDateMinuteStr(int hourOfDay, int minute)
    {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.HOUR_OF_DAY, hourOfDay);
        c.set(Calendar.MINUTE, minute);
        return DATE_MINUTE_DF.format(c.getTime());
    }
    
    public static final DateFormat getDateFormat(String pattern)
    {
        return new SimpleDateFormat(pattern);
    }
    
    /**
     * 
     * 判断一个日期是否是休息日
     * 
     * @param cal
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static final boolean isRestDay(Calendar cal)
    {
        int weekDay = cal.get(Calendar.DAY_OF_WEEK);
        return weekDay == Calendar.SATURDAY || weekDay == Calendar.SUNDAY;
    }
    
    /**
     * 
     * 判断一个日期是否是休息日
     * 
     * @param date
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static final boolean isRestDay(Date d)
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(d);
        int weekDay = cal.get(Calendar.DAY_OF_WEEK);
        return weekDay == Calendar.SATURDAY || weekDay == Calendar.SUNDAY;
    }
    
    public static void toNextWorkDay(Calendar cal)
    {
        if (isRestDay(cal))
        {
            cal.add(Calendar.DATE, 1);
            toNextWorkDay(cal);
        }
    }
}
