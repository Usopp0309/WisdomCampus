package com.guotop.palmschool.entity;

import java.io.Serializable;
import java.util.List;

import com.google.gson.annotations.Expose;



/**
 * 学校实体类
 * @author tao
 *
 */
public class School implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 *  编码
	 */
	@Expose
	private long schoolId;
	
	/**
	 * 学校名称
	 */
	@Expose
	private String schoolName;
	
	/**
	 * 学校简介
	 */
	private String introduction;

	/**
	 * 建校时间
	 */
	private String createDate;
	
	/**
	 * 归属地区
	 */
	private String schoolAreaId;
	
	/***
	 * 学校地址
	 */
	private String schoolAddress;
	
	/**
	 *  学校联系电话
	 */
	private String schoolTelephone;
	/**
	 * 学校性质: 0 公办 1 私立 2 其它
	 */
	private String schoolType;
	/**
	 * 学校类别: 0 幼儿园 1义务教务阶段 2高中
	 */
	@Expose
	private String schoolCategory;
	
	/**
	 * 校长寄语
	 */
	private String headmasterMotto;
	/**
	 * 学校总人数
	 */
	private Integer totalNum;
	
	/**
	 * 区域adress
	 */
	private String areaAddress;
	//校长名称
	private String president;
	//校徽
	private String schoolBadge;
	//校长照片
	private String headmasterMottoPhoto;
	//简介图片地址
	private String introductionImg;
	//新闻列表
	private List<News> newList;
	
	public long getSchoolId() {
		return schoolId;
	}
	public void setSchoolId(long schoolId) {
		this.schoolId = schoolId;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getSchoolAreaId() {
		return schoolAreaId;
	}
	public void setSchoolAreaId(String schoolAreaId) {
		this.schoolAreaId = schoolAreaId;
	}
	public String getSchoolAddress() {
		return schoolAddress;
	}
	public void setSchoolAddress(String schoolAddress) {
		this.schoolAddress = schoolAddress;
	}
	public String getSchoolTelephone() {
		return schoolTelephone;
	}
	public void setSchoolTelephone(String schoolTelephone) {
		this.schoolTelephone = schoolTelephone;
	}
	public String getSchoolType() {
		return schoolType;
	}
	public void setSchoolType(String schoolType) {
		this.schoolType = schoolType;
	}
	public String getSchoolCategory()
	{
		return schoolCategory;
	}
	public void setSchoolCategory(String schoolCategory)
	{
		this.schoolCategory = schoolCategory;
	}
	public String getHeadmasterMotto()
	{
		return headmasterMotto;
	}
	public void setHeadmasterMotto(String headmasterMotto)
	{
		this.headmasterMotto = headmasterMotto;
	}
	public Integer getTotalNum()
	{
		return totalNum;
	}
	public void setTotalNum(Integer totalNum)
	{
		this.totalNum = totalNum;
	}
	public String getPresident()
	{
		return president;
	}
	public void setPresident(String president)
	{
		this.president = president;
	}
	public String getSchoolBadge()
	{
		return schoolBadge;
	}
	public void setSchoolBadge(String schoolBadge)
	{
		this.schoolBadge = schoolBadge;
	}
	public String getHeadmasterMottoPhoto()
	{
		return headmasterMottoPhoto;
	}
	public void setHeadmasterMottoPhoto(String headmasterMottoPhoto)
	{
		this.headmasterMottoPhoto = headmasterMottoPhoto;
	}
	public String getIntroductionImg()
	{
		return introductionImg;
	}
	public void setIntroductionImg(String introductionImg)
	{
		this.introductionImg = introductionImg;
	}
	public List<News> getNewList()
	{
		return newList;
	}
	public void setNewList(List<News> newList)
	{
		this.newList = newList;
	}
	public String getAreaAddress()
	{
		return areaAddress;
	}
	public void setAreaAddress(String areaAddress)
	{
		this.areaAddress = areaAddress;
	}
	
}
