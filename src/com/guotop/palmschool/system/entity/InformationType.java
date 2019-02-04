package com.guotop.palmschool.system.entity;

import java.util.List;

/**
 *  信息提醒类型
 */
public class InformationType
{
	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 发送类型 1 只发送短信 2 只推送 3 即发送信息也推送 4 即不发送信息也不推送
	 */
	private Integer type;

	/**
	 * 名称：校园公告，在线请假，会议通知，宿舍通知，校车通知, 短信平台，成绩通知, 进出校园,一卡通，一体机、晨检 , 作息时间设置
	 */
	private String name;

	/**
	 * 父ID 如 一卡通的id为9 又分为消费 充值等那消费对应的parentId为9 如果没有就为空
	 */
	private Integer parentId;

	/**
	 * 信息类型 1校园公告，2在线请假，3会议通知，4宿舍通知，5校车通知, 6短信平台，7成绩通知, 8进出校园,9一卡通， 10 一体机， 11 晨检 , 12 作息时间设置
	 * 如果有parentId  则用parentId 对应的 informationType 加01 02 03 …… 
	 */
	private Integer informationType;
	
	
	private List<InformationType> information;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public Integer getType()
	{
		return type;
	}

	public void setType(Integer type)
	{
		this.type = type;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public Integer getParentId()
	{
		return parentId;
	}

	public void setParentId(Integer parentId)
	{
		this.parentId = parentId;
	}

	public Integer getInformationType()
	{
		return informationType;
	}

	public void setInformationType(Integer informationType)
	{
		this.informationType = informationType;
	}

	public List<InformationType> getInformation()
	{
		return information;
	}

	public void setInformation(List<InformationType> information)
	{
		this.information = information;
	}
	
}
