package com.guotop.palmschool.entity;
/**
 * 设备实体类
 * @author shi */
public class Device 
{
	/**
	 * ID
	 */
	private String id;
	
	/**
	 * 设备编码
	 */
	private String code;
	
	/**
	 * 名称
	 */
	private String name;

	/**
	 * ip
	 */
	private String ip;
	
	/**
	 * 更新时间
	 */
	private String updatetime;
	
	/**
	 * 更新时间
	 */
	private Integer placeId;
	
	/**
	 * 生成时间
	 */
	private String createtime;
	
	/**
	 * 
	 * 进出类型
	 */
	private String inoutType;
	/**
	 * 
	 * 记录点类型
	 */
	private String positionType;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getInoutType()
	{
		return inoutType;
	}

	public void setInoutType(String inoutType)
	{
		this.inoutType = inoutType;
	}

	public String getPositionType()
	{
		return positionType;
	}

	public void setPositionType(String positionType)
	{
		this.positionType = positionType;
	}

	public Integer getPlaceId()
	{
		return placeId;
	}

	public void setPlaceId(Integer placeId)
	{
		this.placeId = placeId;
	}
	
	
	
}
