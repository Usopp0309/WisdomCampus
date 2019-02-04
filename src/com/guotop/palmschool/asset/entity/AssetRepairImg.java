package com.guotop.palmschool.asset.entity;

import com.google.gson.annotations.Expose;

/**
 * 资产实体类
 * @author taomingyue
 */
public class AssetRepairImg
{
	private int id;
	/**
	 * 维修信息ID
	 */
	private Integer repairId;
	/**
	 * 图片ID
	 */
	@Expose
	private String path;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 创建时间
	 */
	private String createTime;
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public Integer getRepairId()
	{
		return repairId;
	}
	public void setRepairId(Integer repairId)
	{
		this.repairId = repairId;
	}
	public String getPath()
	{
		return path;
	}
	public void setPath(String path)
	{
		this.path = path;
	}
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public String getCreateTime()
	{
		return createTime;
	}
	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}
}
