package com.guotop.palmschool.growth.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.growth.entity.GrowthArchive;
import com.guotop.palmschool.growth.entity.GrowthContent;
import com.guotop.palmschool.growth.entity.GrowthTemplate;
import com.guotop.palmschool.growth.entity.SelfGrowth;
import com.guotop.palmschool.growth.entity.UserDetail;
import com.guotop.palmschool.growth.service.GrowthArchiveService;
import com.guotop.palmschool.service.GradeService;
import com.guotop.palmschool.util.FileUploadUtil;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

import dev.gson.GsonHelper;

/**
 * 成绩查看
 * 
 * @author jfy
 * @date 2016年1月7日
 */
@RequestMapping("/growth")
@Controller
public class GrowthController extends BaseController
{
	private Logger log = LoggerFactory.getLogger(GrowthController.class);
	@Resource
	private CommonService commonService;
	@Resource
	private GrowthArchiveService growthArchiveService;
	@Resource
	private GradeService gradeService;

	/**
	 * 进入成长档案页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toArchiveList.do")
	public String ArchiveList(ModelMap modelMap)
	{
		return "growthArchives/archive_List";
	}

	@RequestMapping(value = "/getGrowthArchiveList.do")
	public String getGrowthArchiveList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		try
		{
			// 选定user
			User loginUser = (User) session.getAttribute("user");
			String clazzId = request.getParameter("clazzId");
			String queryContent = request.getParameter("queryContent");
			String roleId = request.getParameter("roleId");
			HashMap<String, Object> params = new HashMap<String, Object>();
			if (clazzId != null && !"".equals(clazzId))
			{
				params.put("clazzId", Integer.valueOf(clazzId));
			}
			String cPage = request.getParameter("cPage");
			// 分页信息
			Integer currentPage = 1;
			if (cPage != null && !"".equals(cPage))
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			}
			Pages pages = new Pages();
			this.getPages().setPageSize(20);
			params.put("queryContent", queryContent);
			if (commonService.hasAdminPermission(loginUser))// 管理员
			{
				pages = growthArchiveService.getGrowthArchiveList(this.getPages().getPageSize(), currentPage, params);
			} else if (roleId != null && roleId.equals("parent"))// 家长
			{
				params.put("userId", loginUser.getUserId());
				params.put("roleId", roleId);

				pages = growthArchiveService.getGrowthArchiveList(this.getPages().getPageSize(), currentPage, params);
			} else
			{
				// 有权限的人员
				List<Integer> clazzIds = commonService.getIdsByUserIdAndPermissionCode(loginUser.getUserId(), "morningCheck", 0);
				params.put("clazzIds", clazzIds);
				params.put("userId", loginUser.getUserId());
				params.put("roleId", roleId);
				pages = growthArchiveService.getGrowthArchiveList(this.getPages().getPageSize(), currentPage, params);
			}
			response.getWriter().write(GsonHelper.toJson(pages));
			response.getWriter().flush();
		} catch (Exception e)
		{
			log.error(e.getMessage());
		}
		return null;
	}

	/**
	 * 进入新增页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toAddGrowth.do")
	public String toAddGrowth(HttpServletRequest request, ModelMap modelMap)
	{
		List<GrowthTemplate> list = growthArchiveService.getTemplateList();
		modelMap.addAttribute("templateList", list);
		modelMap.addAttribute("userId", request.getParameter("userId"));
		return "growthArchives/archive_Template";
	}
	
	/**
	 * 进入详情页面
	 * 
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/toGrowthDetail.do")
	public String toGrowthDetail(HttpServletRequest request,HttpServletResponse response,ModelMap modelMap) throws UnsupportedEncodingException
	{
		response.setCharacterEncoding("utf-8");
		String userId = URLDecoder.decode(request.getParameter("userId"));
		String realName = URLDecoder.decode(request.getParameter("realName"),"UTF-8");
		String gradeName = URLDecoder.decode(request.getParameter("gradeName"),"UTF-8");
		String clazzName = URLDecoder.decode(request.getParameter("clazzName"),"UTF-8");
		String parentName = URLDecoder.decode(request.getParameter("parentName"),"UTF-8");
		String leaderName = URLDecoder.decode(request.getParameter("leaderName"),"UTF-8");
//		String templateName = URLDecoder.decode(request.getParameter("templateName"));
		modelMap.put("userId", userId);
		modelMap.put("realName", realName);
		modelMap.put("gradeName", gradeName);
		modelMap.put("clazzName", clazzName);
		modelMap.put("parentName", parentName);
		modelMap.put("leaderName", leaderName);
//		modelMap.put("templateName", templateName);
		List<GrowthArchive> list = growthArchiveService.getModalInfoByUserId(userId);
		request.setAttribute("list", GsonHelper.toJson(list));
		return "growthArchives/archive_stage";
	}

	/**
	 * 新增页面
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/doAddGrowth.do")
	public String doAddGrowth(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		String templateId = request.getParameter("templateId");
		String userId = request.getParameter("userId");
		try
		{
			int template = 0;
			if (templateId != null && !"".equals(templateId))
			{
				template = Integer.valueOf(templateId);
			}
			// 获取学期，9月之前为下学期，9月之后为上学期
			int term = 0;
			Date now = new Date();
			boolean isLastTerm = now.getMonth() > 9;
			if (!isLastTerm)
			{
				term = 1;
			}
			// 获取年级
			String gradeName = gradeService.getGradeByUserId(Integer.valueOf(userId));
			SelfGrowth sg = new SelfGrowth();
			sg.setTemplateId(template);
			sg.setUserId(Integer.valueOf(userId));
			sg.setGradeName(gradeName);
			sg.setTerm(term);
			sg.setCreateTime(TimeUtil.getInstance().now());
			int growthId = growthArchiveService.addSelfGrowth(sg);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("growthId", growthId);
			map.put("code", "0");

			response.getWriter().write(GsonHelper.toJson(map));
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 进入档案首页
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "toAddArchive.do")
	public String toAddArchive(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		String userId = request.getParameter("userId");
		String endDate = request.getParameter("endDate");
		String growthId = request.getParameter("growthId");
		String roleCode = request.getParameter("roleCode");
		if (roleCode == null || "".equals(roleCode))
		{
			roleCode = "classLeader";
		}
		try
		{
			GrowthArchive ga = growthArchiveService.getArchiveInfoByUserId(Integer.valueOf(userId));
			modelMap.addAttribute("ga", ga);
			modelMap.addAttribute("endDate", endDate);
			modelMap.addAttribute("growthId", growthId);
			modelMap.addAttribute("roleCode", roleCode);
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return "growthArchives/archive_detail";
	}

	/**
	 * 获取档案详情
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getInfo.do")
	public String getInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		String userId = request.getParameter("userId");
		String growthId = request.getParameter("growthId");
		try
		{
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("userId", Integer.valueOf(userId));
			map.put("growthId", Integer.valueOf(growthId));
			UserDetail ud = growthArchiveService.getInfoByUserId(map);
			// 不存在，则创建
			if (ud == null)
			{
				ud = new UserDetail();
				ud.setGrowthId(Integer.valueOf(growthId));
				ud.setUserId(Integer.valueOf(userId));
				int id = growthArchiveService.addPalmUserDetail(ud);
				ud.setId(id);
			}
			response.getWriter().write(GsonHelper.toJson(ud));
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 保存成长档案页面图片
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/saveDetailInfo.do")
	public String saveDetailImg(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setContentType("text/html;charset=UTF-8");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		String detailId = request.getParameter("detailId");
		String userId = request.getParameter("userId");
		String zoodiac = request.getParameter("zoodiac");
		String bloodType = request.getParameter("bloodType");
		String favorite = request.getParameter("favorite");
		String nickName = request.getParameter("nickName");
		String birthday = request.getParameter("birthDay");
		String sex = request.getParameter("sex");
		String imgPath = request.getParameter("imgPath");
		UserDetail ud = new UserDetail();
		boolean hashFile = false;
		if (detailId != null)
		{
			try
			{
				ud.setId(Integer.valueOf(detailId));
				ud.setUserId(Integer.valueOf(userId));
				ud.setZoodiac(zoodiac);
				ud.setBloodType(bloodType);
				ud.setFavorite(favorite);
				ud.setNickName(nickName);
				ud.setBirthday(birthday);
				ud.setSex(Integer.valueOf(sex));
				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
				for (Iterator it = multipartRequest.getFileNames(); it.hasNext();)
				{
					String key = (String) it.next();
					MultipartFile imgFile = multipartRequest.getFile(key);
					if (imgFile.getOriginalFilename().length() > 0)
					{
						hashFile = true;
						String fileName = imgFile.getOriginalFilename();
						String uploadFilePathTemp = request.getSession().getServletContext().getRealPath("/") + "temp";
						File dir = new File(uploadFilePathTemp);
						if (!dir.exists())
						{
							dir.mkdirs();
						}
						String fileNameStr = formatter.format(new Date())+"__"+fileName;
						File tempFile = new File(uploadFilePathTemp + "/" + fileNameStr );
						if (!tempFile.exists())
						{
							tempFile.createNewFile();
						}
						imgFile.transferTo(tempFile);
						FileUploadUtil fuu = new FileUploadUtil();
						fuu.simpleUpload(tempFile.getAbsolutePath(), "growth/archive/"+fileName, Cons.QINIU_BUCKETNAME_GROWTH);
						tempFile.delete();
						ud.setImgPath(Cons.QINIU_BUCKETNAME_GROWTH_URL + "growth/archive/"+fileName);
					}
					
				}
				if (!hashFile)
				{
					ud.setImgPath(imgPath);
				}
				growthArchiveService.updateUserDetailInfo(ud);
				response.getWriter().write(GsonHelper.toJson("0"));
				response.getWriter().flush();
			} catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		
		return null;
	}
	/**
	 * 根据档案ID和类型获取页面内容
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/getContentByGrowthIdAndType.do")
	public String getContentByGrowthIdAndType(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		String growthId = request.getParameter("growthId");
		String type= request.getParameter("type");
		try
		{
		if (growthId != null)
		{
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("growthId", Integer.valueOf(growthId));
			map.put("type", Integer.valueOf(type));
			List<GrowthContent> contentList = growthArchiveService.getContentByGrowthIdAndType(map);
			response.getWriter().write(GsonHelper.toJson(contentList));
			response.getWriter().flush();
		}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	/**
	 * 保存页面内容
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/saveContent.do")
	public String saveContent(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setContentType("text/html;charset=UTF-8");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		String growthId = request.getParameter("growthId");		
		String type= request.getParameter("type");
		String contentId = request.getParameter("contentId");
		String content = request.getParameter("content");
		User login = (User)session.getAttribute("user");
		String modal = request.getParameter("modal");
		String img1Path = request.getParameter("img1Path");
		String img2Path = request.getParameter("img2Path");
		String img3Path = request.getParameter("img3Path");
		boolean hasImg1=false,hasImg2=false,hasImg3=false;
		try
		{
			GrowthContent gc = new GrowthContent();
			if (content != null)
			{
				gc.setContent(content);
			}
			gc.setGrowthId(Integer.valueOf(growthId));
			gc.setType(Integer.valueOf(type));
			
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		
			for (Iterator it = multipartRequest.getFileNames(); it.hasNext();)
			{
				String key = (String) it.next();
				MultipartFile imgFile = multipartRequest.getFile(key);
				if (imgFile.getOriginalFilename().length() > 0)
				{
					String fileName = imgFile.getOriginalFilename();
					String uploadFilePathTemp = request.getSession().getServletContext().getRealPath("/") + "temp";
					File dir = new File(uploadFilePathTemp);
					if (!dir.exists())
					{
						dir.mkdirs();
					}
					String fileNameStr = formatter.format(new Date())+"__"+fileName;
					File tempFile = new File(uploadFilePathTemp + "/" + fileNameStr );
					if (!tempFile.exists())
					{
						tempFile.createNewFile();
					}
					imgFile.transferTo(tempFile);
					FileUploadUtil fuu = new FileUploadUtil();
					fuu.simpleUpload(tempFile.getAbsolutePath(), "growth/"+modal+"/"+fileName, Cons.QINIU_BUCKETNAME_GROWTH);
					tempFile.delete();
					if (key.equals("file"))
					{
						gc.setFirstImgPath(Cons.QINIU_BUCKETNAME_GROWTH_URL + "growth/"+modal+"/"+fileName);
						hasImg1 = true;
					}else if(key.equals("file2"))
					{
						gc.setSecondImgPath(Cons.QINIU_BUCKETNAME_GROWTH_URL + "growth/"+modal+"/"+fileName);
						hasImg2 = true;
					}else if (key.equals("file3"))
					{
						gc.setThirdImgPath(Cons.QINIU_BUCKETNAME_GROWTH_URL + "growth/"+modal+"/"+fileName);
						hasImg3 = true;
					}
				}
			}
			if (!hasImg1 && img1Path != null)
			{
				gc.setFirstImgPath(img1Path);
			}
			if (!hasImg2 && img2Path != null)
			{
				gc.setSecondImgPath(img2Path);
			}
			if (!hasImg3 && img3Path != null)
			{
				gc.setThirdImgPath(img3Path);
			}
			if (contentId != null && !"".equals(contentId))
			{
				gc.setId(Integer.valueOf(contentId));
				gc.setCreateTime(TimeUtil.getInstance().now());
				gc.setUpdateTime(TimeUtil.getInstance().now());
				gc.setCreaterId(login.getUserId());
				growthArchiveService.saveContent(gc);
			}else
			{
				gc.setUpdateTime(TimeUtil.getInstance().now());
				growthArchiveService.addContent(gc);
			}
			response.getWriter().write(GsonHelper.toJson("0"));
			response.getWriter().flush();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 删除档案内容
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/deleteContent.do")
	public String deleteContent(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		String contentId = request.getParameter("contentId");
		try
		{
			if (contentId != null && !"".equals(contentId))
			{
				//根据contentId查询对应的成长档案内容 用于删除七牛上对应的图片
				GrowthContent growthContent = growthArchiveService.getContentByContentId(Integer.valueOf(contentId));
				
				if(growthContent!=null)
				{
					growthArchiveService.deleteContent(Integer.valueOf(contentId));
					
					FileUploadUtil fuu = new FileUploadUtil();
					
					if(!StringUtil.isEmpty(growthContent.getFirstImgPath()))
					{
						String firstImgPath = growthContent.getFirstImgPath();
						fuu.simpleDelete(Cons.QINIU_BUCKETNAME_GROWTH, firstImgPath.substring(Cons.QINIU_BUCKETNAME_GROWTH_URL.length()));
					}
					if(!StringUtil.isEmpty(growthContent.getSecondImgPath()))
					{
						String secondImgPath = growthContent.getSecondImgPath();
						fuu.simpleDelete(Cons.QINIU_BUCKETNAME_GROWTH, secondImgPath.substring(Cons.QINIU_BUCKETNAME_GROWTH_URL.length()));
					}
					if(!StringUtil.isEmpty(growthContent.getThirdImgPath()))
					{
						String thirdImgPath = growthContent.getThirdImgPath();
						fuu.simpleDelete(Cons.QINIU_BUCKETNAME_GROWTH, thirdImgPath.substring(Cons.QINIU_BUCKETNAME_GROWTH_URL.length()));
					}
				}
				
				response.getWriter().write(GsonHelper.toJson("0"));
				response.getWriter().flush();
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
}
