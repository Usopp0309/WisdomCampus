package com.guotop.palmschool.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.util.Pages;

@Service("clazzService")
public class ClazzServiceImpl extends BaseService implements ClazzService
{

	@Resource
	private CommonService commonService;
	/**
	 * 表单校验相关---begin
	 */

	/**
	 * 根据ID修改互信群组ID字段
	 * 
	 * @param id
	 * @param hxGroupId
	 */
	public void modifyHxGroupIdById(Integer id, String hxGroupId)
	{
		// TODO Auto-generated method stub
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("huxinId", hxGroupId);
		paramMap.put("id", id);
		getBaseDao().updateObject("Clazz.modifyGroupHxId", paramMap);
	}

	/**
	 * 表单校验相关---end
	 */

	/**
	 * 修改权限
	 **/
	public void modifyRoleByClazzId(Map<String, Object> paramMap)
	{
		getBaseDao().updateObject("UserRole.modifyRoleByClazzId", paramMap);
	}

	/**
	 * 修改权限
	 **/
	public void modifyRoleByUserId(Map<String, Object> paramMap)
	{
		getBaseDao().updateObject("UserRole.modifyRoleByUserId", paramMap);
	}

	/**
	 * 根据班级名称查找到班级bean
	 * 
	 * @param 班级名称
	 * @return 查找到的班级bean update by shengyinjiang 20151124
	 */
	public Clazz getClazzByNameAndGradeId(Map<String, Object> paramMap)
	{
		return (Clazz) getBaseDao().selectObjectByObject("Clazz.getClazzByNameAndGradeId", paramMap);
	}

	/**
	 * 增加班级
	 * 
	 * @param clazz
	 * @param userId
	 *            update by shengyinjiang 20151125
	 */
	public Integer addClazz(Clazz clazz)
	{
		Integer id = getBaseDao().addObject("Clazz.addClazz", clazz);
		return id;
	}

	/**
	 * 增加班级 for 福建
	 * @param clazz
	 * @param userId
	 * add by shengyinjiang 20161029
	 */
	public Integer addClazzForFJ(Clazz clazz){
		Integer id = getBaseDao().addObject("Clazz.addClazzForFJ", clazz);
		return id;
	}
	
	/**
	 * 班级修改 update by shengyinjiang 20151126
	 **/
	public void modifyClazzById(Map<String, Object> paramMa)
	{
		getBaseDao().updateObject("Clazz.modifyClazz", paramMa);
	}

	/**
	 * 修改班级信息时查看班级编号是否存在
	 * 
	 * @param map一个为原始班级编号
	 *            一个为修改的班级编号
	 * @return 返回值 update by shengyinjiang 20151126
	 */
	public ResultInfo checkClazzModifyByCode(Map<String, Object> paramMap)
	{

		Integer result = (Integer) getBaseDao().selectObjectByObject("Clazz.checkClazzModifyByCode", paramMap);
		ResultInfo resultInfo = new ResultInfo();
		if (ResultInfo.RESULT_EXISTS.equals(result))
		{
			resultInfo.setResultCode(ResultInfo.RESULT_SUCCESS);
		} else
		{
			resultInfo.setResultCode(ResultInfo.RESULT_ERROR);
		}
		return resultInfo;
	}

	/**
	 * 根据fjClazzId获取在智慧校园中的clazzId
	 * @param fjClazzId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Integer getClazzIdByFjClazzId(String fjClazzId,String clazzName){
		Map<String, Object> parmMap = new HashMap<String, Object>();
		parmMap.put("fjClazzId", fjClazzId);
		parmMap.put("clazzName", clazzName);
		List<Integer> clazzIdList = getBaseDao().selectListByObject("Clazz.getClazzIdByFjClazzId", parmMap);
		Integer clazzId = 0;
		if(CollectionUtils.isEmpty(clazzIdList)){
			clazzId = 0;
		}else{
			clazzId = clazzIdList.get(0);
		}
		return clazzId;
	}
	/**
	 * 加载班级列表 分页
	 * 
	 * @param pageSize
	 * @param page
	 * @param user
	 *            用户
	 * @param paramMap
	 *            参数map update by shengyinjiang 20151126
	 */
	@SuppressWarnings("unchecked")
	public Pages getClazzList(int pageSize, int page, User user, Map<String, Object> paramMap)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<Clazz> list = new ArrayList<Clazz>();

