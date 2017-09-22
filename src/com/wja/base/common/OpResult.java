package com.wja.base.common;

public class OpResult
{
    /**
     * 结果码： 成功
     */
    public static final int STATUS_OK = 200;
    
    /**
     * 结果码： 系统异常失败
     */
    public static final int STATUS_ERROR = 500;
    
    /**
     * 操作：操作
     */
    public static final int OPER_NORMAL = 0;
    
    /**
     * 操作：新增
     */
    public static final int OPER_ADD = 1;
    
    /**
     * 操作：修改
     */
    public static final int OPER_UPDATE = 2;
    
    /**
     * 操作：删除
     */
    public static final int OPER_DELETE = 3;
    
    /**
     * 结果状态码
     */
    private int status = STATUS_OK;
    
    /**
     * 操作
     */
    private int operate = OPER_NORMAL;
    
    private String mess;
    
    private Object data;
    
    public OpResult(int status, int operate, String mess, Object data)
    {
        this.status = status;
        this.operate = operate;
        this.mess = mess;
        this.data = data;
    }
    
    public static OpResult ok()
    {
        return new OpResult(STATUS_OK, OPER_NORMAL, null, null);
    }
    
    public static OpResult error(String mess, Object data)
    {
        return new OpResult(STATUS_ERROR, OPER_NORMAL, mess, data);
    }
    
    public static OpResult addOk()
    {
        return new OpResult(STATUS_OK, OPER_ADD, null, null);
    }
    
    public static OpResult addOk(Object data)
    {
        return new OpResult(STATUS_OK, OPER_ADD, null, data);
    }
    
    public static OpResult addError(String mess, Object data)
    {
        return new OpResult(STATUS_ERROR, OPER_ADD, mess, data);
    }
    
    public static OpResult updateOk()
    {
        return new OpResult(STATUS_OK, OPER_UPDATE, null, null);
    }
    
    public static OpResult updateOk(Object data)
    {
        return new OpResult(STATUS_OK, OPER_UPDATE, null, data);
    }
    
    public static OpResult updateError(String mess, Object data)
    {
        return new OpResult(STATUS_ERROR, OPER_UPDATE, mess, data);
    }
    
    public static OpResult deleteOk()
    {
        return new OpResult(STATUS_OK, OPER_DELETE, null, null);
    }
    
    public static OpResult deleteOk(String mess, Object data)
    {
        return new OpResult(STATUS_OK, OPER_DELETE, mess, data);
    }
    
    public static OpResult deleteError(String mess, Object data)
    {
        return new OpResult(STATUS_ERROR, OPER_DELETE, mess, data);
    }
    
    public String getMess()
    {
        return mess;
    }
    
    public OpResult setMess(String mess)
    {
        this.mess = mess;
        return this;
    }
    
    public Object getData()
    {
        return data;
    }
    
    public OpResult setData(Object data)
    {
        this.data = data;
        return this;
    }
    
    public int getStatus()
    {
        return status;
    }
    
    public OpResult setStatus(int status)
    {
        this.status = status;
        return this;
    }
    
    public int getOperate()
    {
        return operate;
    }
    
    public OpResult setOperate(int operate)
    {
        this.operate = operate;
        return this;
    }
    
}
