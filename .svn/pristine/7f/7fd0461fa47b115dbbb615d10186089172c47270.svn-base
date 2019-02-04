package com.guotop.palmschool.recipe.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.entity.Dish;
import com.guotop.palmschool.recipe.entity.Recipe;
import com.guotop.palmschool.util.Pages;

/**
 * 菜谱管理业务类接口
 * 
 * @author zhou
 * 
 */
public interface RecipeService
{
	public Recipe loadRecipeById(Integer recipeId);
	
	public Dish loadDishById(Integer dishId);
	/**
	 * 加载菜谱列表
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	public Pages loadRecipeList(int pageSize, int page, Map<String, Object> paramMap);
	
	/**
	 * 添加菜谱
	 * @param user
	 */
	public Integer addRecipe(Recipe recipe);
	
	/**
	 * 添加菜品
	 * @param user
	 */
	public void addDish(Dish dish);
	
	/**
	 * 加载菜品列表
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	public Pages loadDishList(int pageSize, int page, Map<String, Object> paramMap);

	/**
	 * 根据recipeId获取dishList
	 * @param recipeId
	 * @return
	 */
	public List<Dish> loadDishListByRecipeId(Integer recipeId);
	
	/**
	 * 根据recipeId获取dishList(手机端)
	 * @param recipeId
	 * @return
	 */
	public List<com.richx.pojo.Dish> loadDishListByRecipeIdRichx(Integer recipeId);
	
	/**
	 * 删除recipe
	 * @param recipeId
	 */
	public void delRecipeByRecipeId(Integer recipeId);
	
	/**
	 * 删除dish
	 * @param dishId
	 */
	public void delDishByDishId(Integer dishId);
	
	/**
	 * 修改recipe
	 * @param recipeId
	 */
	public void modifyRecipeByRecipeId(Recipe recipe);
	
	/**
	 * 修改dish
	 * @param dishId
	 */
	public void modifyDishByDishId(Dish dish);
	
	/**
	 * success 代表检查成功
	 * error  代表检查失败
	 * @param paramMap
	 * @return
	 */
	public ResultInfo checkPushDate(Map<String, Object> paramMap);
	
	/**
	 * 通过日期加载菜谱 app使用
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	public Recipe loadRecipeByPushDate(String pushDate);
	
	/**
	 * 通过日期加载菜谱列表 PC使用
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	public Recipe loadRecipeByPushDateInPC(String pushDate);
	
	/**
	 * 通过日期加载菜谱列表 pc使用
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	public List<Recipe> loadRecipeBewteenPushDate(String startPushDate,String endPushDate);
	
	/**
	 * 根据日期查询食谱菜单
	 */
	public List<Recipe> getWeekRecipe(List<String> dayList);
	
	/**
	 * 根据日期查询食谱菜单(手机端)
	 */
	public List<com.richx.pojo.Recipe> getWeekRecipeRichx(List<String> dayList);
	
	/**
	 * 获取所有的菜谱信息
	 */
	public List<Dish> getAllDishList();

	public String getDataDay(String day);

}
