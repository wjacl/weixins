package com.wja.base.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class UrlUtil
{
    public static String encode(String str)
    {
        try
        {
            return URLEncoder.encode(str, "utf-8");
        }
        catch (UnsupportedEncodingException e)
        {
            return str;
        }
    }
}
