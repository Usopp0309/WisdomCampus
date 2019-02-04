package com.guotop.palmschool.entity;

import java.io.Serializable;

/**
 * 亦信用户转智慧校园用户实体类
 * 
 * @author shengyinjiang
 *
 */
public class UserForYixinToWisdom implements Serializable
{

	private static final long serialVersionUID = 1L;

	//亦信賬戶對應的userId
	private Integer yUserId;
	//亦信賬戶對應的phone
	private String yPhone;
	//亦信賬戶對應的智慧校園賬號(為空)
	private String yPalmUsername;
	//亦信賬戶對應的綁定手機號
	private String yBindPhone;
	//智慧校園賬戶對應的userId
	private Integer wUserId;
	//智慧校園賬戶對應的phone
	private String wPhone;
	//智慧校園賬戶對應的智慧校園賬號
	private String wPalmUserName;
	//智慧校園賬戶對應的綁定手機號
	private String wBindphone;
	//智慧校園賬戶對應的schoolId
	private String schoolId;
	//賬戶對應的balance
	private String balance;
	
	public Integer getyUserId()
	{
		return yUserId;
	}
	public void setyUserId(Integer yUserId)
	{
		this.yUserId = yUserId;
	}
	public String getyPhone()
	{
		return yPhone;
	}
	public void setyPhone(String yPhone)
	{
		this.yPhone = yPhone;
	}
	public String getyPalmUsername()
	{
		return yPalmUsername;
	}
	public void setyPalmUsername(String yPalmUsername)
	{
		this.yPalmUsername = yPalmUsername;
	}
	public String getyBindPhone()
	{
		return yBindPhone;
	}
	public void setyBindPhone(String yBindPhone)
	{
		this.yBindPhone = yBindPhone;
	}
	public Integer getwUserId()
	{
		return wUserId;
	}
	public void setwUserId(Integer wUserId)
	{
		this.wUserId = wUserId;
	}
	public String getwPhone()
	{
		return wPhone;
	}
	public void setwPhone(String wPhone)
	{
		this.wPhone = wPhone;
	}
	public String getwPalmUserName()
	{
		return wPalmUserName;
	}
	public void setwPalmUserName(String wPalmUserName)
	{
		this.wPalmUserName = wPalmUserName;
	}
	public String getwBindphone()
	{
		return wBindphone;
	}
	public void setwBindphone(String wBindphone)
	{
		this.wBindphone = wBindphone;
	}
	public String getSchoolId()
	{
		return schoolId;
	}
	public void setSchoolId(String schoolId)
	{
		this.schoolId = schoolId;
	}
	public String getBalance()
	{
		return balance;
	}
	public void setBalance(String balance)
	{
		this.balance = balance;
	}
	
	
}