		boolean isAdmin = commonService.hasAdminPermission(user);
		if (isAdmin)
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("Clazz.getClazzList", paramMap);
		}else{
			allRow = this.getBaseDao().getAllRowCountByCondition("Clazz.getClazzListByUserIdAndPermissionCodeForClazzManager", paramMap);
		}
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		if (isAdmin)
		{
			list = this.getBaseDao().queryForPageByCondition("Clazz.getClazzList", paramMap, offset, length);
		}else{
			list = this.getBaseDao().queryForPageByCondition("Clazz.getClazzListByUserIdAndPermissionCodeForClazzManager", paramMap, offset, length);
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
	 * 查询条件查询班级记录 /分页查询【福建专用】
	 * @param paramMap 条件
	 * @return 班级记录/分页
	 * update by shengyinjiang 20151126
	 */
	@SuppressWarnings("unchecked")
	public Pages getClazzListFj(int pageSize, int page,User user,Map<String, Object> paramMap){
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<Clazz> list = new ArrayList<Clazz>();
		allRow = this.getBaseDao().getAllRowCountByCondition("Clazz.getClazzListFj", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		list = this.getBaseDao().queryForPageByCondition("Clazz.getClazzListFj", paramMap, offset, length);
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
	 * 查询条件查询班级记录
	 * 
	 * update by shengyinjiang 20151202
	 */
	@SuppressWarnings("unchecked")
	public List<Clazz> getClazzList()
	{
		return getBaseDao().selectListBySql("Clazz.getClazzList");
	}

	/**
	 * 根据年级ID查找到班级bean
	 * 
	 * @param clazzId
	 *            班级ID
	 * @return 查找到的班级bean update by shengyinjiang 20151126
	 */
	public Clazz getClazzById(Integer clazzId)
	{
		return (Clazz) getBaseDao().selectObjectByObject("Clazz.getClazzById", clazzId);
	}

	public String getClazzByIdInRICHBOOK(Integer clazzId)
	{
		return (String) getBaseDao().selectObjectByObject("Clazz.getClazzByIdInRICHBOOK", clazzId);
	}

	/**
	 * 添加班级时查看班级编号是否存在
	 * 
	 * @param code
	 *            班级编号
	 * @return 返回值
	 * 
	 *         update by shengyinjiang 20151129
	 */
	public ResultInfo checkClazzByCode(String code)
	{
		Integer result = (Integer) getBaseDao().selectObjectByObject("Clazz.checkClazzByCode", code);
		ResultInfo resultInfo = new ResultInfo();
		if (ResultInfo.RESULT_EXISTS.equals(result))
		{
			resultInfo.setResultCode(ResultInfo.RESULT_SUCCESS);
		} else
		{
			resultInfo.setResultCode(ResultInfo.RESULT_ERROR);
		}
		return resultInfo;
	}

	/**
	 * 添加班级时查看班级名称是否存在
	 * 
	 * @param code
	 *            班级编号
	 * @return 返回值
	 * 
	 *         update by shengyinjiang 20151129
	 */
	public ResultInfo checkClazzByClazzName(Map<String, Object> paramMa)
	{

		Integer result = (Integer) getBaseDao().selectObjectByObject("Clazz.checkClazzByClazzName", paramMa);
		ResultInfo resultInfo = new ResultInfo();
		if (ResultInfo.RESULT_EXISTS.equals(result))
		{
			resultInfo.setResultCode(ResultInfo.RESULT_SUCCESS);
		} else
		{
			resultInfo.setResultCode(ResultInfo.RESULT_ERROR);
		}
		return resultInfo;
	}
    
	/**
	 * 获取所有有班主任权限的人员列表
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<User> getAllClazzLeader()
	{
		return this.getBaseDao().selectListBySql("User.getClazzLeaderList");
	}

	@SuppressWarnings("unchecked")
	public List<User> getUserIdListByClazzId(Integer clazzId)
	{
		return getBaseDao().selectListByObject("Clazz.getUserIdListByClazzId", clazzId);
	}

	@SuppressWarnings("unchecked")
	public List<User> getParentListByClazzId(Integer clazzId)
	{
		return getBaseDao().selectListByObject("Clazz.getParentListByClazzId", clazzId);
	}
	
	/**
	 * 根据年级ID获取班级列表
	 * 
	 * @param gradeId
	 * @return 20160114tao
	 */
	@SuppressWarnings("unchecked")
	public List<Clazz> getClazzListByGradeId(Integer gradeId)
	{
		if (gradeId == 0)
		{
			return getBaseDao().selectListBySql("Clazz.getAllClazzList");
		} else
		{
			return getBaseDao().selectList("Clazz.getClazzListByGradeId", gradeId);
		}
	}
	/**
	 * 根据年级ID获取班级列表
	 * 
	 * @param gradeId
	 * @return 20160114tao
	 */
	@SuppressWarnings("unchecked")
	public List<Clazz> getClazzListByGradeId4App(Integer gradeId)
	{
		if (gradeId == 0)
		{
			return getBaseDao().selectListBySql("Clazz.getAllClazzList4App");
		} else
		{
			return getBaseDao().selectList("Clazz.getClazzListByGradeId4App", gradeId);
		}
	}
	/**
	 * 根据家长Id找出小孩的班级id
	 * 
	 * @param gradeId
	 * @return 20160409 SHENG
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Clazz> getClazzListByParentId(Integer parentId)
	{
		return getBaseDao().selectList("Clazz.getClazzListByParentId", parentId);
	}

	/**
	 * 根据学生Id找出班级id
	 * @param studentId
	 * @return  20160409 SHENG
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Clazz> getClazzListByStudentId(Integer studentId)
	{
		return getBaseDao().selectList("Clazz.getClazzListByStudentId", studentId);
	}
	
	public void updateOptClazzId2NullByClazzIdAndUserId(HashMap<String,Object> map)
	{
		getBaseDao().updateObject("UserPermission.updateOptClazzId2NullByClazzIdAndUserId", map);
	}
    /**
     * 根据班级获得年级信息
      @author chenyong
      @date 2016年8月30日 下午5:45:40
     * @param classId
     * @return
     */
	@Override
	public Clazz getGradeByClassId(Integer classId)
	{
		return (Clazz) getBaseDao().selectObjectByObject("Clazz.getGradeByClassId", classId);
	}

	/**
	 * 根据年级Id和roleCode获取班级列表 管理员 校长 查询所有的 班主任 其对应的班级
	 * 
	 * @param gradeId
	 *            roleCode
	 */
	@SuppressWarnings("unchecked")
	public List<Clazz> getClazzListByGradeIdAndUserIdAndRoleCode(Integer gradeId, String roleCode, Integer userId)
	{
		List<Clazz> list = new ArrayList<Clazz>();

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("gradeId", gradeId);
		paramMap.put("userId", userId);
		
		if (roleCode.equals("admin") || roleCode.equals("president") || roleCode.equals("chairman"))
		{
			list = getBaseDao().selectList("Clazz.getClazzListByGradeIdAsAdmin", gradeId);
		} else if (roleCode.equals("classLeader"))
		{
			list = getBaseDao().selectListByObject("Clazz.getClazzListByGradeIdAndUserIdAsClassLeader", paramMap);
		} else if (roleCode.equals("parent"))
		{
			list = getBaseDao().selectListByObject("Clazz.getClazzListByGradeIdAndUserIdAsParent", paramMap);
		} else if (roleCode.equals("student"))
		{
			list = getBaseDao().selectListByObject("Clazz.getClazzListByGradeIdAndUserIdAsStudent", paramMap);
		} else
		{
			list = getBaseDao().selectListByObject("Clazz.getClazzListByGradeIdAndUserIdAsTeacher", paramMap);
		}

		return list;

	}
    /**
     * 添加班级时查看班级名称是否存在
      @author chenyong
      @date 2016年10月12日 下午6:10:45
     * @param paramMa
     * @return
     */
	@SuppressWarnings("unchecked")
	@Override
	public List<Clazz> getClazzByClazzName(Map<String, Object> paramMa)
	{
		List<Clazz> clazzList =getBaseDao().selectListByObject("Clazz.getClazzByClazzName", paramMa);
		return clazzList;
	}
	
	/**
	 * 根据userId获取用户在userpermission中所有可以操作的班级
	 * @param userId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Clazz> getClazzListForSetPermission(Integer userId){
		return getBaseDao().selectListByObject("UserPermission.getOptClazzsByUserId",userId);
	}
	
	/**
	 * 通过年级idlist获取对应班级
	 * @param gradeIdsList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Clazz> getClazzListByGradeIdList(List<Integer> gradeIdList)
	{
		return (List<Clazz>) getBaseDao().selectListByObject("Clazz.getClazzListByGradeIdList", gradeIdList);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Clazz> getClazzListByUserIdAndPermissionCode(Map<String, Object> map) {
		return (List<Clazz>) getBaseDao().selectListByObject("Clazz.getClazzListByUserIdAndPermissionCode", map);
	}
	/**
	 * 修改学生的班级
	 * 
	 * @author chenyong
	 * @Time 2017年3月16日 上午10:17:10
	 */
	@Override
	public void updateClazzByUserId(Map<String, Object> map) {
		getBaseDao().updateObject("Clazz.updateClazzByUserId", map);	
	}
}
