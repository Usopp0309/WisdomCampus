package com.guotop.palmschool.dormitory.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.dormitory.entity.DormitoryAbnormal;
import com.guotop.palmschool.dormitory.entity.InoutDormitory;
import com.guotop.palmschool.dormitory.service.DormitoryService;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.WebWriteFile;

/**
 * 宿舍管理控制类
 * 
 * @author zhou
 */
@RequestMapping("/dormitory")
@Controller
public class DormitoryController extends BaseController
{
	@Resource
	private CommonService commonService;

	@Resource
	private DormitoryService dormitoryService;

	@Resource
	private UserService userService;

	/**
	 * 进入进出宿舍页面
	 */
	@RequestMapping(value = "/toDormitoryInoutList.do")
	public String toDormitoryInoutList()
	{
		return "dormitory/dormitory_inout_list";
	}

	/**
	 * 进入进出宿舍异常页面
	 */
	@RequestMapping(value = "/toDormitoryAbnormalDetailList.do")
	public String toDormitoryAbnormalDetailList()
	{
		return "dormitory/dormitor_abnormal_list";
	}

	/**
	 * 不同权限查看到不同的page 加载进出宿舍列表 加载进出宿舍list 20151204
	 */
	@RequestMapping(value = "/loadDormitoryInoutList.do")
	public String loadDormitoryInoutList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		try
		{

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
			/*
			 * 师生类型
			 */

			Integer type = Integer.valueOf(request.getParameter("type"));

			/**
			 * 进出状态
			 */
			Integer inoutType = 0;
			try
			{
				inoutType = Integer.valueOf(request.getParameter("inoutType"));
				/**
				 * 全部即不设进出类型
				 */
				if (Cons.TCHSTUTYPE_ALL.equals(inoutType))
				{
					inoutType = null;
				}
			} catch (Exception e)
			{
				inoutType = null;
			}

			// 查询内容
			String queryContent = null;

			try
			{
				queryContent = request.getParameter("queryContent");
			} catch (Exception e)
			{
				queryContent = null;
			}

			// 开始时间
			String startTime = null;
			try
			{
				startTime = request.getParameter("startTime");
			} catch (Exception e)
			{
				startTime = null;
			}

			// 结束时间
			String endTime = null;
			try
			{
				endTime = request.getParameter("endTime");
			} catch (Exception e)
			{
				endTime = null;
			}

			User user = (User) session.getAttribute("user");

			String roleCode = request.getParameter("roleCode");

			paramMap.put("userId", user.getUserId());
			paramMap.put("roleCode", roleCode);
			paramMap.put("type", type);
			paramMap.put("inoutType", inoutType);
			paramMap.put("queryContent", queryContent);
			paramMap.put("startTime", startTime);
			paramMap.put("endTime", endTime);

			/**
			 * 获取分页数据
			 */
			this.getPages().setPageSize(50);

			/**
			 * 获取分页数据
			 */
			Pages pages = dormitoryService.getDormitoryInoutList(this.getPages().getPageSize(), currentPage, paramMap, user);
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
	 * 不同权限查看到不同的page 加载进出宿舍异常列表 加载进出宿舍list 20151207
	 */
	@RequestMapping(value = "/loadDormitorAbnormalList.do")
	public String loadDormitorAbnormalList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		/**
		 * 00:00:00
		 */
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, 0); // 时
		cal.set(Calendar.MINUTE, 0); // 分
		cal.set(Calendar.SECOND, 0); // 秒
		cal.set(Calendar.MILLISECOND, 0); // 毫秒
		String todayBegin = formatter.format(cal.getTime());

