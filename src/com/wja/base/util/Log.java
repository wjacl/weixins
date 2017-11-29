package com.wja.base.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Log
{
    public static final Logger LOGGER = LoggerFactory.getLogger(Log.class);
    
    public static void error(String message,Throwable e){
        LOGGER.error(message, e);
    }
    
    public static void error(String message){
        LOGGER.error(message);
    }
}
