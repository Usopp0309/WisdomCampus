package com.guotop.palmschool.rest.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.SmsService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.StringUtil;
import com.richx.pojo.RichHttpResponse;
import common.Logger;

import dev.gson.GsonHelper;

@RequestMapping("/verify")
@Controller
public class VerifyCardAndPersonController extends BaseController
{
	private Logger log = Logger.getLogger(VerifyCardAndPersonController.class);
	@Resource
	private UserService userService;

	@Resource
	private SmsService smsService;

	/**
	 * 校园一体机 上传头像前调用接口，用于验证卡和人的关系 本人登陆的能
	 */
	@RequestMapping(value = "/verifyCardAndPerson.do")
	public String verifyCardAndPerson(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		RichHttpResponse<Boolean> richHttpResponse = new RichHttpResponse<Boolean>();
		response.setHeader("Content-type", "application/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		try
		{
			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");
			String cardCode = request.getParameter("cardCode");
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				//通过卡号查找对应的人员
				if (!StringUtil.isEmpty(cardCode))
				{
					//获取卡号对应的人
					User user = userService.getUserInfoByCardCode(cardCode);
					if (user != null)
					{
						//如果登陆用户和卡号查找出来的人的id是一样的，就是本人在操作。
						if(user.getUserId().intValue() == loginUser.getUserId().intValue()){
							richHttpResponse.ResponseCode = 0;
							richHttpResponse.ResponseResult = "判断成功";
							richHttpResponse.ResponseObject = true;
						}else{
							//不是的情况下，需要验证两者是不是有对应的关系
							Integer loginId = loginUser.getUserId();
							Integer cardId = user.getUserId();
							Integer id = userService.getIdByStudentIdAndParentId(cardId,loginId);
							if(id == null){
								richHttpResponse.ResponseCode = -2;
								richHttpResponse.ResponseResult = "输入的卡号你不能操作";
								richHttpResponse.ResponseObject = false;
							}else{
								richHttpResponse.ResponseCode = 0;
								richHttpResponse.ResponseResult = "判断成功";
								richHttpResponse.ResponseObject = true;
							}
						}
					}else
					{
						richHttpResponse.ResponseCode = -3;
						richHttpResponse.ResponseResult = "输入的卡号不存在对应的用户";
						richHttpResponse.ResponseObject = false;
					}
				}else{
					richHttpResponse.ResponseCode = -4;
					richHttpResponse.ResponseResult = "输入的卡号为空";
					richHttpResponse.ResponseObject = false;
				}
			} else
			{
				richHttpResponse.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				richHttpResponse.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				richHttpResponse.ResponseObject = false;

				String json = GsonHelper.toJson(richHttpResponse);
				response.getWriter().write(json);
				response.getWriter().flush();
				return null;
			}
			String json = GsonHelper.toJson(richHttpResponse);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			log.error(e);
		}
		return null;
	}

}
