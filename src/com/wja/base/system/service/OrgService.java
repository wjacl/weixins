package com.wja.base.system.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.system.dao.OrgDao;
import com.wja.base.system.entity.Org;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.Sort;

@Service
public class OrgService {
    @Autowired
    private OrgDao dao;

    /**
     * 查询指定组织机构下的所有子孙机构
     * 
     * @param porg
     *            指定的父机构
     * @param orgs
     *            存放子孙机构的List
     * @param param
     *            附加的查询条件，可为null
     * @param sort
     *            排序规则,可为null,为空时会按ordno 升序排序
     * @see [类、类#方法、类#成员]
     */
    public void getAllChildOrg(Org porg, List<Org> orgs, Map<String, Object> param, Sort sort) {
	if (param == null) {
	    param = new HashMap<>();
	}
	param.put("pid_eq_String", porg.getId());
	if (sort == null) {
	    sort = new Sort("ordno", "asc");
	}
	List<Org> childs = this.findAll(param, sort);
	if (!CollectionUtil.isEmpty(childs)) {
	    orgs.addAll(childs);
	    for (Org o : childs) {
		this.getAllChildOrg(o, orgs, param, sort);
	    }
	}
    }

    public Org save(Org org) {
	if (StringUtils.isNotBlank(org.getId())) {
	    Org temp = this.dao.getOne(org.getId());
	    BeanUtil.copyPropertiesIgnoreNull(org, temp);
	    org = temp;
	}

	return this.dao.save(org);
    }

    public Org getByPidAndName(String pid, String name) {
	return this.dao.findByPidAndName(pid, name);
    }

    /**
     * 
     * 对一个机构下的子机构进行排序
     * 
     * @param orgIds
     * @see [类、类#方法、类#成员]
     */
    public void setOrder(String[] orgIds) {
	if (CollectionUtil.isNotEmpty(orgIds)) {
	    Org org = null;
	    for (short i = 0; i < orgIds.length; i++) {
		org = this.get(orgIds[i]);
		if (org != null) {
		    org.setOrdno(i);
		    this.dao.save(org);
		}
	    }
	}
    }

    public List<Org> findAll() {
	Sort sort = new Sort("pid,ordno", "asc,asc");
	return this.dao.findAll(sort.getSpringSort());
    }

    public List<Org> findAll(Map<String, Object> params, Sort sort) {
	return this.dao.findAll(new CommSpecification<Org>(params), sort == null ? null : sort.getSpringSort());
    }

    public void delete(String[] ids) {
	this.dao.logicDeleteInBatch(ids);
    }

    public Org get(String id) {
	return this.dao.getOne(id);
    }
}
