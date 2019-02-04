package com.guotop.palmschool.dao.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

import com.guotop.palmschool.dao.BaseDao;
import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * dao层公用方法实现类
 * @author zhou
 *
 */
@SuppressWarnings("deprecation")
@Repository
public class BaseDaoImpl extends SqlMapClientDaoSupport implements BaseDao 
{
	
	@Resource(name = "sqlMapClient")
	private SqlMapClient sqlMapClient;

	@PostConstruct
	public void initSqlMapClient() 
	{
		super.setSqlMapClient(sqlMapClient);
	}

	/**
	 * 根据对象的已有属性查找出该对象的所有属性
	 * @param sql iBATIS中的sql映射名
	 * @param object 含有若干属性的对象
	 * @return 查找出该对象所有的属性
	 */
	public Object selectObjectByObject(String sql, Object object)
	{
		return getSqlMapClientTemplate().queryForObject(sql, object);
	}
	
	/**
	 * 根据id查找List
	 * @param sql 
	 * @param id
	 * @return 
	 */
	@SuppressWarnings("rawtypes")
	public List selectList(String sql, Integer id)
	{
		return getSqlMapClientTemplate().queryForList(sql, id);
	}
	
	/**
	 * 根据id查找Object
	 * @param sql 
	 * @param id
	 * @return 
	 */
	public Object selectObject(String sql, Integer id)
	{
		return getSqlMapClientTemplate().queryForObject(sql, id);
	}
	
	
	/**
	 * 根据object查找List
	 * @param sql 
	 * @param object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectListByObject(String sql, Object object)
	{
		return getSqlMapClientTemplate().queryForList(sql, object);
	}
	
	/**
	 * 根据sql查找List
	 * @param sql
	 * @return List
	 */
	@SuppressWarnings("rawtypes")
	public List selectListBySql(String sql)
	{
		return getSqlMapClientTemplate().queryForList(sql);
	}
	
	/**
	 * 修改object
	 * @param sql
	 * @param object 待修改的object
	 */
	public void updateObject(String sql, Object object)
	{
		getSqlMapClientTemplate().update(sql, object);
	}
	
	/**
	 * 删除对象
	 * @param sql
	 */
	public void deleteObject(String sql, Object object)
	{
		getSqlMapClientTemplate().delete(sql, object);
	}
	
	/**
	 * 根据ID删除对象
	 * @param sql
	 * @param id
	 */
	public void deleteObjectById(String sql, Integer id)
	{
		getSqlMapClientTemplate().delete(sql, id);
	}
	
	/**
	 * 添加对象(可以获取其返回结果：此数据插入表中生成的主键)
	 * @param sql
	 * @param object
	 */
	public Integer addObject(String sql, Object object)
	{
		return (Integer) getSqlMapClientTemplate().insert(sql, object);
	}
	
	public Integer addObjectReturnId(String sql, Object object)
	{
		Object primaryId = getSqlMapClientTemplate().insert(sql, object);
		
		return (Integer) primaryId;
	}
	
	/**
	 * 查询所有记录数
	 * 
	 * @return 总记录数
	 */
	public int getAllRowCount(String sql) 
	{
		return getSqlMapClientTemplate().queryForList(sql).size();
	}
	
	/**
	 * 分页查询
	 * 
	 * @param sql
	 *            查询的条件
	 * @param offset
	 *            开始记录
	 * @param length
	 *            一次查询几条记录
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List queryForPage(final String sql, final int offset,
			final int length)
	{
		 return getSqlMapClientTemplate().queryForList(sql, offset, length);
	}
	
	/**
	 * 按照条件查询所有的记录数
	 * 
	 * @param sql 查询的sql
	 * 
	 * @param object 条件
	 * 
	 * @return 总记录数
	 */
	public int getAllRowCountByCondition(String sql, Object object)
	{
		return getSqlMapClientTemplate().queryForList(sql, object).size();
	}
	
	/**
	 * 按照条件分页查询
	 * 
	 * @param sql
	 *            查询的条件
	 * @param offset
	 *            开始记录
	 * @param length
	 *            一次查询几条记录
	 *   
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List queryForPageByCondition(final String sql, Object object, final int offset,
			final int length)
	{
		return getSqlMapClientTemplate().queryForList(sql, object, offset, length);
	}
	
	/**
	 * 查询map
	 * @param sql 查询语句
	 * @param object 入参
	 * @param key 返回map key
	 * @param value 返回map value
	 * @return 返回map
	 */
	@SuppressWarnings("rawtypes")
	public Map queryForMap(String sql, Object object, String key, String value)
	{
		return getSqlMapClientTemplate().queryForMap(sql, object, key, value);
	}
}
