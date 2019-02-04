package com.guotop.palmschool.securitydanger.entity;

import java.util.List;

/**
 * 安全隐患排查
 * 
 * @author chenyong
 *
 */
public class SecurityDanger {
	private Integer id;
	
    private Integer sdId;
	
    private Integer type;
	
	/**
	 * 类型名称
	 */
	private String typeName;
	/**
	 * 隐患描述
	 */
	private String desc;

	/**
	 * 上报人
	 */
	private Integer createUserId;
	/**
	 * 上报时间
	 */
	private String createTime;
	/**
	 * 上班人姓名
	 */
	private String userName;

	/**
	 * 上报人姓名
	 */
	private String phone;

	public Integer getSdId() {
		return sdId;
	}

	public void setSdId(Integer sdId) {
		this.sdId = sdId;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	private List<SecurityDangerDetail> details;

	private List<SecurityDangerAttachment> attachments;


	public List<SecurityDangerDetail> getDetails() {
		return details;
	}

	public void setDetails(List<SecurityDangerDetail> details) {
		this.details = details;
	}

	public List<SecurityDangerAttachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<SecurityDangerAttachment> attachments) {
		this.attachments = attachments;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		setSdId(id);
		this.id = id;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public Integer getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}
