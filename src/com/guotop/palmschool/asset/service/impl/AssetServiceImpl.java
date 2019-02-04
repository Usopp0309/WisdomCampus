package com.guotop.palmschool.asset.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.guotop.palmschool.asset.entity.Asset;
import com.guotop.palmschool.asset.entity.AssetImport;
import com.guotop.palmschool.asset.entity.AssetRepair;
import com.guotop.palmschool.asset.entity.AssetRepairImg;
import com.guotop.palmschool.asset.entity.AssetServiceman;
import com.guotop.palmschool.asset.service.AssetService;
import com.guotop.palmschool.bluetooth.service.BraceletService;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.DepartmentService;
import com.guotop.palmschool.util.Pages;

@Service("assetService")
public class AssetServiceImpl extends BaseService implements AssetService
{

	@Resource
	private CommonService commonService;
	@Resource
	private DepartmentService departmentService;
	
	@Resource
	private BraceletService braceletService;
	/**
	 * 获取资产列表（分页）
	 * 
	 * @param page
	 * @param pageSize
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Pages getAssetList(int page, int pageSize,int personOrschool,User user, Map<String,Object> paramMap)
	{
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);
		int allRow  = 0;
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);

		List<Asset> list = new ArrayList<>();
		if(personOrschool == 0)//学校资产
		{
			allRow = (Integer) getBaseDao().selectObjectByObject("Asset.getAssetListCount", paramMap);
			list = getBaseDao().selectListByObject("Asset.getAssetList", paramMap);
		}
		else//个人资产
		{
			if(commonService.hasAdminPermission(user))//如果当前用户有管理员权限则可以看到所有的个人资产
			{
				allRow = (Integer) getBaseDao().selectObjectByObject("Asset.getAssetListPersonCountForAdmin", paramMap);
				list = getBaseDao().selectListByObject("Asset.getAssetListPersonForAdmin", paramMap);
			}else//其他人只能看到自己负责的或自己领取的个人资产
			{
				allRow = (Integer) getBaseDao().selectObjectByObject("Asset.getAssetListPersonCount", paramMap);
				list = getBaseDao().selectListByObject("Asset.getAssetListPerson", paramMap);
			}
		}
		
		int totalPage = Pages.countTotalPage(pageSize, allRow);

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
	 * 获取资产导入列表（分页）
	 * @param page
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Pages getImportList(int page,int pageSize)
	{
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);

		Map<String,Object> paramMap = new HashMap<String, Object>();
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);

		int allRow = (Integer) getBaseDao().selectObjectByObject("Asset.getImportListCount",null);
		int totalPage = Pages.countTotalPage(pageSize, allRow);
		List<AssetImport> list = getBaseDao().selectListByObject("Asset.getImportList", paramMap);

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

	@Override
	public Integer addAsset(Asset asset)
	{
		Integer assetId=(Integer)getBaseDao().addObject("Asset.addAsset", asset);
		/*if(asset.getIsBluetooth().intValue()==2){//蓝牙手环
			//插入指定数量的蓝牙手环
			List<BluetoothBracelet> list=new ArrayList<>();
			BluetoothBracelet bluetoothBracelet=null;
			for(int i=0;i<asset.getCount();i++){
				bluetoothBracelet=new BluetoothBracelet();
				bluetoothBracelet.setAssetId(assetId);
				bluetoothBracelet.setStatus(0);//状态(0:正常，1：停用)
				list.add(bluetoothBracelet);
			}
			braceletService.insertBathBluetoothBracelet(list);
		}*/
		return assetId;
	}
	
	@Override
	public void modifyAsset(Asset asset)
	{
		getBaseDao().updateObject("Asset.modifyAsset", asset);
	}

	@Override
	public Asset getAssetDetailById(Integer id)
	{
		return (Asset) getBaseDao().selectObject("Asset.getAssetDetailById", id);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Asset>getAllAssetListByType(Map<String,Object> paramMap)
	{
		return (List<Asset>) getBaseDao().selectListByObject("Asset.getAllAssetListByType", paramMap);
	}

	@Override
	public void deleteAssetById(Integer id)
	{
		getBaseDao().deleteObjectById("Asset.deleteAssetById", id);
		deleteAssetRepairByAssetId(id);
	}

	@Override
	public void deleteAssetRepairByAssetId(Integer assetId)
	{
		getBaseDao().deleteObjectById("Asset.deleteAssetRepairByAssetId", assetId);
	}

	@Override
	public boolean checkCode(Map<String, Object> paramMap)
	{
		Integer count = (Integer) getBaseDao().selectObjectByObject("Asset.checkCode", paramMap);
		if(count>0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	@Override
	public void addAssetImport(AssetImport imp)
	{
		getBaseDao().addObject("Asset.addAssetImport", imp);
	}
	
	@Override
	public boolean isServiceman(Integer userId)
	{
		Integer count = (Integer) getBaseDao().selectObjectByObject("Asset.isServiceman", userId);
		if(count>0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	@Override
	public boolean isServicemanLeader(Integer userId)
	{
		Integer count = (Integer) getBaseDao().selectObjectByObject("Asset.isServicemanLeader", userId);
		if(count>0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	/**
	 * 添加维修信息
	 * @param repair
	 * @return
	 */
	public Integer addAssetRepair(AssetRepair repair)
	{
		return (Integer)getBaseDao().addObject("Asset.addAssetRepair", repair);
	}
	
	/**
	 * 添加维修信息图片
	 * @param repairImg
	 */
	public void addAssetRepairImg(AssetRepairImg repairImg)
	{
		getBaseDao().addObject("Asset.addAssetRepairImg", repairImg);
	}
	
	/**
	 * 获取维修人员列表（分页）
	 * @param page
	 * @param pageSize
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Pages getServicemanList( int page,int pageSize,Map<String, Object> paramMap)
	{
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);

		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);

		int allRow = (Integer) getBaseDao().selectObjectByObject("Asset.getServicemanListCount",paramMap);
		int totalPage = Pages.countTotalPage(pageSize, allRow);
		List<AssetServiceman> list = getBaseDao().selectListByObject("Asset.getServicemanList", paramMap);

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
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AssetServiceman>getAllServicemanListByType(Integer type)
	{
		if(type==null){
			return (List<AssetServiceman>) getBaseDao().selectListBySql("Asset.getAllServicemanList");
		}else{
			return (List<AssetServiceman>) getBaseDao().selectList("Asset.getAllServicemanListByType", type);	
		}
		
	}
	
	/**
	 * 根据维修人员ID获取对应的负责人用户推送消息
	 * @param servicemanId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<User> getLeaderListByServicemanIdForPush(Integer servicemanId,int type)
	{
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("servicemanId", servicemanId);
		paramMap.put("type", type);
		List<AssetServiceman> servicemanList = getBaseDao().selectListByObject("Asset.getServicemanByServicemanId", paramMap);
		List<User> list = new ArrayList<>();
		for(AssetServiceman man : servicemanList)
		{
			if(man.getLeaderIdOne() != null){
				User user1 = commonService.getUserByUserIdForPush(man.getLeaderIdOne());
				if(user1 != null)
				{
					list.add(user1);
				}
			}
			if(man.getLeaderIdTwo() != null){
				User user2 = commonService.getUserByUserIdForPush(man.getLeaderIdTwo());
				if(user2 != null)
				{
					list.add(user2);
				}
			}
		}
		return list;
	}

	/**
	 * 添加维修人员
	 * @param serviceman
	 */
	public void addAssetServiceman(AssetServiceman serviceman)
	{
		getBaseDao().addObject("Asset.addAssetServiceman", serviceman);
	}
	
	/**
	 * 根据userId和维修类型查看维修人员是否已经存在
	 */
	@SuppressWarnings({"unchecked" })
	public boolean isExistServicemanByServicemanIdAndType(Integer servicemanId,Integer type){
		Map<String, Object> parmMap = new HashMap<String, Object>();
		parmMap.put("servicemanId", servicemanId);
		parmMap.put("type", type);
		List<AssetServiceman> list = getBaseDao().selectListByObject("Asset.gerServicemanByServicemanIdAndType", parmMap);
		if(CollectionUtils.isEmpty(list)){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 根据登录人获取维修列表
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Pages getAssetRepairList(int page, int pageSize,String personnelType,User user,Map<String, Object> paramMap)
	{
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);
		int allRow = 0;
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		List<AssetRepair>  list = new ArrayList<>();
		if("leader".equals(personnelType))//领导可以 查看自己报修的或者维修人是自己或者自己是维修人的领导
		{
			if(commonService.hasAdminPermission(user))
			{
				allRow = (Integer) getBaseDao().selectObjectByObject("Asset.getAssetRepairListForAdminCount",paramMap);
				list = getBaseDao().selectListByObject("Asset.getAssetRepairListForAdmin", paramMap);
			}
			else
			{
				allRow = (Integer) getBaseDao().selectObjectByObject("Asset.getAssetRepairListForLeaderCount",paramMap);
				list = getBaseDao().selectListByObject("Asset.getAssetRepairListForLeader", paramMap);
			}

		}
		else if("serviceman".equals(personnelType))//维修人员获取自己报修的和维修人员是自己的
		{
			allRow = (Integer) getBaseDao().selectObjectByObject("Asset.getAssetRepairListForServicemanCount",paramMap);
			
			list = getBaseDao().selectListByObject("Asset.getAssetRepairListForServiceman", paramMap);
		}
		else//普通人员看到自己报修的列表
		{
			allRow = (Integer) getBaseDao().selectObjectByObject("Asset.getAssetRepairListForRepairCount",paramMap);
			
			list = getBaseDao().selectListByObject("Asset.getAssetRepairListForRepair", paramMap);
		}

		
		int totalPage = Pages.countTotalPage(pageSize, allRow);
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
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Pages getAssetRepairListByPersonnelType(int page, int pageSize,String personnelType,User user,Map<String, Object> paramMap){
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);
		int allRow = 0;
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		List<AssetRepair>  list = new ArrayList<>();
		if("leader".equals(personnelType))//领导可以 查看自己报修的或者维修人是自己或者自己是维修人的领导
		{
			if(commonService.hasAdminPermission(user))
			{
				allRow = (Integer) getBaseDao().selectObjectByObject("Asset.getAssetRepairListForAdminCount",paramMap);
				list = getBaseDao().selectListByObject("Asset.getAssetRepairListForAdmin", paramMap);
			}
			else
			{
				allRow = (Integer) getBaseDao().selectObjectByObject("Asset.getAssetRepairListForLeaderCount",paramMap);
				list = getBaseDao().selectListByObject("Asset.getAssetRepairListForLeader", paramMap);
			}

		}
		else if("serviceman".equals(personnelType))//维修人员获取维修人员是自己的
		{
			allRow = (Integer) getBaseDao().selectObjectByObject("Asset.getAssetRepairListCountByServicemanIdForServiceman",paramMap);
			
			list = getBaseDao().selectListByObject("Asset.getAssetRepairListByServicemanIdForServiceman", paramMap);
		}
		int totalPage = Pages.countTotalPage(pageSize, allRow);
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
	 * 根据ID获取维修详情
	 * @param id
	 * @return
	 */
	public AssetRepair getAssetRepairDetailById(Integer id)
	{
		return (AssetRepair)getBaseDao().selectObject("Asset.getAssetRepairDetailById", id);
	}
	/**
	 * 根据ID获取维修详情
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AssetRepairImg> getAssetRepairImgListByRepairId(Integer id)
	{
		return (List<AssetRepairImg>)getBaseDao().selectList("Asset.getAssetRepairImgListByRepairId", id);
	}
	
	public void updateAsserRepair(AssetRepair repair)
	{
		getBaseDao().updateObject("Asset.updateAsserRepair", repair);
	}
	
	
	/******************APP使用**********************/
	
	/**
	 * 获取自己或学校资产列表
	 * @param personOrschool
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Asset> getAssetListForApp(int personOrschool,Map<String,Object> paramMap)
	{
		if(personOrschool == 0)
		{
			return (List<Asset>)getBaseDao().selectListByObject("Asset.getAssetList", paramMap);
		}
		else
		{
			return (List<Asset>)getBaseDao().selectListByObject("Asset.getAssetListPerson", paramMap);
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<AssetRepair> getAssetRepairList(int personType,int userId)
	{
		/*
		 * 判断当前登录人身份
		 * 1维修人员的领导则可以看到自己报修的，自己是维修人的领导的所有报修单
		 * 2维修人员则可以看到自己报修的和维修人是自己的所有报修单
		 * 3普通人员则只能看到自己报修的报修单
		 */
		List<AssetRepair>  list = new ArrayList<>();
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("userId", userId);
		if(personType == 1)
		{
			list = getBaseDao().selectListByObject("Asset.getAssetRepairListForLeader", paramMap);
		}
		else if(personType == 2)
		{
			list = getBaseDao().selectListByObject("Asset.getAssetRepairListForServiceman", paramMap);
		}
		else
		{
			list = getBaseDao().selectListByObject("Asset.getAssetRepairListForRepair", paramMap);
		}
		return list;
	}
	
	/**
	 * 获取人员类型
	 * @return
	 */
	public String getPersonnelType(User user){
		String personnelType = "repair";
		if (commonService.hasAdminPermission(user))// 如果是管理员权限表示报修人是领导
		{
			personnelType = "leader";
		} else
		{
			boolean flag = false;
			List<Role> roleList = user.getRoleList();
			for (Role role : roleList)
			{
				if (role.getRoleCode().equals("departManager"))// 如果有部门管理员权限表示报修人是领导
				{
					flag = true;
					break;
				}
			}
			// 根据用户ID判断是否有管理的部门
			boolean isDapartLeader = departmentService.checkIsDapartLeaderByUserId(user.getUserId());
			// 根据用户ID判断是否是维修部门人员的领导
			boolean isServicemanLeader = isServicemanLeader(user.getUserId());
			if (flag || isDapartLeader || isServicemanLeader)// 报修人为领导
			{
				personnelType = "leader";
			} else// 不是领导 判断是否为维修人员还是普通人员
			{
				boolean isServiceman = isServiceman(user.getUserId());
				if (isServiceman)
				{
					personnelType = "serviceman";
				} else
				{
					personnelType = "repair";
				}
			}
		}
		return personnelType;
	}
	/**
	 * 导出资产二维码
	 * @author chenyong
	 * @Time 2017年2月28日 上午10:21:31
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Asset> getAssetQcode(int personOrschool, User user, Map<String, Object> paramMap) {
		List<Asset> list = new ArrayList<>();
		if(personOrschool == 0)//学校资产
		{
			list = getBaseDao().selectListByObject("Asset.getAssetListToQcode", paramMap);
		}
		else//个人资产
		{
			if(commonService.hasAdminPermission(user))//如果当前用户有管理员权限则可以看到所有的个人资产
			{
				list = getBaseDao().selectListByObject("Asset.getAssetListPersonForAdminToQcode", paramMap);
			}else//其他人只能看到自己负责的或自己领取的个人资产
			{
				list = getBaseDao().selectListByObject("Asset.getAssetListPersonToQcode", paramMap);
			}
		}
		return list;
	}

	@Override
	public void deleteAssetServicemanById(Integer servicemanId) {
		getBaseDao().deleteObjectById("Asset.deleteAssetServicemanById", servicemanId);
	}
}
