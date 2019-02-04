package com.guotop.palmschool.controller;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Card;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Menu;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.Student;
import com.guotop.palmschool.entity.StudentDetail;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserRole;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.CardService;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.MenuService;
import com.guotop.palmschool.service.OrderMessageService;
import com.guotop.palmschool.service.PermissionService;
import com.guotop.palmschool.service.StudentService;
import com.guotop.palmschool.service.UserDataChangeRecordsService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.guotop.palmschool.util.WebWriteFile;

import dev.gson.GsonHelper;

/**
 * 学生控制类
 * 
 * @author
 * 
 */
@RequestMapping("/student")
@Controller
public class StudentController extends BaseController {
	@Resource
	private StudentService studentService;

	@Resource
	private CardService cardService;

	@Resource
	private CommonService commonService;
	@Resource
	private PermissionService permissionService;
	@Resource
	private MenuService menuService;
	@Resource
	private UserService userService;

	@Resource
	private OrderMessageService orderMessageService;

	@Resource
	private UserDataChangeRecordsService userDataChangeRecordsService;

	@Resource
	private ClazzService clazzService;

	private String syncObject = "1"; // 同步对象1：学生

	private String operationClass = "student"; // 操作对象

	/**
	 * 进入学生管理页面
	 */
	@RequestMapping(value = "/toStudentList.do")
	public String toStudentList(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			Model modelMap) {
		// 判断是否有权限，无则跳转到首页
		User user = (User) session.getAttribute("user");
		String clazzId = request.getParameter("clazzId");
		String queryContent = request.getParameter("queryContent");
		List<Permission> permissionList = user.getPermissionList();
		modelMap.addAttribute("count", orderMessageService.getPalmOrderMessageCount());
		boolean hasPriv = false;
		String returUrl = "student/student_list";
		modelMap.addAttribute("clazzId", clazzId);
		modelMap.addAttribute("queryContent", queryContent);
		if (permissionList != null) {
			for (Permission permission : permissionList) {
				if ("admin".equals(permission.getPermissionCode())
						|| "studentParentManager".equals(permission.getPermissionCode())) {
					hasPriv = true;
				}
			}
		}
		if (!hasPriv) {
			User loginUser = (User) session.getAttribute("user");

			List<Menu> menuList = new ArrayList<Menu>();
			DBContextHolder.setDBType(loginUser.getSchoolId());
			if (loginUser.getUserId() == 1) {
				menuList = menuService.getAllMenuInfoSysadmin(loginUser.getSchoolId(), null);
			} else {
				menuList = menuService.getAllMenuInfo(loginUser.getSchoolId(), 0);
			}
			session.setAttribute("menuList", menuList);
			modelMap.addAttribute("menuList", menuList);
			returUrl = "home/main";
		}
		return returUrl;
	}

