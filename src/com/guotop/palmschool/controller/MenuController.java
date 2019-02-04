package com.guotop.palmschool.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.entity.Menu;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.MenuService;
import com.guotop.palmschool.service.PermissionService;
import com.guotop.palmschool.service.SchoolService;

import dev.gson.GsonHelper;

/**
 * 菜单控制类
 * 
 * @author jfy
 *
 */
@RequestMapping("/menu")
@Controller
public class MenuController extends BaseController
{
	@Resource
	private MenuService menuService;
	@Resource
	private SchoolService schoolService;
	@Resource
	private PermissionService permissionService;

	/**
	 * 获取菜单信息
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/getAllMenu.do")
	public String getAllMenu(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			User loginUser = (User) session.getAttribute("user");
			List<Menu> menuList = new ArrayList<Menu>();
			DBContextHolder.setDBType(loginUser.getSchoolId());
			if (loginUser.getUserId() == 1)
			{
				menuList = menuService.getAllMenuInfoSysadmin(loginUser.getSchoolId(), null);
			} else
			{
				menuList = menuService.getAllMenuInfo(loginUser.getSchoolId(), 0);
			}
			session.setAttribute("menuList", menuList);
			Gson gson = new Gson();
			String json = gson.toJson(menuList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}

	/**
	 * 进入菜单配置页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/toMenuConfig.do")
	public String toMenuConfig(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			User loginUser = (User) session.getAttribute("user");
			String schoolId = loginUser.getSchoolId();
			if (schoolId != null && !"".equals(schoolId))
			{
				School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(schoolId));
				modelMap.addAttribute("schoolName", school.getSchoolName());
				if (school.getSchoolCategory().equals("0"))
				{
					modelMap.addAttribute("version", "智慧校园幼儿园版");
				} else if (school.getSchoolCategory().equals("1"))
				{
					modelMap.addAttribute("version", "智慧校园中小学版");
				}
			}

		} catch (Exception e)
		{
			e.printStackTrace();
		}
//		return "system/menuConfig";
		return "system/New_menuConfig";
	}

	/**
	 * 菜单配置
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/doMenuConfig.do")
	public String doMenuConfig(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		User loginUser = (User) session.getAttribute("user");
		String schoolId = loginUser.getSchoolId();
		try
		{
			// 解析前台发送过来的选中菜单的id
			String[] checkMenuId = GsonHelper.fromJson(request.getParameter("checkMenuId"), String[].class);
			List<String> checkMenuIdList = new ArrayList<String>();
			// 将数组转换成list
			Collections.addAll(checkMenuIdList, checkMenuId);

			// 解析前台发送过来的未选中菜单的id
			String[] notCheckMenuId = GsonHelper.fromJson(request.getParameter("notCheckMenuId"), String[].class);
			List<String> notCheckMenuIdList = new ArrayList<String>();
			// 将数组转换成list
			Collections.addAll(notCheckMenuIdList, notCheckMenuId);

			if (checkMenuIdList.size() > 0)
			{
				// 修改所有选择菜单的id未可用状态
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("checkMenuIdList", checkMenuIdList);
				param.put("status", 0);
				menuService.modifyMenuStatus(schoolId, param);
			}
			if (notCheckMenuIdList.size() > 0)
			{
				// 修改所有未选择菜单的id状态为不可用状态
				HashMap<String, Object> param2 = new HashMap<String, Object>();
				param2.put("notCheckMenuIdList", notCheckMenuIdList);
				param2.put("status", 1);
				menuService.modifyMenuStatus(schoolId, param2);
			}

			response.getWriter().write("0");
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 获取所有菜单信息，用于设置菜单
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getMenusInfo.do")
	public String getMenus(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			List<Menu> list = menuService.getMenusInfo(null);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(list);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	/**
	 * 根据Id查询
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getMenusById.do")
	public String getMenusById(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");//菜单名称
		try
		{
			Map<String, Object> map= menuService.getMapById(id);
			
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(map);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	/**
	 * 根据permissionCode查询
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getPermiByCode.do")
	public String getPermiByCode(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		String permissionCode = request.getParameter("permissionCode");//菜单名称
		try
		{
			Permission p = permissionService.getPermissionPermissionCode(permissionCode);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(p);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	/**
	 * 根据id查询Menu
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getMenuById.do")
	public String getMenuById(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");//菜单名称
		try
		{
			Menu m =menuService.getMenuById(id);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(m);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	/**
	 * 查询所有父级菜单
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getAllMenus.do")
	public String getAllMenus(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			
			List<Menu> menus= menuService.getParentMenuInfo(null);
			
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(menus);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	/**
	 * 查询 父级权限
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getByParentCodeNull.do")
	public String getByParentCodeNull(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			
			List<Permission> pes= permissionService.getByParentCodeNull();
			
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pes);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	/**
	 * 查询二级菜单数量
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/getChildCount.do")
	public String getChildCount(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			String parentId = request.getParameter("parentId");
			int child = menuService.getChildCount(parentId);
			
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(child);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	/**
	 * 修改菜单
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/updateMenuById.do")
	public String updateMenuById(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			int f = 0;
			String id = request.getParameter("id");//id
			String name = request.getParameter("name");//菜单名称
			String status = request.getParameter("status");//'0' COMMENT '是否启用:0 启用 1：禁用'
			String parentId = request.getParameter("parentId");//父菜单ID 
			String url = request.getParameter("url");//页面链接
			String icon = request.getParameter("icon");//图标
			if(icon == null ||"".equals(icon)){
				Menu m =menuService.getMenuById(id);
				icon=m.getIcon();
			}
			String permissionCode = request.getParameter("permissionCode");//权限编码
			String orders = request.getParameter("orders");//排序号
			
			Menu m = new Menu();
			m.setId(id);
			m.setIcon(icon);
			m.setParentId(parentId);
			m.setName(name);
			m.setOrders(Integer.parseInt(orders));
			m.setPermissionCode(permissionCode);
			m.setUrl(url);
			m.setStatus(status);
			
			try {
				menuService.updateMenu(m);
			} catch (Exception e) {
				e.printStackTrace();
				f=1;
			}
			
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(f);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	@RequestMapping("/updatePermissiom.do")
	public String updatePermissiom(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			int f = 0;
			String parentCode = request.getParameter("parentCode");//父菜单ID 
			String permissionCode = request.getParameter("permissionCode");//权限编码
			String permissionName = request.getParameter("permissionName");
			String type = request.getParameter("type");
			
			Permission pe =new Permission();
			pe.setParentCode(parentCode);
			pe.setPermissionCode(permissionCode);
			pe.setPermissionName(permissionName);
			pe.setType(type);
			
			try {
				permissionService.updatePermission(pe);
			} catch (Exception e) {
				e.printStackTrace();
				f=1;
			}
			
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(f);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 添加菜单
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/addMenus.do")
	public String addMenus(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			/**
			 * 父菜单的 parentId，url 都为NULL
			 */
			String id = request.getParameter("id");//id
			
