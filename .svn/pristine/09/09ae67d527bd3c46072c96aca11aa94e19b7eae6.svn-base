package com.guotop.palmschool.service;

import java.util.List;

import com.guotop.palmschool.entity.UserDataChangeRecords;
import com.guotop.palmschool.entity.UserDataChangeRecordsDetail;

/**
 * 用户操作日志类接口
 *	@author wangwei
 */
public interface UserDataChangeRecordsService
{

	/**
	 * 增加用户操作日志
	 * @param userOprateLog
	 * @return
	 */
	Integer addUserOprateLog(UserDataChangeRecords userDataChangeRecords);
	/**
	 * 根据ObjectId查询未同步的add或update操作记录
	 * @param id
	 * @return
	 */
	List<UserDataChangeRecords> getNoSyncByObjectId(Integer id);
	/**
	 * 根据ObjectId查询未同步的add操作记录
	 * @param id
	 * @return
	 */
	List<UserDataChangeRecords> getAddNoSyncByObjectId(Integer id);
	/**
	 * 根据ObjectId查询未同步的update操作记录
	 * @param id
	 * @return
	 */
	List<UserDataChangeRecords> getUpdateNoSyncByObjectId(Integer id);
	/**
	 *	根据Id删除用户操作日志
	 * @param id
	 * @return
	 */
	void deleteUserOprateLogById(Integer id);
	/**
	 *	根据recordsId删除用户操作日志详情
	 * @param recordsId
	 * @return
	 */
	void deleteDetailByRecordsId(Integer recordsId);
	/**
	 * 增加用户操作日志详情
	 * @param userDataChangeRecordsDetail
	 * @return
	 */
	void addDetail(UserDataChangeRecordsDetail userDataChangeRecordsDetail);

}
