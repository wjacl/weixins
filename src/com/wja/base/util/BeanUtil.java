package com.wja.base.util;

import java.beans.PropertyDescriptor;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.FatalBeanException;
import org.springframework.util.Assert;
import org.springframework.util.ClassUtils;

import com.wja.base.common.CommDao;
import com.wja.base.web.AppContext;

public class BeanUtil extends BeanUtils {
    /**
     * 
     * 忽略null值的bean属性复制
     * 
     * @param source
     * @param target
     * @throws BeansException
     * @see [类、类#方法、类#成员]
     */
    public static void copyPropertiesIgnoreNull(Object source, Object target) throws BeansException {
	copyPropertiesIgnoreNull(source, target, null, (String[]) null);
    }

    /**
     * 
     * 忽略null值的bean属性复制
     * 
     * @param source
     * @param target
     * @param editable
     *            复制指定的类的属性
     * @throws BeansException
     * @see [类、类#方法、类#成员]
     */
    public static void copyPropertiesIgnoreNull(Object source, Object target, Class<?> editable) throws BeansException {
	copyPropertiesIgnoreNull(source, target, editable, (String[]) null);
    }

    /**
     * 
     * 忽略null值的bean属性复制
     * 
     * @param source
     * @param target
     * @param editable
     *            复制指定的类的属性
     * @param ignoreProperties
     *            忽略的属性
     * @throws BeansException
     * @see [类、类#方法、类#成员]
     */
    public static void copyPropertiesIgnoreNull(Object source, Object target, Class<?> editable,
	    String... ignoreProperties) throws BeansException {

	Assert.notNull(source, "Source must not be null");
	Assert.notNull(target, "Target must not be null");

	Class<?> actualEditable = target.getClass();
	if (editable != null) {
	    if (!editable.isInstance(target)) {
		throw new IllegalArgumentException("Target class [" + target.getClass().getName()
			+ "] not assignable to Editable class [" + editable.getName() + "]");
	    }
	    actualEditable = editable;
	}
	PropertyDescriptor[] targetPds = getPropertyDescriptors(actualEditable);
	List<String> ignoreList = (ignoreProperties != null ? Arrays.asList(ignoreProperties) : null);

	for (PropertyDescriptor targetPd : targetPds) {
	    Method writeMethod = targetPd.getWriteMethod();
	    if (writeMethod != null && (ignoreList == null || !ignoreList.contains(targetPd.getName()))) {
		PropertyDescriptor sourcePd = getPropertyDescriptor(source.getClass(), targetPd.getName());
		if (sourcePd != null) {
		    Method readMethod = sourcePd.getReadMethod();
		    if (readMethod != null && ClassUtils.isAssignable(writeMethod.getParameterTypes()[0],
			    readMethod.getReturnType())) {
			try {
			    if (!Modifier.isPublic(readMethod.getDeclaringClass().getModifiers())) {
				readMethod.setAccessible(true);
			    }
			    Object value = readMethod.invoke(source);
			    if (value != null) {
				if (!Modifier.isPublic(writeMethod.getDeclaringClass().getModifiers())) {
				    writeMethod.setAccessible(true);
				}
				writeMethod.invoke(target, value);
			    }
			} catch (Throwable ex) {
			    throw new FatalBeanException(
				    "Could not copy property '" + targetPd.getName() + "' from source to target", ex);
			}
		    }
		}
	    }
	}
    }

    /**
     * 
     * 对集合中的bean中有SetValue注解的属性进行值设置的工具方法
     * 
     * @param col
     * @see [类、类#方法、类#成员]
     */
    public static <T> void setCollFieldValues(Collection<T> col) {
	setCollFieldValues(col, null);
    }

