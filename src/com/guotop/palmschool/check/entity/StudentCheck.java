package com.guotop.palmschool.check.entity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 学生考勤
 * 
 * @author zhou
 */
public class StudentCheck {

	/**
	 * 年级名
	 */
	private String gradeName;

	/**
	 * 学号
	 */
	private String code;

	/**
	 * 姓名
	 */
	private String name;

	/**
	 * 手机号码
	 */
	private String phone;

	/**
	 * 电子卡
	 */
	private String cardCode;
	
	/**
	 * 用户Id
	 */
	private Integer uId;

	/**
	 * 状态
	 */
	private Integer status;

	/**
	 * 更新时间
	 */
	private String updateTime;
	/**
	 * 状态名称
	 */
	private String statusName;
	
	private String time;
	
	private Integer orderStyle;
	/**
	 * 刷卡时间
	 */
	private String inoutTime;

	/**
	 * 考勤补录信息
	 */
	private String remark;
	/**
	 * 作息时间类型（0分段 1全天）
	 */
	private Integer scheduleType;
	
	/**
	 * key 是createDate
	 * 存着不同提起对应的的考勤
	 */
	private Map<String, StudentCheck> dateMap = new HashMap<String, StudentCheck>();
	
	/**
	 * 当天所有的考勤 列表
	 */
	private List<AttendanceCurrentDateInout> currentDateInoutlist = new ArrayList<AttendanceCurrentDateInout>();
	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCardCode() {
		return cardCode;
	}

	public void setCardCode(String cardCode) {
		this.cardCode = cardCode;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getStatusName()
	{
		return statusName;
	}

	public void setStatusName(String statusName)
	{
		this.statusName = statusName;
	}
    
	public String getTime()
	{
		return time;
	}

	public void setTime(String time)
	{
		this.time = time;
	}

	public Integer getOrderStyle()
	{
		return orderStyle;
	}

	public void setOrderStyle(Integer orderStyle)
	{
		this.orderStyle = orderStyle;
	}

	public String getInoutTime()
	{
		return inoutTime;
	}

	public void setInoutTime(String inoutTime)
	{
		this.inoutTime = inoutTime;
	}

	public List<AttendanceCurrentDateInout> getCurrentDateInoutlist()
	{
		return currentDateInoutlist;
	}

	public void setCurrentDateInoutlist(List<AttendanceCurrentDateInout> currentDateInoutlist)
	{
		this.currentDateInoutlist = currentDateInoutlist;
	}

	public Integer getuId()
	{
		return uId;
	}

	public void setuId(Integer uId)
	{
		this.uId = uId;
	}

	public Integer getScheduleType()
	{
		return scheduleType;
	}

	public void setScheduleType(Integer scheduleType)
	{
		this.scheduleType = scheduleType;
	}

	public String getRemark()
	{
		return remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}

	public Map<String, StudentCheck> getDateMap()
	{
		return dateMap;
	}

	public void setDateMap(Map<String, StudentCheck> dateMap)
	{
		this.dateMap = dateMap;
	}
	
}
