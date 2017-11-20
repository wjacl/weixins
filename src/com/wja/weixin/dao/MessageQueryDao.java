package com.wja.weixin.dao;

import java.math.BigInteger;
import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.wja.base.util.DateUtil;
import com.wja.base.util.Page;

@Component
public class MessageQueryDao
{
    @PersistenceContext
    private EntityManager em;
    
    public Page<?> queryMyMessages(String openId,String title,Date stime,Page<?> page){
        
        String sql = "select a.id,a.pubid,a.title,a.img,date_format(a.create_time,'%Y-%m-%d %H:%i'),d.name pubName,date_format(c.create_time,'%Y-%m-%d %H:%i') readTime " +
                    " from t_wx_message a join t_wx_follwer_info d on (a.pubid = d.openid) " + 
                    " LEFT JOIN t_wx_mess_rec c " +
                    " on (a.id = c.messid and c.recid = ?) " +
                    " where a.valid = 1 " +
                    "   and a.create_time >= ? " +
                    "   and (a.trange = '1'  " +
                    "         or a.pubid in (select b.bgzid " +
                    "                        from t_wx_gz_record b " +
                    "                        where b.gzid = ? and b.valid = 1) " +
                    "       ) " +
                    (StringUtils.isBlank(title) ? "" : " and a.title like ? ") +
                    " order by a.create_time desc ";
        
        String countSql = "select count(*) " +
            " from t_wx_message a " +
            " where a.valid = 1 " +
            "   and a.create_time >= ? " +
            "   and (a.trange = '1'  " +
            "         or a.pubid in (select b.bgzid " +
            "                        from t_wx_gz_record b " +
            "                        where b.gzid = ? and b.valid = 1) " +
            "       ) " +
            (StringUtils.isBlank(title) ? "" : " and a.title like ? ");
        
        /*
        String sql = "select a.*,d.name,c.createTime readTime " +
            " from Message a join FollwerInfo d on (a.pubid = d.openId) " + 
            " LEFT JOIN MessReceiveRecord c " +
            " on (a.id = c.messId and c.recId = ?) " +
            " where a.valid = 1 " +
            "   and a.createTime >= ? " +
            "   and (a.trange = '1'  " +
            "         or a.pubId in (select b.bgzid " +
            "                        from GzRecord b " +
            "                        where b.gzid = ? and b.valid = 1) " +
            "       ) " +
            (StringUtils.isBlank(title) ? "" : " and a.title like ? ") +
            " order by a.createTime desc ";
        
        String countSql = "select count(*) "
            + " from Message a "
            + " where a.valid = 1 "
            + " and a.createTime >= ? "
            + " and (a.trange = '1' or a.pubId in (select b.bgzid from GzRecord where b.gzid = ?)) " +
            (StringUtils.isBlank(title) ? "" : " and a.title like ? ");
            */
        String strTime = DateUtil.DEFAULT_DF.format(stime);
        Query query = em.createNativeQuery(countSql);
        query.setParameter(1, strTime);
        query.setParameter(2, openId);
        if(StringUtils.isNotBlank(title)){
            query.setParameter(3, "%" + title + "%");
        }
        Long total = ((BigInteger)query.getSingleResult()).longValue();
        page.setTotal(total);
        if((page.getPageNum() - 1) * page.getSize() + 1 <= total){
            query = em.createNativeQuery(sql);
            query.setParameter(1, openId);
            query.setParameter(2, strTime);
            query.setParameter(3, openId);
            if(StringUtils.isNotBlank(title)){
                query.setParameter(4, "%" + title + "%");
            }
            query.setFirstResult(page.getStartNum() - 1);
            query.setMaxResults(page.getSize());
            page.setRows(query.getResultList());
        }
        
        return page;
    }
    
}
