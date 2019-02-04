package com.guotop.palmschool.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.service.RoleService;

/**
 * 角色操作类
 * 
 * @author zhou
 * 
 */
@RequestMapping("/role")
@Controller
public class RoleController
{
	@Resource
	private RoleService roleService;

	@RequestMapping(value = "/getRoleList.do")
	public String getRoleList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			List<Role> list = roleService.getRoleList();
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(list);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;

	}
}
