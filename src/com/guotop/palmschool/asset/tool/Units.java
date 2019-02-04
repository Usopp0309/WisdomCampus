package com.guotop.palmschool.asset.tool;

import java.util.ArrayList;
import java.util.List;

public enum Units{
	TAI("台", 0),
	GE("个", 1), 
	BA("把", 2), 
	TAO("套", 3),
	JIAN("件", 4), 
	BU("部", 5),
	PING("瓶", 6), 
	HE("盒", 7);
	
	// 成员变量
	private String name;
	private int index;
	// 构造方法，注意：构造方法不能为public，因为enum并不可以被实例化
	private Units(String name, int index)
	{
		this.setName(name);
		this.index = index;
	}

	// 普通方法
    public static List<String> getList()
    {
    	List<String> nameList = new ArrayList<>();
    	for (Units u : Units.values())
    	{
    		nameList.add(u.name);
    	}
      return nameList;
    }
    
	public void setIndex(int index)
	{
		this.index = index;
	}
	
	public int getIndex()
	{
		return index;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}
}
