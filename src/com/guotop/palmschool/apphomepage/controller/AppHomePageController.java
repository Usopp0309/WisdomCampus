package com.guotop.palmschool.apphomepage.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.guotop.palmschool.apphomepage.entity.APPHomePage;
import com.guotop.palmschool.apphomepage.entity.AddressList;
import com.guotop.palmschool.apphomepage.service.AppHomePageService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.dynamicGraph.entity.DynamicGraph;
import com.guotop.palmschool.dynamicGraph.service.DynamicGraphService;
import com.guotop.palmschool.entity.Menu;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.MenuService;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.FileUploadUtil;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.richx.pojo.RichHttpResponse;
import com.richx.pojo.WisdomCampusMenu;

import dev.gson.GsonHelper;

/**
 * APP首页设置
 */
@RequestMapping("/appHomePage")
@Controller
public class AppHomePageController extends BaseController
{
	private Logger log = LoggerFactory.getLogger(AppHomePageController.class);

	@Resource
	private AppHomePageService appHomePageService;

	@Resource
	private UserService userService;

	@Resource
	private SchoolService schoolService;

	@Resource
	private DynamicGraphService dynamicGraphService;

	@Resource
	private MenuService menuService;

	/**
	 * 进入APP首页设置页面
	 */
	@RequestMapping(value = "/toSetAppHomePage.do")
	public String toSetAppHomePage(HttpSession session, ModelMap modelMap)
	{
		User user = (User) session.getAttribute("user");
		School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(user.getSchoolId()));
		modelMap.addAttribute("school", school);
		return "apphomepage/app_home_page";
	}

	/**
	 * 获取APP首页中部【四】个菜单的已选项
	 */
	@RequestMapping(value = "/loadMiddleMenuList.do")
	public String loadMiddleMenuList(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			List<APPHomePage> middleMenu = appHomePageService.getMenuList(1);
			Gson gson = new Gson();
			String json = gson.toJson(middleMenu);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;

	}

	/**
	 * 获取APP首页中部【八】个菜单的已选项
	 */
	@RequestMapping(value = "/loadBelowMenuList.do")
	public String loadBelowMenuList(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			List<APPHomePage> belowMenu = appHomePageService.getMenuList(2);

			Gson gson = new Gson();
			String json = gson.toJson(belowMenu);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;

	}

	/**
	 * 获取APP首页上不动态图
	 */
	@RequestMapping(value = "/loadDynamicGraphList.do")
	public String loadDynamicGraphList(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			List<DynamicGraph> graphList = dynamicGraphService.getGraphListByStatus(1);

			Gson gson = new Gson();
			String json = gson.toJson(graphList);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 获取通讯录
	 */
	@RequestMapping(value = "/loadAddressList.do")
	public String loadAddressList(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{

			List<AddressList> addressList = appHomePageService.getAddressList();

			Gson gson = new Gson();
			String json = gson.toJson(addressList);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;

	}

	/**
	 * 修改通讯录状态
	 */
	@RequestMapping(value = "/updateAddressList.do")
	public String updateAddressList(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{

			Integer status = StringUtil.toint(request.getParameter("status"));
			String menuId = request.getParameter("menuId");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("status", status);
			paramMap.put("menuId", menuId);
			appHomePageService.updateAddressList(paramMap);
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;

	}

	/**
	 * 修改通讯录状态
	 */
	@RequestMapping(value = "/deleteMenu.do")
	public String deleteMenu(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{

			Integer menuStatus = StringUtil.toint(request.getParameter("menuStatus"));
			Integer menuType = StringUtil.toint(request.getParameter("menuType"));
			String menuId = request.getParameter("menuId");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("menuStatus", menuStatus);
			paramMap.put("menuType", menuType);
			paramMap.put("menuId", menuId);
			appHomePageService.deleteMenu(paramMap);
			List<APPHomePage> pageList = appHomePageService.getPageListByType(paramMap);
			if (pageList.size() > 0)
			{
				Map<String, Object> map = new HashMap<String, Object>();
				for (APPHomePage page : pageList)
				{
					map.put("id", page.getId());
					map.put("menuType", page.getMenuType() - 1);
					appHomePageService.updateMenu(map);
				}
			}
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;

	}

	/**
	 * 获取APP首页中部四个菜单的可选项
	 * TODO 该方法已经舍弃
	 */
	@RequestMapping(value = "/getMiddleMenuList.do")
	public String getMiddleMenuList(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			User user = (User) session.getAttribute("user");
			School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(user.getSchoolId()));
			List<String> menuIdList = new ArrayList<String>();
			menuIdList.add("inout");
			menuIdList.add("abnormal");
			menuIdList.add("applyLeave");
			menuIdList.add("dormitoryInout");
			menuIdList.add("schoolBusDetail");
			menuIdList.add("clazzPhotoAlbum");
			menuIdList.add("selfPhotoAlbum");
			menuIdList.add("todayActivity");
			menuIdList.add("evaluateList");
			menuIdList.add("morningCheck"); 
			menuIdList.add("orderMessageManager"); 
			List<Menu> menuList = appHomePageService.getMiddleMenuList(menuIdList);
			Menu subM1 = new Menu();
			subM1.setId("newsInfo");
			subM1.setOrders(1);
			subM1.setIcon("fa fa-commenting-o");
			subM1.setName("新闻资讯");
			menuList.add(subM1);

			Menu subM2 = new Menu();
			subM2.setId("announcement");
			subM2.setOrders(2);
			subM2.setIcon("fa fa-volume-up");
			if (school.getSchoolCategory().equals("0"))
			{
				subM2.setName("园所通知");
			} else
			{
				subM2.setName("校园公告");
			}
			menuList.add(subM2);

			Menu subM3 = new Menu();
			subM3.setId("platformInfo");
			subM3.setOrders(3);
			subM3.setIcon("fa fa-commenting");
			subM3.setName("信息中心");
			menuList.add(subM3);

			Gson gson = new Gson();
			String json = gson.toJson(menuList);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;

	}

	/**
	 * 获取APP首页下面八个菜单的可选项
	 * TODO 该方法已经舍弃
	 */
	@RequestMapping(value = "/getBelowMenuList.do")
	public String getBelowMenuList(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			User user = (User) session.getAttribute("user");
			School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(user.getSchoolId()));
			// 获取所有一级菜单
			List<Menu> menuList = menuService.getAllMenuInfo(user.getSchoolId(), 0);

			List<Menu> list = new ArrayList<Menu>();

			for (Menu menu : menuList)
			{
				if (menu.getId().equals("schoolManager") || menu.getId().equals("systemManage") 
						|| menu.getId().equals("growthArchives") || menu.getId().equals("informationPlatform") 
						|| menu.getId().equals("xyYktManager") || menu.getId().equals("evaluationManager")
						|| menu.getId().equals("siguUpManager") || menu.getId().equals("liveCameraManager") 
						|| menu.getId().equals("morningCheckSys") || menu.getId().equals("cloudAchievement") 
						|| menu.getId().equals("sysMessage") || menu.getId().equals("attendanceReport")
						|| menu.getId().equals("attendanceFill")|| menu.getId().equals("messageManage")
						|| menu.getId().equals("assetManagement"))
				{
					if(menu.getId().equals("systemManage")){
						
						List<Menu> subList = new ArrayList<Menu>();
						menu.setSubMenuList(new ArrayList<Menu>());
						Menu subM = new Menu();
						subM.setId("addCardApply");
						subM.setOrders(1);
						subM.setIcon("fa fa-edit fa-lg");
						subM.setName("在线补办卡");
						subList.add(subM);
						menu.getSubMenuList().addAll(subList);
						list.add(menu);
					}else if(menu.getId().equals("assetManagement")){
						List<Menu> subList = new ArrayList<Menu>();
						menu.setSubMenuList(new ArrayList<Menu>());
						Menu subM1 = new Menu();
						subM1.setId("assetRepair");
						subM1.setOrders(1);
						subM1.setIcon("fa fa-wrench");
						subM1.setName("资产报修");
						subList.add(subM1);
						Menu subM2 = new Menu();
						subM2.setId("securityDanger");
						subM2.setOrders(2);
						subM2.setIcon("fa fa-building-o");
						subM2.setName("安全隐患排查");
						subList.add(subM2);
						Menu subM3 = new Menu();
						subM3.setId("bluetoothList");
						subM3.setOrders(3);
						subM3.setIcon("fa fa-tasks");
						subM3.setName("蓝牙手环");
						subList.add(subM3);
						menu.getSubMenuList().addAll(subList);
						list.add(menu);
					}else{
						continue;	
					}
				} else
				{
					List<Menu> subMenuList = menu.getSubMenuList();

					List<Menu> subList = new ArrayList<Menu>();
					Menu m = new Menu();
					for (Menu subMenu : subMenuList)
					{
						if (subMenu.getId().equals("schoolNewsLook"))
						{
							Menu subM1 = new Menu();
							subM1.setId("campusNews");
							subM1.setOrders(1);
							subM1.setIcon("fa fa-commenting-o");
							// 0 幼儿园 1义务教务阶段 2高中
							if (school.getSchoolCategory().equals("0"))
							{
								subM1.setName("园所新闻");
							} else
							{
								subM1.setName("校园新闻");
							}

							subList.add(subM1);

							Menu subM2 = new Menu();
							subM2.setId("activityNotice");
							subM2.setOrders(2);
							subM2.setIcon("fa fa-volume-up");
							subM2.setName("活动通知");
							subList.add(subM2);

							Menu subM3 = new Menu();
							subM3.setId("precontractApply");
							subM3.setOrders(3);
							subM3.setIcon("fa fa-ioxhost");
							subM3.setName("预约报名");
							subList.add(subM3);

							Menu subM4 = new Menu();
							subM4.setId("parentClass");
							subM4.setOrders(4);
							subM4.setIcon("fa fa-whatsapp");
							subM4.setName("家长课堂");
							subList.add(subM4);
							
							Menu subM5 = new Menu();
							subM5.setId("classActivity");
							subM5.setOrders(5);
							subM5.setIcon("fa fa-yelp");
							subM5.setName("班级每日活动");
							subList.add(subM5);
							
							m = subMenu;
						}
					}

					if (subList.size() > 0)
					{
						menu.getSubMenuList().remove(m);
						menu.getSubMenuList().addAll(subList);
					}
					list.add(menu);
				}
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
	 * 添加动态图
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addDynamicGraph.do")
	public String addDynamicGraph(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setContentType("text/html;charset=UTF-8");

		try
		{
			User user = (User) session.getAttribute("user");
			Integer type = StringUtil.toint(request.getParameter("type"));
			String title = request.getParameter("title");
			String url = request.getParameter("url");
			String graphId = request.getParameter("graphId");
			String path = "";
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			boolean flag = false;
			for (Iterator it = multipartRequest.getFileNames(); it.hasNext();)
			{
				String key = (String) it.next();
				MultipartFile imgFile = multipartRequest.getFile(key);
				if (imgFile.getOriginalFilename().length() > 0)
				{
					
					String fileName = imgFile.getOriginalFilename();
					String uploadFilePathTemp = request.getSession().getServletContext().getRealPath("/") + "temp";
					File dir = new File(uploadFilePathTemp);
					if (!dir.exists())
					{
						dir.mkdirs();
					}
					String fileNameStr = formatter.format(new Date()) + "__" + fileName;
					File tempFile = new File(uploadFilePathTemp + "/" + fileNameStr);
					if (!tempFile.exists())
					{
						tempFile.createNewFile();
					}
					imgFile.transferTo(tempFile);
					FileUploadUtil fuu = new FileUploadUtil();
					path = "app/dynamicgraph/" + user.getUserId() + System.currentTimeMillis() + "/" + fileName;
					fuu.simpleUpload(tempFile.getAbsolutePath(), path, Cons.QINIU_BUCKETNAME_RICH_AD);
					tempFile.delete();
					flag = true;
				}

			}
			
			
			if(flag)
			{
				dynamicGraphService.updateDynamicGraph(type);
				DynamicGraph dynamicGraph = new DynamicGraph();
				dynamicGraph.setPath(Cons.QINIU_BUCKETNAME_RICH_AD_URL + path);
				dynamicGraph.setUserId(user.getUserId());
				dynamicGraph.setRealName(user.getRealName());
				dynamicGraph.setStatus(1);
				if (type != 0)
				{
					dynamicGraph.setType(type);
				}
				dynamicGraph.setCount(0);
				if (!StringUtil.isEmpty(title))
				{
					dynamicGraph.setTitle(title);
				}
				if (!StringUtil.isEmpty(url))
				{
					dynamicGraph.setUrl(url);
				}
				dynamicGraph.setCreateTime(TimeUtil.getInstance().now());
				dynamicGraphService.addDinamicGraph(dynamicGraph);
			}else
			{
				if(!StringUtil.isEmpty(graphId))
				{
					
					DynamicGraph dynamicGraph = new DynamicGraph();
					dynamicGraph.setGraphId(StringUtil.toint(graphId));
					if (!StringUtil.isEmpty(title))
					{
						dynamicGraph.setTitle(title);
					}
					if (!StringUtil.isEmpty(url))
					{
						dynamicGraph.setUrl(url);
					}
					dynamicGraphService.updateByGraphId(dynamicGraph);
				}
				
			}
			

			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 添加图标
	 */
	@RequestMapping(value = "/addMiddleMenu.do")
	public String addMiddleMenu(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			Integer menuType = StringUtil.toint(request.getParameter("menuType"));
			Integer menuStatus = StringUtil.toint(request.getParameter("menuStatus"));
			String menuId = request.getParameter("menuId");
			String menuName = request.getParameter("menuName");
			String menuUrl = request.getParameter("menuUrl");
			String menuIcon = request.getParameter("menuIcon");
			String permissionCode = request.getParameter("permissionCode");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("menuType", menuType);
			paramMap.put("menuStatus", menuStatus);
			APPHomePage page = appHomePageService.getAPPHomePageByTypeAndStatus(paramMap);
			APPHomePage apppage = new APPHomePage();
			apppage.setMenuIcon(menuIcon);
			apppage.setMenuId(menuId);
			apppage.setMenuName(menuName);
			apppage.setMenuStatus(menuStatus);
			if (StringUtil.isEmpty(menuUrl) || menuUrl == "undefined")
			{
				apppage.setMenuUrl(menuUrl);
			}
			if (StringUtil.isEmpty(permissionCode) || permissionCode == "undefined")
			{
				apppage.setPermissionCode(permissionCode);
			}
			if (page == null)
			{
				List<APPHomePage> menuList2 = appHomePageService.getMenuList(menuStatus);

				apppage.setMenuType(menuList2.size() + 1);

				appHomePageService.addMiddleMenu(apppage);
			} else
			{
				apppage.setMenuType(menuType);
				appHomePageService.updateMiddleMenu(apppage);
			}

			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取APP首页菜单
	 */
	@RequestMapping(value = "/getAPPHomePageByApiKey.do")
	public String getAPPHomePageByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{

		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<WisdomCampusMenu>> rhr = new RichHttpResponse<List<WisdomCampusMenu>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String json;
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		try
		{
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());
				School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(schoolId));
				List<WisdomCampusMenu> wisdomCampusMenuList = new ArrayList<WisdomCampusMenu>();

				List<APPHomePage> menuList1 = appHomePageService.getMenuList(1);

				List<Permission> permissionList = loginUser.getPermissionList();
				Map<String, Object> permissionMap = new HashMap<String, Object>();

				if (CollectionUtils.isEmpty(menuList1))
				{
					WisdomCampusMenu subM1 = new WisdomCampusMenu();
					subM1.menuId = "newsInfo";
					subM1.menuType = 1;
					subM1.menuStatus = 1;
					subM1.menuName = "新闻资讯";
					wisdomCampusMenuList.add(subM1);

					WisdomCampusMenu subM2 = new WisdomCampusMenu();
					subM2.menuId = "announcement";
					subM2.menuType = 2;
					subM2.menuStatus = 1;
					if (school.getSchoolCategory().equals("0"))
					{
						subM2.menuName = "园所通知";
					} else
					{
						subM2.menuName = "校园公告";
					}
					wisdomCampusMenuList.add(subM2);

					WisdomCampusMenu subM3 = new WisdomCampusMenu();
					subM3.menuId = "platformInfo";
					subM3.menuType = 3;
					subM3.menuStatus = 1;
					subM3.menuName = "信息中心";
					wisdomCampusMenuList.add(subM3);
					
					WisdomCampusMenu subM4 = new WisdomCampusMenu();
					subM4.menuId = "clazzPhotoAlbumManager";
					subM4.menuType = 4;
					subM4.menuStatus = 1;
					subM4.menuName = "校园相册";
					wisdomCampusMenuList.add(subM4);

				} else
				{
					for (APPHomePage menu : menuList1)
					{
						WisdomCampusMenu wisdomCampusMenu = new WisdomCampusMenu();
						wisdomCampusMenu.menuId = menu.getMenuId();
						wisdomCampusMenu.menuType = menu.getMenuType();
						wisdomCampusMenu.menuStatus = menu.getMenuStatus();
						wisdomCampusMenu.menuName = menu.getMenuName();
						wisdomCampusMenu.menuUrl = menu.getMenuUrl();
						wisdomCampusMenu.menuIcon = menu.getMenuIcon();
						wisdomCampusMenuList.add(wisdomCampusMenu);
					}
				}

				List<APPHomePage> menuList2 = appHomePageService.getMenuList(2);
				if (CollectionUtils.isEmpty(menuList2))
				{
					List<Menu> menuList = menuService.getAllMenuInfo(schoolId, 0);
					if (permissionList != null)
					{
						// list->map
						for (Permission permission : permissionList)
						{
							permissionMap.put(permission.getPermissionCode(), permission);
						}

						if (permissionMap.containsKey("admin"))
						{
							int num = 0;
							// 管理员权限的情况下，所有的菜单能查看

							for (Menu menu : menuList)
							{
								if (num < 4)
								{
									if (menu.getId().equals("schoolManager") || menu.getId().equals("systemManage") 
											|| menu.getId().equals("growthArchives") || menu.getId().equals("informationPlatform") 
											|| menu.getId().equals("xyYktManager") || menu.getId().equals("evaluationManager") 
											|| menu.getId().equals("siguUpManager") || menu.getId().equals("liveCameraManager") 
											|| menu.getId().equals("morningCheckSys") || menu.getId().equals("cloudAchievement")
											|| menu.getId().equals("sysMessage") || menu.getId().equals("attendanceReport") 
											|| menu.getId().equals("attendanceFill") || menu.getId().equals("messageManage")
											|| menu.getId().equals("assetManagement"))
									{
										if(menu.getId().equals("systemManage")){
											WisdomCampusMenu wisdomCampusMenu = new WisdomCampusMenu();
											wisdomCampusMenu.menuId = menu.getId();
											wisdomCampusMenu.menuType = menu.getOrders();
//											wisdomCampusMenu.menuName = menu.getName();
											wisdomCampusMenu.menuStatus = 2;
											wisdomCampusMenu.menuName = "在线补办卡";
											wisdomCampusMenu.menuUrl = menu.getUrl();
											wisdomCampusMenu.menuIcon = menu.getIcon();
											
											wisdomCampusMenuList.add(wisdomCampusMenu);
											num++;
										}else if(menu.getId().equals("assetManagement")){
											//每个人都能看到资产管理和安全隐患报修
											WisdomCampusMenu wisdomCampusMenu = new WisdomCampusMenu();
											wisdomCampusMenu.menuId = menu.getId();
											wisdomCampusMenu.menuType = menu.getOrders();
//											wisdomCampusMenu.menuName = menu.getName();
											wisdomCampusMenu.menuStatus = 2;
											wisdomCampusMenu.menuName = "资产与隐患";
											wisdomCampusMenu.menuUrl = menu.getUrl();
											wisdomCampusMenu.menuIcon = menu.getIcon();
											
											List<WisdomCampusMenu> subCampusMenuList = new ArrayList<WisdomCampusMenu>();
											WisdomCampusMenu subM1 = new WisdomCampusMenu();
											subM1.menuId = "assetRepair";
											subM1.menuType = 1;
											subM1.menuName = "资产报修";
											subCampusMenuList.add(subM1);
											WisdomCampusMenu subM2 = new WisdomCampusMenu();
											subM2.menuId = "securityDanger";
											subM2.menuType = 2;
											subM2.menuName = "安全隐患排查";
											subCampusMenuList.add(subM2);
											WisdomCampusMenu subM3 = new WisdomCampusMenu();
											subM3.menuId = "bluetoothList";
											subM3.menuType = 3;
											subM3.menuName = "蓝牙手环";
											subCampusMenuList.add(subM3);
											wisdomCampusMenu.subMenuList = subCampusMenuList;
											wisdomCampusMenuList.add(wisdomCampusMenu);
											num++;
										}else{
											continue;	
										}
									} else
									{
										WisdomCampusMenu wisdomCampusMenu = new WisdomCampusMenu();
										wisdomCampusMenu.menuId = menu.getId();
										wisdomCampusMenu.menuType = menu.getOrders();
										wisdomCampusMenu.menuStatus = 2;
										wisdomCampusMenu.menuName = menu.getName();
										wisdomCampusMenu.menuUrl = menu.getUrl();
										wisdomCampusMenu.menuIcon = menu.getIcon();
										wisdomCampusMenuList.add(wisdomCampusMenu);
										num++;
									}
								}
							}

						} else
						{
							// 没有管理员权限情况下，查询他能看到的菜单，
							// 由于一级菜单没有权限,需要通过二级的菜单的个数来判断他是否可以查看到一级菜单
							// 二级菜单个数为0的情况下不能查看一级菜单，大于0的情况下，能够查看到一级菜单
							// 管理员权限的情况下，所有的菜单能查看
							int num = 0;

							for (Menu menu : menuList)
							{
								if (num < 4)
								{
									if (menu.getId().equals("schoolManager") || menu.getId().equals("systemManage") 
											|| menu.getId().equals("growthArchives") || menu.getId().equals("informationPlatform") 
											|| menu.getId().equals("xyYktManager") || menu.getId().equals("evaluationManager") 
											|| menu.getId().equals("siguUpManager") || menu.getId().equals("liveCameraManager") 
											|| menu.getId().equals("morningCheckSys") || menu.getId().equals("cloudAchievement")
											|| menu.getId().equals("sysMessage") || menu.getId().equals("attendanceReport") 
											|| menu.getId().equals("attendanceFill") || menu.getId().equals("messageManage")
											|| menu.getId().equals("assetManagement"))
									{
										if(menu.getId().equals("systemManage")){
											WisdomCampusMenu wisdomCampusMenu = new WisdomCampusMenu();
											wisdomCampusMenu.menuId = menu.getId();
											wisdomCampusMenu.menuType = menu.getOrders();
											wisdomCampusMenu.menuStatus = 2;
//											wisdomCampusMenu.menuName = menu.getName();
											wisdomCampusMenu.menuName = "在线补办卡";
											wisdomCampusMenu.menuUrl = menu.getUrl();
											wisdomCampusMenu.menuIcon = menu.getIcon();
											
											wisdomCampusMenuList.add(wisdomCampusMenu);
											num++;
										}else if(menu.getId().equals("assetManagement")){
											//每个人都能看到资产管理和安全隐患报修
											WisdomCampusMenu wisdomCampusMenu = new WisdomCampusMenu();
											wisdomCampusMenu.menuId = menu.getId();
											wisdomCampusMenu.menuType = menu.getOrders();
//											wisdomCampusMenu.menuName = menu.getName();
											wisdomCampusMenu.menuName = "资产与隐患";
											wisdomCampusMenu.menuUrl = menu.getUrl();
											wisdomCampusMenu.menuIcon = menu.getIcon();
											
											List<WisdomCampusMenu> subCampusMenuList = new ArrayList<WisdomCampusMenu>();
											WisdomCampusMenu subM1 = new WisdomCampusMenu();
											subM1.menuId = "assetRepair";
											subM1.menuType = 1;
											subM1.menuName = "资产报修";
											subCampusMenuList.add(subM1);
											WisdomCampusMenu subM2 = new WisdomCampusMenu();
											subM2.menuId = "securityDanger";
											subM2.menuType = 2;
											subM2.menuName = "安全隐患排查";
											subCampusMenuList.add(subM2);
											WisdomCampusMenu subM3 = new WisdomCampusMenu();
											subM3.menuId = "bluetoothList";
											subM3.menuType = 3;
											subM3.menuName = "蓝牙手环";
											subCampusMenuList.add(subM3);
											wisdomCampusMenu.subMenuList = subCampusMenuList;
											wisdomCampusMenuList.add(wisdomCampusMenu);
											num++;
										}else{
											continue;	
										}
									} else
									{
										WisdomCampusMenu wisdomCampusMenu = new WisdomCampusMenu();
										wisdomCampusMenu.menuId = menu.getId();
										wisdomCampusMenu.menuType = menu.getOrders();
										wisdomCampusMenu.menuStatus = 2;
										wisdomCampusMenu.menuName = menu.getName();
										wisdomCampusMenu.menuUrl = menu.getUrl();
										wisdomCampusMenu.menuIcon = menu.getIcon();
										wisdomCampusMenuList.add(wisdomCampusMenu);
										num++;
									}
								}
							}
						}
					}

				} else
				{

					if (permissionList != null)
					{
						// list->map
						for (Permission permission : permissionList)
						{
							permissionMap.put(permission.getPermissionCode(), permission);
						}
						if (permissionMap.containsKey("admin"))
						{
							for (APPHomePage menu : menuList2)
							{
								if (menu.getMenuId().equals("schoolManager") || menu.getMenuId().equals("systemManage") 
										|| menu.getMenuId().equals("growthArchives") || menu.getMenuId().equals("informationPlatform") 
										|| menu.getMenuId().equals("xyYktManager") || menu.getMenuId().equals("evaluationManager") 
										|| menu.getMenuId().equals("siguUpManager") || menu.getMenuId().equals("liveCameraManager") 
										|| menu.getMenuId().equals("morningCheckSys") || menu.getMenuId().equals("cloudAchievement")
										|| menu.getMenuId().equals("sysMessage") || menu.getMenuId().equals("attendanceReport") 
										|| menu.getMenuId().equals("attendanceFill")|| menu.getMenuId().equals("messageManage")
										|| menu.getMenuId().equals("assetManagement"))
								{
									if(menu.getMenuId().equals("systemManage")){
										WisdomCampusMenu wisdomCampusMenu = new WisdomCampusMenu();
										wisdomCampusMenu.menuId = menu.getMenuId();
										wisdomCampusMenu.menuType = menu.getMenuType();
										wisdomCampusMenu.menuStatus = menu.getMenuStatus();
										wisdomCampusMenu.menuName = menu.getMenuName();
										wisdomCampusMenu.menuUrl = menu.getMenuUrl();
										wisdomCampusMenu.menuIcon = menu.getMenuIcon();
										
										wisdomCampusMenuList.add(wisdomCampusMenu);
									}else if(menu.getId().equals("assetManagement")){
										//每个人都能看到资产管理和安全隐患报修
										WisdomCampusMenu wisdomCampusMenu = new WisdomCampusMenu();
										wisdomCampusMenu.menuId = menu.getMenuId();
										wisdomCampusMenu.menuType = menu.getMenuType();
//										wisdomCampusMenu.menuName = menu.getName();
										wisdomCampusMenu.menuStatus = menu.getMenuStatus();
										wisdomCampusMenu.menuName = "资产与隐患";
										wisdomCampusMenu.menuUrl = menu.getMenuUrl();
										wisdomCampusMenu.menuIcon = menu.getMenuIcon();
										
										List<WisdomCampusMenu> subCampusMenuList = new ArrayList<WisdomCampusMenu>();
										WisdomCampusMenu subM1 = new WisdomCampusMenu();
										subM1.menuId = "assetRepair";
										subM1.menuType = 1;
										subM1.menuName = "资产报修";
										subCampusMenuList.add(subM1);
										WisdomCampusMenu subM2 = new WisdomCampusMenu();
										subM2.menuId = "securityDanger";
										subM2.menuType = 2;
										subM2.menuName = "安全隐患排查";
										subCampusMenuList.add(subM2);
										WisdomCampusMenu subM3 = new WisdomCampusMenu();
										subM3.menuId = "bluetoothList";
										subM3.menuType = 3;
										subM3.menuName = "蓝牙手环";
										subCampusMenuList.add(subM3);
										wisdomCampusMenu.subMenuList = subCampusMenuList;
										wisdomCampusMenuList.add(wisdomCampusMenu);
									}else{
										continue;	
									}
								} else
								{
									WisdomCampusMenu wisdomCampusMenu = new WisdomCampusMenu();
									wisdomCampusMenu.menuId = menu.getMenuId();
									wisdomCampusMenu.menuType = menu.getMenuType();
									wisdomCampusMenu.menuStatus = menu.getMenuStatus();
									wisdomCampusMenu.menuName = menu.getMenuName();
									wisdomCampusMenu.menuUrl = menu.getMenuUrl();
									wisdomCampusMenu.menuIcon = menu.getMenuIcon();
									wisdomCampusMenuList.add(wisdomCampusMenu);
								}
							}
						} else
						{
							for (APPHomePage menu : menuList2)
							{
								String subMenuPermissionCode = menu.getPermissionCode();
								if (StringUtil.isEmpty(subMenuPermissionCode) || permissionMap.containsKey(subMenuPermissionCode))
								{
									WisdomCampusMenu wisdomCampusMenu = new WisdomCampusMenu();
									wisdomCampusMenu.menuId = menu.getMenuId();
									wisdomCampusMenu.menuType = menu.getMenuType();
									wisdomCampusMenu.menuStatus = menu.getMenuStatus();
									wisdomCampusMenu.menuName = menu.getMenuName();
									wisdomCampusMenu.menuUrl = menu.getMenuUrl();
									wisdomCampusMenu.menuIcon = menu.getMenuIcon();
									wisdomCampusMenuList.add(wisdomCampusMenu);
								}
							}
						}
					}
				}

				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = wisdomCampusMenuList;
				json = GsonHelper.toJson(rhr);
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseObject = null;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				json = GsonHelper.toJson(rhr);
			}

			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("获取失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 获取通讯录
	 */
	@RequestMapping(value = "/getAddressListByApiKey.do")
	public String getAddressListByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{

		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<AddressList>> rhr = new RichHttpResponse<List<AddressList>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String json;
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		try
		{
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());
				List<AddressList> addressList = appHomePageService.getAddressList();
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = addressList;
				json = GsonHelper.toJson(rhr);
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseObject = null;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				json = GsonHelper.toJson(rhr);
			}

			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("获取失败：" + e.getMessage());
		}
		return null;
	}

}
