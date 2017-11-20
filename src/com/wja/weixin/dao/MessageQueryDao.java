package com.wja.weixin.dao;

import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.wja.base.util.Page;
import com.wja.weixin.entity.MessageVo;

@Component
public class MessageQueryDao
{
    @PersistenceContext
    private EntityManager em;
    
    public Page<MessageVo> queryMyMessages(String openId,String title,Date stime,Page<MessageVo> page){
        String sql = "select a.*,d.name,c.createTime readTime " +
                    " from t_wx_message a join t_wx_follwer_info d on (a.pubid = d.openid) " + 
                    " LEFT JOIN t_wx_mess_rec c " +
                    " on (a.id = c.messid and c.recid = ?) " +
                    " where a.valid = 1 " +
                    "   and a.create_time >= ? " +
                    "   and (a.trange = '1'  " +
                    "         or a.pubid in (select b.bgzid " +
                    "                        from t_wx_gz_record b " +
                    "                        where b.gzid = ?) " +
                    "       ) " +
                    (StringUtils.isBlank(title) ? "" : " and a.title like ? ") +
                    " order by a.createTime desc ";
        
        String countSql = "select count(*) " +
            " from t_wx_message a " +
            " where a.valid = 1 " +
            "   and a.create_time >= ? " +
            "   and (a.trange = '1'  " +
            "         or (a.pubid in (select b.bgzid " +
            "                        from t_wx_gz_record b " +
            "                        where b.gzid = ?) " +
            "       )" +
            (StringUtils.isBlank(title) ? "" : " and a.title like ? ");
        
        Query query = em.createNativeQuery(countSql);
        query.setParameter(0, stime);
        query.setParameter(1, openId);
        if(StringUtils.isNotBlank(title)){
            query.setParameter(2, "%" + title + "%");
        }
        Long total = (Long)query.getSingleResult();
        page.setTotal(total);
        if((page.getPageNum() - 1) * page.getSize() + 1 >= total){
            query = em.createNativeQuery(sql,MessageVo.class);
            query.setParameter(0, openId);
            query.setParameter(1, stime);
            query.setParameter(2, openId);
            if(StringUtils.isNotBlank(title)){
                query.setParameter(3, "%" + title + "%");
            }
            query.setFirstResult(page.getStartNum() - 1);
            query.setMaxResults(page.getSize());
            page.setRows(query.getResultList());
        }
        
        return page;
    }
    
}
