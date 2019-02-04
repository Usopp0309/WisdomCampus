package com.guotop.palmschool.common.entity;

import java.sql.Timestamp;

public class SmsSent
{
	/**
	 * 自动增长ID
	 */
	private Long sendId;

	/**
	 * 对应 SMS_MT 表中的 ID
	 */
	private Long mtId;

	/**
	 * 客户提交短信时生成的ID
	 */
	private String smsId;

	/**
	 * 手机号码
	 */
	private String destAddr;

	/**
	 * 入库时间，从SMS_MT 带来
	 */
	private Timestamp createTime;

	/**
	 * 是否需要状态报告0:不需要1:需要
	 */
	private Integer isNeedReport;

	/**
	 * 提交到网关响应0:成功1:失败
	 */
	private Integer sendFlag;

	/**
	 * 提交到网关的时间
	 */
	private Timestamp sendTime;

	/**
	 * 发送所走的通道
	 */
	private String channel;

	/**
	 * 重发所走的通道
	 */
	private String resendChannel;

	/**
	 * 短信内容
	 */
	private String message;

	/**
	 * 拆分后的内容
	 */
	private String splitMessage;

	/**
	 * 同一条长短信拆分后的条数
	 */
	private Integer pkTotal;

	/**
	 * 处于拆分后的第几条
	 */
	private Integer pkNumber;

	/**
	 * 0：不需要重发 1：需要重发
	 */
	private Integer isNeedResend;

	/**
	 * 失败重发状态,Isneedresend 为1时此字段有效 0 失败不需要重发 1 失败已重发 2 失败未重发 4
	 * 没有重发通道或重发通道没有配置重发 5 提交成功但无应答短信
	 */
	private Integer resendStatus;

	/**
	 * 提交到网关返回的ID
	 */
	private String messageId;

	/**
	 * 短信发送最终结果 status 为null 0：应答成功，1：应答失败 status 为not null 0：发送成功，1：发送失败
	 */
	private Integer sendRet;

	/**
	 * 如果用户需要状态报告，发送成功后状态报告保存在此字段
	 */
	private String status;

	/**
	 * 收到状态报告的时间
	 */
	private Timestamp reportTime;

	/**
	 * 扩展码，机构扩展码+用户扩展码
	 */
	private String extCode;

	/**
	 * 描述
	 */
	private String description;

	/**
	 * 机构ID
	 */
	private Integer orgId;

	/**
	 * 用户ID
	 */
	private Integer sendUserId;

	/**
	 * 
	 */
	private String securityContent;

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

	/**
	 *定时发送时间
	 */
	private Timestamp presendTime;

	public Long getSendId()
	{
		return sendId;
	}

	public void setSendId(Long sendId)
	{
		this.sendId = sendId;
	}

	public Long getMtId()
	{
		return mtId;
	}

	public void setMtId(Long mtId)
	{
		this.mtId = mtId;
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

	public Timestamp getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(Timestamp createTime)
	{
		this.createTime = createTime;
	}

	public Integer getIsNeedReport()
	{
		return isNeedReport;
	}

	public void setIsNeedReport(Integer isNeedReport)
	{
		this.isNeedReport = isNeedReport;
	}

	public Integer getSendFlag()
	{
		return sendFlag;
	}

	public void setSendFlag(Integer sendFlag)
	{
		this.sendFlag = sendFlag;
	}

	public Timestamp getSendTime()
	{
		return sendTime;
	}

	public void setSendTime(Timestamp sendTime)
	{
		this.sendTime = sendTime;
	}

	public String getChannel()
	{
		return channel;
	}

	public void setChannel(String channel)
	{
		this.channel = channel;
	}

	public String getResendChannel()
	{
		return resendChannel;
	}

	public void setResendChannel(String resendChannel)
	{
		this.resendChannel = resendChannel;
	}

	public String getMessage()
	{
		return message;
	}

	public void setMessage(String message)
	{
		this.message = message;
	}

	public String getSplitMessage()
	{
		return splitMessage;
	}

	public void setSplitMessage(String splitMessage)
	{
		this.splitMessage = splitMessage;
	}

	public Integer getPkTotal()
	{
		return pkTotal;
	}

	public void setPkTotal(Integer pkTotal)
	{
		this.pkTotal = pkTotal;
	}

	public Integer getPkNumber()
	{
		return pkNumber;
	}

	public void setPkNumber(Integer pkNumber)
	{
		this.pkNumber = pkNumber;
	}

	public Integer getIsNeedResend()
	{
		return isNeedResend;
	}

	public void setIsNeedResend(Integer isNeedResend)
	{
		this.isNeedResend = isNeedResend;
	}

	public Integer getResendStatus()
	{
		return resendStatus;
	}

	public void setResendStatus(Integer resendStatus)
	{
		this.resendStatus = resendStatus;
	}

	public String getMessageId()
	{
		return messageId;
	}

	public void setMessageId(String messageId)
	{
		this.messageId = messageId;
	}

	public Integer getSendRet()
	{
		return sendRet;
	}

	public void setSendRet(Integer sendRet)
	{
		this.sendRet = sendRet;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public Timestamp getReportTime()
	{
		return reportTime;
	}

	public void setReportTime(Timestamp reportTime)
	{
		this.reportTime = reportTime;
	}

	public String getExtCode()
	{
		return extCode;
	}

	public void setExtCode(String extCode)
	{
		this.extCode = extCode;
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
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

	public String getSecurityContent()
	{
		return securityContent;
	}

	public void setSecurityContent(String securityContent)
	{
		this.securityContent = securityContent;
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

	public Timestamp getPresendTime()
	{
		return presendTime;
	}

	public void setPresendTime(Timestamp presendTime)
	{
		this.presendTime = presendTime;
	}

}
