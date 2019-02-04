package com.guotop.palmschool.listener;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.druid.pool.DruidDataSource;
import com.guotop.palmschool.util.StringUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

public class DynamicDataSource extends AbstractRoutingDataSource
{
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	private Map<Object, Object> _targetDataSources;

	@Override
	protected Object determineCurrentLookupKey()
	{
		String dataSourceName = DBContextHolder.getDBType();

		if (StringUtil.isEmpty(dataSourceName))
		{

			dataSourceName = "dataSource";

		} else
		{

			this.selectDataSource(Long.valueOf(dataSourceName));

			if (dataSourceName.equals("0"))

				dataSourceName = "dataSource";

		}

		// log.debug("--------> use datasource " + dataSourceName);

		return dataSourceName;
	}

	public void setTargetDataSources(Map<Object, Object> targetDataSources)
	{

		this._targetDataSources = targetDataSources;

		super.setTargetDataSources(this._targetDataSources);

		afterPropertiesSet();

	}

	private void addTargetDataSource(String key, DruidDataSource dataSource)
	{
		if(!this._targetDataSources.containsKey(key)){
			this._targetDataSources.put(key, dataSource);
			this.setTargetDataSources(this._targetDataSources);
		}
	}

	private DruidDataSource createDataSource(String driverClassName, String url,

	String username, String password)
	{

		DruidDataSource dataSource = new DruidDataSource();

		dataSource.setDriverClassName(driverClassName);

		dataSource.setUrl(url);

		dataSource.setUsername(username);

		dataSource.setPassword(password);

		dataSource.setTestWhileIdle(true);

		return dataSource;

	}

	/**
	 * 
	 * @param serverId
	 * 
	 * @describe 数据源存在时不做处理，不存在时创建新的数据源链接，并将新数据链接添加至缓存
	 */

	private void selectDataSource(Long serverId)
	{

		Object sid = DBContextHolder.getDBType();

		if ("0".equals(serverId + ""))
		{

			DBContextHolder.setDBType("0");

			return;

		}

		Object obj = this._targetDataSources.get(String.valueOf(serverId));

		if (obj != null && sid.equals(serverId + ""))
		{

			return;

		} else
		{

			DruidDataSource dataSource = this.getDataSource(serverId);

			if (null != dataSource)

				this.setDataSource(serverId, dataSource);

		}

	}

	/**
	 * 
	 * @describe 查询serverId对应的数据源记录
	 * 
	 * @param serverId
	 * 
	 * @return
	 */

	private DruidDataSource getDataSource(Long serverId)
	{

		selectDataSource((long) 0);

		this.determineCurrentLookupKey();

		Connection conn = null;

		HashMap<String, Object> map = null;

		try
		{

			conn = this.getConnection();

			PreparedStatement ps = conn

			.prepareStatement("SELECT * FROM platform.school_datasource WHERE schoolId = ?");

			ps.setLong(1, serverId);

			ResultSet rs = ps.executeQuery();

			map = new HashMap<String, Object>();

			if (rs.next())
			{

				map.put("DBS_ID", rs.getLong("schoolId"));

				map.put("DBS_DriverClassName", rs

				.getString("driverClass"));

				map.put("DBS_URL", rs.getString("url"));

				map.put("DBS_UserName", rs.getString("userName"));

				map.put("DBS_Password", rs.getString("passWord"));

			}

			rs.close();

			ps.close();

		} catch (SQLException e)
		{

			logger.error("动态数据源sql执行出错1，错误信息如下："+e);

		} finally
		{

			try
			{

				conn.close();

			} catch (SQLException e)
			{

				logger.error("动态数据源sql执行出错2，错误信息如下："+e);

			}

		}

		if (null != map)
		{

			String driverClassName = map.get("DBS_DriverClassName").toString();

			String url = map.get("DBS_URL").toString();

			String userName = map.get("DBS_UserName").toString();

			String password = map.get("DBS_Password").toString();

			DruidDataSource dataSource = createDataSource(driverClassName,

			url, userName, password);

			return dataSource;

		}

		return null;

	}

	/**
	 * 
	 * @param serverId
	 * 
	 * @param dataSource
	 */

	public void setDataSource(Long serverId, DruidDataSource dataSource)
	{

		this.addTargetDataSource(serverId + "", dataSource);

		DBContextHolder.setDBType(serverId + "");

	}

}
