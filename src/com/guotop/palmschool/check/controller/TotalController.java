package com.guotop.palmschool.check.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.check.service.TotalService;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;

/**
 * 考勤统计控制类
 * 
 * @author zhou
 */
@RequestMapping("/total")
@Controller
public class TotalController extends BaseController
{
	@Resource
	private CommonService commonService;

	@Resource
	private TotalService totalService;

	/**
	 * 考勤统计---begin
	 */
	/**
	 * 进入考勤统计页面
	 */
	@RequestMapping(value = "/toCheckCount.do")
	public String toCheckCount()
	{
		return "check/check_count";
	}

	/**
	 * 不同权限查看到不同的page 加载考勤统计list
	 */
	@RequestMapping(value = "/loadTotalCheckList.do")
	public String loadTotalCheckList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		try
		{
			/**
			 * 接收页面请求参数---begin
			 */
			Integer roleId = Integer.valueOf(request.getParameter("roleId"));

			/**
			 * 分页信息
			 */
			Integer currentPage = 1;

			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			/**
			 * 人员类型，1:教师，2:学生
			 */
			Integer userType = null;
			try
			{
				userType = Integer.valueOf(request.getParameter("userType"));
				if (-1 == userType)
				{
					userType = null;
				}
			} catch (Exception e)
			{
				userType = null;
			}

			/**
			 * 统计类别，0:全校，1:年级，2:班级，3:个人
			 */
			Integer type = null;
			try
			{
				type = Integer.valueOf(request.getParameter("type"));
				if (-1 == type)
				{
					type = null;
				}
			} catch (Exception e)
			{
				type = null;
			}

			/**
			 * 统计类型，0:月，1:周，2:日
			 */
			Integer periodType = null;
			try
			{
				periodType = Integer
						.valueOf(request.getParameter("periodType"));
				if (-1 == periodType)
				{
					periodType = null;
				}
			} catch (Exception e)
			{
				periodType = null;
			}

			/**
			 * 编号，type=0时为学校编号，type=1时为学校编号，type=2时为班号，3时为工号或学号
			 */
			String code = request.getParameter("code");

			String name = request.getParameter("name");

			User user = (User) session.getAttribute("user");

			/**
			 * 名称，参照code，对应的名称
			 */

			paramMap.put("userType", userType);
			paramMap.put("type", type);
			paramMap.put("periodType", periodType);
			paramMap.put("code", code);
			paramMap.put("name", name);
			paramMap.put("clazzId", user.getClazzId());
			/**
			 * 接收页面请求参数---end
			 */

			Pages pages = totalService.loadTotalCheckList(this.getPages()
					.getPageSize(), currentPage, paramMap, user, roleId);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 考勤统计---end
	 */
}
