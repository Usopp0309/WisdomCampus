package com.guotop.palmschool.entity;

/**
 * 新闻实体类
 * 
 * @author zhou
 */
public class News
{
	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 标题
	 */
	private String title;

	/**
	 * 内容
	 */
	private String content;

	/**
	 * 图片地址
	 */
	private String imgPath;

	/**
	 * 创建时间
	 */
	private String createTime;

	/**
	 * 状态 0 在用  1禁用
	 */
	private String status;
	/**
	 * 创建人
	 */
	private String createUserId;
	
	public Integer getId()
	{
		return id;
	}
	public void setId(Integer id)
	{
		this.id = id;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getImgPath()
	{
		return imgPath;
	}
	public void setImgPath(String imgPath)
	{
		this.imgPath = imgPath;
	}
	public String getCreateTime()
	{
		return createTime;
	}
	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}
	public String getStatus()
	{
		return status;
	}
	public void setStatus(String status)
	{
		this.status = status;
	}
	public String getCreateUserId()
	{
		return createUserId;
	}
	public void setCreateUserId(String createUserId)
	{
		this.createUserId = createUserId;
	}

	
}
