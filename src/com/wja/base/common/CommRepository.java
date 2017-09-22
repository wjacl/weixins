package com.wja.base.common;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.NoRepositoryBean;

@NoRepositoryBean
public interface CommRepository<T, ID extends Serializable> extends JpaRepository<T, ID>, JpaSpecificationExecutor<T>
{
    @Query("from #{#entityName} u where u.id in ?1")
    List<T> findAll(Serializable[] ids);
    
    /**
     * 逻辑删除 the entity with the given id.
     * 
     * @param id must not be {@literal null}.
     * @throws IllegalArgumentException in case the given {@code id} is {@literal null}
     */
    @Modifying
    @Query("update #{#entityName} u set u.valid = 0 where u.id = ?1 ")
    void logicDelete(ID id);
    
    /**
     * 批量逻辑删除 the entity with the given id.
     * 
     * @param id must not be {@literal null}.
     * @throws IllegalArgumentException in case the given {@code id} is {@literal null}
     */
    @Modifying
    @Query("update #{#entityName} u set u.valid = 0 where u.id in ?1 ")
    void logicDeleteInBatch(Iterable<ID> ids);
    
    /**
     * 批量逻辑删除 the entity with the given id.
     * 
     * @param id must not be {@literal null}.
     * @throws IllegalArgumentException in case the given {@code id} is {@literal null}
     */
    @Modifying
    @Query("update #{#entityName} u set u.valid = 0 where u.id in ?1 ")
    void logicDeleteInBatch(Serializable[] ids);
    
}
