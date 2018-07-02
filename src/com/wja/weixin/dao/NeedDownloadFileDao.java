package com.wja.weixin.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.wja.weixin.entity.NeedDownloadFile;

@Repository
public interface NeedDownloadFileDao extends JpaRepository<NeedDownloadFile, String>, JpaSpecificationExecutor<NeedDownloadFile>
{
 
}
