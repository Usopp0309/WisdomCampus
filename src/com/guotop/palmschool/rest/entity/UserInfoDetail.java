package com.guotop.palmschool.rest.entity;

import java.io.Serializable;

/**
 * 用户信息详情表,结合user_auth表和userbase以及userdetail表
 * 用户返回亦信“智慧校园信息”功能
 * （包含福建用户）
 * 
 * @author Administrator
 *
 */

public class UserInfoDetail implements Serializable
{

	private static final long serialVersionUID = -608482396992459552L;

	/**
	 * richx对应的userId
	 */
	private Integer userId;
	
	/**
	 * 工号或者学号
	 */
	private String code;
	
	/**
	 * 卡号
	 */
	private String cardCode;

	/**
	 * 用户的统一ID
	 */
	private String personid;

	/**
	 * 手机号码
	 */
	private String phone;

	/**
	 * 邮箱
	 */
	private String email;

	/**
	 * 用户姓名
	 */
	private String realName;

	/**
	 * 昵称
	 */
	private String nickName;

	/**
	 * 用户归属地区域
	 */
	private String areacode;

	/**
	 * 福建 性别: 0是女，1为男 
	 * richx 性别：0 男 1 女
	 */
	private String sex;

	/**
	 * 生日
	 */
	private String birthday;

	/**
	 * 用户类型 0:学生 1:老师 2:家长 3:机构 4:学校 5:学校工作人员 6:机构工作人员 
	 * 福建字段usertype
	 */
	private String roleCode;

	/**
	 * 角色名称
	 */
	private String roleName;

	/**
	 * 通讯地址
	 */
	private String address;

	/**
	 * 邮编
	 */
	private String postcode;

	/**
	 * 浏览渠道：1：小；2：中；3：大；
	 */
	private Integer logotype;

	private String headImg;

	/**
	 * 兴趣，多个兴趣之间用分号分开
	 */
	private String interests;

	/**
	 * 职业
	 */
	private String profession;

	/**
	 * 0：身份证 1:护照 2:军人证 3:其他
	 */
	private String credtype;

	/**
	 * 证件号码
	 */
	private String idcardno;

	/**
	 * 签名
	 * 
	 * singature
	 */
	private String userDescription;

	/**
	 * 粉丝数
	 */
	private Integer fnascount;

	/**
	 * 如登录用户为教师，则返回所教学科，JSON数组
	 */
	private String teachesubjectlist;

	/**
	 * 学科id
	 */
	private String subjectid;

	/**
	 * 学科名称
	 */
	private String subjectname;

	/**
	 * 教材id
	 */
	private String teachmaterialid;

	/**
	 * 教材名称
	 */
	private String teachmaterialname;

	/**
	 * 班级ID
	 */
	private String clazzId;

	/**
	 * 班级或部门名称
	 */
	private String clazzName;

	/**
	 * 用户所在年级 1:一年级 2：二年级 3：三年级 4：四年级 5：五年级 6：六年级 7：初一 8：初二 9：初三 10：高一 11：高二
	 * 12：高三　13: 职一　14:职二　15:职三
	 */
	private String gradeId;

	private String gradeName;

	/**
	 * 学段 1:小学 2:初中 3:高中 4:高职
	 */
	private String section;

	/**
	 * 班级成立年份
	 */
	private String foundtime;

	/**
	 * 用户所在班级身份: 1:班主任 2：班长 3：管理员 4: 教师 5：成员 6：教研员，7：教务员，8：信息员
	 */
	private String classidentity;

	/**
	 * 用户所在机构\学校id 福建:orgaid
	 */
	private String schoolId;

	/**
	 * 用户所在机构\学校名称 福建:organame
	 */
	private String schoolName;

	/**
	 * 用户在机构身份：1:管理员2：成员3：教研员；4：教务员；5：信息员
	 */
	private String orgaidentity;

	/**
	 * 个人标签
	 */
	private String tags;

	/**
	 * 省份
	 * 
	 * @return
	 */
	private String provicename;
	
	/**
	 * 城市
	 * 
	 * @return
	 */
	private String cityname;

	/**
	 * 部门名称
	 */
	private String departmentName;
	
	/**
	 * 住校类型
	 * 是否住校:0 走读 1 住校
	 */
	private String schoolType;
	
	/**
	 * 家长姓名
	 */
	private String parentName;
	/**
	 * 家长手机号码
	 */
	private String parentPhone;
	
	/**
	 * 小孩姓名
	 */
	private String childName;

	/**
	 * 小孩姓名
	 */
	private String childPhone;
	
	public Integer getUserId()
	{
		return userId;
	}

	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public String getPersonid()
	{
		return personid;
	}

	public void setPersonid(String personid)
	{
		this.personid = personid;
	}

	public String getPhone()
	{
		return phone;
	}

