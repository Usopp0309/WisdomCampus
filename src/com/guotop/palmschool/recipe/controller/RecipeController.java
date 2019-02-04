package com.guotop.palmschool.recipe.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.Dish;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.recipe.entity.Recipe;
import com.guotop.palmschool.recipe.service.RecipeService;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.service.PermissionService;
import com.guotop.palmschool.service.ScheduleService;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.FileUploadUtil;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.richx.pojo.RecipePOJO;
import com.richx.pojo.RichHttpResponse;

import dev.gson.GsonHelper;

/**
 * 食谱操作类(幼儿园版)
 * 
 * @author sheng
 * 
 */
@RequestMapping("/recipe")
@Controller
public class RecipeController extends BaseController
{
	private Logger log = LoggerFactory.getLogger(RecipeController.class);
	@Resource
	private RecipeService recipeService;
	@Resource
	private UserService userService;
	@Resource
	private ScheduleService scheduleService;
	@Resource
	private CommonService commonService;
	@Resource
	private PermissionService permissionService;

	@Resource
	private SchoolService schoolService;
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

	/************* 手机端begin ***************/

	/**
	 * 进入菜谱列表页面-app页面
	 */
	@RequestMapping(value = "/toRecipeListByApiKey.do")
	public String toRecipeListByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String parmDate = request.getParameter("parmDate");
		if (StringUtil.isEmpty(parmDate))
		{
			parmDate = sf.format(new Date());
		}
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (loginUser != null)
		{
			TimeUtil timeUtil = TimeUtil.getInstance();
			// 存session
			session.setAttribute("user", loginUser);
			try
			{
				List<String> dateList = getFiveWorkDay(parmDate);
				HashMap<String, Recipe> recipeMap = new HashMap<String, Recipe>();
				HashMap<String, String> dateMap = new HashMap<String, String>();
				for (String date : dateList)
				{
					try
					{
						Recipe recipe = recipeService.loadRecipeByPushDate(date);
						String newDate = timeUtil._getWeekDay(sf.parse(date));
						dateMap.put(date, newDate);
						if (recipe != null)
						{
							recipeMap.put(date, recipe);
						}
					} catch (ParseException e)
					{
						continue;
					}
				}

				modelMap.addAttribute("dateList", dateList);
				modelMap.addAttribute("currentDate", sf.format(new Date()));
				modelMap.addAttribute("parmDate", parmDate);
				modelMap.addAttribute("currentMonday", getCurrentMonday(parmDate));
				modelMap.addAttribute("dateMap", dateMap);
				modelMap.addAttribute("map", recipeMap);
				modelMap.addAttribute("apiKey", apiKey);
				modelMap.addAttribute("schoolId", schoolId);
				return "app/recipe/recipeList_app";
			} catch (Exception e)
			{
				return null;
			}
		} else
		{
			return null;
		}
	}

	/**
	 * 进入喜爱菜谱排行页面-app页面
	 */
	@RequestMapping(value = "/toRecipeListTopByApiKey.do")
	public String toRecipeListTopByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (loginUser != null)
		{
			// 存session
			session.setAttribute("user", loginUser);
			try
			{
				return "app/recipe/recipeList_top_app";
			} catch (Exception e)
			{
				return null;
			}
		} else
		{
			return null;
		}
	}

	/**
	 * 本周的菜谱
	 */
	@RequestMapping(value = "/currentRecipeList.do")
	public String currentRecipeList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String parmDate = sf.format(new Date());
		TimeUtil timeUtil = TimeUtil.getInstance();
		try
		{
			List<String> dateList = getFiveWorkDay(parmDate);
			HashMap<String, Recipe> recipeMap = new HashMap<String, Recipe>();
			HashMap<String, String> dateMap = new HashMap<String, String>();
			for (String date : dateList)
			{
				try
				{
					Recipe recipe = recipeService.loadRecipeByPushDate(date);
					String newDate = timeUtil._getWeekDay(sf.parse(date));
					dateMap.put(date, newDate);
					if (recipe != null)
					{
						recipeMap.put(date, recipe);
					}
				} catch (ParseException e)
				{
					continue;
				}
			}

			modelMap.addAttribute("dateList", dateList);
			modelMap.addAttribute("currentDate", parmDate);
			modelMap.addAttribute("currentMonday", getCurrentMonday(parmDate));
			modelMap.addAttribute("dateMap", dateMap);
			modelMap.addAttribute("map", recipeMap);
			return "app/recipe/recipeList_app";
		} catch (Exception e)
		{
			return null;
		}
	}

	/**
	 * 上一周的菜谱
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/priviousRecipeList.do")
	public String priviousRecipeList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String parmDate = request.getParameter("parmDate");
		if (StringUtil.isEmpty(parmDate))
		{
			parmDate = sf.format(new Date());
		}
		TimeUtil timeUtil = TimeUtil.getInstance();
		try
		{
			String previousMonday = getPreviousMonday(parmDate);
			List<String> dateList = getFiveWorkDay(previousMonday);
			HashMap<String, Recipe> recipeMap = new HashMap<String, Recipe>();
			HashMap<String, String> dateMap = new HashMap<String, String>();
			for (String date : dateList)
			{
				try
				{
					Recipe recipe = recipeService.loadRecipeByPushDate(date);
					String newDate = timeUtil._getWeekDay(sf.parse(date));
					dateMap.put(date, newDate);
					if (recipe != null)
					{
						recipeMap.put(date, recipe);
					}
				} catch (ParseException e)
				{
					continue;
				}
			}

			modelMap.addAttribute("dateList", dateList);
			modelMap.addAttribute("currentDate", sf.format(new Date()));
			modelMap.addAttribute("currentMonday", previousMonday);
			modelMap.addAttribute("dateMap", dateMap);
			modelMap.addAttribute("map", recipeMap);
			return "app/recipe/recipeList_app";
		} catch (Exception e)
		{
			return null;
		}
	}

	/**
	 * 下一周的菜谱
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/nextRecipeList.do")
	public String nextRecipeList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String parmDate = request.getParameter("parmDate");
		if (StringUtil.isEmpty(parmDate))
		{
			parmDate = sf.format(new Date());
		}
		TimeUtil timeUtil = TimeUtil.getInstance();
		try
		{
			String nextMonday = getNextMonday(parmDate);
			List<String> dateList = getFiveWorkDay(nextMonday);
			HashMap<String, Recipe> recipeMap = new HashMap<String, Recipe>();
			HashMap<String, String> dateMap = new HashMap<String, String>();
			for (String date : dateList)
			{
				try
				{
					Recipe recipe = recipeService.loadRecipeByPushDate(date);
					String newDate = timeUtil._getWeekDay(sf.parse(date));
					dateMap.put(date, newDate);
					if (recipe != null)
					{
						recipeMap.put(date, recipe);
					}
				} catch (ParseException e)
				{
					continue;
				}
			}

			modelMap.addAttribute("dateList", dateList);
			modelMap.addAttribute("currentDate", sf.format(new Date()));
			modelMap.addAttribute("currentMonday", nextMonday);
			modelMap.addAttribute("dateMap", dateMap);
			modelMap.addAttribute("map", recipeMap);
			return "app/recipe/recipeList_app";
		} catch (Exception e)
		{
			return null;
		}
	}

	/**
	 * 获取本周的五个工作日的作息时间
	 * 
	 * @return
	 * @throws ParseException
	 */
	private List<String> getFiveWorkDay(String parmDate) throws ParseException
	{
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("starttime", getCurrentMonday(parmDate));
		map.put("endtime", getNextMonday(parmDate));
		// 通过作息时间表获取本周的作息时间
		// List<String> dateList = scheduleService.loadScheduleListInAPP(map);
		// if (dateList == null || dateList.size() == 0)
		// {
		// dateList = new ArrayList<String>();
		// dateList.add(getCurrentMonday(parmDate));
		// dateList.add(getCurrentTuesday(parmDate));
		// dateList.add(getCurrentWednesday(parmDate));
		// dateList.add(getCurrentThursday(parmDate));
		// dateList.add(getCurrentFriday(parmDate));
		// }
		List<String> dateList = new ArrayList<String>();
		dateList = new ArrayList<String>();
		dateList.add(getCurrentMonday(parmDate));
		dateList.add(getCurrentTuesday(parmDate));
		dateList.add(getCurrentWednesday(parmDate));
		dateList.add(getCurrentThursday(parmDate));
		dateList.add(getCurrentFriday(parmDate));
		Collections.sort(dateList);
		return dateList;
	}

	// 获得下周星期一的日期
	@SuppressWarnings("static-access")
	public String getNextMonday(String parmDate) throws ParseException
	{
		String currentMonday = getCurrentMonday(parmDate);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(sf.parse(currentMonday));
		calendar.add(calendar.DATE, 7);

		Date monday = calendar.getTime();
		String nextMonday = sf.format(monday);
		return nextMonday;
	}

	// 获得上周星期一的日期
	@SuppressWarnings("static-access")
	public String getPreviousMonday(String parmDate) throws ParseException
	{
		String currentMonday = getCurrentMonday(parmDate);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(sf.parse(currentMonday));
		calendar.add(calendar.DATE, -7);

		Date monday = calendar.getTime();
		String previousMonday = sf.format(monday);
		return previousMonday;
	}

	/**
	 * 获得传递过来参数周- 周一的日期
	 * 
	 * @return
	 * @throws ParseException
	 */
	private String getCurrentMonday(String parmDate) throws ParseException
	{
		Date date = sf.parse(parmDate);
		int mondayPlus = getMondayPlus(date);
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.setTime(date);
		currentDate.add(GregorianCalendar.DATE, mondayPlus);
		Date monday = currentDate.getTime();
		String currentMonday = sf.format(monday);
		return currentMonday;
	}

	/**
	 * 获得当前周- 周二的日期
	 * 
	 * @return
	 * @throws ParseException
	 */
	private String getCurrentTuesday(String parmDate) throws ParseException
	{
		Date date = sf.parse(parmDate);
		int mondayPlus = getMondayPlus(date);
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.setTime(date);
		currentDate.add(GregorianCalendar.DATE, mondayPlus + 1);
		Date tuesday = currentDate.getTime();
		String currentTuesday = sf.format(tuesday);
		return currentTuesday;
	}

	/**
	 * 获得当前周- 周三的日期
	 * 
	 * @return
	 * @throws ParseException
	 */
	private String getCurrentWednesday(String parmDate) throws ParseException
	{
		Date date = sf.parse(parmDate);
		int mondayPlus = getMondayPlus(date);
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.setTime(date);
		currentDate.add(GregorianCalendar.DATE, mondayPlus + 2);
		Date wednesday = currentDate.getTime();
		String currentWednesday = sf.format(wednesday);
		return currentWednesday;
	}

	/**
	 * 获得当前周- 周四的日期
	 * 
	 * @return
	 * @throws ParseException
	 */
	private String getCurrentThursday(String parmDate) throws ParseException
	{
		Date date = sf.parse(parmDate);
		int mondayPlus = getMondayPlus(date);
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.setTime(date);
		currentDate.add(GregorianCalendar.DATE, mondayPlus + 3);
		Date thursday = currentDate.getTime();
		String currentThursday = sf.format(thursday);
		return currentThursday;
	}

	/**
	 * 获得当前周- 周五 的日期
	 * 
	 * @return
	 * @throws ParseException
	 */
	private String getCurrentFriday(String parmDate) throws ParseException
	{
		Date date = sf.parse(parmDate);
		int mondayPlus = getMondayPlus(date);
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.setTime(date);
		currentDate.add(GregorianCalendar.DATE, mondayPlus + 4);
		Date friday = currentDate.getTime();
		String currentFriday = sf.format(friday);
		return currentFriday;
	}

	/**
	 * 获得当前周- 周六 的日期
	 * 
	 * @return
	 * @throws ParseException
	 */
	private String getCurrentSaturday(String parmDate) throws ParseException
	{
		Date date = sf.parse(parmDate);
		int mondayPlus = getMondayPlus(date);
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.setTime(date);
		currentDate.add(GregorianCalendar.DATE, mondayPlus + 5);
		Date saturday = currentDate.getTime();
		String currentSaturday = sf.format(saturday);
		return currentSaturday;
	}

	/**
	 * 获得当前周- 周日 的日期(在中国的传统观点认为周日是本周最后一天)
	 * 
	 * @return
	 * @throws ParseException
	 */
	private String getCurrentSunday(String parmDate) throws ParseException
	{
		Date date = sf.parse(parmDate);
		int mondayPlus = getMondayPlus(date);
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.setTime(date);
		currentDate.add(GregorianCalendar.DATE, mondayPlus + 6);
		Date sunday = currentDate.getTime();
		String currentSunday = sf.format(sunday);
		return currentSunday;
	}

	/**
	 * 获得当前日期与本周一相差的天数
	 * 
	 * @return
	 * @throws ParseException
	 */
	private int getMondayPlus(Date date)
	{
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		// 获得今天是一周的第几天，星期日是第一天，星期二是第二天......
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
		if (dayOfWeek == 1)
		{
			return -6;
		} else
		{
			return 2 - dayOfWeek;
		}
	}

	/**
	 * 菜品点赞
	 */
	@RequestMapping(value = "/addPraise.do")
	public String addPraise(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 查询类型
			String id = request.getParameter("id");
			Dish dish = new Dish();
			if (!StringUtil.isEmpty(id))
			{
				dish = recipeService.loadDishById(Integer.valueOf(id));
				Integer praiseCount = dish.getPraiseCount();
				praiseCount = praiseCount + 1;
				dish.setPraiseCount(praiseCount);
				recipeService.modifyDishByDishId(dish);
			}
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(dish);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{

		}

		return null;
	}

	/**
	 * 菜品点赞取消
	 */
	@RequestMapping(value = "/delPraise.do")
	public String delPraise(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 查询类型
			String id = request.getParameter("id");
			Dish dish = new Dish();
			if (!StringUtil.isEmpty(id))
			{
				dish = recipeService.loadDishById(Integer.valueOf(id));
				Integer praiseCount = dish.getPraiseCount();
				if (Integer.valueOf(praiseCount).intValue() >= 1)
				{
					praiseCount = praiseCount - 1;
				}
				dish.setPraiseCount(praiseCount);
				recipeService.modifyDishByDishId(dish);
			}
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(dish);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{

		}

		return null;
	}

	/**
	 * 【手机端】根据日期day加载一周食谱
	 */
	@RequestMapping(value = "/loadWeekRecipeByApiKey.do")
	public String loadWeekRecipeByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{

		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<RecipePOJO> rhr = new RichHttpResponse<RecipePOJO>();
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

				// 拥有editRecipe可以进行编辑食谱操作
				boolean flag = permissionService.hasPermissionByPermissionCode(loginUser, "editRecipe");

				RecipePOJO recipePOJO = new RecipePOJO();

				recipePOJO.editPermission = flag;

				String day = request.getParameter("day");

				if (StringUtil.isEmpty(day))
				{
					day = TimeUtil.getInstance().date();
				}

				// 判断当前的

				// 所有日期的集合
				List<String> dayList = new ArrayList<String>();
				Map<String, String> dayMap = getWeekdays(day);
				for (String key : dayMap.keySet())
				{
					dayList.add(key);
				}
				
				String monday = "";
				String tuesday = "";
				String wednesday = "";
				String thursday = "";
				String friday = "";
				String saturday = "";
				String sunday = "";
				
				try
				{
					monday = getCurrentMonday(day);
					tuesday = getCurrentTuesday(day);
					wednesday = getCurrentWednesday(day);
					thursday = getCurrentThursday(day);
					friday = getCurrentFriday(day);
					saturday = getCurrentSaturday(day);
					sunday = getCurrentSunday(day);
				} catch (ParseException e)
				{
					log.info("获取时间失败：" + e.getMessage());
				}

				
				Map<String, com.richx.pojo.Recipe> recipeMap = new HashMap<String, com.richx.pojo.Recipe>();
				// 创建一个空的recipe对象
				com.richx.pojo.Recipe recipe_monday_null = new com.richx.pojo.Recipe();
				recipe_monday_null.recipeId=-1;// -1的情况下代表不存在的食谱
				recipe_monday_null.pushDate=monday;
				recipeMap.put("星期一", recipe_monday_null);

				com.richx.pojo.Recipe recipe_tuesday_null = new com.richx.pojo.Recipe();
				recipe_tuesday_null.recipeId=-1;// -1的情况下代表不存在的食谱
				recipe_tuesday_null.pushDate=tuesday;
				recipeMap.put("星期二", recipe_tuesday_null);

				com.richx.pojo.Recipe recipe_wednesday_null = new com.richx.pojo.Recipe();
				recipe_wednesday_null.recipeId=-1;// -1的情况下代表不存在的食谱
				recipe_wednesday_null.pushDate=wednesday;
				recipeMap.put("星期三", recipe_wednesday_null);

				com.richx.pojo.Recipe recipe_thursday_null = new com.richx.pojo.Recipe();
				recipe_thursday_null.recipeId=-1;// -1的情况下代表不存在的食谱
				recipe_thursday_null.pushDate=thursday;
				recipeMap.put("星期四", recipe_thursday_null);

				com.richx.pojo.Recipe recipe_friday_null = new com.richx.pojo.Recipe();
				recipe_friday_null.recipeId=-1;// -1的情况下代表不存在的食谱
				recipe_friday_null.pushDate=friday;
				recipeMap.put("星期五", recipe_friday_null);

				com.richx.pojo.Recipe recipe_saturday_null = new com.richx.pojo.Recipe();
				recipe_saturday_null.recipeId=-1;// -1的情况下代表不存在的食谱
				recipe_saturday_null.pushDate=saturday;
				recipeMap.put("星期六", recipe_saturday_null);

				com.richx.pojo.Recipe recipe_sunday_null = new com.richx.pojo.Recipe();
				recipe_sunday_null.recipeId=-1;// -1的情况下代表不存在的食谱
				recipe_sunday_null.pushDate=sunday;
				recipeMap.put("星期日", recipe_sunday_null);
				

				// 根据日期查出所所有的食谱
				List<com.richx.pojo.Recipe> recipeList = recipeService.getWeekRecipeRichx(dayList);

				if (recipeList.size() > 0)
				{
					for (com.richx.pojo.Recipe recipe : recipeList)
					{
						List<com.richx.pojo.Dish> dishList = recipeService.loadDishListByRecipeIdRichx(recipe.recipeId);
						List<com.richx.pojo.Dish> breakfastList = new ArrayList<com.richx.pojo.Dish>();
						List<com.richx.pojo.Dish> lunchList = new ArrayList<com.richx.pojo.Dish>();
						List<com.richx.pojo.Dish> snackList = new ArrayList<com.richx.pojo.Dish>();
						List<com.richx.pojo.Dish> otherList = new ArrayList<com.richx.pojo.Dish>();
						for (com.richx.pojo.Dish dish : dishList)
						{
							if (dish.dishType.equals("1"))
							{
								breakfastList.add(dish);
							} else if (dish.dishType.equals("2"))
							{
								lunchList.add(dish);
							} else if (dish.dishType.equals("3"))
							{
								snackList.add(dish);
							} else if (dish.dishType.equals("4"))
							{
								otherList.add(dish);
							}
						}
						recipe.breakfastList = breakfastList;
						recipe.lunchList = lunchList;
						recipe.snackList = snackList;
						recipe.otherList = otherList;
						recipe.pushDate = recipe.pushDate;
						recipe.week = dayMap.get(recipe.pushDate);
						
						// 当周的食谱list转成map集合
						String week = dayMap.get(recipe.pushDate);
						recipeMap.put(week, recipe);
					}
				}

				List<com.richx.pojo.Recipe> list = new ArrayList<com.richx.pojo.Recipe>(recipeMap.values());
				// 按照日期排序
				Collections.sort(list, new Comparator<com.richx.pojo.Recipe>()
				{
					public int compare(com.richx.pojo.Recipe re1, com.richx.pojo.Recipe re2)
					{
						if (re1.pushDate == null || re2.pushDate == null)
						{
							return 0;
						} else
						{
							return re1.pushDate.compareTo(re2.pushDate);
						}
					}
				});
				
				recipePOJO.recipeList = list;
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = recipePOJO;
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
	 * 【手机端】获取上传token
	 */
	@RequestMapping(value = "/getUpTokenRecipe.do")
	public String getUpToken(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<String> rhr = new RichHttpResponse<String>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		try
		{
			String json;
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());

				FileUploadUtil fileUploadUtil = new FileUploadUtil();
				String token = fileUploadUtil.getSimpleUpToken(Cons.QINIU_BUCKETNAME_SCHOOLRECIPE);
				rhr.ResponseCode = 0;
				rhr.ResponseObject = token;
				rhr.ResponseResult = "获取成功";
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
			log.error("获取七牛token失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 【手机端】根据日期添加修改对应的食谱
	 */
	@RequestMapping(value = "/addFoodPicByApiKey.do")
	public String addFoodPicByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{

		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Object> rhr = new RichHttpResponse<Object>();
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

				// 菜谱id(为0时表示添加 不为0时表示修改)
				Integer dishId = StringUtil.toint(request.getParameter("dishId"));
				// 图片名字
				String picName = request.getParameter("picName");
				// 图片路径
				String picPath = request.getParameter("picPath");
				// 菜名
				String dishName = request.getParameter("dishName");
				// 1:早餐,2:午餐,3:加餐,4:其他
				String dishType = request.getParameter("dishType");
				// 日期
				String pushDate = request.getParameter("pushDate");

				Recipe recipe = recipeService.loadRecipeByPushDateInPC(pushDate);

				if (recipe != null)
				{
					if (dishId == 0)
					{
						if (!StringUtil.isEmpty(dishName) || !StringUtil.isEmpty(picPath))
						{
							Dish dish = new Dish();
							dish.setRecipeId(recipe.getId());
							dish.setDishType(dishType);
							dish.setCreateTime(TimeUtil.getInstance().now());
							dish.setDishName(dishName);
							dish.setPicName(picName);
							dish.setPicPath(picPath);
							dish.setPraiseCount(0);
							recipeService.addDish(dish);
						}
					} else
					{
						Dish dish = recipeService.loadDishById(dishId);
						if (!StringUtil.isEmpty(picName))
						{
							dish.setPicName(picName);
						}
						if (!StringUtil.isEmpty(picPath))
						{
							dish.setPicPath(picPath);
						}
						if (!StringUtil.isEmpty(dishName))
						{
							dish.setDishName(dishName);
						}
						recipeService.modifyDishByDishId(dish);
					}
				} else
				{
					if (!StringUtil.isEmpty(dishName) || !StringUtil.isEmpty(picPath))
					{
						recipe = new Recipe();
						recipe.setPushDate(pushDate);
						recipe.setCreateTime(TimeUtil.getInstance().now());
						Integer recipeId = recipeService.addRecipe(recipe);
						recipe.setId(recipeId);

						Dish dish = new Dish();
						dish.setRecipeId(recipeId);
						dish.setDishType(dishType);
						dish.setCreateTime(TimeUtil.getInstance().now());
						dish.setDishName(dishName);
						dish.setPicName(picName);
						dish.setPicPath(picPath);
						dish.setPraiseCount(0);
						recipeService.addDish(dish);
					}
				}

				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = true;
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
	 * 【手机端】根据dishId 删除食谱
	 */
	@RequestMapping(value = "/deleteDishByDishIdByApiKey.do")
	public String deleteDishByDishIdByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{

		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Object> rhr = new RichHttpResponse<Object>();
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
				// 菜谱id
				Integer dishId = StringUtil.toint(request.getParameter("dishId"));
				Dish dish = recipeService.loadDishById(StringUtil.toint(dishId));
				if (dish != null)
				{
					List<Dish> dishList = recipeService.loadDishListByRecipeId(dish.getRecipeId());
					if (dishList != null && dishList.size() > 1)
					{
						recipeService.delDishByDishId(StringUtil.toint(dishId));
					} else
					{
						recipeService.delRecipeByRecipeId(dish.getRecipeId());
					}
					// 用于删除七牛对应的图片
					FileUploadUtil fuu = new FileUploadUtil();
					String picPath = dish.getPicPath();
					if (!StringUtil.isEmpty(picPath))
					{
						fuu.simpleDelete(Cons.QINIU_BUCKETNAME_SCHOOLRECIPE, picPath.substring(Cons.QINIU_BUCKETNAME_SCHOOLRECIPE_URL.length()));
					}
				}
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = true;
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
	 * 【手机端】复制食谱
	 */
	@RequestMapping(value = "/copyRecipeByApiKey.do")
	public String copyRecipeByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{

		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Object> rhr = new RichHttpResponse<Object>();
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
				// 当前页面上菜谱的开始日期
				String currentPageStartDay = request.getParameter("currentPageStartDay");
				// 当前页面上菜谱的结束日期
				String currentPageEndDay = request.getParameter("currentPageEndDay");
				// 选择复制的开始时间
				String startDay = request.getParameter("startDay");
				// 复制的开始时间和复制的结束时间之间的周数
				int weekDifference = StringUtil.toint(request.getParameter("weekDifference"));

				SimpleDateFormat dateFm = new SimpleDateFormat("EEEE");
				Map<String, Recipe> map = new HashMap<String, Recipe>();
				map.put("星期一", null);
				map.put("星期二", null);
				map.put("星期三", null);
				map.put("星期四", null);
				map.put("星期五", null);
				map.put("星期六", null);
				map.put("星期日", null);
				// 获取页面上当前周菜谱列表
				List<Recipe> recipeList = recipeService.loadRecipeBewteenPushDate(currentPageStartDay, currentPageEndDay);
				if (recipeList != null && recipeList.size() > 0)
				{
					for (Recipe recipe : recipeList)
					{
						Date date = sf.parse(recipe.getPushDate());
						String week = dateFm.format(date);
						map.put(week, recipe);
					}
					
					String currentTime = TimeUtil.getInstance().now();
					GregorianCalendar currentDate = new GregorianCalendar();
					Map<String, Object> parmMap = new HashMap<String, Object>();
					for (int i = 0; i < weekDifference; i++)
					{
						// 获取复制开始时间当前周的星期一的日期 ,复制的食谱从这个星期一开始
						String monday = getCurrentMonday(startDay);
						String tuesday = getCurrentTuesday(startDay);
						String wednesday = getCurrentWednesday(startDay);
						String thursday = getCurrentThursday(startDay);
						String friday = getCurrentFriday(startDay);
						String saturday = getCurrentSaturday(startDay);
						String sunday = getCurrentSunday(startDay);

						// 获取被复制对象的一周食谱
						Recipe modayRecipe = map.get("星期一");
						Recipe tuesdayRecipe = map.get("星期二");
						Recipe wednesdayRecipe = map.get("星期三");
						Recipe thursdayRecipe = map.get("星期四");
						Recipe fridayRecipe = map.get("星期五");
						Recipe saturdayRecipe = map.get("星期六");
						Recipe sundayRecipe = map.get("星期日");

						// 保存到数据库
						if (modayRecipe != null)
						{
							modayRecipe.setCreateTime(currentTime);
							modayRecipe.setPushDate(monday);
							// 保存食谱之前先要判断当期日期是否已经存在
							parmMap.put("pushDate", monday);
							ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
							if (resultInfo.getResultCode().equals("success"))
							{
								// success 代表当前日期没有食谱
								Integer recipeId = recipeService.addRecipe(modayRecipe);
								// 保存食谱对应的菜品
								List<Dish> dishList = modayRecipe.getDishList();
								if (dishList != null && dishList.size() > 0)
								{
									for (Dish dish : dishList)
									{
										dish.setRecipeId(recipeId);
										dish.setCreateTime(currentTime);
										recipeService.addDish(dish);
									}
								}
							}

						}
						if (tuesdayRecipe != null)
						{
							tuesdayRecipe.setCreateTime(currentTime);
							tuesdayRecipe.setPushDate(tuesday);
							parmMap.put("pushDate", tuesday);
							ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
							if (resultInfo.getResultCode().equals("success"))
							{
								// success 代表当前日期没有食谱
								Integer recipeId = recipeService.addRecipe(tuesdayRecipe);
								// 保存食谱对应的菜品
								List<Dish> dishList = tuesdayRecipe.getDishList();
								if (dishList != null && dishList.size() > 0)
								{
									for (Dish dish : dishList)
									{
										dish.setRecipeId(recipeId);
										dish.setCreateTime(currentTime);
										recipeService.addDish(dish);
									}
								}
							}
						}
						if (wednesdayRecipe != null)
						{
							wednesdayRecipe.setCreateTime(currentTime);
							wednesdayRecipe.setPushDate(wednesday);
							parmMap.put("pushDate", wednesday);
							ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
							if (resultInfo.getResultCode().equals("success"))
							{
								// 保存食谱
								Integer recipeId = recipeService.addRecipe(wednesdayRecipe);
								// 保存食谱对应的菜品
								List<Dish> dishList = wednesdayRecipe.getDishList();
								if (dishList != null && dishList.size() > 0)
								{
									for (Dish dish : dishList)
									{
										dish.setRecipeId(recipeId);
										dish.setCreateTime(currentTime);
										recipeService.addDish(dish);
									}
								}
							}
						}
						if (thursdayRecipe != null)
						{
							thursdayRecipe.setCreateTime(currentTime);
							thursdayRecipe.setPushDate(thursday);
							parmMap.put("pushDate", thursday);
							ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
							if (resultInfo.getResultCode().equals("success"))
							{
								// 保存食谱
								Integer recipeId = recipeService.addRecipe(thursdayRecipe);
								// 保存食谱对应的菜品
								List<Dish> dishList = thursdayRecipe.getDishList();
								if (dishList != null && dishList.size() > 0)
								{
									for (Dish dish : dishList)
									{
										dish.setRecipeId(recipeId);
										dish.setCreateTime(currentTime);
										recipeService.addDish(dish);
									}
								}
							}
						}
						if (fridayRecipe != null)
						{
							fridayRecipe.setCreateTime(currentTime);
							fridayRecipe.setPushDate(friday);
							parmMap.put("pushDate", friday);
							ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
							if (resultInfo.getResultCode().equals("success"))
							{
								// 保存食谱
								Integer recipeId = recipeService.addRecipe(fridayRecipe);
								// 保存食谱对应的菜品
								List<Dish> dishList = fridayRecipe.getDishList();
								if (dishList != null && dishList.size() > 0)
								{
									for (Dish dish : dishList)
									{
										dish.setRecipeId(recipeId);
										dish.setCreateTime(currentTime);
										recipeService.addDish(dish);
									}
								}
							}
						}
						if (saturdayRecipe != null)
						{
							saturdayRecipe.setCreateTime(currentTime);
							saturdayRecipe.setPushDate(saturday);
							parmMap.put("pushDate", saturday);
							ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
							if (resultInfo.getResultCode().equals("success"))
							{
								// 保存食谱
								Integer recipeId = recipeService.addRecipe(saturdayRecipe);
								// 保存食谱对应的菜品
								List<Dish> dishList = saturdayRecipe.getDishList();
								if (dishList != null && dishList.size() > 0)
								{
									for (Dish dish : dishList)
									{
										dish.setRecipeId(recipeId);
										dish.setCreateTime(currentTime);
										recipeService.addDish(dish);
									}
								}
							}
						}
						if (sundayRecipe != null)
						{
							sundayRecipe.setCreateTime(currentTime);
							sundayRecipe.setPushDate(sunday);
							parmMap.put("pushDate", sunday);
							ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
							if (resultInfo.getResultCode().equals("success"))
							{
								// 保存食谱
								Integer recipeId = recipeService.addRecipe(sundayRecipe);
								// 保存食谱对应的菜品
								List<Dish> dishList = sundayRecipe.getDishList();
								if (dishList != null && dishList.size() > 0)
								{
									for (Dish dish : dishList)
									{
										dish.setRecipeId(recipeId);
										dish.setCreateTime(currentTime);
										recipeService.addDish(dish);
									}
								}
							}
						}
						// startDay加7天
						currentDate.setTime(sf.parse(startDay));
						currentDate.add(GregorianCalendar.DATE, 7);
						Date nextStartDay = currentDate.getTime();
						startDay = sf.format(nextStartDay);
					}
				}
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = true;
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
	 * 【手机端】根据日期删除该日期所在周的所有食谱
	 */
	@RequestMapping(value = "/deleteWeekRecipeByApiKey.do")
	public String deleteWeekRecipeByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{

		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Object> rhr = new RichHttpResponse<Object>();
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
				
				String day = request.getParameter("day");
				if (StringUtil.isEmpty(day))
				{
					day = TimeUtil.getInstance().date();
				}
				// 根据pushDate 查出本周日期
				List<String> dayList = new ArrayList<String>();
				Map<String, String> dayMap = getWeekdays(day);
				for (String key : dayMap.keySet())
				{
					dayList.add(key);
				}
				// 根据日期查出所所有的食谱
				List<Recipe> recipeList = recipeService.getWeekRecipe(dayList);
				if (recipeList != null && recipeList.size() > 0)
				{
					FileUploadUtil fuu = new FileUploadUtil();
					for (Recipe recipe : recipeList)
					{
						recipeService.delRecipeByRecipeId(recipe.getId());
						List<Dish> dishList = recipeService.loadDishListByRecipeId(recipe.getId());
						// 删除七牛上对应的图片
						for (Dish dish : dishList)
						{
							String picPath = dish.getPicPath();
							if (!StringUtil.isEmpty(picPath))
							{
								fuu.simpleDelete(Cons.QINIU_BUCKETNAME_SCHOOLRECIPE, picPath.substring(Cons.QINIU_BUCKETNAME_SCHOOLRECIPE_URL.length()));
							}
						}
					}
				}
				
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "获取成功";
				rhr.ResponseObject = true;
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
	
	/************* 手机端end ***************/

	/************* PC端begin ***************/

	/**
	 * 进入食谱展示页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toRecipeDisplay.do")
	public String toRecipeDisplay(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		User loginUser = (User) session.getAttribute("user");
		// 拥有editRecipe可以进行编辑食谱操作
		boolean flag = permissionService.hasPermissionByPermissionCode(loginUser, "editRecipe");
		//启明星幼儿园和空港幼儿园的早餐名字要改掉
		if("5201120068".equals(loginUser.getSchoolId()) || "3201150078".equals(loginUser.getSchoolId())){
			modelMap.addAttribute("zaocan", "早餐");
			modelMap.addAttribute("zaodian", "早点");
			modelMap.addAttribute("wucan", "午餐");
			modelMap.addAttribute("wancan", "晚餐");
		}else{
			modelMap.addAttribute("zaocan", "早餐");
			modelMap.addAttribute("zaodian", "午餐");
			modelMap.addAttribute("wucan", "下午茶");
			modelMap.addAttribute("wancan", "其他");
		}
		if (flag)
		{
			return "recipe/recipe_display_edit";
		}
		return "recipe/recipe_display";
	}

	/**
	 * 根据日期加载食谱 如果不选择日期 则表示当前日期所在周的食谱
	 */
	@RequestMapping(value = "/loadWeekRecipe.do")
	public String loadWeekRecipe(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			String day = request.getParameter("day");
			if (StringUtil.isEmpty(day))
			{
				day = TimeUtil.getInstance().date();
			}
			// 判断当前的

			// day = recipeService.getDataDay(day);
			// 所有日期的集合
			List<String> dayList = new ArrayList<String>();
			Map<String, String> dayMap = getWeekdays(day);
			for (String key : dayMap.keySet())
			{
				dayList.add(key);
			}
			String monday = "";
			String tuesday = "";
			String wednesday = "";
			String thursday = "";
			String friday = "";
			String saturday = "";
			String sunday = "";
			try
			{
				monday = getCurrentMonday(day);
				tuesday = getCurrentTuesday(day);
				wednesday = getCurrentWednesday(day);
				thursday = getCurrentThursday(day);
				friday = getCurrentFriday(day);
				saturday = getCurrentSaturday(day);
				sunday = getCurrentSunday(day);
			} catch (ParseException e)
			{
				log.info("获取时间失败：" + e.getMessage());
			}

			Map<String, Recipe> recipeMap = new HashMap<String, Recipe>();
			// 创建一个空的recipe对象
			Recipe recipe_monday_null = new Recipe();
			recipe_monday_null.setId(-1);// -1的情况下代表不存在的食谱
			recipe_monday_null.setPushDate(monday);
			recipeMap.put("星期一", recipe_monday_null);

			Recipe recipe_tuesday_null = new Recipe();
			recipe_tuesday_null.setId(-1);// -1的情况下代表不存在的食谱
			recipe_tuesday_null.setPushDate(tuesday);
			recipeMap.put("星期二", recipe_tuesday_null);

			Recipe recipe_wednesday_null = new Recipe();
			recipe_wednesday_null.setId(-1);// -1的情况下代表不存在的食谱
			recipe_wednesday_null.setPushDate(wednesday);
			recipeMap.put("星期三", recipe_wednesday_null);

			Recipe recipe_thursday_null = new Recipe();
			recipe_thursday_null.setId(-1);// -1的情况下代表不存在的食谱
			recipe_thursday_null.setPushDate(thursday);
			recipeMap.put("星期四", recipe_thursday_null);

			Recipe recipe_friday_null = new Recipe();
			recipe_friday_null.setId(-1);// -1的情况下代表不存在的食谱
			recipe_friday_null.setPushDate(friday);
			recipeMap.put("星期五", recipe_friday_null);

			Recipe recipe_saturday_null = new Recipe();
			recipe_saturday_null.setId(-1);// -1的情况下代表不存在的食谱
			recipe_saturday_null.setPushDate(saturday);
			recipeMap.put("星期六", recipe_saturday_null);

			Recipe recipe_sunday_null = new Recipe();
			recipe_sunday_null.setId(-1);// -1的情况下代表不存在的食谱
			recipe_sunday_null.setPushDate(sunday);
			recipeMap.put("星期日", recipe_sunday_null);

			// 根据日期查出所所有的食谱
			List<Recipe> recipeList = recipeService.getWeekRecipe(dayList);
			if (recipeList.size() > 0)
			{
				for (Recipe recipe : recipeList)
				{
					List<Dish> dishList = recipeService.loadDishListByRecipeId(recipe.getId());
					List<Dish> breakfastList = new ArrayList<Dish>();
					List<Dish> lunchList = new ArrayList<Dish>();
					List<Dish> snackList = new ArrayList<Dish>();
					List<Dish> otherList = new ArrayList<Dish>();
					for (Dish dish : dishList)
					{
						if (dish.getDishType().equals("1"))
						{
							breakfastList.add(dish);
						} else if (dish.getDishType().equals("2"))
						{
							lunchList.add(dish);
						} else if (dish.getDishType().equals("3"))
						{
							snackList.add(dish);
						} else if (dish.getDishType().equals("4"))
						{
							otherList.add(dish);
						}
					}
					recipe.setDishList(dishList);
					recipe.setBreakfastList(breakfastList);
					recipe.setLunchList(lunchList);
					recipe.setSnackList(snackList);
					recipe.setOtherList(otherList);
					recipe.setPushDate(recipe.getPushDate());
					recipe.setWeek(dayMap.get(recipe.getPushDate()));

					// 当周的食谱list转成map集合
					String week = dayMap.get(recipe.getPushDate());
					recipeMap.put(week, recipe);
				}
			}
			// 通过科目总分实现比较排序
			Collections.sort(dayList, new Comparator<String>()
			{
				public int compare(String str1, String str2)
				{
					if (str2 == null || str1 == null)
					{
						return 0;
					} else
					{
						return str1.compareTo(str2);
					}
				}
			});

			String currDay = dayList.get(0).substring(5, 7) + "月" + dayList.get(0).substring(8) + "日—" + dayList.get(6).substring(5, 7) + "月" + dayList.get(6).substring(8) + "日";
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("path", Cons.IMGBASEPATH);
			map.put("recipeMap", recipeMap);
			map.put("currDay", currDay);
			map.put("currentPageStartDay", dayList.get(0));// 页面上的星期一
			map.put("currentPageEndDay", dayList.get(6));// 页面上的星期日
			map.put("currentDate", TimeUtil.getInstance().date());// 当前服务器的时间
			Gson gson = new Gson();
			String json = gson.toJson(map);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 复制食谱
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/copyRecipe.do")
	public String copyRecipe(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		String json = "";
		try
		{
			// 当前页面上菜谱的开始日期
			String currentPageStartDay = request.getParameter("currentPageStartDay");
			// 当前页面上菜谱的结束日期
			String currentPageEndDay = request.getParameter("currentPageEndDay");
			// 选择复制的开始时间
			String startDay = request.getParameter("startDay");
			// 复制的开始时间和复制的结束时间之间的周数
			int weekDifference = StringUtil.toint(request.getParameter("weekDifference"));

			SimpleDateFormat dateFm = new SimpleDateFormat("EEEE");
			Map<String, Recipe> map = new HashMap<String, Recipe>();
			map.put("星期一", null);
			map.put("星期二", null);
			map.put("星期三", null);
			map.put("星期四", null);
			map.put("星期五", null);
			map.put("星期六", null);
			map.put("星期日", null);
			// 获取页面上当前周菜谱列表
			List<Recipe> recipeList = recipeService.loadRecipeBewteenPushDate(currentPageStartDay, currentPageEndDay);
			if (recipeList != null && recipeList.size() > 0)
			{
				for (Recipe recipe : recipeList)
				{
					Date date = sf.parse(recipe.getPushDate());
					String week = dateFm.format(date);
					map.put(week, recipe);
				}

				String currentTime = TimeUtil.getInstance().now();
				GregorianCalendar currentDate = new GregorianCalendar();
				Map<String, Object> parmMap = new HashMap<String, Object>();
				for (int i = 0; i < weekDifference; i++)
				{
					// 获取复制开始时间当前周的星期一的日期 ,复制的食谱从这个星期一开始
					String monday = getCurrentMonday(startDay);
					String tuesday = getCurrentTuesday(startDay);
					String wednesday = getCurrentWednesday(startDay);
					String thursday = getCurrentThursday(startDay);
					String friday = getCurrentFriday(startDay);
					String saturday = getCurrentSaturday(startDay);
					String sunday = getCurrentSunday(startDay);

					// 获取被复制对象的一周食谱
					Recipe modayRecipe = map.get("星期一");
					Recipe tuesdayRecipe = map.get("星期二");
					Recipe wednesdayRecipe = map.get("星期三");
					Recipe thursdayRecipe = map.get("星期四");
					Recipe fridayRecipe = map.get("星期五");
					Recipe saturdayRecipe = map.get("星期六");
					Recipe sundayRecipe = map.get("星期日");

					// 保存到数据库
					if (modayRecipe != null)
					{
						modayRecipe.setCreateTime(currentTime);
						modayRecipe.setPushDate(monday);
						// 保存食谱之前先要判断当期日期是否已经存在
						parmMap.put("pushDate", monday);
						ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
						if (resultInfo.getResultCode().equals("success"))
						{
							// success 代表当前日期没有食谱
							Integer recipeId = recipeService.addRecipe(modayRecipe);
							// 保存食谱对应的菜品
							List<Dish> dishList = modayRecipe.getDishList();
							if (dishList != null && dishList.size() > 0)
							{
								for (Dish dish : dishList)
								{
									dish.setRecipeId(recipeId);
									dish.setCreateTime(currentTime);
									recipeService.addDish(dish);
								}
							}
						}

					}
					if (tuesdayRecipe != null)
					{
						tuesdayRecipe.setCreateTime(currentTime);
						tuesdayRecipe.setPushDate(tuesday);
						parmMap.put("pushDate", tuesday);
						ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
						if (resultInfo.getResultCode().equals("success"))
						{
							// success 代表当前日期没有食谱
							Integer recipeId = recipeService.addRecipe(tuesdayRecipe);
							// 保存食谱对应的菜品
							List<Dish> dishList = tuesdayRecipe.getDishList();
							if (dishList != null && dishList.size() > 0)
							{
								for (Dish dish : dishList)
								{
									dish.setRecipeId(recipeId);
									dish.setCreateTime(currentTime);
									recipeService.addDish(dish);
								}
							}
						}
					}
					if (wednesdayRecipe != null)
					{
						wednesdayRecipe.setCreateTime(currentTime);
						wednesdayRecipe.setPushDate(wednesday);
						parmMap.put("pushDate", wednesday);
						ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
						if (resultInfo.getResultCode().equals("success"))
						{
							// 保存食谱
							Integer recipeId = recipeService.addRecipe(wednesdayRecipe);
							// 保存食谱对应的菜品
							List<Dish> dishList = wednesdayRecipe.getDishList();
							if (dishList != null && dishList.size() > 0)
							{
								for (Dish dish : dishList)
								{
									dish.setRecipeId(recipeId);
									dish.setCreateTime(currentTime);
									recipeService.addDish(dish);
								}
							}
						}
					}
					if (thursdayRecipe != null)
					{
						thursdayRecipe.setCreateTime(currentTime);
						thursdayRecipe.setPushDate(thursday);
						parmMap.put("pushDate", thursday);
						ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
						if (resultInfo.getResultCode().equals("success"))
						{
							// 保存食谱
							Integer recipeId = recipeService.addRecipe(thursdayRecipe);
							// 保存食谱对应的菜品
							List<Dish> dishList = thursdayRecipe.getDishList();
							if (dishList != null && dishList.size() > 0)
							{
								for (Dish dish : dishList)
								{
									dish.setRecipeId(recipeId);
									dish.setCreateTime(currentTime);
									recipeService.addDish(dish);
								}
							}
						}
					}
					if (fridayRecipe != null)
					{
						fridayRecipe.setCreateTime(currentTime);
						fridayRecipe.setPushDate(friday);
						parmMap.put("pushDate", friday);
						ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
						if (resultInfo.getResultCode().equals("success"))
						{
							// 保存食谱
							Integer recipeId = recipeService.addRecipe(fridayRecipe);
							// 保存食谱对应的菜品
							List<Dish> dishList = fridayRecipe.getDishList();
							if (dishList != null && dishList.size() > 0)
							{
								for (Dish dish : dishList)
								{
									dish.setRecipeId(recipeId);
									dish.setCreateTime(currentTime);
									recipeService.addDish(dish);
								}
							}
						}
					}
					if (saturdayRecipe != null)
					{
						saturdayRecipe.setCreateTime(currentTime);
						saturdayRecipe.setPushDate(saturday);
						parmMap.put("pushDate", saturday);
						ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
						if (resultInfo.getResultCode().equals("success"))
						{
							// 保存食谱
							Integer recipeId = recipeService.addRecipe(saturdayRecipe);
							// 保存食谱对应的菜品
							List<Dish> dishList = saturdayRecipe.getDishList();
							if (dishList != null && dishList.size() > 0)
							{
								for (Dish dish : dishList)
								{
									dish.setRecipeId(recipeId);
									dish.setCreateTime(currentTime);
									recipeService.addDish(dish);
								}
							}
						}
					}
					if (sundayRecipe != null)
					{
						sundayRecipe.setCreateTime(currentTime);
						sundayRecipe.setPushDate(sunday);
						parmMap.put("pushDate", sunday);
						ResultInfo resultInfo = recipeService.checkPushDate(parmMap);
						if (resultInfo.getResultCode().equals("success"))
						{
							// 保存食谱
							Integer recipeId = recipeService.addRecipe(sundayRecipe);
							// 保存食谱对应的菜品
							List<Dish> dishList = sundayRecipe.getDishList();
							if (dishList != null && dishList.size() > 0)
							{
								for (Dish dish : dishList)
								{
									dish.setRecipeId(recipeId);
									dish.setCreateTime(currentTime);
									recipeService.addDish(dish);
								}
							}
						}
					}
					// startDay加7天
					currentDate.setTime(sf.parse(startDay));
					currentDate.add(GregorianCalendar.DATE, 7);
					Date nextStartDay = currentDate.getTime();
					startDay = sf.format(nextStartDay);
				}
			}
			json = gson.toJson(true);
		} catch (Exception e)
		{
			json = gson.toJson(false);
		}

		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{

		}
		return null;
	}

	/**
	 * 删除单周食谱
	 */
	@RequestMapping(value = "/deleteRecipe.do")
	public String deleteRecipe(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		// 判断该菜品是不是当天最后一个菜品如果是的话，删除当天recipe
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		String json = gson.toJson(true);
		try
		{
			String day = request.getParameter("day");
			if (StringUtil.isEmpty(day))
			{
				day = TimeUtil.getInstance().date();
			}
			// 根据pushDate 查出本周日期
			List<String> dayList = new ArrayList<String>();
			Map<String, String> dayMap = getWeekdays(day);
			for (String key : dayMap.keySet())
			{
				dayList.add(key);
			}
			// 根据日期查出所所有的食谱
			List<Recipe> recipeList = recipeService.getWeekRecipe(dayList);
			if (recipeList != null && recipeList.size() > 0)
			{
				FileUploadUtil fuu = new FileUploadUtil();
				for (Recipe recipe : recipeList)
				{
					recipeService.delRecipeByRecipeId(recipe.getId());
					List<Dish> dishList = recipeService.loadDishListByRecipeId(recipe.getId());
					// 删除七牛上对应的图片
					for (Dish dish : dishList)
					{
						String picPath = dish.getPicPath();
						if (!StringUtil.isEmpty(picPath))
						{
							fuu.simpleDelete(Cons.QINIU_BUCKETNAME_SCHOOLRECIPE, picPath.substring(Cons.QINIU_BUCKETNAME_SCHOOLRECIPE_URL.length()));
						}
					}
				}
			}

		} catch (Exception e)
		{
			json = gson.toJson(false);
		}
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 修改菜名
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/modifyFoodName.do")
	public String modifyFoodName(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		String json;
		try
		{
			// 查询类型
			String id = request.getParameter("id");
			String newFoodName = request.getParameter("newFoodName");
			Dish dish = new Dish();
			if (!StringUtil.isEmpty(id))
			{
				dish = recipeService.loadDishById(Integer.valueOf(id));
				String oldDishName = dish.getDishName();
				dish.setDishName(newFoodName);
				if (!newFoodName.equals(oldDishName) && !StringUtil.isEmpty(newFoodName))
				{
					recipeService.modifyDishByDishId(dish);
					// 只有在菜名更改的情况下才会推送(使用线程运行推送)
					// 推送
					User loginUser = (User) session.getAttribute("user");
					String schoolId = loginUser.getSchoolId();
					Recipe recipe = recipeService.loadRecipeById(dish.getRecipeId());
					final List<User> parentList = userService.getAllParentList();
					School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(schoolId));
					final String sendContent = "尊敬的家长您好," + recipe.getPushDate() + "菜谱已修改！" + school.getSchoolName();
					final PUSHTYPE p = PUSHTYPE.RECIPE;
					new Thread(new Runnable()
					{
						public void run()
						{
							List<PushItem> pushList = new ArrayList<PushItem>();
							for (User parent : parentList)
							{
								String channelId = parent.getBaiduChannelId();
								Integer deviceType = parent.getDeviceType();
								if (!StringUtil.isEmpty(channelId) && deviceType != null && deviceType != 0)
								{
									// 推送手机端消息
									PushItem pi = new PushItem();
									pi.title = p.getName();
									pi.PushContent = sendContent;
									pi.PushType = p.getType();
									pi.PushContentType = p.getContentType();
									pi.channels = channelId;
									pi.deviceType = String.valueOf(deviceType);
									pi.receiverId = parent.getUserId();
									pi.schoolId = parent.getSchoolId();
									pushList.add(pi);
								}
							}
							commonService.pushMsg(pushList, false);
						}
					});
				}
			}
			json = gson.toJson(true);
		} catch (Exception e)
		{
			json = gson.toJson(false);
		}

		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{

		}
		return null;
	}

	/**
	 * 修改图片以及菜谱的名字
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/modifyFoodPic.do")
	public String modifyFoodPic(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		String json;
		boolean flag;
		Dish dish = new Dish();
		try
		{
			// 查询类型
			String id = request.getParameter("id");
			String newFoodPicPath = request.getParameter("newFoodPicPath");
			String newFoodPicName = request.getParameter("newFoodPicName");
			String dishName = request.getParameter("dishName");

			if (!StringUtil.isEmpty(id))
			{
				dish = recipeService.loadDishById(Integer.valueOf(id));
				String oldDishName = dish.getDishName();
				if (!StringUtil.isEmpty(newFoodPicName))
				{
					dish.setPicName(newFoodPicName);
				}
				if (!StringUtil.isEmpty(newFoodPicPath))
				{
					dish.setPicPath(newFoodPicPath);
				}
				if (!StringUtil.isEmpty(dishName))
				{
					dish.setDishName(dishName);
				}
				recipeService.modifyDishByDishId(dish);

				// 只有在菜名更改的情况下才会推送(使用线程运行推送)
				if (!dishName.equals(oldDishName) && !StringUtil.isEmpty(dishName))
				{
					// 推送
					User loginUser = (User) session.getAttribute("user");
					String schoolId = loginUser.getSchoolId();
					Recipe recipe = recipeService.loadRecipeById(dish.getRecipeId());
					final List<User> parentList = userService.getAllParentList();
					School school = schoolService.getSchoolInfoBySchoolId(Long.valueOf(schoolId));
					final String sendContent = "尊敬的家长您好," + recipe.getPushDate() + "菜谱已修改！" + school.getSchoolName();
					final PUSHTYPE p = PUSHTYPE.RECIPE;
					new Thread(new Runnable()
					{
						public void run()
						{
							List<PushItem> pushList = new ArrayList<PushItem>();
							for (User parent : parentList)
							{
								String channelId = parent.getBaiduChannelId();
								Integer deviceType = parent.getDeviceType();
								if (!StringUtil.isEmpty(channelId) && deviceType != null && deviceType != 0)
								{
									// 推送手机端消息
									PushItem pi = new PushItem();
									pi.title = p.getName();
									pi.PushContent = sendContent;
									pi.PushType = p.getType();
									pi.PushContentType = p.getContentType();
									pi.channels = channelId;
									pi.deviceType = String.valueOf(deviceType);
									pi.receiverId = parent.getUserId();
									pi.schoolId = parent.getSchoolId();
									pushList.add(pi);
								}
							}
							commonService.pushMsg(pushList, false);
						}
					});
				}
			}
			flag = true;
		} catch (Exception e)
		{
			flag = false;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", flag);
		map.put("dish", dish);
		json = gson.toJson(map);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
		}
		return null;
	}

	/**
	 * 增加菜品
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/addFoodPic.do")
	public String addFoodPic(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		String json;
		// 增加需要的recipeId或者pushDate，
		String newFoodPicPath = request.getParameter("newFoodPicPath");
		String newFoodPicName = request.getParameter("newFoodPicName");
		String dishName = request.getParameter("dishName");
		String dishType = request.getParameter("dishType");
		String pushDate = request.getParameter("pushDate");
		try
		{
			Recipe recipe = recipeService.loadRecipeByPushDateInPC(pushDate);
			if (recipe != null)
			{
				if (!StringUtil.isEmpty(dishName) || !StringUtil.isEmpty(newFoodPicPath))
				{
					Dish dish = new Dish();
					dish.setRecipeId(recipe.getId());
					dish.setDishType(dishType);
					dish.setCreateTime(TimeUtil.getInstance().now());
					dish.setDishName(dishName);
					dish.setPicName(newFoodPicName);
					dish.setPicPath(newFoodPicPath);
					dish.setPraiseCount(0);
					recipeService.addDish(dish);
				}
			} else
			{
				if (!StringUtil.isEmpty(dishName) || !StringUtil.isEmpty(newFoodPicPath))
				{
					recipe = new Recipe();
					recipe.setPushDate(pushDate);
					recipe.setCreateTime(TimeUtil.getInstance().now());
					Integer recipeId = recipeService.addRecipe(recipe);
					recipe.setId(recipeId);

					Dish dish = new Dish();
					dish.setRecipeId(recipeId);
					dish.setDishType(dishType);
					dish.setCreateTime(TimeUtil.getInstance().now());
					dish.setDishName(dishName);
					dish.setPicName(newFoodPicName);
					dish.setPicPath(newFoodPicPath);
					dish.setPraiseCount(0);
					recipeService.addDish(dish);
				}
			}
			json = gson.toJson(pushDate);
		} catch (Exception e)
		{
			json = gson.toJson(pushDate);
		}
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
		}
		return null;
	}

	/**
	 * 删除单个菜品
	 */
	@RequestMapping(value = "/deleteDishByDishId.do")
	public String deleteDishByDishId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		// 判断该菜品是不是当天最后一个菜品如果是的话，删除当天recipe
		response.setCharacterEncoding("UTF-8");
		String dishId = request.getParameter("dishId");
		Gson gson = new Gson();
		String json = gson.toJson(true);
		try
		{
			if (!StringUtil.isEmpty(dishId))
			{
				Dish dish = recipeService.loadDishById(StringUtil.toint(dishId));
				List<Dish> dishList = recipeService.loadDishListByRecipeId(dish.getRecipeId());

				if (dishList != null && dishList.size() > 1)
				{
					recipeService.delDishByDishId(StringUtil.toint(dishId));
				} else
				{
					recipeService.delRecipeByRecipeId(dish.getRecipeId());
				}

				// 用于删除七牛对应的图片
				FileUploadUtil fuu = new FileUploadUtil();
				String picPath = dish.getPicPath();
				if (!StringUtil.isEmpty(picPath))
				{
					fuu.simpleDelete(Cons.QINIU_BUCKETNAME_SCHOOLRECIPE, picPath.substring(Cons.QINIU_BUCKETNAME_SCHOOLRECIPE_URL.length()));
				}
			}
		} catch (Exception e)
		{
			System.err.println(e.getMessage());
			json = gson.toJson(false);
		}
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 成长手册使用 根据日期加载食谱 如果不选择日期 则表示当前日期所在周的食谱
	 */
	@RequestMapping(value = "/loadWeekRecipeByOne.do")
	public String loadWeekRecipeByOne(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			String day = request.getParameter("day");

			if (day.equals(""))
			{
				day = TimeUtil.getInstance().date();
			}
			day = recipeService.getDataDay(day);
			// 所有日期的集合
			List<String> dayList = new ArrayList<String>();
			Map<String, String> dayMap = getWeekdays(day);
			for (String key : dayMap.keySet())
			{
				dayList.add(key);

			}

			// 根据日期查出所所有的食谱
			List<Recipe> recipeList = recipeService.getWeekRecipe(dayList);

			if (recipeList.size() > 0)
			{
				for (Recipe recipe : recipeList)
				{
					List<Dish> dishList = recipeService.loadDishListByRecipeId(recipe.getId());
					List<Dish> breakfastList = new ArrayList<Dish>();
					List<Dish> lunchList = new ArrayList<Dish>();
					List<Dish> snackList = new ArrayList<Dish>();
					List<Dish> otherList = new ArrayList<Dish>();
					for (Dish dish : dishList)
					{
						if (dish.getDishType().equals("1"))
						{
							breakfastList.add(dish);
						} else if (dish.getDishType().equals("2"))
						{
							lunchList.add(dish);
						} else if (dish.getDishType().equals("3"))
						{
							snackList.add(dish);
						} else if (dish.getDishType().equals("4"))
						{
							otherList.add(dish);
						}
					}
					recipe.setDishList(dishList);
					recipe.setBreakfastList(breakfastList);
					recipe.setLunchList(lunchList);
					recipe.setSnackList(snackList);
					recipe.setOtherList(otherList);
					recipe.setPushDate(recipe.getPushDate());
					recipe.setWeek(dayMap.get(recipe.getPushDate()));
				}
			}

			// 通过科目总分实现比较排序
			Collections.sort(dayList, new Comparator<String>()
			{
				public int compare(String str1, String str2)
				{
					if (str2 == null || str1 == null)
					{
						return 0;
					} else
					{
						return str1.compareTo(str2);
					}
				}
			});

			String currDay = dayList.get(1).substring(5, 7) + "月" + dayList.get(1).substring(8) + "日~" + dayList.get(5).substring(5, 7) + "月" + dayList.get(5).substring(8) + "日";
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("path", Cons.IMGBASEPATH);
			map.put("recipeList", recipeList);
			map.put("currDay", currDay);

			Gson gson = new Gson();
			String json = gson.toJson(map);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据日期查询对应周的所有日期和星期 （返回的是2016-03-27 星期日，2016-03-28 星期一，2016-03-29
	 * 星期二，2016-03-30 星期三，2016-03-31 星期四，2016-04-01 星期五， 2016-04-02 星期六）
	 */
	public Map<String, String> getWeekdays(String day)
	{
		// final int FIRST_DAY = Calendar.SUNDAY;
		// Map<String, String> dayMap = new HashMap<String, String>();
		// try
		// {
		//
		// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// Date date = sdf.parse(day);
		// Calendar calendar = Calendar.getInstance();
		// calendar.setTime(date);
		// while (calendar.get(Calendar.DAY_OF_WEEK) != FIRST_DAY)
		// {
		// calendar.add(Calendar.DATE, -1);
		// }
		// for (int i = 0; i < 7; i++)
		// {
		// SimpleDateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
		// SimpleDateFormat weekFormat = new SimpleDateFormat("EEEEE");
		// dayMap.put(dayFormat.format(calendar.getTime()),
		// weekFormat.format(calendar.getTime()));
		// calendar.add(Calendar.DATE, 1);
		// }
		//
		// } catch (ParseException e)
		// {
		// e.printStackTrace();
		// }

		// 上述代码计算时间,先采用下面的方法
		Map<String, String> dayMap = new HashMap<String, String>();
		try
		{
			dayMap.put(getCurrentMonday(day), "星期一");
			dayMap.put(getCurrentTuesday(day), "星期二");
			dayMap.put(getCurrentWednesday(day), "星期三");
			dayMap.put(getCurrentThursday(day), "星期四");
			dayMap.put(getCurrentFriday(day), "星期五");
			dayMap.put(getCurrentSaturday(day), "星期六");
			dayMap.put(getCurrentSunday(day), "星期日");
		} catch (ParseException e)
		{
			log.info("食谱获取时间失败：" + e.getMessage());
		}

		return dayMap;
	}

	/**
	 * 获取喜爱食物的排名
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/loadFavoriteFood.do")
	public String loadFavoriteFood(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{

			List<Dish> dishList = recipeService.getAllDishList();

			// 获取所有早餐的list
			List<Dish> breakfastList = new ArrayList<Dish>();
			// 获取所有午餐的list
			List<Dish> lunchList = new ArrayList<Dish>();
			// 获取所有下午茶的list
			List<Dish> snackList = new ArrayList<Dish>();
			// 获取所有其他类型的list
			List<Dish> otherList = new ArrayList<Dish>();

			// 根据dishType分类 (1、早餐 2、午餐 3、下午茶4、其他)
			String dishType = null;
			for (Dish dish : dishList)
			{
				dishType = dish.getDishType();
				if (dishType == null || dishType.equals("1"))
				{
					breakfastList.add(dish);
				} else if (dishType == null || dishType.equals("2"))
				{
					lunchList.add(dish);
				} else if (dishType == null || dishType.equals("3"))
				{
					snackList.add(dish);
				} else if (dishType == null || dishType.equals("4"))
				{
					otherList.add(dish);
				}
			}

			// 按照名称分类并获取对应的点赞总和放入Map中
			Map<String, Dish> breakfastMap = new HashMap<String, Dish>();
			for (Dish breakfastDish : breakfastList)
			{
				if (!breakfastMap.containsKey(breakfastDish.getDishName()))
				{
					if (!StringUtil.isEmpty(breakfastDish.getPicPath()))
					{
						breakfastDish.setPicPath(breakfastDish.getPicPath());
					}
					breakfastMap.put(breakfastDish.getDishName(), breakfastDish);
				} else
				{
					Dish dish = breakfastMap.get(breakfastDish.getDishName());
					if (StringUtil.isEmpty(dish.getPicPath()))
					{
						if (!StringUtil.isEmpty(breakfastDish.getPicPath()))
						{
							dish.setPicPath(breakfastDish.getPicPath());
						}
					}
					int praiseCount = dish.getPraiseCount() + breakfastDish.getPraiseCount();
					dish.setPraiseCount(praiseCount);
					breakfastMap.put(breakfastDish.getDishName(), dish);
				}
			}

			// 按照名称分类并获取对应的点赞总和放入Map中
			Map<String, Dish> lunchMap = new HashMap<String, Dish>();
			for (Dish lunchDish : lunchList)
			{
				if (!lunchMap.containsKey(lunchDish.getDishName()))
				{
					if (!StringUtil.isEmpty(lunchDish.getPicPath()))
					{
						lunchDish.setPicPath(lunchDish.getPicPath());
					}
					lunchMap.put(lunchDish.getDishName(), lunchDish);
				} else
				{
					Dish dish = lunchMap.get(lunchDish.getDishName());
					if (StringUtil.isEmpty(dish.getPicPath()))
					{
						if (!StringUtil.isEmpty(lunchDish.getPicPath()))
						{
							dish.setPicPath(lunchDish.getPicPath());
						}
					}
					int praiseCount = dish.getPraiseCount() + lunchDish.getPraiseCount();
					dish.setPraiseCount(praiseCount);
					lunchMap.put(lunchDish.getDishName(), dish);
				}
			}

			// 按照名称分类并获取对应的点赞总和放入Map中
			Map<String, Dish> snackMap = new HashMap<String, Dish>();
			for (Dish snackDish : snackList)
			{
				if (!snackMap.containsKey(snackDish.getDishName()))
				{
					if (!StringUtil.isEmpty(snackDish.getPicPath()))
					{
						snackDish.setPicPath(snackDish.getPicPath());
					}
					snackMap.put(snackDish.getDishName(), snackDish);
				} else
				{
					Dish dish = snackMap.get(snackDish.getDishName());
					if (StringUtil.isEmpty(dish.getPicPath()))
					{
						if (!StringUtil.isEmpty(snackDish.getPicPath()))
						{
							dish.setPicPath(snackDish.getPicPath());
						}
					}
					int praiseCount = dish.getPraiseCount() + snackDish.getPraiseCount();
					dish.setPraiseCount(praiseCount);
					snackMap.put(snackDish.getDishName(), dish);
				}
			}

			// 按照名称分类并获取对应的点赞总和放入Map中
			Map<String, Dish> otherMap = new HashMap<String, Dish>();
			for (Dish otherDish : otherList)
			{
				if (!otherMap.containsKey(otherDish.getDishName()))
				{
					if (!StringUtil.isEmpty(otherDish.getPicPath()))
					{
						otherDish.setPicPath(otherDish.getPicPath());
					}
					otherMap.put(otherDish.getDishName(), otherDish);
				} else
				{
					Dish dish = otherMap.get(otherDish.getDishName());
					if (StringUtil.isEmpty(dish.getPicPath()))
					{
						if (!StringUtil.isEmpty(otherDish.getPicPath()))
						{
							dish.setPicPath(otherDish.getPicPath());
						}
					}
					int praiseCount = dish.getPraiseCount() + otherDish.getPraiseCount();
					dish.setPraiseCount(praiseCount);
					otherMap.put(otherDish.getDishName(), dish);
				}
			}

			// 获取按名称归类后所有早餐的list
			List<Dish> bList = new ArrayList<Dish>();
			for (String key : breakfastMap.keySet())
			{
				bList.add(breakfastMap.get(key));
			}
			// 按照点赞次数排名
			Collections.sort(bList, new Comparator<Dish>()
			{
				public int compare(Dish dish1, Dish dish2)
				{
					if (dish1.getPraiseCount() == null || dish1.getPraiseCount() == null)
					{
						return 0;
					} else
					{
						return dish2.getPraiseCount().compareTo(dish1.getPraiseCount());
					}
				}
			});

			// 获取按名称归类后所有午餐的list
			List<Dish> lList = new ArrayList<Dish>();
			for (String key : lunchMap.keySet())
			{
				lList.add(lunchMap.get(key));
			}
			// 按照点赞次数排名
			Collections.sort(lList, new Comparator<Dish>()
			{
				public int compare(Dish dish1, Dish dish2)
				{
					if (dish1.getPraiseCount() == null || dish1.getPraiseCount() == null)
					{
						return 0;
					} else
					{
						return dish2.getPraiseCount().compareTo(dish1.getPraiseCount());
					}
				}
			});

			// 获取按名称归类后所有下午茶的list
			List<Dish> sList = new ArrayList<Dish>();
			for (String key : snackMap.keySet())
			{
				sList.add(snackMap.get(key));
			}
			// 按照点赞次数排名
			Collections.sort(sList, new Comparator<Dish>()
			{
				public int compare(Dish dish1, Dish dish2)
				{
					if (dish1.getPraiseCount() == null || dish1.getPraiseCount() == null)
					{
						return 0;
					} else
					{
						return dish2.getPraiseCount().compareTo(dish1.getPraiseCount());
					}
				}
			});

			// 获取按名称归类后所有其他类型的list
			List<Dish> oList = new ArrayList<Dish>();
			for (String key : otherMap.keySet())
			{
				oList.add(otherMap.get(key));
			}
			// 按照点赞次数排名
			Collections.sort(oList, new Comparator<Dish>()
			{
				public int compare(Dish dish1, Dish dish2)
				{
					if (dish1.getPraiseCount() == null || dish1.getPraiseCount() == null)
					{
						return 0;
					} else
					{
						return dish2.getPraiseCount().compareTo(dish1.getPraiseCount());
					}
				}
			});

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bList", bList);
			map.put("lList", lList);
			map.put("sList", sList);
			map.put("oList", oList);

			Gson gson = new Gson();
			String json = gson.toJson(map);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 【JS端】获取上传token
	 */
	@RequestMapping(value = "/getUpTokenInJS.do")
	public String getUpTokenInJS(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		try
		{
			FileUploadUtil fileUploadUtil = new FileUploadUtil();
			String token = fileUploadUtil.getSimpleUpToken(Cons.QINIU_BUCKETNAME_SCHOOLRECIPE);
			String json = GsonHelper.toJson(token);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.info("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.info("获取七牛token失败：" + e.getMessage());
		}
		return null;
	}
}
