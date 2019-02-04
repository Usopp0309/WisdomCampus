package com.guotop.palmschool.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.entity.Card;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserCard;
import com.guotop.palmschool.util.Pages;

public interface CardService {
	
	/**
	 * 查找电子卡列表
	 */
	public List<Card> selectAllCard();
	
	/**
	 * 根据电子卡号查找电子卡id
	 * @param code 电子卡号
	 * @return 电子卡id
	 */
	public Integer selectCardIdByCardCode(String code);
	
	/**
	 * 电子卡用户关联增加
	 * @param paramMap 参数map
	 */
	public void addUserCard(Map<String, Object> paramMap);
	
	/**
	 * 查询条件查询电子卡记录 /分页查询
	 * @param paramMap 条件
	 * @return 电子卡记录/分页
	 */
	public Pages getCardList(int pageSize, int page,User user, HashMap<String, Object> paramMap);
	
	/**
	 * 添加年级
	 * @param card 待添加的电子卡
	 */
	public void addCard(Card card);
	
	/**
	 * 修改电子卡
	 * @param card 待修改的电子卡
	 */
	public void modifyCard(Map<String, Object> paramMap);
	
	/**
	 * 通过ID查找Card
	 */
	public Card selectCardById(Integer cardId);
	
	/**
	 * 根据ID修改电子卡号
	 **/
	public void modifyCardById(Map<String, Object> paramMap) ;
	
	/**
	 * 用户新增修改时调用(教师、学生)---begin
	 */
	
	/**
	 * 给用户添加卡号
	 * @param userId 用户ID
	 * @param cardList 卡号列表
	 */
	public void addCardForUser(Integer userId, List<Card> cardList);
	
	/**
	 * 用户新增修改时调用(教师、学生)---end
	 */
	
	/**
	 * 表单校验相关---begin
	 */
	/**
	 * 添加电子卡时查看卡号是否存在
	 * @param code 卡号
	 * @return 返回值
	 */
	public ResultInfo checkCardCode(String code);
	
	/**
	 * 表单校验相关---begin
	 */

	
	/**
	 * 检查电子卡表中是否存在卡号为cardCode的电子卡
	 * @param cardCode 电子卡号
	 * @return true : 存在
	 * 		   false : 不存在
	 */
	public boolean checkCardExists(String cardCode);
	
	/**
	 * 检查卡号为cardCode的电子卡是否存在拥有着
	 * @param cardCode 卡号
	 * @return true : 存在
	 * 		   false : 不存在
	 */
	public boolean checkCardIsUsed(String cardCode);
	
	/**
	 * 根据用户ID查找电子卡列表
	 * @param userId
	 * @param List<Card> 电子卡列表
	 */
	public List<Card> getCardListByUserId(Integer userId);
	/**
	 * 根据用户ID查找电子卡列表【福建专用】
	 * @param userId
	 * @param List<Card> 电子卡列表
	 */
	public List<Card> getCardListByUserIdFj(Integer userId);
	/**
	 * 根据用户ID删除用户与电子卡之间的关联
	 * 20151126
	 * @param userId 用户Id
	 */
	public void deleteUserCard(Integer userId);
	
	/**
	 * 根据userID删除电子卡
	 */
	public void deleteCardByUserId(Integer cardId);
	
	/**
	 * 根据CardID删除用户对应的电子号
	 * 20151126
	 * @param userId 用户Id
	 */
	public void deleteCardByCardId(Integer cardId);
	
	/**
	 * 根据用户ID查找电子卡对应的ID
	 * 20151126
	 */
	public List<UserCard> getCardIdByUserId(Integer userId);
	
	public String getStudentIdByCardId(String cardId);
	
	/**
	 * 通过卡号查找Card
	 * @param cardCode
	 * @return
	 */
	public Card getCardByCardCode(String cardCode);
	
	/**
	 * 【卡号添加】的时候验证卡号是否已经存在
	 * @param cardCode
	 * @return true:被人使用  false:不存在或没有人使用
	 */
	public boolean checkCardCodeIsExist(String cardCode);
	
	/**
	 * 【卡号修改】的时候验证卡号是否已经存在
	 * @param origCardCode
	 * @param cardCode
	 * @return true:存在  false:不存在或没有人使用
	 */
	public boolean checkCardCodeIsExistInModifyCardCode(String origCardCode , String cardCode);
}
