package com.guotop.palmschool.securitydanger.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.guotop.palmschool.asset.entity.AssetServiceman;
import com.guotop.palmschool.asset.service.AssetService;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.securitydanger.entity.SecurityDanger;
import com.guotop.palmschool.securitydanger.entity.SecurityDangerAttachment;
import com.guotop.palmschool.securitydanger.entity.SecurityDangerDetail;
import com.guotop.palmschool.securitydanger.service.SecurityDangerService;
import com.guotop.palmschool.securitydanger.vo.SecurityDangerType;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

import dev.gson.GsonHelper;

/**
 * 安全隐患
 * 
 * @author chenyong
 *
 */
@Controller
@RequestMapping("/securityDanger")
public class SecurityDangerController {

	@Autowired
	private SecurityDangerService securityDangerService;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private AssetService assetService;
	
	@Autowired
	private UserService userService;

	/**
	 * 分页获得安全隐患数据
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午3:57:20
	 */
	@RequestMapping("getPages.do")
	@ResponseBody
	public void getPages(HttpServletResponse response, Integer type, Integer page,HttpSession session) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("type", type);
		User user=(User) session.getAttribute("user");
		//管理员看全部
		if(commonService.hasAdminPermission(user)){
			paramMap.put("userId", "");
		}else{//看接收人含有自己的
			paramMap.put("userId",user.getUserId());
		}
		@SuppressWarnings("rawtypes")
		Pages pages = securityDangerService.getSecurityDangerPages(page, 30, paramMap);
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(GsonHelper.toJson(pages));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 进入安全隐患列表
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午4:08:45
	 */
	@RequestMapping("/toSecurityDanger.do")
	public String toSecurityDanger(Model model) {
		List<SecurityDangerType> list=SecurityDangerType.getSecurityDangerType();
		model.addAttribute("typeJson", GsonHelper.toJson(list));
     return "asset/asset_safe";
	}
	@RequestMapping("/toDangerPersonList.do")
	public String toDangerPersonList(Model model) {
		List<SecurityDangerType> list=SecurityDangerType.getSecurityDangerType();
		model.addAttribute("types", list);
		return "asset/asset_danger_person";
	}
	/**
	 * 添加人员
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午4:08:45
	 */
	@RequestMapping("/toAddSecurityDanger.do")
	public String toAddSecurityDanger(Model model) {
		List<SecurityDangerType> types= SecurityDangerType.getSecurityDangerType();
		model.addAttribute("types", types);
		return "asset/asset_danger_add";
	}

	/**
	 * 获得安全隐患详细
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午8:23:27
	 */
	@RequestMapping("/getSecurityDangerDetails.do")
	@ResponseBody
	public void getSecurityDangerDetails(HttpSession session, HttpServletResponse response, Integer id) {
		SecurityDanger securityDanger = securityDangerService.getByKey(id);
		List<SecurityDangerDetail> details = securityDangerService.getDetailsByParentId(id);
		List<SecurityDangerAttachment> attachments = securityDangerService.getAttachments(id);
		securityDanger.setAttachments(attachments);
		securityDanger.setDetails(details);
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(GsonHelper.toJson(securityDanger));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	/**
	 * 添加安全隐患推送人员分组
	 */
	@RequestMapping(value = "/addDangersAcceptPerson.do")
	@ResponseBody
	public void addDangersAcceptPerson(HttpServletResponse response,HttpSession session,String userIdStr, int type) {
		int f = 0;
		User user=(User) session.getAttribute("user");
		if (user == null) {
			f = 1;
		} else {
			try {
				// 安全隐患信息
				// set集合用户保存所有接收者信息
				Set<User> set = new HashSet<User>();
				// 添加人员
				String[] userIds = userIdStr.split(",");
				// 切换数据源
				DBContextHolder.setDBType(user.getSchoolId());
				boolean e=false;//是否是福建
		        if(StringUtil.isFjequals(user.getSchoolId())){
		        	e=true;
		        }else{
		        	e=false;
		        }
		        
				for (String string : userIds) {
					String firstChar = string.substring(0, 1);
					int getId=  Integer.valueOf(string.substring(1));
					//部门
					if("D".equals(firstChar)){
						// 接下来是通过部门ID获取该年级下所有的老师信息
						List<User> teacherList =null;
						if(!e){//非福建
							teacherList=commonService.getTeacherDetailByDepartmentIdInSms(getId);
						}else{//福建
							teacherList=commonService.getTeacherDetailByDepartmentIdInSmsFj(getId);
						}
						for (User teacher : teacherList)
						{
							set.add(teacher);
						}
					}
					//人员
					if("T".equals(firstChar)){
						User teacher =null;
						if(!e){//非福建
							teacher = commonService.getUserDetailByUserId(getId);
						}else{
							teacher = commonService.getUserDetailByUserIdFj(getId);	
						}
						set.add(teacher);
					}
				}
				//类型
				if(type == 1){
					type =-1;
				}else{
					type =-2;
				}
				for (User u : set) {
					user = userService.getUserDetailByUserIdInPersonCenter(u.getUserId());
					boolean flag = assetService.isExistServicemanByServicemanIdAndType(u.getUserId(),type);
					if(!flag){
						AssetServiceman as = new AssetServiceman();
						as.setCreateTime(TimeUtil.getInstance().now());
						as.setPhone(u.getPhone());
						as.setServiceman(u.getRealName());
						as.setServicemanId(u.getUserId());
						as.setType(type);
						as.setCode(u.getCode());
						as.setLeaderIdOne(null);
						as.setLeaderIdTwo(null);
						as.setLeaderOne(null);
						as.setLeaderTwo(null);
						assetService.addAssetServiceman(as);
					}
				}
				
				f =0;
			} catch (Exception e) {
				e.printStackTrace();
				f =1;
			}
		}
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(f));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	/**
	 * 删除检查人员
	 * @param session
	 * @param response
	 * @param servicemanId
	 */
	@RequestMapping("/deleteAssetServicemanById.do")
	@ResponseBody
	public void deleteAssetServicemanById(HttpSession session, HttpServletResponse response, Integer servicemanId) {
			int f = 0;
			try {
				assetService.deleteAssetServicemanById(servicemanId);
			} catch (Exception e) {
				f=1;
			}
			
		try {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(GsonHelper.toJson(f));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
			
		}

	}
}
