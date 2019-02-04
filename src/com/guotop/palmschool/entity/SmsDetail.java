package com.guotop.palmschool.entity;

public class SmsDetail
{
	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 短信内容
	 */
	private String content;

	/**
	 * 发送人
	 */
	private Integer senderId;

	/**
	 * 发送人姓名
	 */
	private String senderName;

	/**
	 * 接收人Id
	 */
	private Integer receiverId;

	/**
	 * 接收人手机号码
	 */
	private String phone;

	/**
	 * 接收人姓名
	 */
	private String receiverName;

	private String seq;

	private String report;

	private Integer status;

	private Integer smsId;

	/**
	 * 短信回执时间
	 */
	private String reportTime;

	/**
	 * 创建时间
	 */
	private String createTime;

	/**
	 * 短信发送用途 发送短信类型，0:教师短信服务 1:学生短信服务 2:成绩下发 3:会议通知 4:校车  5:进出记录 8:宿舍  9请假
	 */
	private String type;

	/**
	 * 用于成绩发送
	 */
	private String sentTime;

	/**
	 * 是否实时 0：定时发送  1：实时发送
	 */
	private String isRealTime;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public Integer getSenderId()
	{
		return senderId;
	}

	public void setSenderId(Integer senderId)
	{
		this.senderId = senderId;
	}

	public String getSenderName()
	{
		return senderName;
	}

	public void setSenderName(String senderName)
	{
		this.senderName = senderName;
	}

	public Integer getReceiverId()
	{
		return receiverId;
	}

	public void setReceiverId(Integer receiverId)
	{
		this.receiverId = receiverId;
	}

	public String getPhone()
	{
		return phone;
	}

	public void setPhone(String phone)
	{
		this.phone = phone;
	}

	public String getReceiverName()
	{
		return receiverName;
	}

	public void setReceiverName(String receiverName)
	{
		this.receiverName = receiverName;
	}

	public String getSeq()
	{
		return seq;
	}

	public void setSeq(String seq)
	{
		this.seq = seq;
	}

	public String getReport()
	{
		return report;
	}

	public void setReport(String report)
	{
		this.report = report;
	}

	public Integer getStatus()
	{
		return status;
	}

	public void setStatus(Integer status)
	{
		this.status = status;
	}

	public Integer getSmsId()
	{
		return smsId;
	}

	public void setSmsId(Integer smsId)
	{
		this.smsId = smsId;
	}

	public String getReportTime()
	{
		return reportTime;
	}

	public void setReportTime(String reportTime)
	{
		this.reportTime = reportTime;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getType()
	{
		return type;
	}

	public void setType(String type)
	{
		this.type = type;
	}

	public String getSentTime()
	{
		return sentTime;
	}

	public void setSentTime(String sentTime)
	{
		this.sentTime = sentTime;
	}

	public String getIsRealTime()
	{
		return isRealTime;
	}

	public void setIsRealTime(String isRealTime)
	{
		this.isRealTime = isRealTime;
	}

}