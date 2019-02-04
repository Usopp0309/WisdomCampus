package com.guotop.palmschool.shopping.entity;

import java.util.List;

/**
 * 物品实体类
 * @author jfy
 * @date 2016年1月8日
 */
public class Goods
{
	private int id;
	//名称
	private String name;
	//生产厂商
	private String manufacturer;
	//类型编码 对应goodstype表ID
	private int typeId;
	//创建时间
	private String createTime;
	//是否启用 0启用 1禁用
	private int status;
	//图片路径
	private String imgPath;
	//排序
	private int order;
	//备注
	private String remark;
	//详情列表
	private List<GoodsDetail> list;
	
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public String getManufacturer()
	{
		return manufacturer;
	}
	public void setManufacturer(String manufacturer)
	{
		this.manufacturer = manufacturer;
	}
	public int getTypeId()
	{
		return typeId;
	}
	public void setTypeId(int typeId)
	{
		this.typeId = typeId;
	}
	public String getCreateTime()
	{
		return createTime;
	}
	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}
	public int getStatus()
	{
		return status;
	}
	public void setStatus(int status)
	{
		this.status = status;
	}
	public String getImgPath()
	{
		return imgPath;
	}
	public void setImgPath(String imgPath)
	{
		this.imgPath = imgPath;
	}
	public int getOrder()
	{
		return order;
	}
	public void setOrder(int order)
	{
		this.order = order;
	}
	public String getRemark()
	{
		return remark;
	}
	public void setRemark(String remark)
	{
		this.remark = remark;
	}
	public List<GoodsDetail> getList()
	{
		return list;
	}
	public void setList(List<GoodsDetail> list)
	{
		this.list = list;
	}
	
	
	
}
