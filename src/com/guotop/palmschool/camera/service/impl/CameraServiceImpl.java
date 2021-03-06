package com.guotop.palmschool.camera.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.guotop.palmschool.camera.entity.Camera;
import com.guotop.palmschool.camera.entity.CameraRelation;
import com.guotop.palmschool.camera.service.CameraService;
import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Place;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

/**
 * 视屏直播实现类
 * 
 * @author Administrator
 *
 */
@Service("/cameraService")
public class CameraServiceImpl extends BaseService implements CameraService
{

	@Resource
	private CommonService commonService;

	/**
	 * 获取地点列表（包含cameraList）
	 */
	@SuppressWarnings("unchecked")
	public List<Place> getPlaceList(Integer userId,User user)
	{
		if(commonService.hasAdminPermission(user))
		{
			return getBaseDao().selectList("Camera.getPlaceListByAdmin",null);
		}
		else
		{
			return getBaseDao().selectList("Camera.getPlaceList",userId);
		}
	}

	/**
	 * 加载所有cameraList
	 * 
	 * @param pageSize
	 * @param currentPage
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pages getCameraList(int pageSize, int page, Map<String, Object> paramMap)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;

		currentPage = Pages.countCurrentPage(page);

		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);

		List<Camera> list = new ArrayList<Camera>();

		String roleCode = (String) paramMap.get("roleCode");

		User user = (User) paramMap.get("user");

		/**
		 * 家长 （自己孩子的所在班和校门等公共场所）
		 */
		if (roleCode != null && roleCode.equals("parent"))
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("Camera.getCameraListCountParent", paramMap);

			totalPage = Pages.countTotalPage(pageSize, allRow);

