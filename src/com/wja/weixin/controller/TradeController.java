package com.wja.weixin.controller;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.system.service.DictService;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.DateUtil;
import com.wja.base.util.Log;
import com.wja.base.util.Page;
import com.wja.base.web.AppContext;
import com.wja.base.web.RequestThreadLocal;
import com.wja.weixin.entity.TradeRecord;
import com.wja.weixin.service.TradeService;

@Controller
@RequestMapping("/wx/web/fee")
public class TradeController
{
    @Autowired
    private TradeService tradeService;
    
    @Autowired
    private DictService ds;
    
    @RequestMapping("view")
    public String view(Model model)
    {
        String openId = RequestThreadLocal.openId.get();
        model.addAttribute("ac", this.tradeService.getAccount(openId));
        return "weixin/fee/fee";
    }
    
    @RequestMapping("cz")
    public String toCz(Model model)
    {
        model.addAttribute("opts", ds.getByPid("cz.amount"));
        return "weixin/fee/cz";
    }
    
    @RequestMapping("czok")
    public String toCzok(Model model)
    {
        return "weixin/fee/czok";
    }
    
    @RequestMapping("docz")
    @ResponseBody
    public Object doCz(BigDecimal amount, String timeStamp,String nonceStr, HttpServletRequest req)
    {
        if (amount == null || amount.compareTo(new BigDecimal(0)) != 1
            || amount.compareTo(new BigDecimal(999999.99)) == 1)
        {
            return OpResult.error("金额[" + amount.toPlainString() + "]不正确,需在0.01~999999.99间", null);
        }
        
        try
        {
            return OpResult.ok().setData(this.tradeService.generateJsPayParam(req.getRemoteAddr(),
                amount,
                TradeRecord.BusiType.CZ,
                AppContext.getSysParam("wx.cz.body"),
                null,timeStamp,nonceStr));
        }
        catch (Exception e)
        {
            Log.LOGGER.error("调用微信接口生成订单异常", e);
            return OpResult.error("调用微信接口生成订单异常", e.getMessage());
        }
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
