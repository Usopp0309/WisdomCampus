package com.guotop.palmschool.check.entity;


/**
 * 考勤统计实体类
 * @author zhou
 */
public class Total 
{
	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 人员类型，1:教师，2:学生
	 */
	private Integer userType;

	/**
	 * 统计类别，0:全校，1:年级，2:班级，3:个人
	 */
	private Integer type;

	/**
	 * 统计类型，0:月，1:周，2:日
	 */
	private Integer periodType;

	/**
	 * 月/日/周
	 */
	private String period;

	/**
	 * 月/日/周 日期类型 日:当天，月:1日，周:周日(第1天)
	 */
	private String periodTime;

	/**
	 * 编号，type=0时为学校编号，type=1时为学校编号，type=2时为班号，3时为工号或学号
	 */
	private String code;

	/**
	 * 名称，参照code，对应的名称
	 */
	private String name;

	/**
	 * ID，参照code，对应对象的ID
	 */
	private Integer objId;

	/**
	 * 统计对象对应班级
	 */
	private Integer clazzId;

	/**
	 * 统计对象对应年级
	 */
	private Integer gradeId;

	/**
	 * 迟到次数
	 */
	private Integer lateTimes = 0;

	/**
	 * 早退次数
	 */
	private Integer leaveTimes = 0;
	
	/**
	 * 最早到校时间
	 */
	private String arrivalTime;

	/**
	 * 最晚离校时间
	 */
	private String leaveTime;

	/**
	 * 在校时长
	 */
	private float hours;

	/**
	 * 创建时间
	 */
	private String createTime;

	/**
	 * 事假次数
	 */
	private Integer affairLeave = 0;
	
	/**
	 * 病假次数
	 */
	private Integer sickLeave = 0;
	
	/**
	 * 产假次数
	 */
	private Integer maternityLeave = 0;
	
	/**
	 * 出差次数
	 */
	private Integer businessTrip = 0;

	public Integer getId() 
	{
		return id;
	}

	public void setId(Integer id) 
	{
		this.id = id;
	}

	public Integer getUserType()
	{
		return userType;
	}

	public void setUserType(Integer userType) 
	{
		this.userType = userType;
	}

	public Integer getType()   
	{
		return type;
	}

	public void setType(Integer type) 
	{
		this.type = type;
	}

	public Integer getPeriodType() 
	{
		return periodType;
	}

	public void setPeriodType(Integer periodType)
	{
		this.periodType = periodType;
	}

	public String getPeriod() 
	{
		return period;
	}

	public void setPeriod(String period)
	{
		this.period = period;
	}

	public String getPeriodTime() 
	{
		return periodTime;
	}

	public void setPeriodTime(String periodTime) 
	{
		this.periodTime = periodTime;
	}

	public String getCode() 
	{
		return code;
	}

	public void setCode(String code) 
	{
		this.code = code;
	}

	public String getName() 
	{
		return name;
	}

	public void setName(String name) 
	{
		this.name = name;
	}

	public Integer getObjId() 
	{
		return objId;
	}

	public void setObjId(Integer objId) 
	{
		this.objId = objId;
	}

	public Integer getClazzId() 
	{
		return clazzId;
	}

	public void setClazzId(Integer clazzId) 
	{
		this.clazzId = clazzId;
	}

	public Integer getGradeId() 
	{
		return gradeId;
	}

	public void setGradeId(Integer gradeId) 
	{
		this.gradeId = gradeId;
	}

	public Integer getLateTimes() 
	{
		return lateTimes;
	}

	public void setLateTimes(Integer lateTimes) 
	{
		this.lateTimes = lateTimes;
	}

	public Integer getLeaveTimes() 
	{
		return leaveTimes;
	}

	public void setLeaveTimes(Integer leaveTimes) 
	{
		this.leaveTimes = leaveTimes;
	}

	public String getArrivalTime() 
	{
		return arrivalTime;
	}

	public void setArrivalTime(String arrivalTime) 
	{
		this.arrivalTime = arrivalTime;
	}

	public String getLeaveTime() 
	{
		return leaveTime;
	}

	public void setLeaveTime(String leaveTime) 
	{
		this.leaveTime = leaveTime;
	}

	public float getHours() 
	{
		return hours;
	}

	public void setHours(float hours) 
	{
		this.hours = hours;
	}

	public String getCreateTime() 
	{
		return createTime;
	}

	public void setCreateTime(String createTime) 
	{
		this.createTime = createTime;
	}
	
	public Integer getAffairLeave() 
	{
		return affairLeave;
	}

	public void setAffairLeave(Integer affairLeave) 
	{
		if (0 != affairLeave)
		{
			this.affairLeave = affairLeave;
		}
		else
		{
			this.affairLeave = 0;
		}
	}

	public Integer getSickLeave() 
	{
		return sickLeave;
	}

	public void setSickLeave(Integer sickLeave) 
	{
		if (0 != sickLeave)
		{
			this.sickLeave = sickLeave;
		}
		else
		{
			this.sickLeave = 0;
		}
	}

	public Integer getMaternityLeave() 
	{
		return maternityLeave;
	}

	public void setMaternityLeave(Integer maternityLeave) 
	{
		if (0 != maternityLeave)
		{
			this.maternityLeave = maternityLeave;
		}
		else
		{
			this.maternityLeave = 0;
		}
	}

	public Integer getBusinessTrip() 
	{
		return businessTrip;
	}

	public void setBusinessTrip(Integer businessTrip) 
	{
		if (0 != businessTrip)
		{
			this.businessTrip = businessTrip;
		}
		else
		{
			this.businessTrip = 0;
		}
	}
}
