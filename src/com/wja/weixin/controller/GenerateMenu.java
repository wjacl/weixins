package com.wja.weixin.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.sword.wechat4j.menu.Menu;
import org.sword.wechat4j.menu.MenuManager;

import com.alibaba.fastjson.JSON;

@Controller
@RequestMapping("/wx/menu")
public class GenerateMenu
{
    @RequestMapping("create")
    @ResponseBody
    public String generateMenu()
    {
        try (InputStream in = GenerateMenu.class.getResourceAsStream("/menu.json");
            BufferedReader r = new BufferedReader(new InputStreamReader(in, "UTF-8"));)
        {
            StringBuilder sb = new StringBuilder();
            String line = null;
            while ((line = r.readLine()) != null)
            {
                sb.append(line);
            }
            Menu m = JSON.parseObject(sb.toString(), Menu.class);
            MenuManager mm = new MenuManager();
            mm.create(m);
            return "ok";
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return "error";
        }
    }
}