	/**
	 * 导出学生的详细信息
	 * 
	 * @author chenyong
	 * @Time 2017年3月7日 下午1:53:56
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/exportStudentDetail.do")
	public void exportStudentDetail(Map<String, Object> paramMap, String queryContent, Integer clazzId,
			HttpServletResponse response) {
		paramMap.put("queryContent", queryContent);
		Map<String, Object> map = studentService.exportStudentDetail(clazzId, paramMap);
		List<Clazz> listClazz = (List<Clazz>) map.get("clazz");
		Map<Integer, List<User>> mapStuClazz = (Map<Integer, List<User>>) map.get("stuClazz");
		int maxStuCarCodeLength = (int) map.get("maxStuCarCodeLength");
		int maxParentCarCodeLength = (int) map.get("maxParentCarCodeLength");
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook();
		String type = "";
		HSSFSheet sheet = null;
		HSSFRow contentRow = null;
		HSSFCell contentRowCell = null;
		HSSFCellStyle titleStyle = hssfWorkbook.createCellStyle(); // 在工作薄的基础上建立一个样式
		titleStyle.setFillForegroundColor(HSSFColor.BLACK.index); // 填充的背景颜色
		HSSFFont font = hssfWorkbook.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		titleStyle.setFont(font);
		String gradeName = "";
		List<String> cardCodes = null;
		List<User> parentList = null;
		for (Clazz c : listClazz) {
			List<User> student = mapStuClazz.get(c.getId());
			if (student == null || student.size() == 0) {
				continue;
			}
			Collections.sort(student, new Comparator<User>() {
				public int compare(User s1, User s2) {
					return s1.getCode().compareTo(s2.getCode());
				}
			});
			int i = 0;

			gradeName = c.getFullClazzName();
			// 0 幼儿园 1小学 2 初中 3 高中
			if ("0".equals(c.getType())) {
				type = "幼儿园";
			} else if ("1".equals(c.getType())) {
				type = "小学";
			} else if ("2".equals(c.getType())) {
				type = "初中";
			} else if ("3".equals(c.getType())) {
				type = "高中";
			}
			// 获取excel文件第一个工作簿
			sheet = hssfWorkbook.createSheet(type + gradeName);
			contentRow = sheet.createRow(0);
			contentRowCell = contentRow.createCell(0);
			contentRowCell.setCellStyle(titleStyle);
			contentRowCell.setCellValue("姓名");
			contentRowCell = contentRow.createCell(1);
			contentRowCell.setCellStyle(titleStyle);
			contentRowCell.setCellValue("学好");
			contentRowCell = contentRow.createCell(2);
			contentRowCell.setCellStyle(titleStyle);
			contentRowCell.setCellValue("学生手机号");
			sheet.setColumnWidth(0, 18 * 256);
			sheet.setColumnWidth(1, 18 * 256);
			sheet.setColumnWidth(2, 18 * 256);
			for (int k = 1; k <= maxStuCarCodeLength; k++) {
				contentRowCell = contentRow.createCell(2 + k);
				contentRowCell.setCellStyle(titleStyle);
				contentRowCell.setCellValue("卡" + k);
				sheet.setColumnWidth(2 + k, 18 * 256);
			}
			contentRowCell = contentRow.createCell(3 + maxStuCarCodeLength);
			contentRowCell.setCellStyle(titleStyle);
			contentRowCell.setCellValue("家长1姓名");
			sheet.setColumnWidth(3 + maxStuCarCodeLength, 18 * 256);
			contentRowCell = contentRow.createCell(4 + maxStuCarCodeLength);
			contentRowCell.setCellStyle(titleStyle);
			contentRowCell.setCellValue("家长1联系电话");
			sheet.setColumnWidth(4 + maxStuCarCodeLength, 18 * 256);
			for (int k = 1; k <= maxParentCarCodeLength; k++) {
				contentRowCell = contentRow.createCell(4 + maxStuCarCodeLength + k);
				contentRowCell.setCellStyle(titleStyle);
				contentRowCell.setCellValue("家长1卡" + k);
				sheet.setColumnWidth(4 + maxStuCarCodeLength + k, 18 * 256);
			}
			contentRowCell = contentRow.createCell(5 + maxStuCarCodeLength + maxParentCarCodeLength);
			contentRowCell.setCellStyle(titleStyle);
			contentRowCell.setCellValue("家长2姓名");
			sheet.setColumnWidth(5 + maxStuCarCodeLength + maxParentCarCodeLength, 18 * 256);
			contentRowCell = contentRow.createCell(6 + maxStuCarCodeLength + maxParentCarCodeLength);
			contentRowCell.setCellStyle(titleStyle);
			contentRowCell.setCellValue("家长2联系电话");
			sheet.setColumnWidth(6 + maxStuCarCodeLength + maxParentCarCodeLength, 18 * 256);
			for (int k = 1; k <= maxParentCarCodeLength; k++) {
				contentRowCell = contentRow.createCell(6 + maxStuCarCodeLength + maxParentCarCodeLength + k);
				contentRowCell.setCellStyle(titleStyle);
				contentRowCell.setCellValue("家长2卡" + k);
				sheet.setColumnWidth(6 + maxStuCarCodeLength + maxParentCarCodeLength + k, 18 * 256);
			}

			for (User stu : student) {
				i++;
				contentRow = sheet.createRow(i);
				contentRowCell = contentRow.createCell(0);
				contentRowCell.setCellValue(stu.getRealName());
				contentRowCell = contentRow.createCell(1);
				contentRowCell.setCellValue(stu.getCode());
				contentRowCell = contentRow.createCell(2);
				contentRowCell.setCellValue(stu.getPhone());
				cardCodes = stu.getCardCodes();
				if (cardCodes != null && cardCodes.size() > 0) {
					for (int k = 1; k <= cardCodes.size(); k++) {
						contentRowCell = contentRow.createCell(2 + k);
						contentRowCell.setCellValue(cardCodes.get((k - 1)));
					}
				}
				parentList = stu.getParentList();
				if (parentList.size() == 1) {
					contentRowCell = contentRow.createCell(3 + maxStuCarCodeLength);
					contentRowCell.setCellValue(parentList.get(0).getRealName());
					contentRowCell = contentRow.createCell(4 + maxStuCarCodeLength);
					contentRowCell.setCellValue(parentList.get(0).getPhone());
					cardCodes = stu.getCardCodes();
					if (cardCodes != null && cardCodes.size() > 0) {
						for (int k = 1; k <= cardCodes.size(); k++) {
							contentRowCell = contentRow.createCell(4 + maxStuCarCodeLength + k);
							contentRowCell.setCellValue(cardCodes.get((k - 1)));
						}
					}
					// 家长2
					contentRowCell = contentRow.createCell(5 + maxStuCarCodeLength + maxParentCarCodeLength);
					contentRowCell.setCellValue("");
					contentRowCell = contentRow.createCell(6 + maxStuCarCodeLength + maxParentCarCodeLength);
					contentRowCell.setCellValue("");

					cardCodes = parentList.get(0).getCardCodes();
					if (cardCodes != null && cardCodes.size() > 0) {
						for (int k = 1; k <= cardCodes.size(); k++) {
							contentRowCell = contentRow
									.createCell(6 + maxStuCarCodeLength + maxParentCarCodeLength + k);
							contentRowCell.setCellValue(cardCodes.get((k - 1)));
						}
					}

				} else if (parentList.size() == 2) {
					contentRowCell = contentRow.createCell(3 + maxStuCarCodeLength);
					contentRowCell.setCellValue(parentList.get(0).getRealName());
					contentRowCell = contentRow.createCell(4 + maxStuCarCodeLength);
					contentRowCell.setCellValue(parentList.get(0).getPhone());
					cardCodes = parentList.get(0).getCardCodes();
					if (cardCodes != null && cardCodes.size() > 0) {
						for (int k = 1; k <= cardCodes.size(); k++) {
							contentRowCell = contentRow.createCell(4 + maxStuCarCodeLength + k);
							contentRowCell.setCellValue(cardCodes.get((k - 1)));
						}
					}
					// 家长2
					contentRowCell = contentRow.createCell(5 + maxStuCarCodeLength + maxParentCarCodeLength);
					contentRowCell.setCellValue(parentList.get(1).getRealName());
					contentRowCell = contentRow.createCell(6 + maxStuCarCodeLength + maxParentCarCodeLength);
					contentRowCell.setCellValue(parentList.get(1).getPhone());
					cardCodes = parentList.get(1).getCardCodes();
					if (cardCodes != null && cardCodes.size() > 0) {
						for (int k = 1; k <= cardCodes.size(); k++) {
							contentRowCell = contentRow
									.createCell(6 + maxStuCarCodeLength + maxParentCarCodeLength + k);
							contentRowCell.setCellValue(cardCodes.get((k - 1)));
						}
					}
				}

			}

		}
		OutputStream outputStream = null;
		try {
			outputStream = new BufferedOutputStream(response.getOutputStream());
			// 清空response
			response.reset();
			// 设置response的Header
			response.setHeader("Content-Disposition",
					"attachment;filename=" + new String(("学生详细信息.xls").getBytes("gb2312"), "ISO8859-1"));
			response.setContentType("application/vnd.ms-excel");
			hssfWorkbook.write(outputStream); // 将excel文件写入到输出流中
			outputStream.flush();
			response.flushBuffer();
		} catch (Exception e) {
		} finally {
			try {
				outputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	/*
	 * public void doExportExcel(Map<String, Object> paramMap, String
	 * queryContent, Integer clazzId, HttpServletResponse response) {
	 * paramMap.put("queryContent", queryContent); Map<String, Object> map =
	 * studentService.exportStudentDetail(clazzId, paramMap); List<Clazz>
	 * listClazz = (List<Clazz>) map.get("clazz"); Map<Integer, List<User>>
	 * mapStuClazz = (Map<Integer, List<User>>) map.get("stuClazz"); int
	 * maxStuCarCodeLength = (int) map.get("maxStuCarCodeLength"); int
	 * maxParentCarCodeLength = (int) map.get("maxParentCarCodeLength");
	 * HSSFWorkbook hssfWorkbook = new HSSFWorkbook(); String type = "";
	 * HSSFSheet sheet = null; HSSFRow contentRow = null; HSSFCell
	 * contentRowCell = null; HSSFCellStyle titleStyle =
	 * hssfWorkbook.createCellStyle(); // 在工作薄的基础上建立一个样式
	 * titleStyle.setFillForegroundColor(HSSFColor.BLACK.index); // 填充的背景颜色
	 * HSSFFont font = hssfWorkbook.createFont();
	 * font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); titleStyle.setFont(font);
	 * String gradeName = ""; List<String> cardCodes = null; List<User>
	 * parentList = null; for (Clazz c : listClazz) { List<User> student =
	 * mapStuClazz.get(c.getId()); if (student == null || student.size() == 0) {
	 * continue; } Collections.sort(student, new Comparator<User>() { public int
	 * compare(User s1, User s2) { return s1.getCode().compareTo(s2.getCode());
	 * } }); int i = 0;
	 * 
	 * gradeName = c.getFullClazzName(); // 0 幼儿园 1小学 2 初中 3 高中 if
	 * ("0".equals(c.getType())) { type = "幼儿园"; } else if
	 * ("1".equals(c.getType())) { type = "小学"; } else if
	 * ("2".equals(c.getType())) { type = "初中"; } else if
	 * ("3".equals(c.getType())) { type = "高中"; } // 获取excel文件第一个工作簿 sheet =
	 * hssfWorkbook.createSheet(type + gradeName); contentRow =
	 * sheet.createRow(0); contentRowCell = contentRow.createCell(0);
	 * contentRowCell.setCellStyle(titleStyle);
	 * contentRowCell.setCellValue("ID"); contentRowCell =
	 * contentRow.createCell(1); contentRowCell.setCellStyle(titleStyle);
	 * contentRowCell.setCellValue("姓名"); contentRowCell =
	 * contentRow.createCell(2); contentRowCell.setCellStyle(titleStyle);
	 * contentRowCell.setCellValue("学号"); sheet.setColumnWidth(0, 18 * 256);
	 * sheet.setColumnWidth(1, 18 * 256); sheet.setColumnWidth(2, 18 * 256);
	 * 
	 * 
	 * 
	 * for (User stu : student) { i++; contentRow = sheet.createRow(i);
	 * contentRowCell = contentRow.createCell(0);
	 * contentRowCell.setCellValue(stu.getRealName()); contentRowCell =
	 * contentRow.createCell(1); contentRowCell.setCellValue(stu.getCode());
	 * contentRowCell = contentRow.createCell(2);
	 * contentRowCell.setCellValue(stu.getPhone());
	 * 
	 * }
	 * 
	 * }
	 * 
	 * OutputStream outputStream = null; try { outputStream = new
	 * BufferedOutputStream(response.getOutputStream()); // 清空response
	 * response.reset(); // 设置response的Header
	 * response.setHeader("Content-Disposition", "attachment;filename=" + new
	 * String(("学生详细信息.xls").getBytes("gb2312"), "ISO8859-1"));
	 * response.setContentType("application/vnd.ms-excel");
	 * hssfWorkbook.write(outputStream); // 将excel文件写入到输出流中
	 * outputStream.flush(); response.flushBuffer(); } catch (Exception e) { }
	 * finally { try { outputStream.close(); } catch (IOException e) {
	 * e.printStackTrace(); } }
	 * 
	 * }
	 */

