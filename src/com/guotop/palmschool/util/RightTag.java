package com.guotop.palmschool.util;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.User;

/**
 * 权限标签
 * 
 * @author jfy
 * @date 2015年11月25日
 */
public class RightTag extends TagSupport
{
	//按钮权限编码
	private String rightCode;
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 8075890892396839386L;

	@Override
	public int doStartTag() throws JspException
	{
		boolean result = false;
		HttpServletRequest request = (HttpServletRequest) this.pageContext.getRequest();// 通过成员变量获取HttpServletRequest对象
		User user = (User) request.getSession().getAttribute("user");// 获取登录到系统的用户
		List<Permission> permissionList = user.getPermissionList();
		if(permissionList != null){
			for (Permission permission : permissionList)
			{
				String permissionCode = permission.getPermissionCode();
				if (rightCode== null || rightCode.trim().equals("") || permissionCode.equals(rightCode) || permissionCode.equals("admin") )
				{
					result = true;
					break;
				}
			}
		}
		
		return result ? EVAL_BODY_INCLUDE : SKIP_BODY;// EVAL_BODY_INCLUDE代表执行自定义标签中的内容，SKIP_BODY代表不执行自定义标签中的内容。
	}

	public String getRightCode()
	{
		return rightCode;
	}

	public void setRightCode(String rightCode)
	{
		this.rightCode = rightCode;
	}
	
}
