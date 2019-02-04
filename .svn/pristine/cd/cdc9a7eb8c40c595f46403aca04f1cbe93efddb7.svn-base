package com.guotop.palmschool.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.guotop.palmschool.entity.UserForwardsmsSwitch;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.UserForwardsmsSwitchService;

/**
 * 个人账户接口
 *
 */
@Service("userForwardsmsSwitchService")
public class UserForwardsmsSwitchServiceImpl extends BaseService implements UserForwardsmsSwitchService
{

	@Override
	public int addUserForwardsmsSwitch(UserForwardsmsSwitch userForwardsmsSwitch)
	{
		Integer id = getBaseDao().addObject("UserForwardsmsSwitch.addUserForwardsmsSwitch", userForwardsmsSwitch);
		return id;
	}

	@SuppressWarnings("unchecked")
	@Override
	public UserForwardsmsSwitch findUserForwardsmsSwitch(Integer userId)
	{
		UserForwardsmsSwitch userForwardsmsSwitch = null;
		List<UserForwardsmsSwitch> userForwardsmsSwitchList = (List<UserForwardsmsSwitch>) getBaseDao().selectListByObject("UserForwardsmsSwitch.getUserForwardsmsSwitch", userId);
		if ((!CollectionUtils.isEmpty(userForwardsmsSwitchList)) && userForwardsmsSwitchList.size() > 0)
		{
			userForwardsmsSwitch = userForwardsmsSwitchList.get(0);
		}else{
			userForwardsmsSwitch = new UserForwardsmsSwitch();
			userForwardsmsSwitch.setForwardPushStatus(1);
			userForwardsmsSwitch.setForwardSmsStatus(1);
			userForwardsmsSwitch.setUserId(userId);
			int id = addUserForwardsmsSwitch(userForwardsmsSwitch);
			userForwardsmsSwitch.setId(id);
		}
		return userForwardsmsSwitch;
	}
}
