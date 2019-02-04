package com.guotop.palmschool.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Place;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.PlaceService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 地点控制类
 * 
 * @author tao
 *
 */
@RequestMapping("/place")
@Controller
public class PlaceController extends BaseController
{

	@Resource
	private PlaceService placeService;

	@Resource
	private CommonService commonService;

	@Resource
	private ClazzService clazzService;

	/**
	 * 进入地点管理页面
	 */
	@RequestMapping(value = "/toPlaceList.do")
	public String toPositionList()
	{
		return "place/place_list";
	}

	/**
	 * 不同权限查看到不同的page 20151129
	 */
	@RequestMapping(value = "/getPlaceList.do")
	public String getPositionList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			/**
			 * 分页信息
			 */
			Integer currentPage = 1;

			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			User loginUser = (User) session.getAttribute("user");

			/**
			 * 参数map
			 */
			Map<String, Object> paramMap = new HashMap<String, Object>();

			Pages pages = placeService.getPlaceList(this.getPages().getPageSize(), currentPage, loginUser, paramMap);

			/**
			 * flush到页面
			 */
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
	 * 进入增加地点页面
	 */
	@RequestMapping(value = "/toAddPlace.do")
	public String toAddPosition(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		User userList = (User) session.getAttribute("user");

		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("user", userList);

		return "place/place_add";
	}

	/**
	 * 执行增加地点逻辑
	 */
	@RequestMapping(value = "/doAddPlace.do")
	public String doAddPosition(HttpServletRequest request, HttpSession session, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			//记录点名称
			String name = request.getParameter("name");
			//记录点名称
			Integer type = Integer.valueOf(request.getParameter("type"));
			String wifi = request.getParameter("wifi");

			Place place = new Place();
			place.setName(name);
			place.setType(type);
			place.setWifi(wifi);
//			if (type == 5)
//			{
//				place.setFunctionId(functionId);
//				place.setFunctionType(functionType);
//			}
			place.setCreateTime(TimeUtil.getInstance().now());
			//添加地点
			placeService.addPlace(place);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "place/place_list";
	}

	/**
	 * 进入修改地点页面
	 */
	@RequestMapping(value = "/toModifyPlace.do")
	public String toModifyPlace(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		try
		{
			Integer placeId = StringUtil.toint(request.getParameter("placeId"));
			Place place = placeService.selectPlaceListById(placeId);
			/**
			 * 存放页面隐藏域
			 */
			modelMap.addAttribute("place", place);
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return "place/place_modify";
	}

	/**
	 * 执行修改地点逻辑
	 */
	@RequestMapping(value = "/doModifyPlace.do")
	public String doModifyPlace(HttpServletRequest request, HttpSession session, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer placeId = StringUtil.toint(request.getParameter("placeId"));
			//地点名称
			String name = request.getParameter("name");
			//地点类型
			Integer type = Integer.valueOf(request.getParameter("type"));
			//1 functionId表示班级Id 2functionId表示部门Id
			Integer functionType = StringUtil.toint(request.getParameter("functionType"));
			//班级或部门id
			Integer functionId = 0;
			if (functionType == 1)
			{
				functionId = StringUtil.toint(request.getParameter("clazzId"));
			} else if (functionType == 2)
			{
				functionId = StringUtil.toint(request.getParameter("departmentId"));
			} else
			{

			}
			//wifi名称
			String wifi = request.getParameter("wifi");
			Place place = new Place();
			place.setId(placeId);
			place.setName(name);
			place.setType(type);
			place.setWifi(wifi);
			if (type == 5)
			{
				place.setFunctionId(functionId);
				place.setFunctionType(functionType);
			}
			//修改地点
			placeService.modifyPlace(place);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "place/place_list";
	}
	
	
	/**
	 * 删除地点及对应的设备
	 */
	@RequestMapping(value = "/deletePlace.do")
	public String deletePlace(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			//地点Id
			Integer placeId = StringUtil.toint(request.getParameter("placeId"));
			
			//地点类型
			Integer type = StringUtil.toint(request.getParameter("type"));

			boolean flag = false;

			try
			{
				//删除地点及对应的设备
				placeService.deletePlace(placeId,type);
				flag = true;
			} catch (Exception e)
			{
				flag = false;
				e.printStackTrace();
			}

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 进入查看设备页面
	 */
	@RequestMapping(value = "/toViewDevice.do")
	public String toViewDevice(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		User user = (User) session.getAttribute("user");

		/**
		 * 地点的id
		 */
		Integer placeId = Integer.valueOf(request.getParameter("placeId"));

		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("user", user);
		modelMap.addAttribute("schoolId", user.getSchoolId());
		modelMap.addAttribute("placeId", placeId);

		return "device/device_list";
	}

	/**
	 * 加载班级
	 */
	@RequestMapping(value = "/loadClazzList.do")
	public String loadClazzList(HttpServletRequest request, HttpSession session, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			List<Clazz> clazzList = clazzService.getClazzListByGradeId(0);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(clazzList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
}