			String name = request.getParameter("name");//菜单名称
//			String status = request.getParameter("status");//'0' COMMENT '是否启用:0 启用 1：禁用'
			String parentId = request.getParameter("parentId");//父菜单ID 
			String url = request.getParameter("url");//页面链接
//			String icon = request.getParameter("icon");//图标
			String permissionCode = request.getParameter("permissionCode");//权限编码
			String orders = request.getParameter("orders");//排序号
			
			String permissionName = request.getParameter("permissionName");
			HashMap<String, Object> map =new HashMap<String, Object>();
			String parentCode = null;
			if(parentId != null && parentId!=""){
				Menu m =menuService.getMenuById(parentId);
				parentCode = m.getPermissionCode();
			}
			
			map.put("id", id);
			map.put("name", name);
			map.put("status", 0);
			map.put("parentId", parentId);
			map.put("url", url);
			map.put("icon", null);
			map.put("isSystem", 1);
			map.put("permissionCode", permissionCode);
			map.put("orders", orders);
			map.put("permissionName", permissionName);
			map.put("type", 0);//0菜单 1按钮
			map.put("parentCode",parentCode);//父权限
			int f =0 ;
			try {
				if(id != null && permissionCode!=null){
					menuService.addMenu(map);
				}else{
					f=1;
				}
			} catch (Exception e) {
				e.printStackTrace();
				f=1;
			}
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(f);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	@RequestMapping("/addPermisssion.do")
	public String addPermisssion(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			String parentCode = request.getParameter("parentCode");//父菜单ID 
			String permissionCode = request.getParameter("permissionCode");//权限编码
			String permissionName = request.getParameter("permissionName");
			String type = request.getParameter("type");
			
			Permission pe =new Permission();
			pe.setParentCode(parentCode);
			pe.setPermissionCode(permissionCode);
			pe.setPermissionName(permissionName);
			pe.setType(type);
			int f =0 ;
			try {
				permissionService.addPermission(pe);
			} catch (Exception e) {
				e.printStackTrace();
				f=1;
			}
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(f);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	/**
	 * 删权限
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/deleteByPermissionCode.do")
	public String deleteByPermissionCode(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			int f = 0;
			String permissionCode = request.getParameter("permissionCode");//权限编码
			
			
			try {
				permissionService.deleteByPermissionCode(permissionCode);
			} catch (Exception e) {
				e.printStackTrace();
				f=1;
			}
			
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(f);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	/**
	 * 删菜单 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/deleteMenuById.do")
	public String deleteMenuById(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			int f = 0;
			String id = request.getParameter("id");//权限编码
			try {
				menuService.deleteById(id);
			} catch (Exception e) {
				e.printStackTrace();
				f=1;
			}
			
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(f);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入菜单配置页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/cleanMenuCache.do")
	public String cleanMenuCache(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			User loginUser = (User) session.getAttribute("user");
			String schoolId = loginUser.getSchoolId();
			menuService.cleanMenuCache(schoolId);
			menuService.cleanMenuCacheForSysadmin(schoolId);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
//		return "system/menuConfig";
		return "system/New_menuConfig";
	}
}
