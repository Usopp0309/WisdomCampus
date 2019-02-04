package com.guotop.palmschool.camera.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.camera.entity.Camera;
import com.guotop.palmschool.camera.entity.CameraRelation;
import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.entity.Place;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;

/**
 * 视屏直播业务类
 * @author Administrator
 *
 */
public interface CameraService
{
	/**
	 * 获取地点列表（包含cameraList）
	 */
	public List<Place> getPlaceList(Integer userId,User user);
	
	/**
	 * 加载所有cameraList
	 * @param pageSize
	 * @param currentPage
	 * @param paramMap
	 * @return
	 */
	public Pages getCameraList(int pageSize, int page, Map<String,Object> paramMap);
	/**
	 * 加载摄像头班级用户关系
	 * @param pageSize
	 * @param currentPage
	 * @param paramMap
	 * @return
	 */
	public Pages getCameraClassUser(int pageSize, int page, Map<String,Object> paramMap);
	
	/**
	 * 添加设备
	 * @param camera
	 * @return
	 */
	public Integer addCamera(Camera camera);
	
	/**
	 * 修改设备
	 * @param camera
	 */
	public void modifyCamera(Camera camera);
	
	/**
	 * 删除设备
	 * @param cameraId
	 */
	public void deleteCamera(Integer cameraId);
	
	/**
	 * 根据cameraId查询对应的camera
	 * @param cameraId
	 * @return
	 */
	public Camera getCameraById(Integer cameraId);
	
	/**
	 * 校验设备编码是否存在(添加设备时)
	 * @param cameraCode
	 * @return
	 */
	public ResultInfo checkCameraCode(String cameraCode);
	
	/**
	 * 校验设备编码是否存在(修改设备时)
	 * @param cameraCode
	 * @return
	 */
	public ResultInfo checkCameraCodeByModify(Map<String,Object> paramMap);
	
	/**
	 * 根据类型加载对应的摄像头List
	 * @param type
	 * @return
	 */
	public List<Camera> getCameraListByType(Integer type);
	
	/**
	 * 添加摄像头和班级（或学生）的关系
	  @author chenyong
	  @date 2016年10月8日 上午9:56:16
	 * @param type 0 班级使用  1 表示需交费才可以查看 2全校
	 * @param cameraRelationList
	 */
	public void addCameraRelation(Integer type , List<CameraRelation> cameraRelationList);
	/**
	 * 添加摄像头和班级（或学生）的关系
	  @author chenyong
	  @date 2016年10月8日 上午9:56:16
	 * @param type 0 班级使用  1 表示需交费才可以查看 2全校
	 * @param cameraRelationList
	 */
	public void deleteCameraRelation(Integer type ,List<CameraRelation> cameraRelationList);
	
	/**
	 * 根据userId和roleCode获取对应的摄像头list
	 * @param userId 用户id
	 * @param roleCode 用户的角色
	 * @return
	 */
	public List<Camera> getAllCameraListByUserIdRoleCode(User user,Integer userId,String roleCode);
	
	public CameraRelation getCameraByClazzId(Map<String,Integer> paramMap);
	public CameraRelation getCameraUserByUserId(Map<String,Integer> paramMap);
}

