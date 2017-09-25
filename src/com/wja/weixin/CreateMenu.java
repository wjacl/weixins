package com.wja.weixin;

import java.util.ArrayList;
import java.util.List;

import org.sword.wechat4j.menu.Menu;
import org.sword.wechat4j.menu.MenuButton;

public class CreateMenu
{
    
    public static void main(String[] args)
    {
        String uri = "http://18494w50i7.51mypc.cn/weixins/weixin/";
        Menu menu = new Menu();
        List<MenuButton> list = new ArrayList<>();
        MenuButton b = new MenuButton();
        list.add(b);
        b.setName("信息");
        List<MenuButton> clist = new ArrayList<>();
        b.setSubButton(clist);
        MenuButton cb = new MenuButton();
        clist.add(cb);
        cb.setName("");
    }
    
}
