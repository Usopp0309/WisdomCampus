package com.guotop.palmschool.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 菜单实体类
 * 
 * @author zhou
 */
public class Menu implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * ID
	 */
	private String id;

	/**
	 * 菜单名称
	 */
	private String name;

	/**
	 * 状态
	 */
	private String status;

	/**
	 * 父菜单ID
	 */
	private String parentId;

	/**
	 * 菜单链接
	 */
	private String url;

	/**
	 * 菜单图片
	 */
	private String icon;
	/**
	 * 是否系统菜单
	 */
	private String isSystem;
	/**
	 * 菜单权限编码
	 */
	private String permissionCode;

	/**
	 * 排序
	 */
	private Integer orders;
	/**
	 * 子菜单列表
	 */
	private List<Menu> subMenuList = new ArrayList<Menu>();
	
	/**
	 * 菜单对应的子权限列表
	 */
	private List<Permission> subPermissionList = new ArrayList<Permission>();
	
	/**
	 * 是否拥有该权限
	 */
	private boolean hasPermission;

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public String getParentId()
	{
		return parentId;
	}

	public void setParentId(String parentId)
	{
		this.parentId = parentId;
	}

	public String getUrl()
	{
		return url;
	}

	public void setUrl(String url)
	{
		this.url = url;
	}

	public String getIcon()
	{
		return icon;
	}

	public void setIcon(String icon)
	{
		this.icon = icon;
	}

	public String getIsSystem()
	{
		return isSystem;
	}

	public void setIsSystem(String isSystem)
	{
		this.isSystem = isSystem;
	}

	public String getPermissionCode()
	{
		return permissionCode;
	}

	public void setPermissionCode(String permissionCode)
	{
		this.permissionCode = permissionCode;
	}

	public List<Menu> getSubMenuList()
	{
		return subMenuList;
	}

	public void setSubMenuList(List<Menu> subMenuList)
	{
		this.subMenuList = subMenuList;
	}

	public Integer getOrders()
	{
		return orders;
	}

	public void setOrders(Integer orders)
	{
		this.orders = orders;
	}

	public List<Permission> getSubPermissionList()
	{
		return subPermissionList;
	}

	public void setSubPermissionList(List<Permission> subPermissionList)
	{
		this.subPermissionList = subPermissionList;
	}

	public boolean isHasPermission()
	{
		return hasPermission;
	}

	public void setHasPermission(boolean hasPermission)
	{
		this.hasPermission = hasPermission;
	}

}
