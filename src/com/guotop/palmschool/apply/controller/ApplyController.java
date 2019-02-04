package com.guotop.palmschool.apply.controller;

import java.awt.Image;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.util.Streams;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.guotop.palmschool.apply.entity.Apply;
import com.guotop.palmschool.apply.entity.Area;
import com.guotop.palmschool.apply.service.ApplyService;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.util.PropertiesUtil;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

import common.Logger;

/**
 * 学校注册操作类
 * 
 * @author zhou
 * 
 */
@RequestMapping("/apply")
@Controller
public class ApplyController extends BaseController
{
	private Logger log = Logger.getLogger(ApplyController.class);
	@Resource
	private ApplyService applyService;

	@Resource
	private CommonService commonService;
	
	@Resource
	private SchoolService schoolService;

	/**
	 * 进入申请页面
	 */
	@RequestMapping(value = "/apply.do")
	public String toAnnouncementList()
	{
		return "apply/apply_add";
	}
	/**
	 * 获取省份列表
	 * @return
	 */
	@RequestMapping(value = "/getPronvice.do")
	public String getProvince(HttpServletRequest request, HttpServletResponse response, HttpSession session){
		List<Area> list =  applyService.getProvince();
		Gson gson = new Gson();
		try
		{
			String json = gson.toJson(list);
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("getProvince error:" + e.getMessage());
		}
		return null;
	}
	/**
	 * 根据父地区编码获取子地区
	 * @return
	 */
	@RequestMapping(value = "/getChildrens.do")
	public String getChildAreaByParent(HttpServletRequest request, HttpServletResponse response, HttpSession session){
		String parentId = request.getParameter("areaId");
		List<Area> list =  applyService.getChildAreaByParentId(parentId);
		Gson gson = new Gson();
		try
		{
			String json = gson.toJson(list);
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("getChildAreaByParent error:" + e.getMessage());
		}
		return null;
	}
	/**
	 * 根据地区编码获取该地区学校
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getSchoolsByAreaId.do")
	public String getSchoolByAreaId(HttpServletRequest request, HttpServletResponse response, HttpSession session){
		String areaId = request.getParameter("areaId");
		List<School> list =  applyService.getSchoolByAreaId(areaId);
		Gson gson = new Gson();
		try
		{
			String json = gson.toJson(list);
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("getSchoolByAreaId error:" + e.getMessage());
		}
		return null;
	}
	/**
	 * 申请成功
	  @author chenyong
	  @date 2016年9月27日 下午5:40:07
	 * @return
	 */
	@RequestMapping("/toApplySuccess.do")
	public String toApplySuccess(){
		
		return "apply/success";
		
	}
	/**
	 * 保存申请信息，若学校存在，则直接保存，若学校不存在，则保存学校，然后保存申请信息
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/submitApplyInfo.do")
	public String saveApplyInfo(HttpServletRequest request, HttpServletResponse response,
			HttpSession session,@RequestParam(required = false) MultipartFile multiFile,ModelMap modelMap){
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Apply applyInfo = new Apply();
		if (multiFile != null && !multiFile.isEmpty()) {
			Image m;
			try
			{
				m = ImageIO.read(multiFile.getInputStream());
				if(m == null){//不是图片
					modelMap.addAttribute("status", -1);
					modelMap.addAttribute("msg", "请上传图片，格式:png,jpg,jpeg！");
					return "apply/apply_add";
				}else if(multiFile.getSize()>(1024*1024*5)){//大于5M
					modelMap.addAttribute("status", -1);
					modelMap.addAttribute("msg", "图片大小必须为5M以内！");
					return "apply/apply_add";
				}
			} catch (IOException e1)
			{
				modelMap.addAttribute("status", -1);
				modelMap.addAttribute("msg", "请上传图片，格式:png,jpg,jpeg！");
				return "apply/apply_add";
				
			}
				try
				{
					Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
			    	String savaPath=pro.getProperty("savaPath"); //附件存放位置
			    	String filePath=pro.getProperty("filePath"); //数据库放位置
			    	File f=new File(savaPath);
			    	if(!f.exists()){//不存在时创建
			    		f.mkdirs();
			    	}
			    	String fileName =System.currentTimeMillis()+multiFile.getOriginalFilename().substring(multiFile.getOriginalFilename().lastIndexOf("."));
					String virtualPath = savaPath + fileName;
					BufferedInputStream inputStream = new BufferedInputStream(multiFile.getInputStream());
					BufferedOutputStream outputStream;
					outputStream = new BufferedOutputStream(new FileOutputStream(new File(virtualPath)));
					Streams.copy(inputStream, outputStream, true);
					inputStream.close();
					outputStream.close();
					applyInfo.setAttachment(filePath+"/"+fileName);
				} catch (FileNotFoundException e)
				{
					modelMap.addAttribute("status", -1);
					modelMap.addAttribute("msg", "提交失败，请联系客服人员！");
					log.error("saveApplyInfo error:" + e.getMessage());
					e.printStackTrace();
					return "apply/apply_add";
				} catch (IOException e)
				{
					modelMap.addAttribute("status", -1);
					modelMap.addAttribute("msg", "提交失败，请联系客服人员！");
					log.error("saveApplyInfo error:" + e.getMessage());
					e.printStackTrace();
					return "apply/apply_add";
				}
		}
		//选择学校ID
		String schoolId = request.getParameter("schoolId");
		String schoolName = request.getParameter("schoolName");
		String schoolType = request.getParameter("schoolType");
		String schoolCategory = request.getParameter("schoolCategory");
		String createTime = request.getParameter("createTime");
		String schoolNum = request.getParameter("schoolNum");
		String applyName = request.getParameter("name");
		String phone = request.getParameter("phone");
		String areaId = request.getParameter("country");
		String email = request.getParameter("email");
		String duties = request.getParameter("duties");
		String schoolMasterPhone = request.getParameter("schoolMasterPhone");
		String schoolMaster = request.getParameter("schoolMaster");
		applyInfo.setSchoolMaster(schoolMaster);
		applyInfo.setSchoolMasterPhone(schoolMasterPhone);
		applyInfo.setProposer(applyName);
		applyInfo.setApplyTime(formatter.format(new Date()));
		applyInfo.setPhone(phone);
		applyInfo.setStatus("0");
		applyInfo.setDuties(duties);
		applyInfo.setEmail(email);
		if (schoolNum == null || schoolNum.length() == 0)
		{
			schoolNum = "0";
		}
		if(StringUtil.isEmpty(schoolCategory)){
			schoolCategory = "1";
		}
		try{
			//为空，需新增学校
			if (schoolId==null || schoolId.equals("")){
				//获取该区最大学校编号
				long addSchoolId = applyService.getMaxSchoolIdByAreaId(areaId) + 1;
				School school = new School();
				school.setSchoolId(addSchoolId);
				school.setSchoolName(schoolName);
				school.setSchoolAreaId(areaId);
				school.setSchoolType(schoolType);
				school.setSchoolCategory(schoolCategory);
				school.setCreateDate(createTime);
				school.setTotalNum(Integer.valueOf(schoolNum));
				school.setCreateDate(TimeUtil.getInstance().now());
				school.setPresident(schoolMaster);
				applyService.addSchoolInfo(school);
				applyInfo.setSchoolId(addSchoolId);
			}else{
				//更新学校类别和学校性质
				School school = new School();
				school.setSchoolId(Long.valueOf(schoolId));
				school.setSchoolType(schoolType);
				school.setSchoolCategory(schoolCategory);
				schoolService.updataSchoolDetail(school);
				applyInfo.setSchoolId(Long.valueOf(schoolId));
			}
			applyService.addApply(applyInfo);
			resultMap.put("status", 0);
			resultMap.put("msg", "提交成功，请耐心等候审核员审核！");
		}catch(Exception e){
			e.printStackTrace();
			modelMap.addAttribute("status", -1);
			modelMap.addAttribute("msg", "提交失败，请联系客服人员！");
			log.error("saveApplyInfo error:" + e.getMessage());
			return "apply/apply_add";
		}
		/*Gson gson = new Gson();
		try
		{
			
			String json = gson.toJson(resultMap);
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("saveApplyInfo error:" + e.getMessage());
		}*/
		return "apply/success";
	}

}
