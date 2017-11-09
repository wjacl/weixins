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
        /*
         * // 如果带有月份，且页码小于等于1，则当选择了月份进行查询处理：定位月份的首行所在的页码。 if (StringUtils.isNotBlank(month) && page.getPageNum() <= 1) {
         * Date d = DateUtil.getNextMonth(month, null); int srow = this.tradeService.queryAfterCount(openId, d) + 1;
         * page.setPageNum((srow + page.getSize() - 1) / page.getSize()); }
         */
        
        Map<String, Object> param = new HashMap<>();
        param.put("openId", openId);
        Date d = DateUtil.getNextMonth(month, null);
        param.put("createTime_lt_date", d);
        
        page.setOrder("desc");
        page.setSort("createTime");
        
        this.tradeService.tradePageQuery(param, page);
        
        Map<String, Object> res = new HashMap<>();
        res.put("page", page);
        
        // 获取月份统计结果
        if (CollectionUtil.isNotEmpty(page.getRows()))
        {
            Date emonth = page.getRows().get(0).getCreateTime();
            Date smonth = page.getRows().get(page.getRows().size() - 1).getCreateTime();
            
            res.put("tj",
                this.tradeService.queryMonthTongji(openId,
                    DateUtil.getMonthFirstDay(smonth),
                    DateUtil.getNextMonth(emonth)));
        }
        
        return res;
    }
}
