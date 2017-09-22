package com.wja.base.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.service.CommService;
import com.wja.base.system.dao.PrivilegeDao;
import com.wja.base.system.entity.Privilege;

@Service
public class PrivilegeService extends CommService<Privilege> {
	
	@Autowired
	private PrivilegeDao dao;
	
	public List<Privilege> getAll(){
		return this.dao.findAll();
	}
	
}
