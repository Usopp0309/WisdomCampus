package com.guotop.palmschool.bluetooth.entity;

/**
 * 蓝牙手环与学生关系表
 * 
 * @author chenyong
 *
 */
public class BluetoothStudent {
	private Integer id;
	/**
	 * 学生
	 */
	private Integer userId;
	/**
	 * 更新时间
	 */
	private String updateTime;
	/**
	 * 蓝牙手环主键
	 */
	private Integer bluetoothBraceletId;
	/**
	 * 开始使用时间
	 */
	private String startTime;
	/**
	 * 使用结束时间
	 */
	private String endTime;
	/**
	 * 班级
	 */
	private Integer clazzId;
	/**
	 * 操作人
	 */
	private Integer updateUserId;
	/**
	 * 班级名称
	 */
	private String clazzName;
	/**
	 * 学生名称
	 */
	private String studentName;
	/**
	 * 手环的Mac
	 */
	private String mac;
	/**
	 * 手环编号
	 */
	private String braceletCode;
	
	/**
	 * 手环使用课程时间
	 */
	private Integer bluetoothCourseTimeId;
	/**
	 * 课程名称
	 */
	private String courseName;
    /**
     * 学生学号
     */
	private String userCode;
    
	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public String getBraceletCode() {
		return braceletCode;
	}

	public void setBraceletCode(String braceletCode) {
		this.braceletCode = braceletCode;
	}

	public Integer getBluetoothCourseTimeId() {
		return bluetoothCourseTimeId;
	}

	public void setBluetoothCourseTimeId(Integer bluetoothCourseTimeId) {
		this.bluetoothCourseTimeId = bluetoothCourseTimeId;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getMac() {
		return mac;
	}

	public void setMac(String mac) {
		this.mac = mac;
	}

	public String getClazzName() {
		return clazzName;
	}

	public void setClazzName(String clazzName) {
		this.clazzName = clazzName;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public Integer getUpdateUserId() {
		return updateUserId;
	}

	public void setUpdateUserId(Integer updateUserId) {
		this.updateUserId = updateUserId;
	}

	public Integer getClazzId() {
		return clazzId;
	}

	public void setClazzId(Integer clazzId) {
		this.clazzId = clazzId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getBluetoothBraceletId() {
		return bluetoothBraceletId;
	}

	public void setBluetoothBraceletId(Integer bluetoothBraceletId) {
		this.bluetoothBraceletId = bluetoothBraceletId;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

}
