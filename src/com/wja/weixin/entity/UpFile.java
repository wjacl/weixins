package com.wja.weixin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.wja.base.common.CommConstants;

@Entity
@Table(name = "t_wx_up_files")
public class UpFile
{
    @Id
    @Column(name = "id", length = 200)
    /*@GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")*/
    private String id;
    
    @Column(length = 200)
    private String fileName;
    
    @Column(length = 20)
    private String type;
    
    /**
     * 数据删除标识
     * 
     * @see CommConstants.DATA_VALID
     */
    @Column(length = 1)
    private byte valid = CommConstants.DATA_VALID;
    
    public UpFile()
    {
    }
    
    public UpFile(String fileName, String type)
    {
        this.fileName = fileName;
        this.type = type;
    }
    
    public UpFile(String id,String fileName, String type)
    {
        this.id = id;
        this.fileName = fileName;
        this.type = type;
    }
    
    public String getId()
    {
        return id;
    }
    
    public void setId(String id)
    {
        this.id = id;
    }
    
    public String getFileName()
    {
        return fileName;
    }
    
    public void setFileName(String fileName)
    {
        this.fileName = fileName;
    }
    
    public String getType()
    {
        return type;
    }
    
    public void setType(String type)
    {
        this.type = type;
    }
    
    public byte getValid()
    {
        return valid;
    }
    
    public void setValid(byte valid)
    {
        this.valid = valid;
    }
    
}