    /**
     * 
     * 对集合中的bean中有SetValue注解的属性进行值设置的工具方法
     * 
     * @param col
     *            要设置值的集合
     * @param c
     *            要设置值的属性所属的类，即限定指设置这个类的带有SetValue注解的属性。
     * @see [类、类#方法、类#成员]
     */
    public static <T, C> void setCollFieldValues(Collection<T> col, Class<C> c) {
	if (CollectionUtil.isEmpty(col)) {
	    return;
	}
	Class<?> clazz = c;
	if (clazz == null) {
	    clazz = col.iterator().next().getClass();
	}

	Map<String, Object> cache = new HashMap<>();

	Field[] fields = clazz.getDeclaredFields();
	for (Field f : fields) {
	    SetValue vf = f.getAnnotation(SetValue.class);
	    if (vf != null) {
		try {
		    Method getIdValueMethod = clazz.getMethod("get" + StringUtils.capitalize(vf.id()));
		    Method setMethod = clazz.getMethod("set" + StringUtils.capitalize(f.getName()), f.getType());
		    Method getFieldValueMethod = vf.clazz().getMethod("get" + StringUtils.capitalize(vf.field()));

		    Object idValue = null;
		    for (Object o : col) {
			idValue = getIdValueMethod.invoke(o);
			if (idValue != null) {
			    String cacheKey = vf.clazz().getName() + "-" + idValue;
			    String valueCacheKey = cacheKey + "-" + vf.field();
			    if (cache.containsKey(valueCacheKey)) {
				Object val = cache.get(valueCacheKey);
				setMethod.invoke(o, val);
			    } else {
				Object bean = null;
				if (!cache.containsKey(cacheKey)) {
				    CommDao dao = AppContext.getWebApplicationContext().getBean(CommDao.class);
				    bean = dao.get(vf.clazz(), (Serializable) idValue);
				    cache.put(cacheKey, bean);
				} else {
				    bean = cache.get(cacheKey);
				}

				if (bean != null) {
				    try {
					Object fieldValue = getFieldValueMethod.invoke(bean);
					cache.put(valueCacheKey, fieldValue);
					setMethod.invoke(o, fieldValue);
				    } catch (Exception e) {
					Log.LOGGER.error("Bean属性值设置时，获取Id属性的get方法异常", e);
				    }
				}
			    }
			}
		    }

		} catch (Exception e) {
		    Log.LOGGER.error("Bean属性值设置时，获取Id属性的get方法异常", e);
		}

	    }
	}

    }

    /**
     * 
     * 对bean中有SetValue注解的属性进行值设置的工具方法
     * 
     * @param o
     * @see [类、类#方法、类#成员]
     */
    public static <T> void setFieldValues(T o) {
	setFieldValues(o, null);
    }

    /**
     * 
     * 对bean中有SetValue注解的属性进行值设置的工具方法
     * 
     * @param o
     *            bean对象
     * @param c
     *            限定指设置这个类的带有SetValue注解的属性
     * @see [类、类#方法、类#成员]
     */
    public static <T> void setFieldValues(Object o, Class<T> c) {
	Class<?> clazz = c;
	if (clazz == null) {
	    clazz = o.getClass();
	}

	Map<String, Object> cache = new HashMap<>();

	Field[] fields = clazz.getDeclaredFields();
	for (Field f : fields) {
	    SetValue vf = f.getAnnotation(SetValue.class);
	    if (vf != null) {
		Object idValue = null;
		String getMethodName = "get" + StringUtils.capitalize(vf.id());
		try {
		    Method getm = clazz.getMethod(getMethodName);
		    idValue = getm.invoke(o);
		} catch (Exception e) {
		    Log.LOGGER.error("Bean属性值设置时，获取Id属性的get方法异常", e);
		}

		if (idValue != null) {
		    String cacheKey = vf.clazz().getName() + "-" + idValue;
		    Object bean = null;
		    if (!cache.containsKey(cacheKey)) {
			CommDao dao = AppContext.getWebApplicationContext().getBean(CommDao.class);
			bean = dao.get(vf.clazz(), (Serializable) idValue);
			cache.put(cacheKey, bean);
		    } else {
			bean = cache.get(cacheKey);
		    }

		    if (bean != null) {
			String getMe = "get" + StringUtils.capitalize(vf.field());
			try {
			    Method getm = vf.clazz().getMethod(getMe);
			    Object fieldValue = getm.invoke(bean);
			    Method setm = clazz.getMethod("set" + StringUtils.capitalize(f.getName()), f.getType());
			    if (setm != null) {
				setm.invoke(o, fieldValue);
			    }
			} catch (Exception e) {
			    Log.LOGGER.error("Bean属性值设置时，获取Id属性的get方法异常", e);
			}
		    }
		}

	    }
	}
    }

    /**
     * 
     * 利用反射调用set方法填充对象指定属性的值
     * 
     * @param obj
     * @param fieldName
     * @param value
     * @throws Exception
     * @see [类、类#方法、类#成员]
     */
    public static void setFieldValue(Object obj, String fieldName, Object value) throws Exception {
	Class c = obj.getClass();
	Method method = c.getMethod("set" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1),
		c.getDeclaredField(fieldName).getType()); // 方法
	method.invoke(obj, value);
    }
}