	/**
	 * 不同权限查看到不同的page
	 * 
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getStudentList.do")
	public String getStudentList(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		try {
			String roleId = request.getParameter("roleId");
			// 分页信息
			Integer currentPage = 1;

			try {
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e) {
				currentPage = 1;
			}

			String queryContent = request.getParameter("queryContent");
			String clazzList = null;
			try {
				clazzList = request.getParameter("clazzList");
			} catch (Exception e) {
				clazzList = null;
			}

			// 选定user
			User user = (User) session.getAttribute("user");

			String userType = request.getParameter("userType");

			// 参数map
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("clazzId", user.getClazzId());
			paramMap.put("gradeId", user.getGradeId());
			paramMap.put("queryContent", queryContent);
			paramMap.put("clazzList", clazzList);
			paramMap.put("roleId", roleId);
			paramMap.put("userType", userType);
			paramMap.put("schoolId", user.getSchoolId());
			this.getPages().setPageSize(100);

			Pages pages = null;

			List<Card> cardList = null;
			List<User> list = null;
			boolean flag = false;
			if (!StringUtil.isFjequals(user.getSchoolId())) {// 非福建
				pages = studentService.getStudentListByRole(this.getPages().getPageSize(), currentPage, paramMap, user);
				list = pages.getList();
			} else {
				flag = true;
				paramMap.put("fjSchoolId", user.getFjSchoolId());
				pages = studentService.getStudentListByRoleFj(this.getPages().getPageSize(), currentPage, paramMap,
						user);
				list = pages.getList();
			}

			StringBuilder cards = new StringBuilder();
			for (User u : list) {
				cards.delete(0, cards.length());
				if (!flag) {
					cardList = cardService.getCardListByUserId(u.getUserId());
				} else {
					cardList = cardService.getCardListByUserIdFj(u.getUserId());
				}
				for (Card c : cardList) {
					cards.append(c.getCardCode());
					cards.append(",");
				}
				if (cards.length() > 0) {
					u.setCardCode(cards.toString().substring(0, cards.toString().length() - 1));
				} else {
					u.setCardCode("");
				}
			}
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 通过classid 查找班级学生信息， 分页 显示
	 * 
	 */
	@RequestMapping(value = "/loadStudentListByClazzId.do")
	public String loadStudentListByClazzId(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");

		try {
			User user = (User) session.getAttribute("user");
			/*
			 * 分页信息
			 */
			Integer currentPage = 1;

			try {
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e) {
				currentPage = 1;
			}

			/*
			 * 班级id
			 */
			Integer clazzId = null;
			try {
				clazzId = Integer.valueOf(request.getParameter("clazzId"));
			} catch (Exception e) {
				clazzId = null;
			}

			/**
			 * 参数map
			 */

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("gradeId", user.getGradeId());
			paramMap.put("clazzId", clazzId);

			this.getPages().setPageSize(100);
			Pages pages = studentService.getStudentListByRole(this.getPages().getPageSize(), currentPage, paramMap,
					user);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 进入增加学生页面
	 */
	@RequestMapping(value = "/toAddStudent.do")
	public String toAddStudent(HttpServletRequest request, HttpSession session, ModelMap modelMap) {
		/**
		 * 从session中取出指定的user
		 */
		User user = (User) session.getAttribute("user");

		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("user", user);
		modelMap.addAttribute("schoolId", user.getSchoolId());

		return "student/student_add";
	}

	/**
	 * 执行增加学生逻辑
	 */
	@RequestMapping(value = "/doAddStudent.do")
	@ResponseBody
	public void doAddStudent(HttpServletRequest request, HttpSession session, ModelMap modelMap,
			HttpServletResponse response) {
		String f = "1";
		try {
			User loginUser = (User) session.getAttribute("user");
			// 学生信息
			String code = request.getParameter("code");
			String name = request.getParameter("name");
			String classId = request.getParameter("classId");
			String type = request.getParameter("type");
			String studentCard = request.getParameter("studentCard");// 卡号
			String[] studentCardA = null;
			if (!StringUtil.isEmpty(studentCard)) {
				studentCardA = studentCard.split(",");
			}
			// 家长1信息
			String parentname = request.getParameter("parentname");
			String parent1Phone = request.getParameter("phone");
			String parent1Passwoed = request.getParameter("parent1Passwoed");// 卡号
			String parent1Card = request.getParameter("parent1Card");
			String[] parent1CardA = null;
			if (!StringUtil.isEmpty(parent1Card)) {
				parent1CardA = parent1Card.split(",");
			}
			// 家长2信息
			String parent2name = request.getParameter("parent2name");
			String parent2Phone = request.getParameter("phone2");
			String parent2Passwoed = request.getParameter("parent2Passwoed");
			String parent2Card = request.getParameter("parent2Card");// 卡号
			String[] parent2CardA = null;
			if (!StringUtil.isEmpty(parent2Card)) {
				parent2CardA = parent2Card.split(",");
			}
			if (StringUtil.isEmpty(parent1Passwoed)) {
				parent1Passwoed = parent1Phone;
			}
			parent1Passwoed = StringUtil.toMD5(parent1Phone);
			if (StringUtil.isEmpty(parent2Passwoed)) {
				parent2Passwoed = parent2Phone;
			}
			parent2Passwoed = StringUtil.toMD5(parent2Passwoed);
			// 学生
			User studentUserBase = new User();
			String username = loginUser.getSchoolId() + "S" + TimeUtil.getInstance().dateYYYYMM()
					+ StringUtil.randomNum(3);
			studentUserBase.setCode(code);
			studentUserBase.setRealName(name);
			studentUserBase.setUsername(username);
			studentUserBase.setNickName(name);
			studentUserBase.setClazzId(Integer.valueOf(classId));
			studentUserBase.setPassword(StringUtil.toMD5(code));
			studentUserBase.setSchoolId(loginUser.getSchoolId());
			studentUserBase.setRoleCode("student");
			studentUserBase.setSource("1");// 智慧校园用户
			studentUserBase.setUpdateTime(TimeUtil.getInstance().now());
			studentUserBase.setCreateTime(TimeUtil.getInstance().now());
			studentUserBase.setCreateUserId(loginUser.getUserId());
			studentUserBase.setSchoolType(String.valueOf(type));// 是否住校
			studentUserBase.setPalmUserName(loginUser.getSchoolId() + code);// 学校Id+学好
			studentUserBase.setType(0);// '账号类型 ： 0：学生 1：其它 2代理商 3技术支持 4 财务人员',
			// 家长1
			User parentUser = new User();
			if (!StringUtil.isEmpty(parentname)) {
				username = loginUser.getSchoolId() + "T" + TimeUtil.getInstance().dateYYYYMM()
						+ StringUtil.randomNum(3);
				parentUser.setUsername(username);
				parentUser.setRealName(parentname);
				parentUser.setNickName(parentname);
				parentUser.setCreateTime(TimeUtil.getInstance().now());
				parentUser.setSource("1");// 智慧校园用户
				parentUser.setCreateUserId(loginUser.getUserId());
				parentUser.setPassword(parent1Passwoed);
				parentUser.setPhone(parent1Phone);
				parentUser.setBindPhone(parent1Phone);
				parentUser.setRoleCode("parent");
				parentUser.setSchoolId(loginUser.getSchoolId());
				parentUser.setUpdateTime(TimeUtil.getInstance().now());
				parentUser.setType(1);// 其它账号
			}
			// 家长2
			User parentUser2 = new User();
			if (!StringUtil.isEmpty(parent2name)) {
				username = loginUser.getSchoolId() + "T" + TimeUtil.getInstance().dateYYYYMM()
						+ StringUtil.randomNum(3);
				parentUser2.setUsername(username);
				parentUser2.setRealName(parent2name);
				parentUser2.setNickName(parent2name);
				parentUser2.setCreateTime(TimeUtil.getInstance().now());
				parentUser2.setCreateUserId(loginUser.getUserId());
				parentUser2.setPassword(parent2Passwoed);
				parentUser2.setPhone(parent2Phone);
				parentUser2.setSource("1");// 智慧校园用户
				parentUser2.setBindPhone(parent2Phone);
				parentUser2.setRoleCode("parent");
				parentUser2.setSchoolId(loginUser.getSchoolId());
				parentUser2.setUpdateTime(TimeUtil.getInstance().now());
				parentUser2.setType(1);// 其它账号
			}
			studentService.addStudent(studentUserBase, studentCardA, parentUser, parent1CardA, parentUser2,
					parent2CardA);// 添加
		} catch (Exception e) {
			f = "0";
		}
		try {
			response.getWriter().write(GsonHelper.toJson(f));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 进入修改页面
	 */
	@RequestMapping(value = "/toModifyStudentOrParent.do")
	public String toModifyStudentOrParent(HttpServletRequest request, HttpSession session, ModelMap modelMap) {
		User loginUser = (User) session.getAttribute("user");
		List<Permission> permissionList = loginUser.getPermissionList();
		String queryContent = request.getParameter("queryContent");
		modelMap.addAttribute("queryContent", queryContent);
		boolean hasPriv = false;
		String nextUrl = "student/student_modify";
		for (Permission permission : permissionList) {
			if ("admin".equals(permission.getPermissionCode())
					|| "studentParentModify".equals(permission.getPermissionCode())) {
				hasPriv = true;
				break;
			}
		}
		if (!hasPriv) {
			nextUrl = "student/student_list";
		} else {
			String studentId = request.getParameter("studentId");
			List<User> parents = studentService.getParentByStudentId(Integer.valueOf(studentId));// 家长最多两个
			if (parents != null && parents.size() > 0) {
				modelMap.addAttribute("parent1", parents.get(0));
			}
			if (parents != null && parents.size() >= 2) {
				modelMap.addAttribute("parent2", parents.get(1));
			}
			User student = studentService.getStudentById(Integer.valueOf(studentId));// 学生
			modelMap.addAttribute("student", student);
		}
		/*
		 * if (!hasPriv) { nextUrl = "student/student_list"; } else { String
		 * studentId = request.getParameter("studentId"); String userType =
		 * request.getParameter("userType"); if ("parent".equals(userType))//
		 * 家长信息修改 { User parent =
		 * studentService.getParentByUserId(Integer.valueOf(studentId));
		 * modelMap.addAttribute("parentId", studentId);
		 * modelMap.addAttribute("realName", parent.getRealName());
		 * modelMap.addAttribute("phone", parent.getPhone()); nextUrl =
		 * "student/parent_modify"; } else { User student =
		 * studentService.getStudentById(Integer.valueOf(studentId)); List<User>
		 * parents =
		 * studentService.getParentByStudentId(Integer.valueOf(studentId)); if
		 * (parents != null && parents.size() > 0) { if (parents.size() == 1) {
		 * student.setParentname(parents.get(0).getRealName());
		 * student.setPhone(parents.get(0).getPhone()); } else {
		 * student.setParentname(parents.get(0).getRealName());
		 * student.setPhone(parents.get(0).getPhone());
		 * student.setParent2Name(parents.get(1).getRealName());
		 * student.setPhone2(parents.get(1).getPhone()); } }
		 * modelMap.addAttribute("student", student); }
		 * 
		 * }
		 */

		return nextUrl;
	}

	/**
	 * 加载学生电子卡列表(用于修改)
	 */
	@RequestMapping(value = "/loadStudentCardListForModify.do")
	public String loadStudentCardListForModify(HttpServletRequest request, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		try {
			String studentIdStr = request.getParameter("studentId");
			if (StringUtils.isEmpty(studentIdStr)) {
				studentIdStr = "0";
			}
			Integer studentId = Integer.valueOf(studentIdStr);
			List<Card> cardList = studentService.getCardListByStudentId(studentId);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(cardList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 加载家长的分发号码
	 */
	@RequestMapping(value = "/loadParentForwardPhoneForModify.do")
	public String loadParentForwardPhoneForModify(HttpServletRequest request, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		try {
			String parentIdStr = request.getParameter("parentId");
			if (StringUtils.isEmpty(parentIdStr)) {
				parentIdStr = "0";
			}
			Integer parentId = Integer.valueOf(parentIdStr);
			List<String> phones = userService.getPhonesByUserId(parentId);

			Gson gson = new Gson();
			String json = gson.toJson(phones);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 添加学生家长
	 * 
	 * @author chenyong
	 * @date 2016年9月20日 下午7:40:34
	 * @param response
	 * @param session
	 * @param request
	 */
	@RequestMapping("/addParent.do")
	public void addParent(HttpServletResponse response, HttpSession session, HttpServletRequest request) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		User loginUser = (User) session.getAttribute("user");
		String phone = request.getParameter("phone");
		String parentPhone = request.getParameter("parentPhone");
		String parent2Name = request.getParameter("parentname");
		String studentId = request.getParameter("studentId");
		String passWord = request.getParameter("passWord");

		if (StringUtil.isEmpty(parentPhone)) {
			parentPhone = phone;
		}
		if (StringUtil.isEmpty(passWord)) {
			passWord = phone;
		}
		String isSucccess = "1";
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			/**
			 * 电子卡
			 */
			String[] cardCode = request.getParameter("cardCode").split(",");

			// 分发手机号码
			String[] parentForwardPhone = request.getParameter("parentForwardPhone").split(",");

			// 家长
			User parentUser = new User();
			if (!StringUtil.isEmpty(parent2Name)) {
				String username = loginUser.getSchoolId() + "T" + TimeUtil.getInstance().dateYYYYMM()
						+ StringUtil.randomNum(3);
				parentUser.setUsername(username);
				parentUser.setRealName(parent2Name);
				parentUser.setNickName(parent2Name);
				parentUser.setCreateTime(TimeUtil.getInstance().now());
				parentUser.setSource("1");// 智慧校园用户
				parentUser.setCreateUserId(loginUser.getUserId());
				parentUser.setPassword(StringUtil.toMD5(passWord));
				parentUser.setPhone(parentPhone);
				parentUser.setBindPhone(phone);
				parentUser.setRoleCode("parent");
				parentUser.setSchoolId(loginUser.getSchoolId());
				parentUser.setUpdateTime(TimeUtil.getInstance().now());
				parentUser.setStudentId(Integer.parseInt(studentId));
				parentUser.setType(1);// 其它账号
				List<Card> cardList = new ArrayList<Card>();
				for (int i = 0; i < cardCode.length; i++) {
					Card card = new Card();
					card.setCardCode(cardCode[i]);
					card.setStatus("1");
					card.setBattery("1");
					card.setCreatetime(formatter.format(new Date()));
					card.setUpdatetime(formatter.format(new Date()));
					cardList.add(card);
				}
				Integer parentId = studentService.addParent(parentUser, cardCode);
				userService.delUserUserPhones(parentId);
				for (int i = 0; i < parentForwardPhone.length; i++) {
					userService.addUserPhones(parentId, parentForwardPhone[i]);
				}
			}
		} catch (Exception e) {
			isSucccess = "0";
			e.printStackTrace();
		}
		try {
			response.getWriter().write(GsonHelper.toJson(isSucccess));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 修改学生信息
	 * 
	 * @author chenyong
	 * @date 2016年9月20日 下午4:14:28
	 * @param response
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping("/updateStudent.do")
	public void updateStudent(HttpServletResponse response, HttpSession session, HttpServletRequest request) {
		boolean f = true;
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			/**
			 * 参数map
			 */
			Map<String, Object> paramMap = new HashMap<String, Object>();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			/**
			 * studentId
			 */
			Integer studentId = Integer.valueOf(request.getParameter("studentId"));
			/**
			 * 学号
			 */
			String code = request.getParameter("code");

			/**
			 * 姓名
			 */
			String name = request.getParameter("name");
			/**
			 * 类型
			 */
			String type = request.getParameter("type");
			int detailType = 0;
			if (!StringUtil.isEmpty(type)) {
				detailType = Integer.valueOf(type);
			}
			/**
			 * 电子卡
			 */
			String strCode = request.getParameter("cardCode");
			String[] cardCode = strCode.split(",");
			/**
			 * 班级
			 */
			String clazzId = request.getParameter("clazzId");
			/**
			 * 修改时间
			 */
			String updatetime = formatter.format(new Date());
			User loginUser = (User) session.getAttribute("user");
			// Integer gradeId = clazz.getGradeid();
			paramMap.put("studentId", studentId);
			paramMap.put("code", code);
			paramMap.put("realName", name);
			paramMap.put("detailType", detailType);
			paramMap.put("schoolId", loginUser.getSchoolId());
			paramMap.put("updatetime", updatetime);
			paramMap.put("userId", studentId);
			paramMap.put("clazzId", clazzId);
			paramMap.put("palmUserName", loginUser.getSchoolId() + code);
			paramMap.put("createUserId", loginUser.getUserId());
			paramMap.put("updateTime", formatter.format(new Date()));
			List<Card> cardList = new ArrayList<Card>();
			for (int i = 0; i < cardCode.length; i++) {
				Card card = new Card();
				card.setCardCode(cardCode[i]);
				card.setStatus("1");
				card.setBattery("1");
				card.setCreatetime(formatter.format(new Date()));
				card.setUpdatetime(formatter.format(new Date()));
				cardList.add(card);
			}
			studentService.modifyStudentById(paramMap, cardList);
		} catch (UnsupportedEncodingException e) {
			f = false;
			e.printStackTrace();
		}
		try {
			response.getWriter().write(GsonHelper.toJson(f));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 根据根据palmUserName判断家长是否存在
	 * 
	 * @author chenyong
	 * @date 2016年9月23日 上午9:59:33
	 * @param response
	 */
	@RequestMapping("/checkParentByPhone.do")
	public void checkParentByPhone(HttpServletResponse response, String phone, String name) {
		response.setCharacterEncoding("UTF-8");
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		User parent2User = userService.getUserByBindPhone(phone);
		map2 = new HashMap<String, Object>();
		map2.put("flag", false);
		if (parent2User != null && !parent2User.getRealName().equals(name)) {
			map2.put("flag", true);
			List<User> userList = studentService.getStudentListByParentId(parent2User.getUserId());// 根据家长获得小孩
			String studentName = "";
			if (userList != null && userList.size() > 0) {
				if (userList != null && userList.size() == 1) {
					studentName = userList.get(0).getRealName();
				} else if (userList != null && userList.size() > 2) {
					for (User user : userList) {
						studentName += user.getRealName() + ",";
					}
				}
				map2.put("msg", "该号码已被" + studentName + "的家长:" + parent2User.getRealName() + "使用");
			} else if (userList == null || userList.size() == 0) {
				map2.put("msg", "该号码已被家长:" + parent2User.getRealName() + "使用");
			} else {
				List<UserRole> roles = commonService.getUserRoleByUserId(parent2User.getUserId());
				boolean f = false;
				if (roles != null && roles.size() > 0) {
					for (UserRole userRole : roles) {
						if (userRole.getClass() != null && userRole.getRoleCode().equals("student")) {
							map2.put("msg", "该号码已被学生" + parent2User.getRealName() + "使用");
							f = true;
							break;
						} else if (userRole.getClass() != null && userRole.getRoleCode().equals("teacher")) {
							map2.put("msg", "该号码已被教师" + parent2User.getRealName() + "使用");
							f = true;
							break;
						}
					}
				}
				if (!f) {
					map2.put("msg", "该号码被" + parent2User.getRealName() + "使用");
				}
			}
		}
		try {
			response.getWriter().write(GsonHelper.toJson(map2));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 修改家长信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/doModifyParent.do")
	public void doModifyParent(HttpServletRequest request, HttpSession session, ModelMap modelMap,
			HttpServletResponse response) {
		String f = "1";
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			User loginUser = (User) session.getAttribute("user");
			String parentUserId = request.getParameter("parentId");
			String parentName = request.getParameter("parentname");
			// 绑定手机
			String bindPhone = request.getParameter("phone");
			// 接收短信手机号
			String parentPhone = request.getParameter("parentPhone");
			// 接受短信手机号为空，默认是绑定手机号
			if (StringUtil.isEmpty(parentPhone)) {
				parentPhone = bindPhone;
			}
			String passWord = request.getParameter("passWord");
			String studentId = request.getParameter("studentId");
			String[] cardCode = request.getParameter("cardCode").split(",");
			// 分发手机号码
			String[] parentForwardPhone = request.getParameter("parentForwardPhone").split(",");

			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("userId", parentUserId);
			map.put("parentPhone", parentPhone);
			map.put("studentUserId", studentId);
			map.put("realName", parentName);
			map.put("bindPhone", bindPhone);
			map.put("updateUserId", loginUser.getUserId());
			map.put("schoolId", loginUser.getSchoolId());
			map.put("updateTime", formatter.format(new Date()));
			map.put("oldPhone", request.getParameter("oldPhone"));
			if (passWord != null && !"".equals(passWord)) {
				map.put("passWord", StringUtil.toMD5(passWord));
			}
			List<Card> cardList = new ArrayList<Card>();
			for (int i = 0; i < cardCode.length; i++) {
				Card card = new Card();
				card.setCardCode(cardCode[i]);
				card.setStatus("1");
				card.setBattery("1");
				card.setCreatetime(formatter.format(new Date()));
				card.setUpdatetime(formatter.format(new Date()));
				cardList.add(card);
			}
			studentService.modifyParent(map, cardList);

			userService.delUserUserPhones(Integer.valueOf(parentUserId));
			for (int i = 0; i < parentForwardPhone.length; i++) {
				if (!StringUtils.isEmpty(parentForwardPhone[i])) {
					userService.addUserPhones(Integer.valueOf(parentUserId), parentForwardPhone[i]);
				}
			}
		} catch (Exception ex) {
			f = "0";
			ex.printStackTrace();
		}
		try {
			response.getWriter().write(GsonHelper.toJson(f));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// return "student/student_list";
	}

	/**
	 * 执行删除逻辑
	 */
	@RequestMapping(value = "/doDeleteStudent.do")
	public String doDeleteStudent(HttpServletRequest request, HttpSession session, ModelMap modelMap) {
		return "student/student_list";
	}

	/**
	 * 根据班级ID加载学生列表
	 */
	@RequestMapping(value = "/selectStudentListByClazzId.do")
	public String selectStudentListByClazzId(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");

		try {
			Integer clazzId = Integer.valueOf(request.getParameter("clazzId"));
			List<User> studentList = commonService.selectStudentListByClazzId(clazzId);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(studentList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 进入导入学生页面
	 */
	@RequestMapping(value = "/toImportStudent.do")
	public String toImportStudent(HttpServletRequest request, ModelMap modelMap) {
		String userId = request.getParameter("userId");
		modelMap.put("userId", userId);

		return "student/student_import";
	}

	/**
	 * 师生信息(详情)---begin
	 */
	/**
	 * 进入学生信息页面
	 */
	@RequestMapping(value = "/toStudentDetail.do")
	public String toStudentDetail() {
		return "student/student_detail";
	}

	/**
	 * 师生信息(详情)---end
	 */

	/**
	 * 进入学生详细页面
	 */
	@RequestMapping(value = "/toStudentDetailView.do")
	public String toStudentDetailView(HttpServletRequest request, ModelMap modelMap) {
		Integer id = Integer.valueOf(request.getParameter("id"));

		modelMap.put("id", id);

		return "student/student_detailinfo";
	}

	/**
	 * 根据根据学生ID加载学生详细信息
	 */
	@RequestMapping(value = "/loadStudentDetailInfo.do")
	public String loadStudentDetailInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setCharacterEncoding("UTF-8");

		try {
			Integer id = Integer.valueOf(request.getParameter("studentId"));
			StudentDetail studentDetail = commonService.selectStudentDetailByStudentId(id);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(studentDetail);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据根据学生ID加载学生基本信息
	 */
	@RequestMapping(value = "/loadStudentInfoForStudentDetail.do")
	public String loadStudentInfoForStudentDetail(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		response.setCharacterEncoding("UTF-8");

		try {
			// Integer id = Integer.valueOf(request.getParameter("studentId"));
			Student student = null;

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(student);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 表单校验---begin
	 */
	@RequestMapping(value = "/checkStudentByCode.do")
	public String checkStudentByCode(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setCharacterEncoding("UTF-8");

		try {
			String code = request.getParameter("code");
			String schoolId = request.getParameter("schoolId");
			boolean codeFlag = userService.checkCodeIsExistInAddNewUser(code, Long.valueOf(schoolId));

			Gson gson = new Gson();
			String json = gson.toJson(codeFlag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 表单校验---end
	 */

	/**
	 * 表单校验---begin code 学号
	 */
	@RequestMapping(value = "/checkModifyStudentByCode.do")
	public String checkModifyStudentByCode(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, ModelMap modelMap) {
		response.setCharacterEncoding("UTF-8");
		try {
			User loginUser = (User) session.getAttribute("user");
			Long schoolId = Long.valueOf(loginUser.getSchoolId());
			String code = request.getParameter("code");
			String originalcode = request.getParameter("originalcode");
			modelMap.put("code", code);
			modelMap.put("originalcode", originalcode);
			modelMap.put("schoolId", schoolId);
			boolean codeFlag = userService.checkCodeIsExistInModifyUser(originalcode, code, schoolId);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(codeFlag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 表单校验---end
	 */
	/**
	 * 新增家长
	 * 
	 * @param request
	 * @param session
	 * @param modelMap
	 * @return update jfy 2015-11-29
	 */
	@RequestMapping(value = "/toAddParent.do")
	public String toAddParent(HttpServletRequest request, HttpSession session, ModelMap modelMap) {
		User loginUser = (User) session.getAttribute("user");
		List<Permission> list = loginUser.getPermissionList();
		boolean hasPriv = false;
		for (Permission p : list) {
			if ("admin".equals(p.getPermissionCode()) || "studentParentAdd".equals(p.getPermissionCode())) {
				hasPriv = true;
				break;
			}
		}
		if (hasPriv) {
			return "student/parent_add";
		} else {
			return "student/student_list";
		}

	}

	/**
	 * 删除用户
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/delUser.do")
	public String delUser(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setCharacterEncoding("UTF-8");
		User login = (User) session.getAttribute("user");
		String userId = request.getParameter("userId");
		String studentUserId = request.getParameter("studentUserId");// 删除家长用到
		int reCode = 0;
		try {
			if (!StringUtil.isEmpty(userId)) {
				int userIdInt = Integer.valueOf(userId);
				Long schoolId = Long.valueOf(login.getSchoolId());
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("userId", userIdInt);
				paramMap.put("schoolId", schoolId);
				paramMap.put("studentUserId", studentUserId);
				studentService.delUser(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			reCode = 1;
		}

		try {
			response.getWriter().write(String.valueOf(reCode));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 初始化detail的参数
	 * 
	 * @param user
	 * @param userDetail
	 * @return
	 */
	public Map<String, String> putDetailMap(User user) {
		Map<String, String> detailMap = new HashMap<String, String>();
		detailMap.put("userId", String.valueOf(user.getUserId()));
		detailMap.put("boarder", String.valueOf(user.getSchoolType()));
		detailMap.put("userName", user.getRealName());
		detailMap.put("classId", String.valueOf(user.getClazzId()));
		Clazz clazz = clazzService.getClazzById(user.getClazzId());
		detailMap.put("className", clazz.getClazzName());
		detailMap.put("gradeId", String.valueOf(clazz.getGradeId()));
		detailMap.put("gradeName", clazz.getGradeName());
		detailMap.put("createTime", TimeUtil.getInstance().now());
		detailMap.put("updateTime", user.getUpdateTime());
		detailMap.put("studentNumber", user.getCode());
		return detailMap;
	}

	/**
	 * 初始化modify detail的参数
	 * 
	 * @param user
	 * @param userDetail
	 * @return
	 */
	public Map<String, String> putModifyDetailMap(User user) {
		Map<String, String> detailMap = new HashMap<String, String>();
		detailMap.put("userId", String.valueOf(user.getUserId()));
		detailMap.put("boarder", String.valueOf(user.getSchoolType()));
		detailMap.put("userName", user.getRealName());
		detailMap.put("classId", String.valueOf(user.getClazzId()));
		Clazz clazz = clazzService.getClazzById(user.getClazzId());
		detailMap.put("className", clazz.getClazzName());
		detailMap.put("studentNumber", user.getCode());
		detailMap.put("updateTime", TimeUtil.getInstance().now());
		detailMap.put("passWord", user.getPassword());
		return detailMap;
	}

	/**
	 * 根据班级Id获得改班级的学生(接口，RichCloud用到)
	 * 
	 * @author chenyong
	 * @date 2016年7月28日 上午9:47:50
	 * @param response
	 * @return
	 */
	@RequestMapping("/getStudentInfoByClassId.do")
	@ResponseBody
	public String getStudentInfoByClassId(HttpServletResponse response, HttpServletRequest request) {
		response.setContentType("application/json;charset=UTF-8");
		BufferedReader br;
		try {
			br = new BufferedReader(new InputStreamReader(request.getInputStream(), "utf-8"));
			StringBuilder sb = new StringBuilder();
			String line = null;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			String msgInfoStr = sb.toString();
			Gson gson = new Gson();
			Map<String, Object> param = gson.fromJson(msgInfoStr, new TypeToken<Map<String, Object>>() {
			}.getType());
			String classId = (String) param.get("classId");
			String schoolId = (String) param.get("schoolId");
			DBContextHolder.setDBType(schoolId);
			List<User> studentList = studentService.getStudentListByClazzIdInStudentSMS(Integer.valueOf(classId));
			response.getWriter().write(GsonHelper.toJson(studentList));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
 
	
	
	/**
	 * 导出老师记录
	 */
	@SuppressingWarnings("unchecked")
	@RequestMapping(value="//doExportExcel.do/{userType}")
	public void doTeacherExportExcel(Map<String, Object> paramMap, String queryContent, Integer clazzId,
			HttpServletResponse response) {
		paramMap.put("queryContent", queryContent);
		
	
		
	}
	
	/**
	 * 导出查询记录
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/doExportExcel.do")

	public void doExportExcel(Map<String, Object> paramMap, String queryContent, Integer clazzId,
			HttpServletResponse response) {
		paramMap.put("queryContent", queryContent);
		Map<String, Object> map = studentService.exportStudentDetail(clazzId, paramMap);
		List<Clazz> listClazz = (List<Clazz>) map.get("clazz");
		Map<Integer, List<User>> mapStuClazz = (Map<Integer, List<User>>) map.get("stuClazz");
		int maxStuCarCodeLength = (int) map.get("maxStuCarCodeLength");
		int maxParentCarCodeLength = (int) map.get("maxParentCarCodeLength");
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook();
		String type = "";
		HSSFSheet sheet = null;
		HSSFRow contentRow = null;
		HSSFCell contentRowCell = null;
		HSSFCellStyle titleStyle = hssfWorkbook.createCellStyle(); // 在工作薄的基础上建立一个样式
		titleStyle.setFillForegroundColor(HSSFColor.BLACK.index); // 填充的背景颜色
		HSSFFont font = hssfWorkbook.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		titleStyle.setFont(font);
		String gradeName = "";
		List<String> cardCodes = null;
		List<User> parentList = null;
		List<User> student=null;
		 String fileName = "";
		int i=0;
		for (Clazz c : listClazz) {
			student = mapStuClazz.get(c.getId());
			if (student == null || student.size() == 0) {
				continue;
			}
			Collections.sort(student, new Comparator<User>() {
				public int compare(User s1, User s2) {
					return s1.getCode().compareTo(s2.getCode());
				}
			});
			 

			gradeName = c.getFullClazzName();
			// 0 幼儿园 1小学 2 初中 3 高中
			if ("0".equals(c.getType())) {
				type = "幼儿园";
			} else if ("1".equals(c.getType())) {
				type = "小学";
			} else if ("2".equals(c.getType())) {
				type = "初中";
			} else if ("3".equals(c.getType())) {
				type = "高中";
			}
			// 获取excel文件第一个工作簿
			sheet = hssfWorkbook.createSheet(type + gradeName);
			contentRow = sheet.createRow(0);
			contentRowCell = contentRow.createCell(0);
			contentRowCell.setCellStyle(titleStyle);
			contentRowCell.setCellValue("ID");
			contentRowCell = contentRow.createCell(1);
			contentRowCell.setCellStyle(titleStyle);
			contentRowCell.setCellValue("学号");
			contentRowCell = contentRow.createCell(2);
			contentRowCell.setCellStyle(titleStyle);
			contentRowCell.setCellValue("姓名");
			sheet.setColumnWidth(0, 18 * 256);
			sheet.setColumnWidth(1, 18 * 256);
			sheet.setColumnWidth(2, 18 * 256);
            for (User stu : student) {
				i++;
				contentRow = sheet.createRow(i);
				contentRowCell = contentRow.createCell(0);
				contentRowCell.setCellValue(stu.getUserId());
				contentRowCell = contentRow.createCell(1);
				contentRowCell.setCellValue(stu.getCode());
				contentRowCell = contentRow.createCell(2);
				contentRowCell.setCellValue(stu.getName());
				}

			}
                          
		
		OutputStream outputStream = null;
		try {
			outputStream = new BufferedOutputStream(response.getOutputStream());
			// 清空response
			response.reset();
			// 设置response的Header
			response.setHeader("Content-Disposition",
					"attachment;filename=" + new String(("学生列表.xls").getBytes("gb2312"), "ISO8859-1"));
			response.setContentType("application/vnd.ms-excel");
			hssfWorkbook.write(outputStream); // 将excel文件写入到输出流中
			outputStream.flush();
			response.flushBuffer();
		} catch (Exception e) {
		} finally {
			try {
				outputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	

	/*
	 * public void doExportExcel(HttpServletRequest request, HttpServletResponse
	 * response, HttpSession session) { try {
	 * response.setCharacterEncoding("UTF-8");
	 * request.setCharacterEncoding("UTF-8");
	 * 
	 *//**
	 * 页面加载数据---begin
	 */
	/*
	 * User loginUser = (User) session.getAttribute("user"); Map<String, Object>
	 * parmMap = new HashMap<String, Object>(); String userType =
	 * request.getParameter("userType"); String clazzIdString =
	 * request.getParameter("clazzId"); String sheetName = null; String fileName
	 * = "人员列表"; Integer clazzId = null; String clazzName = "";
	 * 
	 * if(!StringUtil.isEmpty(clazzIdString)){ clazzId =
	 * Integer.valueOf(clazzIdString); Clazz clazz =
	 * clazzService.getClazzById(clazzId); clazzName = clazz.getClazzName(); }
	 * 
	 * List<User> userList = new ArrayList<User>(); if
	 * ("parent".equals(userType))// 家长信息修改 { fileName = "家长列表"; //查询出所有家长
	 * if(StringUtil.isEmpty(clazzName)){ sheetName = "所有家长"; }else{ sheetName =
	 * clazzName+"-家长"; } parmMap.put(userType, "parent");
	 * 
	 * userList = studentService.getParentListByClazzId(clazzId,
	 * loginUser.getSchoolId()); }else{ fileName = "学生列表"; //查询出所有学生
	 * if(StringUtil.isEmpty(clazzName)){ sheetName = "所有学生"; }else{ sheetName =
	 * clazzName+"-学生"; } parmMap.put(userType, "student"); userList =
	 * studentService.getStudentListByClazzIdInStudentSMS(clazzId);
	 * 
	 * 
	 * 
	 * 
	 * 
	 * /** 页面数据加载---end
	 */

	/**
	 * 初始化excel各项参数---begin
	 */

	
	// 创建Excel的工作书册 Workbook,对应到一个excel文档
	HSSFWorkbook wb = new HSSFWorkbook();

	// 创建Excel的工作sheet,对应到一个excel文档的tab //
	// HSSFSheet sheet=wb.createSheet(sheetName); 
	HSSFSheet sheet1 = wb.createSheet();

	// 创建字体样式 HSSFFont
	font = wb.createFont();

	// 创建单元格样式 
	HSSFCellStyle style = wb.createCellStyle();


	WebWriteFile.getInstance().init(wb,sheet,font,style);
	 /**
	 * 初始化excel各项参数---end
	 */
	
	  
	  HSSFRow row = sheet.createRow(0);row.setHeight((short)500);// 设定行的高度 //
	 // 创建一个Excel的单元格 
	  HSSFCell cell = row.createCell(0); // 给Excel的单元格设置样式和赋值
	  cell.setCellValue("ID");
	  
	  style.setWrapText(true);cell=row.createCell(1);cell.setCellValue("ID");
	  
	  style.setWrapText(true);cell=row.createCell(1);cell.setCellValue("学号");
	  
	  style.setWrapText(true);cell=row.createCell(2);cell.setCellValue("姓名");
	  style.setWrapText(true);cell=row.createCell(3);cell.setCellValue("卡号");
	  
	 /**
	 * 将数据写入excel中---begin
	 */
	
	  
	  for( User stu:student) {
		  i++;
	  
	  row = sheet.createRow(i); 
	  row.setHeight((short) 500);// 设定行的高度
	  style.setWrapText(true);
	 
	  // 创建一个Excel的单元格 cell = row.createCell(0); // 给Excel的单元格设置样式和赋值
	  cell.setCellValue(stu.getUserId());
	  
	  style.setWrapText(true); cell = row.createCell(1);
	  cell.setCellValue(stu.getCode());
	  
	 style.setWrapText(true); cell = row.createCell(2);
	  cell.setCellValue(stu.getRealName());
	  
	  
	 /**
	 * 将数据写入excel中---end
	 */
	/*

	 *//**
	 * 磁盘创建文件并生出输出流
	 */
	  String path = null; 
	  String oos = System.getProperty("os.name");
	  
	  if(oos.toLowerCase().startsWith("win")) { 
	  path = "D:" +File.separator + "report" + File.separator; }else {
	   path = "var" +File.separator + "report" + File.separator; 
	   } 
	   File fp = new File(path); // 创建目录 
	   if (!fp.exists()) {
	    fp.mkdirs();//目录不存在的情况下，创建目录。
	  } 
	  File file = new File(path + new Date().getTime() + ".xls");
	 FileOutputStream os = null;
	 try { 
	 os = new FileOutputStream(file);
	  }catch( FileNotFoundException e) {
	   e.printStackTrace(); 
	  }finally {
	  try { wb.write(os); os.close(); } catch (IOException e){
	  e.printStackTrace(); } }
	  
	  WebWriteFile.getInstance().write(file,response,fileName+".xls");
	  file.delete();
	  } 
	}
	 

	/**
	 * 进入【批量更新信息】学生页面
	 */
	@RequestMapping(value = "/batchUpdateImport.do")
	public String batchUpdateImport(HttpServletRequest request, ModelMap modelMap) {
		String userId = request.getParameter("userId");
		modelMap.put("userId", userId);

		return "student/student_batchUpdate_import";
	}

	/**
	 * 导出学生缴费或为缴费的信息
	 * 
	 * @author chenyong
	 * @Time 2017年2月22日 上午11:33:38
	 */
	@RequestMapping("/payExportExcel.do")
	@ResponseBody
	public void payExportExcel(int payType, HttpServletResponse response, HttpServletRequest request) {
		List<Student> list = null;
		String fileName = "";
		// 打开excel文件
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook();
		if (payType == 0) {// 已缴费
			list = studentService.getPayStudent();
			fileName = "学生已缴费记录.xls";
		} else {// 未缴费
			list = studentService.getNoPayStudent();
			fileName = "学生未缴费记录.xls";
		}
		if (list != null && list.size() > 0) {
			String gradeName = "";
			String type = "";
			HSSFSheet sheet = null;
			HSSFRow contentRow = null;
			HSSFCell contentRowCell = null;
			HSSFCellStyle titleStyle = hssfWorkbook.createCellStyle(); // 在工作薄的基础上建立一个样式
			titleStyle.setFillForegroundColor(HSSFColor.BLACK.index); // 填充的背景颜色
			HSSFFont font = hssfWorkbook.createFont();
			font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			titleStyle.setFont(font);
			int i = 0;
			for (Student student : list) {
				if ("".equals(gradeName)) {
					gradeName = student.getGradeName();
					// 0 幼儿园 1小学 2 初中 3 高中
					if (student.getGradeType().intValue() == 0) {
						type = "幼儿园";
					} else if (student.getGradeType().intValue() == 1) {
						type = "小学";
					} else if (student.getGradeType().intValue() == 2) {
						type = "初中";
					} else if (student.getGradeType().intValue() == 3) {
						type = "高中";
					}
					// 获取excel文件第一个工作簿
					sheet = hssfWorkbook.createSheet(type + gradeName);
					contentRow = sheet.createRow(0);
					contentRowCell = contentRow.createCell(0);
					contentRowCell.setCellStyle(titleStyle);
					contentRowCell.setCellValue("学生");
					contentRowCell = contentRow.createCell(1);
					contentRowCell.setCellStyle(titleStyle);
					contentRowCell.setCellValue("班级");
					contentRowCell = contentRow.createCell(2);
					contentRowCell.setCellStyle(titleStyle);
					contentRowCell.setCellValue("年级");
					sheet.setColumnWidth(0, 18 * 256);
					sheet.setColumnWidth(1, 18 * 256);
					sheet.setColumnWidth(2, 18 * 256);
					i = 1;
				} else if (!gradeName.equals(student.getGradeName())) {
					gradeName = student.getGradeName();
					// 0 幼儿园 1小学 2 初中 3 高中
					if (student.getGradeType().intValue() == 0) {
						type = "幼儿园";
					} else if (student.getGradeType().intValue() == 1) {
						type = "小学";
					} else if (student.getGradeType().intValue() == 2) {
						type = "初中";
					} else if (student.getGradeType().intValue() == 3) {
						type = "高中";
					}
					// 获取excel文件第一个工作簿
					sheet = hssfWorkbook.createSheet(type + gradeName);
					contentRow = sheet.createRow(0);
					contentRowCell = contentRow.createCell(0);
					contentRowCell.setCellStyle(titleStyle);
					contentRowCell.setCellValue("学生");
					contentRowCell = contentRow.createCell(1);
					contentRowCell.setCellStyle(titleStyle);
					contentRowCell.setCellValue("班级");
					contentRowCell = contentRow.createCell(2);
					contentRowCell.setCellStyle(titleStyle);
					contentRowCell.setCellValue("年级");
					sheet.setColumnWidth(0, 18 * 256);
					sheet.setColumnWidth(1, 18 * 256);
					sheet.setColumnWidth(2, 18 * 256);
					i = 1;
				}
				contentRow = sheet.createRow(i);
				contentRowCell = contentRow.createCell(0);
				contentRowCell.setCellValue(student.getName());
				contentRowCell = contentRow.createCell(1);
				contentRowCell.setCellValue(student.getClazzName());
				contentRowCell = contentRow.createCell(2);
				contentRowCell.setCellValue(type + student.getGradeName());
				i++;
			}
		}
		OutputStream outputStream = null;
		try {
			outputStream = new BufferedOutputStream(response.getOutputStream());
			// 清空response
			response.reset();
			// 设置response的Header
			response.setHeader("Content-Disposition",
					"attachment;filename=" + new String((fileName).getBytes("gb2312"), "ISO8859-1"));
			response.setContentType("application/vnd.ms-excel");
			hssfWorkbook.write(outputStream); // 将excel文件写入到输出流中
			outputStream.flush();
			response.flushBuffer();
		} catch (Exception e) {
		} finally {
			try {
				outputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 设置或取消家长接收短信
	 * 
	 * @return
	 */
	@RequestMapping(value = "/confirmSendSms.do")
	public String confirmSendSms(HttpServletRequest request, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();

		// 查询传入页面权限编码
		String studentId = request.getParameter("studentId");
		String parentId = request.getParameter("parentId");
		boolean flag = false;
		if ((!StringUtil.isEmpty(studentId)) && (!StringUtil.isEmpty(parentId))) {
			studentService.updateStudentParent(Integer.valueOf(studentId), Integer.valueOf(parentId));
			flag = true;
		}
		try {
			String json = gson.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

}
