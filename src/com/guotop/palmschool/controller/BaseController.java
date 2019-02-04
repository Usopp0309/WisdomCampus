package com.guotop.palmschool.controller;

import com.guotop.palmschool.util.Pages;

public class BaseController 
{
	
	// 分页部分
	private Pages pages = new Pages();
	
	private String cpage = "1";
	
	private String total = "7";
	
	private String cpageHeadTeacher = "1";

	private String cpageNormalUser = "1";
	

	public Pages getPages() 
	{
		return pages;
	}

	public void setPages(Pages pages) 
	{
		this.pages = pages;
	}

	public String getCpage() 
	{
		return cpage;
	}

	public void setCpage(String cpage) 
	{
		this.cpage = cpage;
	}

	public String getTotal() 
	{
		return total;
	}

	public void setTotal(String total) 
	{
		this.total = total;
	}
	
	public String getCpageHeadTeacher() 
	{
		return cpageHeadTeacher;
	}

	public void setCpageHeadTeacher(String cpageHeadTeacher) 
	{
		this.cpageHeadTeacher = cpageHeadTeacher;
	}
	
	public String getCpageNormalUser() 
	{
		return cpageNormalUser;
	}

	public void setCpageNormalUser(String cpageNormalUser) 
	{
		this.cpageNormalUser = cpageNormalUser;
	}
}
