package com.guotop.palmschool.recipe.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.entity.Dish;
import com.guotop.palmschool.recipe.entity.Recipe;
import com.guotop.palmschool.recipe.service.RecipeService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 菜谱管理业务类接口
 * 
 * @author sheng
 * 
 */
@Service("recipeService")
public class RecipeServiceImpl extends BaseService implements RecipeService
{
	@Override
	public Recipe loadRecipeById(Integer recipeId)
	{
		Recipe recipe = (Recipe) this.getBaseDao().selectObject("Recipe.loadRecipeByRecipeId", recipeId);
		return recipe;
	}

	public Dish loadDishById(Integer dishId)
	{
		Dish dish = (Dish) this.getBaseDao().selectObject("Dish.loadDishByDishId", dishId);
		return dish;
	}

	/**
	 * 加载菜谱列表
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pages loadRecipeList(int pageSize, int page, Map<String, Object> paramMap)
	{
		SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd");
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<Recipe> list = new ArrayList<Recipe>();
		allRow = (Integer) this.getBaseDao().selectObjectByObject("Recipe.loadRecipeCount", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);

		paramMap.put("startIndex", offset);
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("Recipe.loadRecipeList", paramMap);
		if (list != null && list.size() > 0)
		{
			for (Recipe recipe : list)
			{
				List<Dish> dishList = loadDishListByRecipeId(recipe.getId());
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
				String weekDay = "";
				try
				{
					weekDay = TimeUtil.getInstance()._getWeekDay(sim.parse(recipe.getPushDate()));
				} catch (ParseException e)
				{

				}
				recipe.setPushDate(recipe.getPushDate() + "(" + weekDay + ")");
			}
		}
		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}

	/**
	 * 通过日期加载菜谱列表 app使用
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	public Recipe loadRecipeByPushDate(String pushDate)
	{
		Recipe recipe = (Recipe) this.getBaseDao().selectObjectByObject("Recipe.loadRecipeByPushDate", pushDate);

		if(recipe != null){
			List<Dish> dishList = loadDishListByRecipeId(recipe.getId());
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
		}else{
			recipe = new Recipe();
		}
		return recipe;
	}
	
	/**
	 * 通过日期加载菜谱列表 PC使用
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	public Recipe loadRecipeByPushDateInPC(String pushDate)
	{
		Recipe recipe = (Recipe) this.getBaseDao().selectObjectByObject("Recipe.loadRecipeByPushDate", pushDate);
		return recipe;
	}
	
	/**
	 * 通过日期加载菜谱列表 pc使用
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Recipe> loadRecipeBewteenPushDate(String startPushDate,String endPushDate)
	{
		HashMap<String,String> pushDateMap = new HashMap<String, String>();
		pushDateMap.put("startPushDate", startPushDate);
		pushDateMap.put("endPushDate", endPushDate);
		List<Recipe> recipeList = this.getBaseDao().selectListByObject("Recipe.loadRecipeBewteenPushDate", pushDateMap);
		if(recipeList != null && recipeList.size() > 0){
			for(Recipe recipe :recipeList){
				List<Dish> dishList = loadDishListByRecipeId(recipe.getId());
				recipe.setDishList(dishList);
			}
		}else{
			recipeList = new ArrayList<Recipe>();
		}
		return recipeList;
	}

	/**
	 * 添加菜谱
	 * 
	 * @param user
	 */
	public Integer addRecipe(Recipe recipe)
	{
		Integer recipeId = getBaseDao().addObject("Recipe.addRecipe", recipe);
		return recipeId;
	}

	/**
	 * 添加菜品
	 * 
	 * @param user
	 */
	public void addDish(Dish dish)
	{
		getBaseDao().addObject("Dish.addDish", dish);
	}

	/**
	 * 加载菜品列表
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pages loadDishList(int pageSize, int page, Map<String, Object> paramMap)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<Dish> list = new ArrayList<Dish>();
		allRow = (Integer) this.getBaseDao().selectObjectByObject("Dish.loadDishCount", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);

		paramMap.put("startIndex", offset);
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("Dish.loadDishList", paramMap);

		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}

	/**
	 * 根据recipeId获取dishList
	 * 
	 * @param recipeId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Dish> loadDishListByRecipeId(Integer recipeId)
	{
		List<Dish> list = this.getBaseDao().selectListByObject("Dish.loadDishListByRecipeId", recipeId);
		return list;
	}
	
	/**
	 * 根据recipeId获取dishList(手机端)
	 * @param recipeId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<com.richx.pojo.Dish> loadDishListByRecipeIdRichx(Integer recipeId)
	{
		List<com.richx.pojo.Dish> list = getBaseDao().selectListByObject("Dish.loadDishListByRecipeIdRichx", recipeId);
		return list;
	}

	@Transactional(rollbackFor = Exception.class)
	public void delRecipeByRecipeId(Integer recipeId)
	{
		getBaseDao().deleteObjectById("Recipe.deleteRecipe", recipeId);
		getBaseDao().deleteObjectById("Dish.deleteDishByRecipeId", recipeId);
	}
	
	public void delDishByDishId(Integer dishId){
		getBaseDao().deleteObjectById("Dish.deleteDishByDishId", dishId);
	}

	@Override
	public void modifyRecipeByRecipeId(Recipe recipe)
	{
		getBaseDao().updateObject("Recipe.modifyRecipe", recipe);
	}

	@Override
	public void modifyDishByDishId(Dish dish)
	{
		getBaseDao().updateObject("Dish.modifyDish", dish);
	}

	@Override
	public ResultInfo checkPushDate(Map<String, Object> paramMap)
	{
		Integer result = (Integer) getBaseDao().selectObjectByObject("Recipe.checkPushDate", paramMap);
		ResultInfo resultInfo = new ResultInfo();
		if (result > 0)
		{
			resultInfo.setResultCode(ResultInfo.RESULT_ERROR);
		} else
		{
			resultInfo.setResultCode(ResultInfo.RESULT_SUCCESS);
		}
		return resultInfo;
	}
	
	/**
	 * 根据日期查询食谱菜单
	 */
	@SuppressWarnings("unchecked")
	public List<Recipe> getWeekRecipe(List<String> dayList)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dayList", dayList);
		List<Recipe> list = this.getBaseDao().selectListByObject("Recipe.getWeekRecipe", paramMap);
		return list;
	}
	
	/**
	 * 根据日期查询食谱菜单(手机端)
	 */
	@SuppressWarnings("unchecked")
	public List<com.richx.pojo.Recipe> getWeekRecipeRichx(List<String> dayList)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dayList", dayList);
		List<com.richx.pojo.Recipe> list = getBaseDao().selectListByObject("Recipe.getWeekRecipeRichx", paramMap);
		return list;
	}
	
	/**
	 * 获取所有的菜谱信息
	 */
	@SuppressWarnings("unchecked")
	public List<Dish> getAllDishList()
	{
		return (List<Dish>)getBaseDao().selectListBySql("Dish.getAllDishList");
	}

	@Override
	public String getDataDay(String day) {
		return (String)getBaseDao().selectObjectByObject("Recipe.getDataDay",day);
	}
}
