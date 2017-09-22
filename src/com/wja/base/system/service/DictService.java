package com.wja.base.system.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.common.service.CommService;
import com.wja.base.system.dao.DictDao;
import com.wja.base.system.entity.Dict;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.Sort;

@Service
public class DictService extends CommService<Dict>
{
    @Autowired
    private DictDao dictDao;
    
    /**
     * 
     * 对同一个父亲下的子进行排序
     * 
     * @param dictIds
     * @see [类、类#方法、类#成员]
     */
    public void setOrder(String[] dictIds)
    {
        if (CollectionUtil.isNotEmpty(dictIds))
        {
            Dict dict = null;
            for (int i = 0; i < dictIds.length; i++)
            {
                dict = this.dictDao.getOne(dictIds[i]);
                if (dict != null)
                {
                    dict.setOrdno(i);
                    this.dictDao.save(dict);
                }
            }
        }
    }
    
    @Override
    public Dict update(Dict dict)
    {
        Dict temp = this.get(Dict.class, dict.getId());
        temp.setName(dict.getName());
        return this.dictDao.save(temp);
    }
    
    public List<Dict> getByPid(String pid)
    {
        return this.dictDao.findByPidOrderByOrdnoAsc(pid);
    }
    
    public List<Dict> getGroupByPvalue(String pvalue)
    {
        Dict p = this.dictDao.findByValueAndPid(pvalue, Dict.ROOT_ID);
        return this.getByPid(p.getId());
    }
    
    public List<Dict> getAll(Sort sort)
    {
        return this.dictDao.findAll(sort.getSpringSort());
    }
    
    public List<Dict> query(Map<String, Object> params, Sort sort)
    {
        return this.dictDao.findAll(new CommSpecification<Dict>(params), sort == null ? null : sort.getSpringSort());
    }
}
