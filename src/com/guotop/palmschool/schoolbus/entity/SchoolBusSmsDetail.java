package com.guotop.palmschool.schoolbus.entity;


/**
 * 校车信息
 * @author zhou
 */
public class SchoolBusSmsDetail 
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

	/**
	 * 创建时间
	 */
	private String createTime;

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

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

}
