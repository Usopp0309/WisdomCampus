package com.guotop.palmschool.system.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Department;
import com.guotop.palmschool.entity.Menu;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserPermission;
import com.guotop.palmschool.entity.UserRole;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.DepartmentService;
import com.guotop.palmschool.service.MenuService;
import com.guotop.palmschool.service.PermissionService;
import com.guotop.palmschool.system.service.SetPermissionService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;

import dev.gson.GsonHelper;

/**
 * 权限配置控制类
 * 
 * @author jfy
 */
@RequestMapping("/permission")
@Controller
public class SetPermissionController extends BaseController
{
	@Resource
	private SetPermissionService setPermissionService;
	@Resource
	private CommonService commonService;
	@Resource
	private MenuService menuService;
	@Resource
	private PermissionService permissionService;
	@Resource
	private ClazzService clazzService;
	@Resource
	private DepartmentService departmentService;

	private Logger logger = LoggerFactory.getLogger(SetPermissionController.class);

	/**
	 * 进入权限配置页面
	 */
	@RequestMapping(value = "/toSetPermission.do")
	public String toSetPermission(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		return "system/set_permission_list";
	}

	/**
	 * 进入权限修改页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toModifyPermission.do")
	public String toModifyPermission(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		Integer teacherId = Integer.valueOf(request.getParameter("userId"));
		modelMap.addAttribute("teacherId", teacherId);

		// return "system/modify_permission";
		return "system/modify_permission_new";
	}

	/**
	 * 加载所有教师的信息
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getAllTeacherList.do")
	public String getAllTeacherList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");

		try
		{
			// 分页信息
			Integer currentPage = 1;

			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			User user = (User) session.getAttribute("user");

			Map<String, Object> paramMap = new HashMap<String, Object>();

			String queryContent = request.getParameter("queryContent");

			paramMap.put("queryContent", queryContent);
			List<Permission> permissionList = user.getPermissionList();
			paramMap.put("permissionManage", "");
			for (Permission permission : permissionList)
			{
				if ("permissionManage".equals(permission.getPermissionCode()))
				{
					paramMap.put("permissionManage", "permissionManage");
					paramMap.put("userId", user.getUserId());
					break;
				}
			}
			// 获取分页数据
			Pages pages = setPermissionService.getAllTeacherList(this.getPages().getPageSize(), currentPage, paramMap, user);

			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 加载教师的详细信息
	 * 
	 */
	@RequestMapping(value = "/getTeacherByIdForModifyPermission.do")
	public String getTeacherByIdForModifyPermission(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer teacherId = Integer.valueOf(request.getParameter("teacherId"));
			User teacher = setPermissionService.getTeacherByIdForModifyPermission(teacherId);
			Gson gson = new Gson();
			String json = gson.toJson(teacher);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 获取登录用户所有权限用于展示 获取修改人的所有权限用于在显示的时候加上已经选择标记
	 */
	@RequestMapping(value = "/getAllMenuAndPermissionByTeacherId.do", method = RequestMethod.POST)
	public String getAllMenuAndPermissionByTeacherId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		/*
		 * 获取登录用于能看到的所有一级菜单以及二级菜单 并且能够显示被操作用户是否已经拥有该权限
		 */
		try
		{
			response.setCharacterEncoding("UTF-8");
			User loginUser = (User) session.getAttribute("user");
			Integer teacherId = Integer.valueOf(request.getParameter("teacherId"));
			// 被操作人的所有权限列表转换为map结合
			List<Permission> objectPermissionList = setPermissionService.getHavePermissionById(teacherId);
			Map<String, Permission> objectUserMap = new HashMap<String, Permission>();
			for (Permission permission : objectPermissionList)
			{
				objectUserMap.put(permission.getPermissionCode(), permission);
			}
			/* ---------start----------- */
			/* 获取登录用户能看到的所有菜单和权限 admin看到所有的,其余看到他能看到的菜单和按钮权限 */
			// 获取该学校能显示的所有一级菜单以及一级菜单下的二级菜单
			//在使用缓存方法的时候出现的问题先用超管登录，进入设置权限菜单页面后，使用修改的人登录到权限修改页面，在使用超管登录的话，缓存的内容会变
			List<Menu> menuList = menuService.getAllMenuInfoNOCache(loginUser.getSchoolId(), 0);
			List<Menu> newMenuList = new ArrayList<Menu>();
			if (!CollectionUtils.isEmpty(menuList))
			{
				List<Permission> loginUserPermissionList = loginUser.getPermissionList();
				// 将登录用户所拥有的权限list转换成map,Key是权限编码
				Map<String, Permission> loginUserMap = new HashMap<String, Permission>();
				for (Permission permission : loginUserPermissionList)
				{
					loginUserMap.put(permission.getPermissionCode(), permission);
				}
				Map<String, List<Permission>> allMap = permissionService.getPermissionList(loginUser.getSchoolId());
				for (Menu parentMenu : menuList)
				{
					List<Menu> newSubMenuList = new ArrayList<Menu>();
					List<Menu> subMenuList = parentMenu.getSubMenuList();
					for (Menu subMenu : subMenuList)
					{
						// 获取二级菜单的权限值
						String permissionCode = subMenu.getPermissionCode();
						if (!StringUtil.isEmpty(permissionCode))
						{
							// 判断【被操作者】有没有该二级菜单的权限
							boolean objectHasPermission = (objectUserMap.containsKey(permissionCode));
							subMenu.setHasPermission(objectHasPermission);

							// 获取二级菜单对应的子权限列表
							List<Permission> subPermissionList = allMap.get(permissionCode);
							List<Permission> newSubPermissionList = new ArrayList<Permission>();
							boolean loginHasPermission = false;
							if (loginUserMap.containsKey("admin") || loginUserMap.containsKey(permissionCode))
							{
								loginHasPermission = true;
								if (!CollectionUtils.isEmpty(subPermissionList))
								{
									for (Permission subPermission : subPermissionList)
									{
										String subPermissionCode = subPermission.getPermissionCode();
										// 判断【被操作者】有没有该二级菜单下的子权限
										boolean objectHasSubPermission = (objectUserMap.containsKey(subPermissionCode));
										subPermission.setHasPermission(objectHasSubPermission);

										if (loginUserMap.containsKey("admin") || loginUserMap.containsKey(subPermissionCode))
										{
											newSubPermissionList.add(subPermission);
										}
									}
								}
							}
							if (loginHasPermission)
							{
								subMenu.setSubPermissionList(newSubPermissionList);
								newSubMenuList.add(subMenu);
							}
						}
					}

					if (!CollectionUtils.isEmpty(newSubMenuList))
					{
						parentMenu.setHasPermission(true);
						parentMenu.setSubMenuList(newSubMenuList);
						newMenuList.add(parentMenu);
					}
				}
			}
			/* ---------end----------- */
			Gson gson = new Gson();
			String json = gson.toJson(newMenuList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 权限设置页面获取登录人能看到的所有部门
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getDepartmentListForSetPermission.do")
	public String getDepartmentList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		User user = (User) session.getAttribute("user");
		List<Department> departmentList = new ArrayList<Department>();
		if (commonService.hasAdminPermission(user))
		{
			departmentList = commonService.getDepartmentList();
		} else
		{
			departmentList = departmentService.getDepartmentListForSetPermission(user.getUserId());
		}
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(departmentList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 权限设置页面获取登录人能看到的所有班级
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getClazzListForSetPermission.do")
	public String getClazzList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		User user = (User) session.getAttribute("user");
		try
		{
			List<Clazz> clazzList = new ArrayList<Clazz>();
			if (commonService.hasAdminPermission(user))
			{
				Map<String, Object> parmMap = new HashMap<String, Object>();
				parmMap.put("user", user);
				clazzList = commonService.getClazzList(parmMap);
			} else
			{
				clazzList = clazzService.getClazzListForSetPermission(user.getUserId());
			}

			String json = gson.toJson(clazzList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 根据二级菜单的权限值和userId 到user_permission表中查询出【被操作用户】已经拥有的操作班级或操作部门
	 * 
	 */
	@RequestMapping(value = "/loadClazzIdAndDepartIdByPermissionCodeAndUserId.do")
	public String loadClazzIdAndDepartIdByPermissionCodeAndUserId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer teacherId = Integer.valueOf(request.getParameter("teacherId"));
			String permissionCode = request.getParameter("permissionCode");

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("permissionCode", permissionCode);
			paramMap.put("userId", teacherId);

			List<UserPermission> list = setPermissionService.getClazzIdAndDepartIdByPermissionCodeAndUserId(paramMap);
			if (CollectionUtils.isEmpty(list))
			{
				list = new ArrayList<UserPermission>();
			}
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

	/**
	 * 根据用户Id和permissionCodes 添加到的palm_user_permission
	 * 
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addPermissionCodesByUserId.do")
	public String addPermissionCodesByUserId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			User loginUser = (User) session.getAttribute("user");
			Integer teacherId = Integer.valueOf(request.getParameter("teacherId"));
			String permissionMapFromJSON = request.getParameter("permissionMap");
			String subMenuPermissionMapJSON = request.getParameter("subMenuPermissionMap");

			List<UserRole> roleList = commonService.getUserRoleByUserId(teacherId);
			String roleCode = "teacher";
			if (!CollectionUtils.isEmpty(roleList))
			{
				for (UserRole urole : roleList)
				{
					if (!"parent".equals(urole.getRoleCode()))
					{
						roleCode = urole.getRoleCode();
						break;
					}
				}
			}

			// 这个是所有在前台【操作过】得二级菜单的map集合  key=二级菜单权限  value=操作对象list
			Map<String, List<String>> permissionCodeMap = GsonHelper.fromJson(permissionMapFromJSON, new TypeToken<HashMap<String, List<String>>>()
			{
			}.getType());
			// 这个是所有选择的权限map集合 key=二级菜单权限 value=子权限list
			Map<String, List<String>> subMenuPermissionMap = GsonHelper.fromJson(subMenuPermissionMapJSON, new TypeToken<HashMap<String, List<String>>>()
			{
			}.getType());
			boolean flag = true;
			try
			{
				// 如果这个为空代表没有操作
				if (permissionCodeMap.isEmpty())
				{
					flag = true;
				} else
				{
					/*
					 * 情况1.permissionCodeMap中有,subMenuPermissionMap中有,说明这个权限有修改或添加
					 * 情况2.permissionCodeMap中有,subMenuPermissionMap中没有,说明这个权限是删除
					 * 情况3.permissionCodeMap中没有,subMenuPermissionMap中有,说明这个权限以前有,但是没有修改过，所以不要任何操作
					 * 情况4.permissionCodeMap中没有,subMenuPermissionMap中没有,说明这个权限以前没有,现在也没有,所以不要任何操作
					 */
					Map<String, List<Permission>> allMap = permissionService.getPermissionList(loginUser.getSchoolId());
					Set keySet = permissionCodeMap.keySet();// 返回键的集合
					Iterator it = keySet.iterator();
					while (it.hasNext())
					{
						String subMenuPermissionCode = (String) it.next();
						if (subMenuPermissionMap.containsKey(subMenuPermissionCode))
						{
							// 符合【情况1】
							// 处理方法:
							// 步骤1,根据userId和permissionCode删除原有的相关权限
							// 步骤1,根据userId,permissionCode和操作对象保存到palm_user_permission
							List<Permission> subPermissionList = allMap.get(subMenuPermissionCode);//获取二级菜单下的所有子权限，然后删除
							List<String> permissionCodeListForDel = new ArrayList<String>();
							permissionCodeListForDel.add(subMenuPermissionCode);
							if (!CollectionUtils.isEmpty(subPermissionList))
							{
								for (Permission permission : subPermissionList)
								{
									permissionCodeListForDel.add(permission.getPermissionCode());
								}
							}
							Map<String, Object> delParamMap = new HashMap<String, Object>();
							delParamMap.put("userId", teacherId);
							delParamMap.put("permissionCodeList", permissionCodeListForDel);
							setPermissionService.deleteByUserIdAndPermissionCode(delParamMap);

							List<String> subPermissionCodeListForAdd = subMenuPermissionMap.get(subMenuPermissionCode);
							subPermissionCodeListForAdd.add(subMenuPermissionCode);
							List<String> departIdAndClazzIds = permissionCodeMap.get(subMenuPermissionCode);
							List<UserPermission> userPermissionList = new ArrayList<UserPermission>();
							for (String permissionCode : subPermissionCodeListForAdd)
							{
								if (!CollectionUtils.isEmpty(departIdAndClazzIds))
								{
									for (String id : departIdAndClazzIds)
									{
										UserPermission up = new UserPermission();
										up.setUserId(teacherId);
										up.setPermissionCode(permissionCode);
										up.setRoleCode(roleCode);
										// "D" 代表部门
										// "C" 代表班级
										String optId = id.substring(1);
										boolean isDepart = false;
										if ('D' == id.charAt(0))
										{
											isDepart = true;
										} else if ('C' == id.charAt(0))
										{
											isDepart = false;
										}
										
										if (isDepart)
										{
											up.setOptDepartId(optId);
										} else
										{
											up.setOptClazzId(optId);
										}
										userPermissionList.add(up);
									}
								}else{
									UserPermission up = new UserPermission();
									up.setUserId(teacherId);
									up.setPermissionCode(permissionCode);
									up.setRoleCode(roleCode);
									userPermissionList.add(up);
								}
							}
							if(!CollectionUtils.isEmpty(userPermissionList)){
								commonService.addUserPermission(userPermissionList);
							}
							
						} else
						{
							// 符合【情况2】
							List<Permission> subPermissionList = allMap.get(subMenuPermissionCode);//获取二级菜单下的所有子权限，然后删除
							List<String> permissionCodeListForDel = new ArrayList<String>();
							permissionCodeListForDel.add(subMenuPermissionCode);
							if (!CollectionUtils.isEmpty(subPermissionList))
							{
								for (Permission permission : subPermissionList)
								{
									permissionCodeListForDel.add(permission.getPermissionCode());
								}
							}
							Map<String, Object> delParamMap = new HashMap<String, Object>();
							delParamMap.put("userId", teacherId);
							delParamMap.put("permissionCodeList", permissionCodeListForDel);
							setPermissionService.deleteByUserIdAndPermissionCode(delParamMap);
						}

					}

				}
			} catch (Exception e)
			{
				logger.error("addPermissionCodesByUserId，修改权限失败:" + e.getMessage());
				flag = false;
			}

			String json = GsonHelper.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			logger.error("addPermissionCodesByUserId，修改权限失败:" + e.getMessage());
		}

		return null;
	}

	/*----------------------------------下面代码是以前的代码，需要删除-------------------------------------------------*/
	/**
	 * 根据用户id加载已有的权限
	 * 
	 */
	@RequestMapping(value = "/getHavePermissionById.do")
	public String getHavePermissionById(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");
		try
		{

			Integer teacherId = Integer.valueOf(request.getParameter("teacherId"));

			List<Permission> permissionList = setPermissionService.getHavePermissionById(teacherId);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(permissionList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 根据用户id加载未有的权限
	 * 
	 */
	@RequestMapping(value = "/getNotHavePermissionById.do")
	public String getNotHavePermissionById(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");
		try
		{

			Integer teacherId = Integer.valueOf(request.getParameter("teacherId"));
			List<Permission> permissionList = setPermissionService.getNotHavePermissionById(teacherId);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(permissionList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 根据用户Id和permissionCode删除用户对应的权限
	 * 
	 */
	@RequestMapping(value = "/deletePermission.do")
	public String deletePermission(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");
		try
		{

			Integer teacherId = Integer.valueOf(request.getParameter("teacherId"));
			String permissionCode = request.getParameter("permissionCode");

			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<UserRole> roleList = commonService.getUserRoleByUserId(teacherId);
			if (!CollectionUtils.isEmpty(roleList))
			{
				for (UserRole userRole : roleList)
				{
					if (!"parent".equals(userRole.getRoleCode()))
					{
						paramMap.put("roleCode", userRole.getRoleCode());
						break;
					}
				}
			}
			paramMap.put("permissionCode", permissionCode);
			paramMap.put("userId", teacherId);

			String success = setPermissionService.deletePermissionByUserIdAndpermissionCodeAndRoleCode(paramMap);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(success);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 根据用户Id和permissionCode删除用户对应的权限
	 * 
	 */
	@RequestMapping(value = "/addPermission.do")
	public String addPermission(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");
		try
		{

			Integer teacherId = Integer.valueOf(request.getParameter("teacherId"));
			String permissionCode = request.getParameter("permissionCode");

			String ids = request.getParameter("ids");

			String[] idArray = ids.split(",");// 分割出来的字符数组

			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<UserRole> roleList = commonService.getUserRoleByUserId(teacherId);
			if (!CollectionUtils.isEmpty(roleList))
			{
				for (UserRole userRole : roleList)
				{
					if (!"parent".equals(userRole.getRoleCode()))
					{
						paramMap.put("roleCode", userRole.getRoleCode());
						break;
					}
				}
			} else
			{
				paramMap.put("roleCode", "teacher");
			}

			paramMap.put("permissionCode", permissionCode);
			paramMap.put("userId", teacherId);
			commonService.getUserRoleByUserId(teacherId);
			String success = null;
			for (int i = 0; i < idArray.length; i++)
			{
				String id = idArray[i];
				paramMap.put("id", id);
				success = setPermissionService.addPermissionByUserIdAndpermissionCode(paramMap);
			}
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(success);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 根据用户Id和permissionCode修改用户对应的权限
	 * 
	 */
	@RequestMapping(value = "/modifyPermission.do")
	public String modifyPermission(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");
		try
		{

			Integer teacherId = Integer.valueOf(request.getParameter("teacherId"));
			String permissionCode = request.getParameter("permissionCode");

			String ids = request.getParameter("ids");

			String[] idArray = ids.split(",");// 分割出来的字符数组

			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<UserRole> roleList = commonService.getUserRoleByUserId(teacherId);
			if (!CollectionUtils.isEmpty(roleList))
			{
				for (UserRole userRole : roleList)
				{
					if (!"parent".equals(userRole.getRoleCode()))
					{
						paramMap.put("roleCode", userRole.getRoleCode());
						break;
					}
				}
			} else
			{
				paramMap.put("roleCode", "teacher");
			}
			paramMap.put("permissionCode", permissionCode);
			paramMap.put("userId", teacherId);

			setPermissionService.deletePermissionByUserIdAndpermissionCodeAndRoleCode(paramMap);

			String success = null;
			for (int i = 0; i < idArray.length; i++)
			{
				String id = idArray[i];
				paramMap.put("id", id);
				success = setPermissionService.addPermissionByUserIdAndpermissionCode(paramMap);
			}
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(success);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

}
