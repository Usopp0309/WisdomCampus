package com.guotop.palmschool.common.entity;

import java.sql.Timestamp;

public class SmsMT
{
	/**
	 * 主键，自增长
	 */
	private Long mt_id;

	/**
	 * 客户写入的短信ID标识
	 */
	private String smsId;

	/**
	 * 接收手机号码，暂时支持一个号码
	 */
	private String destAddr;
	/**
	 * 短信内容
	 */
	private String message;

	/**
	 * 是否需要状态报告
	 */
	private Integer isNeedReport;

	/**
	 * 入库时间
	 */
	private Timestamp createTime;

	/**
	 * 指定发送通道
	 */
	private String channel;

	/**
	 * 优先级，数值范围0~9，数值越小，优先级越高
	 */
	private Integer priorty;

	/**
	 * 定时发送时间
	 */
	private Timestamp presendTime;

	/**
	 * 有效期从入库算起短信存活期，多长时间发布出去，则不再发送，(单位：秒)
	 */
	private Integer validTime;

	/**
	 * 扩展字段
	 */
	private String extCode;

	/**
	 * 用户签名
	 */
	private String smsSign;

	/**
	 * 发送者机构ID
	 */
	private Integer orgId;

	/**
	 * 发送者ID
	 */
	private Integer sendUserId;

	/**
	 * 业务类型ID
	 */
	private Integer businessId;

	/**
	 * 允许开始发送时间
	 */
	private String businessBeginTime;

	/**
	 *允许结束发送时间
	 */
	private String businessEndTime;

	public Long getMt_id()
	{
		return mt_id;
	}

	public void setMt_id(Long mtId)
	{
		mt_id = mtId;
	}

	public String getSmsId()
	{
		return smsId;
	}

	public void setSmsId(String smsId)
	{
		this.smsId = smsId;
	}

	public String getDestAddr()
	{
		return destAddr;
	}

	public void setDestAddr(String destAddr)
	{
		this.destAddr = destAddr;
	}

	public String getMessage()
	{
		return message;
	}

	public void setMessage(String message)
	{
		this.message = message;
	}

	public Integer getIsNeedReport()
	{
		return isNeedReport;
	}

	public void setIsNeedReport(Integer isNeedReport)
	{
		this.isNeedReport = isNeedReport;
	}

	public Timestamp getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(Timestamp createTime)
	{
		this.createTime = createTime;
	}

	public String getChannel()
	{
		return channel;
	}

	public void setChannel(String channel)
	{
		this.channel = channel;
	}

	public Integer getPriorty()
	{
		return priorty;
	}

	public void setPriorty(Integer priorty)
	{
		this.priorty = priorty;
	}

	public Timestamp getPresendTime()
	{
		return presendTime;
	}

	public void setPresendTime(Timestamp presendTime)
	{
		this.presendTime = presendTime;
	}

	public Integer getValidTime()
	{
		return validTime;
	}

	public void setValidTime(Integer validTime)
	{
		this.validTime = validTime;
	}

	public String getExtCode()
	{
		return extCode;
	}

	public void setExtCode(String extCode)
	{
		this.extCode = extCode;
	}

	public String getSmsSign()
	{
		return smsSign;
	}

	public void setSmsSign(String smsSign)
	{
		this.smsSign = smsSign;
	}

	public Integer getOrgId()
	{
		return orgId;
	}

	public void setOrgId(Integer orgId)
	{
		this.orgId = orgId;
	}

	public Integer getSendUserId()
	{
		return sendUserId;
	}

	public void setSendUserId(Integer sendUserId)
	{
		this.sendUserId = sendUserId;
	}

	public Integer getBusinessId()
	{
		return businessId;
	}

	public void setBusinessId(Integer businessId)
	{
		this.businessId = businessId;
	}

	public String getBusinessBeginTime()
	{
		return businessBeginTime;
	}

	public void setBusinessBeginTime(String businessBeginTime)
	{
		this.businessBeginTime = businessBeginTime;
	}

	public String getBusinessEndTime()
	{
		return businessEndTime;
	}

	public void setBusinessEndTime(String businessEndTime)
	{
		this.businessEndTime = businessEndTime;
	}

}