		/**
		 * 23:59:59
		 */
		cal.set(Calendar.HOUR_OF_DAY, 23); // 时
		cal.set(Calendar.MINUTE, 59); // 分
		cal.set(Calendar.SECOND, 59); // 秒
		cal.set(Calendar.MILLISECOND, 0); // 毫秒
		String todayEnd = formatter.format(cal.getTime());

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		try
		{
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");

			if (null == startTime || "".equals(startTime))
			{
				startTime = todayBegin;
			}
			if (null == endTime || "".equals(endTime))
			{
				endTime = todayEnd;
			}

			String queryContent = request.getParameter("queryContent");

			String type = request.getParameter("type");

			/**
			 * 查询
			 */
			String clazzList = null;
			try
			{
				clazzList = request.getParameter("clazzId");
			} catch (Exception e)
			{
				clazzList = null;
			}

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

			User user = (User) session.getAttribute("user");

			String roleCode = request.getParameter("roleCode");

			paramMap.put("userId", user.getUserId());
			paramMap.put("roleCode", roleCode);
			paramMap.put("queryContent", queryContent);
			paramMap.put("startTime", startTime);
			paramMap.put("endTime", endTime);

			paramMap.put("clazzList", clazzList);

			Pages pages = null;

			/* 出宿舍已刷卡 */
			if (type.equals("1"))
			{
				// 获取分页数据
				pages = dormitoryService.getOutSwingCard(this.getPages().getPageSize(), currentPage, paramMap, user);
			}
			/* 出宿舍未刷卡 */
			else if (type.equals("2"))
			{
				// 获取分页数据
				pages = dormitoryService.getOutNoSwingCard(this.getPages().getPageSize(), currentPage, paramMap, user);
			}
			/* 进宿舍已刷卡 */
			else if (type.equals("3"))
			{
				// 获取分页数据
				pages = dormitoryService.getInSwingCard(this.getPages().getPageSize(), currentPage, paramMap, user);
			}
			/* 进宿舍未刷卡 */
			else if (type.equals("4"))
			{
				// 获取分页数据
				pages = dormitoryService.getInNoSwingCard(this.getPages().getPageSize(), currentPage, paramMap, user);
			}

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
	 * 加载报表详细数据
	 */
	@RequestMapping(value = "/loadDetailData.do")
	public String loadDetailData(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());

		User user = (User) session.getAttribute("user");
		String roleCode = request.getParameter("roleId");

		String time = "";
		Integer type = Cons.DORMITORY_IN;

		try
		{

			time = request.getParameter("time");
			if (null == time || "".equals(time))
			{
				time = today;
			}

			try
			{
				type = Integer.valueOf(request.getParameter("type"));
			} catch (Exception e)
			{
				type = Cons.DORMITORY_IN;
			}

			String gradeName = request.getParameter("gradeName");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("time", time);
			paramMap.put("type", type);
			paramMap.put("gradeId", user.getGradeId());
			paramMap.put("clazzId", user.getClazzId());
			paramMap.put("gradeName", gradeName);
			List<DormitoryAbnormal> dormitoryAbnormalList = dormitoryService.loadDetailData(paramMap, roleCode);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(dormitoryAbnormalList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 导出查询宿舍进出记录
	 */
	@RequestMapping(value = "/doExportExcel.do")
	public void doExportExcel(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try
		{
			Map<String, Object> paramMap = new HashMap<String, Object>();
			/**
			 * 初始化excel各项参数---begin
			 */
			// 创建Excel的工作书册 Workbook,对应到一个excel文档
			HSSFWorkbook wb = new HSSFWorkbook();

			// 创建Excel的工作sheet,对应到一个excel文档的tab
			HSSFSheet sheet = wb.createSheet("进出宿舍记录");

			// 创建字体样式
			HSSFFont font = wb.createFont();

			// 创建单元格样式
			HSSFCellStyle style = wb.createCellStyle();

			WebWriteFile.getInstance().init(wb, sheet, font, style);
			/**
			 * 初始化excel各项参数---end
			 */
			HSSFRow row = sheet.createRow(0);
			row.setHeight((short) 500);// 设定行的高度
			// 创建一个Excel的单元格
			HSSFCell cell = row.createCell(0);
			// 给Excel的单元格设置样式和赋值
			cell.setCellValue("卡号");

			style.setWrapText(true);
			cell = row.createCell(1);
			cell.setCellValue("拥有者");

			style.setWrapText(true);
			cell = row.createCell(2);
			cell.setCellValue("进出状态");

			style.setWrapText(true);
			cell = row.createCell(3);
			cell.setCellValue("电池状态");

			style.setWrapText(true);
			cell = row.createCell(4);
			cell.setCellValue("地点");

			style.setWrapText(true);
			cell = row.createCell(5);
			cell.setCellValue("创建时间");

			/**
			 * 页面加载数据---begin
			 */
			/**
			 * 师生类型
			 */
			Integer type = 0;
			try
			{
				type = Integer.valueOf(request.getParameter("type"));
				/**
				 * 全部即不设师生类型
				 */
				if (Cons.TCHSTUTYPE_ALL.equals(type))
				{
					type = null;
				}
			} catch (Exception e)
			{
				type = null;
			}

			// 获取页面请求参数
			// 卡号
			// String code = request.getParameter("code");

			// 持有者
			// String name = request.getParameter("name");

			// 地点
			// String position = request.getParameter("position");

			User user = (User) session.getAttribute("user");

			paramMap.put("userId", user.getId());
			paramMap.put("schoolId", user.getSchoolId());
			// System.out.println(user.getName());
			paramMap.put("clazzId", user.getClazzId());
			paramMap.put("type", type);
			paramMap.put("gradeId", user.getGradeId());
			// paramMap.put("code", code);
			// paramMap.put("name", name);
			// paramMap.put("position", position);
			paramMap.put("userId", user.getId());

			List<InoutDormitory> InoutDormitoryList = dormitoryService.loadInoutDormitoryListForExport(paramMap, 0);
			/**
			 * 页面数据加载---end
			 */

			/**
			 * 将数据写入excel中---begin
			 */
			int i = 1;
			for (InoutDormitory inoutDormitory : InoutDormitoryList)
			{
				row = sheet.createRow(i);
				row.setHeight((short) 500);// 设定行的高度
				// 创建一个Excel的单元格
				cell = row.createCell(0);
				// 给Excel的单元格设置样式和赋值
				cell.setCellValue(inoutDormitory.getCode());

				style.setWrapText(true);
				cell = row.createCell(1);
				cell.setCellValue(inoutDormitory.getRealName());

				style.setWrapText(true);
				cell = row.createCell(2);
				switch (inoutDormitory.getStatus())
				{
				case 0:
					cell.setCellValue("进");
					break;
				case 1:
					cell.setCellValue("进");
					break;
				case 2:
					cell.setCellValue("出");
					break;
				default:
					cell.setCellValue("进");
					break;
				}

				style.setWrapText(true);
				cell = row.createCell(3);

				style.setWrapText(true);
				cell = row.createCell(4);
				cell.setCellValue(inoutDormitory.getPositionName());

				style.setWrapText(true);
				cell = row.createCell(5);
				cell.setCellValue(inoutDormitory.getCreateTime());
				i++;
			}
			/**
			 * 将数据写入excel中---end
			 */

			/**
			 * 磁盘创建文件并生出输出流
			 */
			File file = new File("D:\\report\\" + new Date().getTime() + ".xls");
			FileOutputStream os = new FileOutputStream(file);
			wb.write(os);
			os.close();

			WebWriteFile.getInstance().write(file, response, "进出宿舍记录.xls");
			file.delete();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * 导出查询宿舍进出记录
	 */
	@RequestMapping(value = "/doExportExcelAsDormitorAbnormal.do")
	public void doExportExcelAsDormitorAbnormal(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try
		{
			Map<String, Object> paramMap = new HashMap<String, Object>();
			/**
			 * 初始化excel各项参数---begin
			 */
			// 创建Excel的工作书册 Workbook,对应到一个excel文档
			HSSFWorkbook wb = new HSSFWorkbook();

			// 创建Excel的工作sheet,对应到一个excel文档的tab
			HSSFSheet sheet = wb.createSheet("进出宿舍异常记录");

			// 创建字体样式
			HSSFFont font = wb.createFont();

			// 创建单元格样式
			HSSFCellStyle style = wb.createCellStyle();

			WebWriteFile.getInstance().init(wb, sheet, font, style);
			/**
			 * 初始化excel各项参数---end
			 */
			HSSFRow row = sheet.createRow(0);
			row.setHeight((short) 500);// 设定行的高度
			// 创建一个Excel的单元格
			HSSFCell cell = row.createCell(0);
			// 给Excel的单元格设置样式和赋值
			cell.setCellValue("持有者");

			style.setWrapText(true);
			cell = row.createCell(1);
			cell.setCellValue("类型");

			style.setWrapText(true);
			cell = row.createCell(2);
			cell.setCellValue("短信内容");

			style.setWrapText(true);
			cell = row.createCell(3);
			cell.setCellValue("创建时间");

			/**
			 * 页面加载数据---begin
			 */

			/**
			 * 师生类型
			 */
			Integer type = 0;
			try
			{
				type = Integer.valueOf(request.getParameter("type"));
				/**
				 * 全部即不设师生类型
				 */
				if (Cons.TCHSTUTYPE_ALL.equals(type))
				{
					type = null;
				}
			} catch (Exception e)
			{
				type = null;
			}

			// /String message = request.getParameter("message");
			// String time = request.getParameter("time");
			// String name = request.getParameter("name");
			// String typeAbnorma = request.getParameter("typeAbnorma");
			// String userName = request.getParameter("name");

			User user = (User) session.getAttribute("user");
			paramMap.put("userId", user.getUserId());
			paramMap.put("schoolId", user.getSchoolId());
			// System.out.println(user.getName());
			paramMap.put("clazzId", user.getClazzId());
			paramMap.put("type", type);
			paramMap.put("gradeId", user.getGradeId());
			// paramMap.put("message", message);
			// paramMap.put("createtime", time);
			// paramMap.put("name", name);
			// paramMap.put("typeAbnorma", typeAbnorma);
			// paramMap.put("userName", userName);
			// paramMap.put("userId", user.getId());

			List<InoutDormitory> InoutDormitoryList = dormitoryService.loadDormitorAbnormalListForExport(paramMap, 0);
			/**
			 * 页面数据加载---end
			 */

			/**
			 * 将数据写入excel中---begin
			 */
			int i = 1;
			for (InoutDormitory inoutDormitory : InoutDormitoryList)
			{
				row = sheet.createRow(i);
				row.setHeight((short) 500);// 设定行的高度
				// 创建一个Excel的单元格
				cell = row.createCell(0);
				// 给Excel的单元格设置样式和赋值
				cell.setCellValue(inoutDormitory.getRealName());

				/*
				 * style.setWrapText(true); cell = row.createCell(1);
				 * cell.setCellValue(inoutDormitory.getType());
				 */

				style.setWrapText(true);
				cell = row.createCell(1);
				switch (inoutDormitory.getType())
				{
				case 0:
					cell.setCellValue("回宿舍异常");
					break;
				case 1:
					cell.setCellValue("出宿舍异常");
					break;
				default:
					cell.setCellValue("未知异常");
					break;
				}

				style.setWrapText(true);
				cell = row.createCell(2);
				cell.setCellValue(inoutDormitory.getMessage());

				style.setWrapText(true);
				cell = row.createCell(3);
				cell.setCellValue(inoutDormitory.getCreateTime());

				i++;
			}
			/**
			 * 将数据写入excel中---end
			 */

			/**
			 * 磁盘创建文件并生出输出流
			 */
			File file = new File("D:\\report\\" + new Date().getTime() + ".xls");
			FileOutputStream os = new FileOutputStream(file);
			wb.write(os);
			os.close();

			WebWriteFile.getInstance().write(file, response, "进出宿舍异常记录.xls");
			file.delete();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	/* 手机端begin */

	@RequestMapping(value = "/toDormitoryInoutListByHuxinId.do")
	public String toDormitoryInoutListByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		User user = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);

		if (user == null)
		{
			user = (User) session.getAttribute("user");

			if (user != null)
			{
				modelMap.addAttribute("apiKeyTimeOut", "2");
			} else
			{
				modelMap.addAttribute("apiKeyTimeOut", "1");
				return "app/dormitory/dormitory_inout_list_app";
			}
		} else
		{
			
			modelMap.addAttribute("apiKeyTimeOut", "2");
		}

		/*
		 * 存session
		 */
		session.setAttribute("user", user);
		
		DBContextHolder.setDBType(user.getSchoolId());

		/*
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		/*
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

		String roleCode = request.getParameter("roleCode");

		if (roleCode == null || roleCode.equals(""))
		{
			roleCode = user.getRoleList().get(0).getRoleCode();
		}

		/*
		 * 师生类型
		 */
		String typeName = request.getParameter("type");

		Integer type = 0;
		if (typeName == null || typeName.equals(""))
		{
			if (roleCode.equals("parent") || roleCode.equals("student"))
			{
				type = 2;
			} else
			{
				type = 1;
			}
		} else if (typeName.equals("teacher") || typeName.equals("1"))
		{
			type = 1;
		} else if (typeName.equals("student") || typeName.equals("2"))
		{
			type = 2;

		} else if (typeName.equals("parent") || typeName.equals("3"))
		{
			type = 3;
		}

		/*
		 * 进出状态
		 */
		Integer inoutType = 0;
		String inout = request.getParameter("inoutType");

		if (inout == null || inout.equals(""))
		{
			inoutType = null;
		} else if (inout.equals("in") || inout.equals("1"))
		{
			inoutType = 1;
		} else
		{
			inoutType = 2;
		}

		// 查询内容
		String queryContent = null;

		try
		{
			queryContent = request.getParameter("queryContent");
		} catch (Exception e)
		{
			queryContent = null;
		}

		// 开始日期
		String startDate = null;
		// 开始时间
		String startTime = null;
		String start = null;
		try
		{
			startDate = request.getParameter("startDate");
			startTime = request.getParameter("startTime");
			if (!StringUtil.isEmpty(startDate))
			{
				start = startDate + " " + startTime + ":00";
			}
		} catch (Exception e)
		{
			startTime = null;
		}

		// 结束日期
		String endDate = null;
		// 结束时间
		String endTime = null;
		String end = null;
		try
		{
			endDate = request.getParameter("endDate");
			endTime = request.getParameter("endTime");
			if (!StringUtil.isEmpty(endDate))
			{
				end = endDate + " " + endTime + ":00";
			}
		} catch (Exception e)
		{
			endTime = null;
			endDate = null;
		}

		paramMap.put("userId", user.getUserId());
		paramMap.put("roleCode", roleCode);
		paramMap.put("type", type);
		paramMap.put("inoutType", inoutType);
		paramMap.put("queryContent", queryContent);
		paramMap.put("startTime", start);
		paramMap.put("endTime", end);

		this.getPages().setPageSize(20);

		/**
		 * 获取分页数据
		 */
		List<InoutDormitory> list = dormitoryService.getDormitoryInoutListApp(this.getPages().getPageSize(), currentPage, paramMap, user);
		currentPage = currentPage + 1;
		modelMap.addAttribute("roleList", user.getRoleList());
		modelMap.addAttribute("roleListSize", user.getRoleList().size());
		modelMap.addAttribute("dormitoryList", list);
		modelMap.addAttribute("listSize", list.size());
		modelMap.addAttribute("roleCode", roleCode);
		modelMap.addAttribute("cPage", currentPage);
		modelMap.addAttribute("inoutType", inoutType);
		modelMap.addAttribute("type", type);
		modelMap.addAttribute("queryContent", queryContent);
		modelMap.addAttribute("startDate", startDate);
		modelMap.addAttribute("startTime", startTime);
		modelMap.addAttribute("endDate", endDate);
		modelMap.addAttribute("endTime", endTime);

		return "app/dormitory/dormitory_inout_list_app";

	}

	/**
	 * 加载进出记录页面（APP）
	 */
	@RequestMapping(value = "/toLoadDormitoryInoutListByHuxinId.do")
	public String toLoadDormitoryInoutListByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");
		try
		{
			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");

			/*
			 * 参数map
			 */
			Map<String, Object> paramMap = new HashMap<String, Object>();

			/*
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

			/*
			 * 师生类型
			 */
			String typeName = request.getParameter("type");
			Integer type = 0;
			if (typeName == null || typeName.equals(""))
			{
				type = 1;
			} else if (typeName.equals("teacher") || typeName.equals("1"))
			{
				type = 1;
			} else if (typeName.equals("student") || typeName.equals("2"))
			{
				type = 2;

			} else if (typeName.equals("parent") || typeName.equals("3"))
			{
				type = 3;
			}
			/*
			 * 进出状态
			 */
			Integer inoutType = 0;
			String inout = request.getParameter("inoutType");

			if (inout == null || inout.equals(""))
			{
				inoutType = null;
			} else if (inout.equals("in") || inout.equals("1"))
			{
				inoutType = 1;
			} else
			{
				inoutType = 2;
			}

			// 查询内容
			String queryContent = null;

			try
			{
				queryContent = request.getParameter("queryContent");
			} catch (Exception e)
			{
				queryContent = null;
			}

			// 开始日期
			String startDate = null;
			// 开始时间
			String startTime = null;
			String start = null;
			try
			{
				startDate = request.getParameter("startDate");
				startTime = request.getParameter("startTime");
				if (!StringUtil.isEmpty(startDate))
				{
					start = startDate + " " + startTime + ":00";
				}
			} catch (Exception e)
			{
				startTime = null;
			}

			// 结束日期
			String endDate = null;
			// 结束时间
			String endTime = null;
			String end = null;
			try
			{
				endDate = request.getParameter("endDate");
				endTime = request.getParameter("endTime");
				if (!StringUtil.isEmpty(endDate))
				{
					end = endDate + " " + endTime + ":00";
				}
			} catch (Exception e)
			{
				endTime = null;
				endDate = null;
			}

			User user = (User) session.getAttribute("user");

			String roleCode = request.getParameter("roleCode");

			paramMap.put("userId", user.getUserId());
			paramMap.put("roleCode", roleCode);
			paramMap.put("type", type);
			paramMap.put("inoutType", inoutType);
			paramMap.put("queryContent", queryContent);
			paramMap.put("startTime", start);
			paramMap.put("endTime", end);

			this.getPages().setPageSize(20);

			List<InoutDormitory> list = dormitoryService.getDormitoryInoutListApp(this.getPages().getPageSize(), currentPage, paramMap, user);

			currentPage = currentPage + 1;

			modelMap.addAttribute("schoolId", schoolId);
			modelMap.addAttribute("apiKey", apiKey);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("inoutType", inoutType);
			modelMap.addAttribute("type", type);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("startDate", startDate);
			modelMap.addAttribute("startTime", startTime);
			modelMap.addAttribute("endDate", endDate);
			modelMap.addAttribute("endTime", endTime);
			modelMap.addAttribute("dormitoryList", list);
			modelMap.addAttribute("listSize", list.size());
			modelMap.addAttribute("roleCode", roleCode);

			Gson gson = new Gson();
			String json = gson.toJson(modelMap);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 进入宿管异常页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/toDormitoryAbnormalDetailListByHuxinId.do")
	public String toDormitoryAbnormalDetailListByHuxinId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");

		response.setCharacterEncoding("UTF-8");

		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);

		String path = null;

		if (loginUser != null)
		{
			/*
			 * 存session
			 */
			session.setAttribute("user", loginUser);
			
			DBContextHolder.setDBType(loginUser.getSchoolId());

			List<Permission> permissionList = loginUser.getPermissionList();
			for (Permission permission : permissionList)
			{
				if ("dormitoryAbnormalManager".equals(permission.getPermissionCode()) || "admin".equals(permission.getPermissionCode()))
				{
					path = "app/dormitory/dormitory_abnormal_list_app";
					break;
				}
			}

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			/**
			 * 00:00:00
			 */
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.HOUR_OF_DAY, 0); // 时
			cal.set(Calendar.MINUTE, 0); // 分
			cal.set(Calendar.SECOND, 0); // 秒
			cal.set(Calendar.MILLISECOND, 0); // 毫秒
			String todayBegin = formatter.format(cal.getTime());

			/**
			 * 23:59:59
			 */
			cal.set(Calendar.HOUR_OF_DAY, 23); // 时
			cal.set(Calendar.MINUTE, 59); // 分
			cal.set(Calendar.SECOND, 59); // 秒
			cal.set(Calendar.MILLISECOND, 0); // 毫秒
			String todayEnd = formatter.format(cal.getTime());

			/**
			 * 参数map
			 */
			Map<String, Object> paramMap = new HashMap<String, Object>();

			try
			{

				String queryContent = request.getParameter("queryContent");

				String type = request.getParameter("type");

				if (type == null || type.equals(""))
				{
					type = "1";
				}

				/**
				 * 查询
				 */
				String clazzList = null;
				try
				{
					clazzList = request.getParameter("clazzId");
				} catch (Exception e)
				{
					clazzList = null;
				}

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

				User user = (User) session.getAttribute("user");

				String roleCode = request.getParameter("roleCode");

				if (roleCode == null || roleCode.equals(""))
				{
					roleCode = loginUser.getRoleList().get(0).getRoleCode();
				}

				// 开始日期
				String startDate = null;
				// 开始时间
				String startTime = null;
				String start = null;
				try
				{
					startDate = request.getParameter("startDate");
					startTime = request.getParameter("startTime");
					if (StringUtil.isEmpty(startDate))
					{
						start = todayBegin;
					} else
					{
						start = startDate + " " + startTime + ":00";
					}
				} catch (Exception e)
				{
					startTime = null;
				}

				// 结束日期
				String endDate = null;
				// 结束时间
				String endTime = null;
				String end = null;
				try
				{
					endDate = request.getParameter("endDate");
					endTime = request.getParameter("endTime");
					if (StringUtil.isEmpty(endDate))
					{
						end = todayEnd;
					} else
					{
						end = endDate + " " + endTime + ":00";
					}
				} catch (Exception e)
				{
					endTime = null;
					endDate = null;
				}

				paramMap.put("userId", user.getUserId());
				paramMap.put("roleCode", roleCode);
				paramMap.put("queryContent", queryContent);
				paramMap.put("startTime", start);
				paramMap.put("endTime", end);

				paramMap.put("clazzList", clazzList);

				List<InoutDormitory> list = null;

				/* 出宿舍已刷卡 */
				if (type.equals("1"))
				{
					// 获取分页数据
					list = dormitoryService.getOutSwingCardAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
				}
				/* 出宿舍未刷卡 */
				else if (type.equals("2"))
				{
					// 获取分页数据
					list = dormitoryService.getOutNoSwingCardAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
				}
				/* 进宿舍已刷卡 */
				else if (type.equals("3"))
				{
					// 获取分页数据
					list = dormitoryService.getInSwingCardAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
				}
				/* 进宿舍未刷卡 */
				else if (type.equals("4"))
				{
					// 获取分页数据
					list = dormitoryService.getInNoSwingCardAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
				}

				currentPage = currentPage + 1;
				modelMap.addAttribute("schoolId", schoolId);
				modelMap.addAttribute("apiKey", apiKey);
				modelMap.addAttribute("cPage", currentPage);
				modelMap.addAttribute("list", list);
				modelMap.addAttribute("listSize", list.size());
				modelMap.addAttribute("roleCode", roleCode);
				modelMap.addAttribute("roleListSize", loginUser.getRoleList().size());
				modelMap.addAttribute("type", type);
				modelMap.addAttribute("queryContent", queryContent);
				modelMap.addAttribute("startTime", startTime);
				modelMap.addAttribute("endTime", endTime);
				modelMap.addAttribute("startDate", startDate);
				modelMap.addAttribute("endDate", endDate);
				modelMap.addAttribute("clazzList", clazzList);

			} catch (Exception e)
			{
				e.printStackTrace();
			}

			modelMap.addAttribute("apiKeyTimeOut", "2");
		} else
		{
			modelMap.addAttribute("apiKeyTimeOut", "1");
			return "app/dormitory/dormitory_abnormal_list_app";
		}

		return path;
	}

	/**
	 * 加载宿舍异常页面（APP）
	 */
	@RequestMapping(value = "/toLoadDormitoryAbnormalDetailListAPP.do")
	public String toLoadDormitoryAbnormalDetailList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		response.setCharacterEncoding("UTF-8");
		try
		{
			String apiKey = request.getParameter("apiKey");
			String schoolId = request.getParameter("schoolId");

			/*
			 * 参数map
			 */
			Map<String, Object> paramMap = new HashMap<String, Object>();

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			/**
			 * 00:00:00
			 */
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.HOUR_OF_DAY, 0); // 时
			cal.set(Calendar.MINUTE, 0); // 分
			cal.set(Calendar.SECOND, 0); // 秒
			cal.set(Calendar.MILLISECOND, 0); // 毫秒
			String todayBegin = formatter.format(cal.getTime());

			/**
			 * 23:59:59
			 */
			cal.set(Calendar.HOUR_OF_DAY, 23); // 时
			cal.set(Calendar.MINUTE, 59); // 分
			cal.set(Calendar.SECOND, 59); // 秒
			cal.set(Calendar.MILLISECOND, 0); // 毫秒

			String todayEnd = formatter.format(cal.getTime());

			String queryContent = request.getParameter("queryContent");

			String type = request.getParameter("type");

			if (type == null || type.equals(""))
			{
				type = "1";
			}

			/**
			 * 查询
			 */
			String clazzList = null;
			try
			{
				clazzList = request.getParameter("clazzId");
			} catch (Exception e)
			{
				clazzList = null;
			}

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

			User user = (User) session.getAttribute("user");

			String roleCode = request.getParameter("roleCode");

			if (roleCode == null || roleCode.equals(""))
			{
				roleCode = user.getRoleList().get(0).getRoleCode();
			}

			// 开始日期
			String startDate = null;
			// 开始时间
			String startTime = null;
			String start = null;
			try
			{
				startDate = request.getParameter("startDate");
				startTime = request.getParameter("startTime");
				if (StringUtil.isEmpty(startDate))
				{
					start = todayBegin;
				} else
				{
					start = startDate + " " + startTime + ":00";
				}
			} catch (Exception e)
			{
				startTime = null;
			}

			// 结束日期
			String endDate = null;
			// 结束时间
			String endTime = null;
			String end = null;
			try
			{
				endDate = request.getParameter("endDate");
				endTime = request.getParameter("endTime");
				if (StringUtil.isEmpty(endDate))
				{
					end = todayEnd;
				} else
				{
					end = endDate + " " + endTime + ":00";
				}
			} catch (Exception e)
			{
				endTime = null;
				endDate = null;
			}

			paramMap.put("userId", user.getUserId());
			paramMap.put("roleCode", roleCode);
			paramMap.put("queryContent", queryContent);
			paramMap.put("startTime", start);
			paramMap.put("endTime", end);

			paramMap.put("clazzList", clazzList);

			List<InoutDormitory> list = null;

			/* 出宿舍已刷卡 */
			if (type.equals("1"))
			{
				// 获取分页数据
				list = dormitoryService.getOutSwingCardAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
			}
			/* 出宿舍未刷卡 */
			else if (type.equals("2"))
			{
				// 获取分页数据
				list = dormitoryService.getOutNoSwingCardAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
			}
			/* 进宿舍已刷卡 */
			else if (type.equals("3"))
			{
				// 获取分页数据
				list = dormitoryService.getInSwingCardAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
			}
			/* 进宿舍未刷卡 */
			else if (type.equals("4"))
			{
				// 获取分页数据
				list = dormitoryService.getInNoSwingCardAPP(this.getPages().getPageSize(), currentPage, paramMap, user);
			}

			currentPage = currentPage + 1;

			modelMap.addAttribute("schoolId", schoolId);
			modelMap.addAttribute("apiKey", apiKey);
			modelMap.addAttribute("cPage", currentPage);
			modelMap.addAttribute("list", list);
			modelMap.addAttribute("listSize", list.size());
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("roleListSize", user.getRoleList().size());
			modelMap.addAttribute("type", type);
			modelMap.addAttribute("queryContent", queryContent);
			modelMap.addAttribute("startTime", startTime);
			modelMap.addAttribute("endTime", endTime);
			modelMap.addAttribute("startDate", startDate);
			modelMap.addAttribute("endDate", endDate);
			modelMap.addAttribute("clazzList", clazzList);

			Gson gson = new Gson();
			String json = gson.toJson(modelMap);
			response.getWriter().write(json);
			response.getWriter().flush();

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 进入宿舍异常搜索页面
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/toDormitoryAbnormalSearchAPP.do")
	public String toDormitoryAbnormalSearchAPP(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String roleCode = request.getParameter("roleCode");

		User user = (User) session.getAttribute("user");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user", user);
		paramMap.put("userId", user.getUserId());
		paramMap.put("permissionCode", "dormitoryAbnormalManager");

		List<Clazz> clazzList = commonService.getClazzList(paramMap);

		modelMap.addAttribute("clazzList", clazzList);
		modelMap.addAttribute("roleCode", roleCode);
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		modelMap.addAttribute("userId", user.getUserId());

		return "app/dormitory/dormitory_abnormal_list_search_app";
	}
}
