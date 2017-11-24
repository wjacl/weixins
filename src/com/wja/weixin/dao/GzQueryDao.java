package com.wja.weixin.dao;

import java.math.BigInteger;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.wja.base.util.Page;

@Component
public class GzQueryDao
{
    @PersistenceContext
    private EntityManager em;
    
    public Page<?> queryMyGz(String openId,Map<String,String> params,Page<?> page){
        StringBuilder sql = new StringBuilder();
        StringBuilder sqlCount = new StringBuilder();
        sql.append("select b.openId,b.name,b.category,b.logo,b.address,b.mphone,b.wechat,date_format(a.create_time,'%Y-%m-%d %H:%i') gt " +
                    " from t_wx_gz_record a, " +
                    "     t_wx_follwer_info b " +
                    " where a.valid = 1 " +
                    "   and b.valid = 1 " +
                    "     and a.bgzid = b.openId " +
                    "   and a.gzid = ? ");
        
        sqlCount.append("select count(*) " +
            " from t_wx_gz_record a, " +
            "     t_wx_follwer_info b " +
            " where a.valid = 1 " +
            "   and b.valid = 1 " +
            "     and a.bgzid = b.openId " +
            "   and a.gzid = ? ");
        String name = params.get("name");
        if(StringUtils.isNotBlank(name)){
            sql.append("     and (b.name like ? or b.pinyin like ?) ");
            sqlCount.append("     and (b.name like ? or b.pinyin like ?) ");
            name = "%" + name + "%";
        }
        
        String category = params.get("category");
        String[] cats = null;
        if(StringUtils.isNotBlank(category)){
            cats = category.split(",");
            sql.append("     and b.category in (");
            sqlCount.append("     and b.category in (");
            for(int i = 0; i < cats.length; i++){
                if(i == 0){
                    sql.append("?");
                    sqlCount.append("?");
                }
                else{
                    sql.append(",?");
                    sqlCount.append(",?");
                }
            }
            sql.append(")");
            sqlCount.append(")");
        }
        
        sql.append(" order by a.create_time desc");
        
        Query query = em.createNativeQuery(sqlCount.toString());
        int i = 1;
        query.setParameter(i++, openId);
        if(StringUtils.isNotBlank(name)){
            query.setParameter(i++, name);
            query.setParameter(i++, name);
        }
        if(StringUtils.isNotBlank(category)){
            for(String c : cats){
                query.setParameter(i++, c);
            }
        }
        Long total = ((BigInteger)query.getSingleResult()).longValue();
        page.setTotal(total);
        
        if((page.getPageNum() - 1) * page.getSize() + 1 <= total){
            query = em.createNativeQuery(sql.toString());
            i = 1;
            query.setParameter(i++, openId);
            if(StringUtils.isNotBlank(name)){
                query.setParameter(i++, name);
                query.setParameter(i++, name);
            }
            if(StringUtils.isNotBlank(category)){
                for(String c : cats){
                    query.setParameter(i++, c);
                }
            }
            query.setFirstResult(page.getStartNum() - 1);
            query.setMaxResults(page.getSize());
            page.setRows(query.getResultList());
        }
        
        return page;
    }
    
}
