package com.wja.base.common.service;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.wja.base.util.Log;

/**
 * 
 * 异步任务服务
 * 
 * @author  wja
 * @version  [v1.0, 2017年11月29日]
 * @see  [相关类/方法]
 * @since  [产品/模块版本]
 */
@Service
public class AsynchTaskService
{
    /**
     * 线程池大小
     */
    @Value("${asynch.task.threadpool.size}")
    private String threadPoolSize;
    
    private ExecutorService executorService;
    
    public AsynchTaskService(){
        int size = 5;
        if(threadPoolSize != null){
            try{
                size = Integer.parseInt(threadPoolSize);
            }catch(Exception e){
                Log.LOGGER.error("初始化异步任务线程池，获取池大小错误，设为了默认值5", e);
            }
        }
        this.executorService = Executors.newFixedThreadPool(size);
        Log.LOGGER.info("********************初始化异步任务线程池完成，线程数为：" + size);
    }
    
    public void execute(Runnable task){
        this.executorService.execute(task);
    }
    
    public Future<?> submit(Runnable task){
        return this.executorService.submit(task);
    }
    
    public Future<T> submit(Callable<T> task){
        return this.executorService.submit(task);
    }
}
