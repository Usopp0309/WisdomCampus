package com.guotop.palmschool.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.UserDataChangeRecords;
import com.guotop.palmschool.entity.UserDataChangeRecordsDetail;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.UserDataChangeRecordsService;

/**
 * @author wangwei
 *
 */
@Service("userDataChangeRecordsService")
public class UserDataChangeRecordsServiceImpl extends BaseService implements UserDataChangeRecordsService
{

	@Override
	public Integer addUserOprateLog(UserDataChangeRecords userDataChangeRecords)
	{
		Integer id = getBaseDao().addObject("UserDataChangeRecords.save", userDataChangeRecords);
		return id;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<UserDataChangeRecords> getNoSyncByObjectId(Integer id)
	{
		return getBaseDao().selectListByObject("UserDataChangeRecords.findNoSyncByObjectId", id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UserDataChangeRecords> getAddNoSyncByObjectId(Integer id)
	{
		return getBaseDao().selectListByObject("UserDataChangeRecords.findAddNoSyncByObjectId", id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UserDataChangeRecords> getUpdateNoSyncByObjectId(Integer id)
	{
		return getBaseDao().selectListByObject("UserDataChangeRecords.findUpdateNoSyncByObjectId", id);
	}

	@Override
	public void deleteUserOprateLogById(Integer id)
	{
		getBaseDao().deleteObjectById("UserDataChangeRecords.delete", id);
	}
	@Override
	public void deleteDetailByRecordsId(Integer recordsId)
	{
		getBaseDao().deleteObjectById("UserDataChangeRecordsDetail.delete", recordsId);
	}

	@Override
	public void addDetail(UserDataChangeRecordsDetail userDataChangeRecordsDetail)
	{
		getBaseDao().addObject("UserDataChangeRecordsDetail.save", userDataChangeRecordsDetail);
	}

}
