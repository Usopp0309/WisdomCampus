package com.guotop.palmschool.dynamicGraph.entity;

/**
 * APP首页动态图
 *
 */
public class DynamicGraph
{
	/**
	 * Id
	 */
	private Integer graphId;

	/**
	 * 类型 预留
	 */
	private Integer type;
	
	/**
	 * 标题 
	 */
	private String title;
	
	/**
	 * 跳转链接
	 */
	private String url;
	
	/**
	 * 描述 预留
	 */
	private String desc;

	/**
	 * 状态 1在用 2 不用
	 */
	private Integer status;
	
	/**
	 * 统计  预留
	 */
	private Integer count;

	/**
	 *  路径
	 */
	private String path;

	/**
	 *  上传者Id
	 */
	private Integer userId;
	
	/**
	 * 上传者
	 */
	private String realName;
	
	/**
	 * 上传时间
	 */
	private String createTime;

	public Integer getGraphId()
	{
		return graphId;
	}

	public void setGraphId(Integer graphId)
	{
		this.graphId = graphId;
	}

	public Integer getType()
	{
		return type;
	}

	public void setType(Integer type)
	{
		this.type = type;
	}

	public String getDesc()
	{
		return desc;
	}

	public void setDesc(String desc)
	{
		this.desc = desc;
	}

	public Integer getStatus()
	{
		return status;
	}

	public void setStatus(Integer status)
	{
		this.status = status;
	}

	public String getPath()
	{
		return path;
	}

	public void setPath(String path)
	{
		this.path = path;
	}

	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public String getRealName()
	{
		return realName;
	}

	public void setRealName(String realName)
	{
		this.realName = realName;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getTitle()
	{
		return title;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public String getUrl()
	{
		return url;
	}

	public void setUrl(String url)
	{
		this.url = url;
	}

	public Integer getCount()
	{
		return count;
	}

	public void setCount(Integer count)
	{
		this.count = count;
	}
}
