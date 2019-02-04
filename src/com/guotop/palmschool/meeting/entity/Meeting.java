package com.guotop.palmschool.meeting.entity;

/**
 * 会议实体
 * 
 * @author
 */

public class Meeting
{

	/**
	 * ID
	 */
	private Integer id;
	
	/**
	 * 添加会议人Id
	 */
	private Integer userId;

	/**
	 * 会议名称
	 */
	private String name;
	/**
	 * 会议开始时间
	 */
	private String startTime;

	/**
	 * 会议结束时间
	 */
	private String endTime;

	/**
	 * 会议地点
	 */
	private String place;
	
	/**
	 * 会议地点名称
	 */
	private String placeName;
	
	/**
	 * 参与人员
	 */
	private String person;
	
	/**
	 * 参与人员姓名
	 */
	private String attendee;
	

	/**
	 * 会议内容
	 */
	private String content;

	/**
	 * 备注
	 */
	private String remark;

	

	/**
	 * 创建时间
	 */
	private String createTime;
	
	private Integer inoutType;
	
	/**
	 * 参加会议人员Id
	 */
	private Integer attendeeId; 

	// getters & setters ------------------------

	
	
	public Integer getId()
	{
		return id;
	}

	public Integer getAttendeeId() {
		return attendeeId;
	}

	public void setAttendeeId(Integer attendeeId) {
		this.attendeeId = attendeeId;
	}

	public Integer getInoutType() {
		return inoutType;
	}

	public void setInoutType(Integer inoutType) {
		this.inoutType = inoutType;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}
	
	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getStartTime()
	{
		return startTime;
	}

	public void setStartTime(String startTime)
	{
		this.startTime = startTime;
	}

	public String getEndTime()
	{
		return endTime;
	}

	public void setEndTime(String endTime)
	{
		this.endTime = endTime;
	}

	public String getPerson()
	{
		return person;
	}

	public void setPerson(String person)
	{
		this.person = person;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public String getPlace()
	{
		return place;
	}
	
	public String getPlaceName()
	{
		return placeName;
	}

	public void setPlaceName(String placeName)
	{
		this.placeName = placeName;
	}

	public void setPlace(String place)
	{
		this.place = place;
	}

	public String getRemark()
	{
		return remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getAttendee()
	{
		return attendee;
	}

	public void setAttendee(String attendee)
	{
		this.attendee = attendee;
	}
	
	private String attname;

	public String getAttname() {
		return attname;
	}

	public void setAttname(String attname) {
		this.attname = attname;
	}



}