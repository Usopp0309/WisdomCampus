package com.guotop.palmschool.shopping.service;

import java.util.List;

import com.guotop.palmschool.shopping.entity.Goods;
import com.guotop.palmschool.shopping.entity.GoodsDetail;
import com.guotop.palmschool.shopping.entity.GoodsType;
/**
 * 购物接口
 * @author jfy
 * @date 2016年1月8日
 */
public interface ShoppingService
{
	/**
	 * 获取商品类别列表
	 * @return
	 */
	public List<GoodsType> getGoodsType();
	/**
	 * 根据商品类别获取商品列表
	 * @param goodsType
	 * @return
	 */
	public List<Goods> getGoodsListByGoodsType(int goodsType);
	/**
	 * 根据商品ID获取商品明细列表
	 * @param goodsId
	 * @return
	 */
	public List<GoodsDetail> getGoodsDetailListByGoodsId(int goodsId);
	/**
	 * 根据ID获取物品信息
	 * @param goodsId
	 * @return
	 */
	public Goods getGoodsById(int goodsId);
	/**
	 * 根据详情ID获取物品信息
	 * @param goodsDetailId
	 * @return
	 */
	public Goods getGoodsByDetailId(int goodsDetailId);
}
