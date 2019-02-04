package com.guotop.palmschool.entity;

/**
 * 设备监控管理类
 */
public class DeviceMonitor 
{
    private Integer id;
	
	/**
	 * 设备号
	 */
	private String code;

	/**
	 * 设备状态 1 开启  2 关闭
	 */
	private int status;

	/**
	 * 设备对应得线程号
	 */
	
	private String threadId;
	
	/**
	 * 开启 关闭时间
	 */
	private String createTime;
	
	/**
	 * 持续时间
	 */
	private String time;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getCode()
	{
		return code;
	}

	public void setCode(String code)
	{
		this.code = code;
	}

	public int getStatus()
	{
		return status;
	}

	public void setStatus(int status)
	{
		this.status = status;
	}

	public String getThreadId()
	{
		return threadId;
	}

	public void setThreadId(String threadId)
	{
		this.threadId = threadId;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getTime()
	{
		return time;
	}

	public void setTime(String time)
	{
		this.time = time;
	}
	
}
