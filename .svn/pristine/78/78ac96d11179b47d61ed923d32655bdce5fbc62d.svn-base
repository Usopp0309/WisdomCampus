package com.guotop.palmschool.shopping.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.shopping.entity.Goods;
import com.guotop.palmschool.shopping.entity.GoodsDetail;
import com.guotop.palmschool.shopping.entity.GoodsType;
import com.guotop.palmschool.shopping.service.ShoppingService;
/**
 * 购物服务实现类
 * @author jfy
 * @date 2016年1月8日
 */
@Service("shoppingService")
public class ShoppingServiceImpl extends BaseService implements ShoppingService
{

	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsType> getGoodsType()
	{
		// TODO Auto-generated method stub
		return getBaseDao().selectListBySql("Goods.getGoodsTypeList");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Goods> getGoodsListByGoodsType(int goodsType)
	{
		// TODO Auto-generated method stub
		return getBaseDao().selectListByObject("Goods.getGoodsListByTypeId", goodsType);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GoodsDetail> getGoodsDetailListByGoodsId(int goodsId)
	{
		// TODO Auto-generated method stub
		return getBaseDao().selectListByObject("Goods.getGoodsDetailListByGoodsId", goodsId);
	}

	@Override
	public Goods getGoodsById(int goodsId)
	{
		// TODO Auto-generated method stub
		return (Goods)getBaseDao().selectObject("Goods.getGoodsByGoodsId", goodsId);
	}

	@Override
	public Goods getGoodsByDetailId(int goodsDetailId)
	{
		// TODO Auto-generated method stub
		return (Goods)getBaseDao().selectObjectByObject("Goods.getGoodsByDetailId", goodsDetailId);
	}
	
}
