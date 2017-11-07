package com.wja.weixin.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.util.CollectionUtil;
import com.wja.base.util.DateUtil;
import com.wja.base.util.Page;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.entity.TradeRecord;
import com.wja.weixin.service.TradeService;

@Controller
@RequestMapping("/wx/web/fee")
public class TradeController
{
    @Autowired
    private TradeService tradeService;
    
    @RequestMapping("view")
    public String view()
    {
        return "weixin/fee/fee";
    }
    
    @RequestMapping("query")
    @ResponseBody
    public Object query(String month, Page<TradeRecord> page)
        throws ParseException
    {
        String openId = RequestThreadLocal.openId.get();
        if (openId == null)
        {
            return null;
        }
        
        Date d = DateUtil.getNextMonth(month, null);
        
        Map<String, Object> param = new HashMap<>();
        param.put("openId", openId);
        param.put("createTime_lt_date", d);
        
        page.setOrder("desc");
        page.setSort("createTime");
        
        this.tradeService.tradePageQuery(param, page);
        
        Map<String, Object> res = new HashMap<>();
        res.put("page", page);
        
        // 获取月份统计结果
        if (CollectionUtil.isNotEmpty(page.getRows()))
        {
            Date smonth = page.getRows().get(0).getCreateTime();
            Date emonth = page.getRows().get(page.getRows().size() - 1).getCreateTime();
            
            res.put("tj",
                this.tradeService.queryMonthTongji(openId,
                    DateUtil.getMonthFirstDay(smonth),
                    DateUtil.getNextMonth(emonth)));
        }
        
        return res;
    }
}
