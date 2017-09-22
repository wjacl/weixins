package com.wja.base.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.system.entity.Dict;
import com.wja.base.system.service.DictService;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.Sort;

@Controller
@RequestMapping("/dict")
public class DictController
{
    @Autowired
    private DictService ds;
    
    @RequestMapping("main")
    public String toMain()
    {
        return "system/dict";
    }
    
    @RequestMapping("tree")
    @ResponseBody
    public List<Dict> getRoots(String id)
    {
        Sort sort = new Sort("pid,ordno", "asc,asc");
        return this.ds.getAll(sort);
    }
    
    @RequestMapping("setOrder")
    @ResponseBody
    public Object setOrder(String[] dictIds)
    {
        this.ds.setOrder(dictIds);
        return OpResult.ok();
    }
    
    @RequestMapping("nameCheck")
    @ResponseBody
    public boolean nameCheck(String name, String pid)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("name", name);
        params.put("pid", pid);
        List<Dict> list = this.ds.query(params, null);
        return CollectionUtil.isEmpty(list);
    }
    
    @RequestMapping("valueCheck")
    @ResponseBody
    public boolean valueCheck(String value, String pid)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("value", value);
        params.put("pid", pid);
        List<Dict> list = this.ds.query(params, null);
        return CollectionUtil.isEmpty(list);
    }
    
    @RequestMapping("get")
    @ResponseBody
    public List<Dict> getByPvalue(String pvalue)
    {
        return this.ds.getGroupByPvalue(pvalue);
    }
    
    @RequestMapping("save")
    @ResponseBody
    public Object save(Dict dict)
    {
        if (StringUtils.isBlank(dict.getId()))
        {
            this.ds.add(dict);
            return OpResult.addOk(dict);
        }
        else
        {
            this.ds.update(dict);
            return OpResult.updateOk(dict);
        }
    }
    
    @RequestMapping("remove")
    @ResponseBody
    public Object remove(String[] ids)
    {
        if (ids != null && ids.length > 0)
        {
            this.ds.delete(Dict.class, ids);
        }
        
        return OpResult.deleteOk();
    }
    
}