			list = this.getBaseDao().selectListByObject("Camera.getCameraListParent", paramMap);
		}

		/**
		 * 学生（自己的所在班和校门等公共场所）
		 */
		else if (roleCode != null && roleCode.equals("student"))
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("Camera.getCameraListCountStudent", paramMap);

			totalPage = Pages.countTotalPage(pageSize, allRow);

			list = this.getBaseDao().selectListByObject("Camera.getCameraListStudent", paramMap);
		}
		/**
		 * 班主任（自己的所在班部门和校门等公共场所）
		 */
		else if (roleCode != null && roleCode.equals("classLeader"))
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("Camera.getCameraListCountClassLeader", paramMap);

			totalPage = Pages.countTotalPage(pageSize, allRow);

			list = this.getBaseDao().selectListByObject("Camera.getCameraListClassLeader", paramMap);
		}

		/**
		 * 校长或者学校管理员（全校所有）
		 */
		else if (commonService.hasAdminPermission(user))
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("Camera.getCameraListCount", paramMap);

			totalPage = Pages.countTotalPage(pageSize, allRow);

			list = this.getBaseDao().selectListByObject("Camera.getCameraList", paramMap);
		}
		/**
		 * 教职工（自己所在部门和校门等公共场所）
		 */
		else
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("Camera.getCameraListCountTeacher", paramMap);

			totalPage = Pages.countTotalPage(pageSize, allRow);

			list = this.getBaseDao().selectListByObject("Camera.getCameraListTeacher", paramMap);
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
	 * 添加设备
	 * 
	 * @param camera
	 * @return
	 */
	public Integer addCamera(Camera camera)
	{
		return (Integer) getBaseDao().addObject("Camera.addCamera", camera);
	}

	/**
	 * 修改设备
	 * 
	 * @param camera
	 */
	public void modifyCamera(Camera camera)
	{
		getBaseDao().updateObject("Camera.modifyCamera", camera);
	}

	/**
	 * 删除设备
	 * 
	 * @param cameraId
	 */
	public void deleteCamera(Integer cameraId)
	{
		getBaseDao().deleteObject("Camera.deleteCamera", cameraId);
	}

	/**
	 * 根据cameraId查询对应的camera
	 * 
	 * @param cameraId
	 * @return
	 */
	public Camera getCameraById(Integer cameraId)
	{
		return (Camera) getBaseDao().selectObject("Camera.getCameraById", cameraId);
	}

	/**
	 * 校验设备编码是否存在
	 * 
	 * @param cameraCode
	 * @return
	 */
	public ResultInfo checkCameraCode(String cameraCode)
	{

		Camera camera = (Camera) getBaseDao().selectObjectByObject("Camera.getCameraByCameraCode", cameraCode);

		ResultInfo resultInfo = new ResultInfo();

		if (camera == null)
		{
			resultInfo.setResultCode(ResultInfo.RESULT_ERROR);
		} else
		{
			resultInfo.setResultCode(ResultInfo.RESULT_SUCCESS);
		}
		return resultInfo;
	}

	/**
	 * 校验设备编码是否存在(修改设备时)
	 * 
	 * @param cameraCode
	 * @return
	 */
	public ResultInfo checkCameraCodeByModify(Map<String, Object> paramMap)
	{

		Camera camera = (Camera) getBaseDao().selectObjectByObject("Camera.checkCameraCodeByModify", paramMap);

		ResultInfo resultInfo = new ResultInfo();

		if (camera == null)
		{
			resultInfo.setResultCode(ResultInfo.RESULT_ERROR);
		} else
		{
			resultInfo.setResultCode(ResultInfo.RESULT_SUCCESS);
		}
		return resultInfo;
	}

	/**
	 * 根据类型加载对应的摄像头List
	 * 
	 * @param type
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Camera> getCameraListByType(Integer type)
	{
		return (List<Camera>) getBaseDao().selectList("Camera.getCameraListByType", type);
	}

	/**
	 * 添加摄像头和班级（或学生）的关系
	 * 
	 * @param cameraRelationList
	 */
	@Transactional(rollbackFor = Exception.class)
	public void addCameraRelation(Integer type, List<CameraRelation> cameraRelationList)
	{
		if (type == 0 && cameraRelationList!=null && cameraRelationList.size()>0)
		{
			getBaseDao().deleteObject("Camera.deleteCameraClazzBycameraId", cameraRelationList);//删除重复
			getBaseDao().addObject("Camera.addClazzCamera", cameraRelationList);
		} else if (type == 1 && cameraRelationList!=null && cameraRelationList.size()>0)
		{
			getBaseDao().deleteObject("Camera.deleteCameraUserBycameraId",cameraRelationList);//删除重复
			getBaseDao().addObject("Camera.addUserCamera", cameraRelationList);
		}
	}
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void deleteCameraRelation(Integer type ,List<CameraRelation> cameraRelationList) {
		if (type == 0 && cameraRelationList!=null && cameraRelationList.size()>0)
		{
			getBaseDao().deleteObject("Camera.deleteCameraClazzBycameraId", cameraRelationList);
		} else if (type == 1 && cameraRelationList!=null && cameraRelationList.size()>0)
		{
			getBaseDao().deleteObject("Camera.deleteCameraUserBycameraId",cameraRelationList);
		}
	}
	/**
	 * 根据userId和roleCode获取对应的摄像头list
	 * @param userId 用户id
	 * @param roleCode 用户的角色
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Camera> getAllCameraListByUserIdRoleCode(User user,Integer userId,String roleCode)
	{
		List<Camera> list = new ArrayList<Camera>();

		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		/**
		 * 家长 （自己孩子的所在班和校门等公共场所）
		 */
		if (roleCode != null && roleCode.equals("parent"))
		{

			list = this.getBaseDao().selectListByObject("Camera.getCameraListParent", paramMap);
		}

		/**
		 * 学生（自己的所在班和校门等公共场所）
		 */
		else if (roleCode != null && roleCode.equals("student"))
		{

			list = this.getBaseDao().selectListByObject("Camera.getCameraListStudent", paramMap);
		}
		/**
		 * 班主任（自己的所在班部门和校门等公共场所）
		 */
		else if (roleCode != null && roleCode.equals("classLeader"))
		{

			list = this.getBaseDao().selectListByObject("Camera.getCameraListClassLeader", paramMap);
		}

		/**
		 * 校长或者学校管理员（全校所有）
		 */
		else if (commonService.hasAdminPermission(user))
		{

			list = this.getBaseDao().selectListByObject("Camera.getCameraList", paramMap);
		}
		/**
		 * 教职工（自己所在部门和校门等公共场所）
		 */
		else
		{

			list = this.getBaseDao().selectListByObject("Camera.getCameraListTeacher", paramMap);
		}
		
		return list;

	}
	/**
	 * 加载摄像头班级用户关系
	 * @param pageSize
	 * @param currentPage
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Pages getCameraClassUser(int pageSize, int page, Map<String, Object> paramMap)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		List<Camera> list = new ArrayList<Camera>();
		allRow = (Integer) this.getBaseDao().selectObjectByObject("Camera.getPagesCameraClazzUserCount", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);
		list = this.getBaseDao().selectListByObject("Camera.getPagesCameraClazzUser", paramMap);	
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
	public CameraRelation getCameraByClazzId(Map<String, Integer> paramMap) {
		return (CameraRelation) this.getBaseDao().selectObjectByObject("Camera.getCameraByClazzId", paramMap);
	}

	@Override
	public CameraRelation getCameraUserByUserId(Map<String, Integer> paramMap) {
		return (CameraRelation) this.getBaseDao().selectObjectByObject("Camera.getCameraUserByUserId", paramMap);
	}

	
}
