package com.wja.base.util;

import java.text.DateFormat;
import java.text.ParseException;
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
    
    public static final String DF_YYYY_MM = "yyyy-MM";
    
    /**
     * 默认的格式器 格式：yyyy-MM-dd
     */
    public static final DateFormat DEFAULT_DF = new SimpleDateFormat(DATE);
    
    /**
     * 默认的格式器 格式：yyyy-MM-dd HH:mm:ss
     */
    public static final DateFormat DATE_TIME_DF = new SimpleDateFormat(DATE_TIME);
    
    /**
     * 日期分钟格式器
     */
    public static final DateFormat DATE_MINUTE_DF = new SimpleDateFormat(DATE_MINUTE);
    
    public static final Date getMonthFirstDay(Date d)
    {
        Calendar ca = Calendar.getInstance();
        Calendar c = Calendar.getInstance();
        c.setTime(d);
        ca.clear();
        ca.set(c.get(Calendar.YEAR), c.get(Calendar.MONTH), 1);
        return ca.getTime();
    }
    
    public static final Date getNextMonth(Date d)
    {
        Calendar ca = Calendar.getInstance();
        Calendar c = Calendar.getInstance();
        c.setTime(d);
        ca.clear();
        ca.set(c.get(Calendar.YEAR), c.get(Calendar.MONTH), 1);
        ca.add(Calendar.MONTH, 1);
        return ca.getTime();
    }
    
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
     * 获取当前月份的下月1号date对象
     * 
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static Date getNextMonth()
    {
        Calendar now = Calendar.getInstance();
        Calendar c = Calendar.getInstance();
        c.clear();
        now.add(Calendar.MONTH, 1);
        c.set(now.get(Calendar.YEAR), now.get(Calendar.MONTH), 1);
        return c.getTime();
    }
    
    /**
     * 
     * 获得指定月份的下一个月1号日期，如没有给定月份值，则返回当前月份的下月1号
     * 
     * @param month 指定月份
     * @param pattern 月份串格式,如为null,则按 yyyy-MM 格式解析
     * @return
     * @throws ParseException
     * @see [类、类#方法、类#成员]
     */
    public static Date getNextMonth(String month, String pattern)
        throws ParseException
    {
        if (StringUtils.isBlank(month))
        {
            return getNextMonth();
        }
        else
        {
            if (StringUtils.isBlank(pattern))
            {
                pattern = DF_YYYY_MM;
            }
            
            Date d = DateUtil.getDateFormat(pattern).parse(month);
            
            Calendar ca = Calendar.getInstance();
            ca.setTime(d);
            ca.add(Calendar.MONTH, 1);
            return ca.getTime();
        }
    }
    
    /**
     * 
     * yyyy-MM-dd HH:mm:ss
     * 
     * @return
     * @see [类、类#方法、类#成员]
     */
    public static final String getNowStr()
    {
        return DATE_TIME_DF.format(new Date());
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