	public void setPhone(String phone)
	{
		this.phone = phone;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public String getRealName()
	{
		return realName;
	}

	public void setRealName(String realName)
	{
		this.realName = realName;
	}

	public String getNickName()
	{
		return nickName;
	}

	public void setNickName(String nickName)
	{
		this.nickName = nickName;
	}

	public String getAreacode()
	{
		return areacode;
	}

	public void setAreacode(String areacode)
	{
		this.areacode = areacode;
	}

	public String getSex()
	{
		return sex;
	}

	public void setSex(String sex)
	{
		this.sex = sex;
	}

	public String getBirthday()
	{
		return birthday;
	}

	public void setBirthday(String birthday)
	{
		this.birthday = birthday;
	}

	public String getRoleCode()
	{
		return roleCode;
	}

	public void setRoleCode(String roleCode)
	{
		this.roleCode = roleCode;
	}

	public String getRoleName()
	{
		return roleName;
	}

	public void setRoleName(String roleName)
	{
		this.roleName = roleName;
	}

	public String getAddress()
	{
		return address;
	}

	public void setAddress(String address)
	{
		this.address = address;
	}

	public String getPostcode()
	{
		return postcode;
	}

	public void setPostcode(String postcode)
	{
		this.postcode = postcode;
	}

	public Integer getLogotype()
	{
		return logotype;
	}

	public void setLogotype(Integer logotype)
	{
		this.logotype = logotype;
	}

	public String getHeadImg()
	{
		return headImg;
	}

	public void setHeadImg(String headImg)
	{
		this.headImg = headImg;
	}

	public String getInterests()
	{
		return interests;
	}

	public void setInterests(String interests)
	{
		this.interests = interests;
	}

	public String getProfession()
	{
		return profession;
	}

	public void setProfession(String profession)
	{
		this.profession = profession;
	}

	public String getCredtype()
	{
		return credtype;
	}

	public void setCredtype(String credtype)
	{
		this.credtype = credtype;
	}

	public String getIdcardno()
	{
		return idcardno;
	}

	public void setIdcardno(String idcardno)
	{
		this.idcardno = idcardno;
	}

	public String getUserDescription()
	{
		return userDescription;
	}

	public void setUserDescription(String userDescription)
	{
		this.userDescription = userDescription;
	}

	public Integer getFnascount()
	{
		return fnascount;
	}

	public void setFnascount(Integer fnascount)
	{
		this.fnascount = fnascount;
	}

	public String getTeachesubjectlist()
	{
		return teachesubjectlist;
	}

	public void setTeachesubjectlist(String teachesubjectlist)
	{
		this.teachesubjectlist = teachesubjectlist;
	}

	public String getSubjectid()
	{
		return subjectid;
	}

	public void setSubjectid(String subjectid)
	{
		this.subjectid = subjectid;
	}

	public String getSubjectname()
	{
		return subjectname;
	}

	public void setSubjectname(String subjectname)
	{
		this.subjectname = subjectname;
	}

	public String getTeachmaterialid()
	{
		return teachmaterialid;
	}

	public void setTeachmaterialid(String teachmaterialid)
	{
		this.teachmaterialid = teachmaterialid;
	}

	public String getTeachmaterialname()
	{
		return teachmaterialname;
	}

	public void setTeachmaterialname(String teachmaterialname)
	{
		this.teachmaterialname = teachmaterialname;
	}

	public String getClazzId()
	{
		return clazzId;
	}

	public void setClazzId(String clazzId)
	{
		this.clazzId = clazzId;
	}

	public String getClazzName()
	{
		return clazzName;
	}

	public void setClazzName(String clazzName)
	{
		this.clazzName = clazzName;
	}

	public String getFoundtime()
	{
		return foundtime;
	}

	public void setFoundtime(String foundtime)
	{
		this.foundtime = foundtime;
	}

	public String getClassidentity()
	{
		return classidentity;
	}

	public void setClassidentity(String classidentity)
	{
		this.classidentity = classidentity;
	}

	public String getSchoolId()
	{
		return schoolId;
	}

	public void setSchoolId(String schoolId)
	{
		this.schoolId = schoolId;
	}

	public String getSchoolName()
	{
		return schoolName;
	}

	public void setSchoolName(String schoolName)
	{
		this.schoolName = schoolName;
	}

	public String getOrgaidentity()
	{
		return orgaidentity;
	}

	public void setOrgaidentity(String orgaidentity)
	{
		this.orgaidentity = orgaidentity;
	}

	public String getTags()
	{
		return tags;
	}

	public void setTags(String tags)
	{
		this.tags = tags;
	}

	public String getProvicename()
	{
		return provicename;
	}

	public void setProvicename(String provicename)
	{
		this.provicename = provicename;
	}

	public String getDepartmentName()
	{
		return departmentName;
	}

	public void setDepartmentName(String departmentName)
	{
		this.departmentName = departmentName;
	}

	public String getGradeId()
	{
		return gradeId;
	}

	public void setGradeId(String gradeId)
	{
		this.gradeId = gradeId;
	}

	public String getGradeName()
	{
		return gradeName;
	}

	public void setGradeName(String gradeName)
	{
		this.gradeName = gradeName;
	}

	public String getSection()
	{
		return section;
	}

	public void setSection(String section)
	{
		this.section = section;
	}

	public String getCode()
	{
		return code;
	}

	public void setCode(String code)
	{
		this.code = code;
	}

	public String getCardCode()
	{
		return cardCode;
	}

	public void setCardCode(String cardCode)
	{
		this.cardCode = cardCode;
	}

	public String getCityname()
	{
		return cityname;
	}

	public void setCityname(String cityname)
	{
		this.cityname = cityname;
	}

	public String getSchoolType()
	{
		return schoolType;
	}

	public void setSchoolType(String schoolType)
	{
		this.schoolType = schoolType;
	}

	public String getParentName()
	{
		return parentName;
	}

	public void setParentName(String parentName)
	{
		this.parentName = parentName;
	}

	public String getParentPhone()
	{
		return parentPhone;
	}

	public void setParentPhone(String parentPhone)
	{
		this.parentPhone = parentPhone;
	}

	public String getChildName()
	{
		return childName;
	}

	public void setChildName(String childName)
	{
		this.childName = childName;
	}

	public String getChildPhone()
	{
		return childPhone;
	}

	public void setChildPhone(String childPhone)
	{
		this.childPhone = childPhone;
	}

}