package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "t_wx_wx_trades")
public class WeiXinTradeRecord
{
    @Id
    @Column(length = 24)
    private String out_trade_no;
    
    @Column(length = 32)
    private String openid;
    
    @Column(length = 14)
    private String time_start;
    
    private int total_fee;
    
    @Column(length = 128)
    private String attach;
    
    @Column(length = 14)
    private String time_end;
    
    @Column(length = 32)
    private String prepay_id;
    
    @Column(length = 32)
    private String transaction_id;
    
    public String getOut_trade_no()
    {
        return out_trade_no;
    }
    
    public void setOut_trade_no(String out_trade_no)
    {
        this.out_trade_no = out_trade_no;
    }
    
    public String getOpenid()
    {
        return openid;
    }
    
    public void setOpenid(String openid)
    {
        this.openid = openid;
    }
    
    public String getTime_start()
    {
        return time_start;
    }
    
    public void setTime_start(String time_start)
    {
        this.time_start = time_start;
    }
    
    public int getTotal_fee()
    {
        return total_fee;
    }
    
    public void setTotal_fee(int total_fee)
    {
        this.total_fee = total_fee;
    }
    
    public String getAttach()
    {
        return attach;
    }
    
    public void setAttach(String attach)
    {
        this.attach = attach;
    }
    
    public String getTime_end()
    {
        return time_end;
    }
    
    public void setTime_end(String time_end)
    {
        this.time_end = time_end;
    }
    
    public String getPrepay_id()
    {
        return prepay_id;
    }
    
    public void setPrepay_id(String prepay_id)
    {
        this.prepay_id = prepay_id;
    }
    
    public String getTransaction_id()
    {
        return transaction_id;
    }
    
    public void setTransaction_id(String transaction_id)
    {
        this.transaction_id = transaction_id;
    }
    
}
