package com.guotop.palmschool.asset.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.guotop.palmschool.asset.entity.Asset;
import com.guotop.palmschool.asset.entity.AssetRepair;
import com.guotop.palmschool.asset.entity.AssetRepairImg;
import com.guotop.palmschool.asset.entity.AssetServiceman;
import com.guotop.palmschool.asset.service.AssetService;
import com.guotop.palmschool.asset.tool.AssetType;
import com.guotop.palmschool.asset.tool.Type;
import com.guotop.palmschool.asset.tool.Units;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.service.DepartmentService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.FileUploadUtil;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.Qcode;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

import dev.gson.GsonHelper;

/**
 * 资产控制类
 * 
 * @author 陶明月
 */
@RequestMapping("/asset")
@Controller
public class AssetController extends BaseController
{
	@Resource
	private AssetService assetService;

	@Resource
	private UserService userService;

	@Resource
	private CommonService commonService;

	@Resource
	private DepartmentService departmentService;

	/**
	 * 资产记录页面
	 */
	@RequestMapping(value = "/toAssetInfoList.do")
	public String toAssetInfoList(HttpSession session,Model model)
	{
		User user=(User) session.getAttribute("user");
		model.addAttribute("schoolId",user.getSchoolId());
		return "asset/asset_list";
	}

	/**
	 * 资产导入页面
	 */
	@RequestMapping(value = "/toAssetImport.do")
	public String toAssetImport()
	{
		return "asset/asset_import";
	}
	/**
	 * 手机端显示资产详细
	 * @author chenyong
	 * @Time 2017年2月27日 下午1:37:45
	 */
	@RequestMapping("/toAppAssetDetail.do")
    public String toAppAssetDetail(String id,Model model,String schoolId){
    	model.addAttribute("assetId", id);
    	model.addAttribute("schoolId",schoolId);
    	List<Type> list = AssetType.getList();
    	DBContextHolder.setDBType(schoolId);
    	List<User> listPerson = userService.getAllUserExceptStudentAndPArent();
    	model.addAttribute("type", GsonHelper.toJson(list));
    	model.addAttribute("listPerson", GsonHelper.toJson(listPerson));
		return "app/asset/asset_detail";
    	
    }
	/**
	 * 根据资产ID获取资产详情
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getAppAssetDetailById.do")
	public String getAppAssetDetailById(HttpServletRequest request, HttpServletResponse response,String schoolId)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer id = StringUtil.toint(request.getParameter("id"));
			DBContextHolder.setDBType(schoolId);
			Asset asset = assetService.getAssetDetailById(id);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(asset);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 资产添加页面
	 */
	@RequestMapping(value = "/toAssetAdd.do")
	public String toAssetAdd()
	{
		return "asset/asset_add";
	}

	/**
	 * 维修列表页面
	 */
	@RequestMapping(value = "/toAssetRepairList.do")
	public String toAssetRepairList()
	{
		return "asset/asset_repair_list";
	}

	/**
	 * 维修人员列表页面
	 */
	@RequestMapping(value = "/toAssetServicemanList.do")
	public String toAssetServicemanList()
	{
		return "asset/asset_serviceman_list";
	}

	/**
	 * 进入添加维修人员列表页面
	 */
	@RequestMapping(value = "/toAddAssetServiceman.do")
	public String toAddAssetServiceman()
	{
		return "asset/asset_serviceman_add";
	}

	/**
	 * 资产报修页面
	 */
	@RequestMapping(value = "/toAssetRepair.do")
	public String toAssetRepair(HttpSession session, ModelMap modelMap)
	{
		User user = (User) session.getAttribute("user");
		String personnelType = assetService.getPersonnelType(user);
		modelMap.addAttribute("personnelType", personnelType);
		modelMap.addAttribute("realName", user.getRealName());
		modelMap.addAttribute("phone", user.getPhone());
		modelMap.addAttribute("userId", user.getUserId());
		return "asset/asset_repair";
	}

	/**
	 * 获取资产列表（分页）
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/getAssetList.do")
	public String getAssetList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			User user = (User) session.getAttribute("user");
			String name = request.getParameter("name");
			String code = request.getParameter("code");
			String type = request.getParameter("type");
			/**
			 * 分页信息
			 */
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("page"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			int personOrschool = StringUtil.toint(request.getParameter("personOrschool"));
			int pageSize = StringUtil.toint(request.getParameter("pageSize"));
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("name", name);
			params.put("code", code);
			params.put("type", type);
			params.put("userId", user.getUserId());
			Pages pages = assetService.getAssetList(currentPage, pageSize, personOrschool,user,params);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取资产导入列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/getImportList.do")
	public String getImportList(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			/**
			 * 分页信息
			 */
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("page"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			int pageSize = StringUtil.toint(request.getParameter("pageSize"));

			Pages pages = assetService.getImportList(currentPage, pageSize);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 添加资产
	 */
	@RequestMapping(value = "/doAddAsset.do")
	public String doAddAsset(HttpServletRequest request, HttpSession session)
	{
		String code = request.getParameter("code");
		String name = request.getParameter("name");
		String manufacturer = request.getParameter("manufacturer");
		String spec = request.getParameter("spec");
		String model = request.getParameter("model");
		Integer type = Integer.valueOf(request.getParameter("type"));
		Integer property = Integer.valueOf(request.getParameter("property"));
		Integer receiveId = null;
		try
		{
			receiveId = Integer.valueOf(request.getParameter("receiveId"));
		} catch (Exception e)
		{
			receiveId = null;
		}
		String units = request.getParameter("units");
		Integer count = Integer.valueOf(request.getParameter("count"));
		Double price = Double.valueOf(request.getParameter("price"));
		Integer respPersonId = Integer.valueOf(request.getParameter("respPersonId"));
		Integer isBluetooth = Integer.valueOf(request.getParameter("isBluetooth"));
		String respPerson = request.getParameter("respPerson");
		String site = request.getParameter("site");
		String buyDate = request.getParameter("buyDate");
		String qualityDate = request.getParameter("qualityDate");
		String remark = request.getParameter("remark");
		Asset asset = new Asset();
		asset.setBuyDate(buyDate);
		asset.setCode(code);
		asset.setCount(count);
		asset.setCreateTime(TimeUtil.getInstance().now());
		asset.setModel(model);
		asset.setIsBluetooth(isBluetooth);
		asset.setName(name);
		asset.setManufacturer(manufacturer);
		asset.setPrice(price);
		asset.setQualityDate(qualityDate);
		asset.setRemark(remark);
		asset.setRespPerson(respPerson);
		asset.setRespPersonId(respPersonId);
		asset.setSite(site);
		asset.setSpec(spec);
		asset.setType(type);
		asset.setUnits(units);
		asset.setProperty(property);
		asset.setReceiveId(receiveId);
		if(receiveId != null)
		{
			asset.setReceiveTime(TimeUtil.getInstance().now());
		}
		assetService.addAsset(asset);
		return "redirect:/asset/toAssetInfoList.do";
	}

	/**
	 * 修改资产
	 */
	@RequestMapping(value = "/modifyAsset.do")
	public String modifyAsset(HttpServletRequest request, HttpServletResponse response)
	{
		try
		{
			Integer assetId = Integer.valueOf(request.getParameter("assetId"));
			Asset ass = assetService.getAssetDetailById(assetId);
			String code = request.getParameter("code");
			String name = request.getParameter("name");
			String manufacturer = request.getParameter("manufacturer");
			Integer type = Integer.valueOf(request.getParameter("type"));
			Integer respPersonId = Integer.valueOf(request.getParameter("respPersonId"));
			String respPerson = request.getParameter("respPerson");
			String spec = request.getParameter("spec");
			String model = request.getParameter("model");
			String units = request.getParameter("units");
			String site = request.getParameter("site");
			String buyDate = request.getParameter("buyDate");
			String qualityDate = request.getParameter("qualityDate");
			String remark = request.getParameter("remark");
			Integer count = Integer.valueOf(request.getParameter("count"));
			Double price = Double.valueOf(request.getParameter("price"));
			Integer property = Integer.valueOf(request.getParameter("property"));
			Integer receiveId = null;
			try
			{
				receiveId = Integer.valueOf(request.getParameter("receiveId"));
			} catch (Exception e)
			{
				receiveId = null;
			}
			Asset asset = new Asset();
			asset.setId(assetId);
			asset.setBuyDate(buyDate);
			asset.setCode(code);
			asset.setCount(count);
			asset.setManufacturer(manufacturer);
			asset.setUpdateTime(TimeUtil.getInstance().now());
			asset.setModel(model);
			asset.setName(name);
			asset.setPrice(price);
			asset.setQualityDate(qualityDate);
			asset.setRemark(remark);
			asset.setRespPerson(respPerson);
			asset.setRespPersonId(respPersonId);
			asset.setSite(site);
			asset.setSpec(spec);
			asset.setType(type);
			asset.setUnits(units);
			asset.setProperty(property);
			asset.setReceiveId(receiveId);
			if(receiveId !=null && (ass.getReceiveId()== null || !ass.getReceiveId().equals(receiveId)))
			{
				asset.setReceiveTime(TimeUtil.getInstance().now());
			}
			assetService.modifyAsset(asset);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 领取资产
	 */
	@RequestMapping(value = "/receiveAssetById.do")
	public String receiveAssetById(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try
		{
			Integer assetId = Integer.valueOf(request.getParameter("id"));
			User user = (User) session.getAttribute("user");
			Asset asset = new Asset();
			asset.setId(assetId);
			asset.setReceiveId(user.getUserId());
			asset.setReceiveTime(TimeUtil.getInstance().now());
			asset.setUpdateTime(TimeUtil.getInstance().now());
			assetService.modifyAsset(asset);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据资产ID获取资产详情
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getAssetDetailById.do")
	public String getAssetDetailById(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer id = StringUtil.toint(request.getParameter("id"));

			Asset asset = assetService.getAssetDetailById(id);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(asset);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据资产类型获取自己的资产列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getAllAssetListByType.do")
	public String getAllAssetListByType(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer type = StringUtil.toint(request.getParameter("type"));

			User user = (User) session.getAttribute("user");
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("type", type);
			paramMap.put("userId", user.getUserId());
			List<Asset> assetList = assetService.getAllAssetListByType(paramMap);
			/**
			 * flush到页面	
			 */
			Gson gson = new Gson();
			String json = gson.toJson(assetList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据资产ID获取资产详情
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/deleteAssetById.do")
	public String deleteAssetById(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer id = StringUtil.toint(request.getParameter("id"));

			assetService.deleteAssetById(id);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 添加维修列表
	 */
	@RequestMapping(value = "/doAddAssetRepair.do")
	public String doAddAssetRepair(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try
		{
			User user = (User) session.getAttribute("user");
			Integer userId = Integer.valueOf(request.getParameter("userId"));
			String realName = request.getParameter("realName");
			String phone = request.getParameter("phone");
			Integer type = Integer.valueOf(request.getParameter("type"));
			Double price = 0.00;
			try
			{
				price = Double.valueOf(request.getParameter("price"));
			} catch (Exception e)
			{
				price = 0.00;
			}
			String personnelType = request.getParameter("personnelType");// leader领导,serviceman维修人员,repair普通报修人员
			String remark = request.getParameter("remark");

			/**
			 * 资产数组
			 */
			String[] assetArr = request.getParameter("assetArr").split(",");
			/**
			 * 维修人员数据
			 */
			String[] servicemanArr = request.getParameter("servicemanArr").split(",");

			String currentTime = TimeUtil.getInstance().now();
			List<AssetRepairImg> repairImgList = new ArrayList<>();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile imgFile1 = multipartRequest.getFile("imgFile1");
			MultipartFile imgFile2 = multipartRequest.getFile("imgFile2");
			List<MultipartFile> fileList = new ArrayList<MultipartFile>();
			boolean flag = false;
			if(!imgFile1.isEmpty()){
				flag = true;
				fileList.add(imgFile1);
			}
			if(!imgFile2.isEmpty()){
				flag = true;
				fileList.add(imgFile2);
			}
			for(MultipartFile imgFile:fileList){
				if (imgFile.getOriginalFilename().length() > 0)
				{
					String fileName = imgFile.getOriginalFilename();
					String uploadFilePathTemp = request.getSession().getServletContext().getRealPath("/") + "temp";
					File dir = new File(uploadFilePathTemp);
					if (!dir.exists())
					{
						dir.mkdirs();
					}
					String fileNameStr = formatter.format(new Date()) + "__" + fileName;
					File tempFile = new File(uploadFilePathTemp + "/" + fileNameStr);
					if (!tempFile.exists())
					{
						tempFile.createNewFile();
					}
					imgFile.transferTo(tempFile);
					FileUploadUtil fuu = new FileUploadUtil();
					String path = "asset/repairgraph/" + userId +"_"+ System.currentTimeMillis() + "/" + fileName;
					fuu.simpleUpload(tempFile.getAbsolutePath(), path, Cons.QINIU_BUCKETNAME_RICH_CLOUD);
					tempFile.delete();

					AssetRepairImg repairImg = new AssetRepairImg();
					repairImg.setCreateTime(currentTime);
					repairImg.setName(fileName);
					repairImg.setPath(Cons.QINIU_BUCKETNAME_RICH_CLOUD_URL + path);
					repairImgList.add(repairImg);
				}
			}

			// 推送手机端消息
			List<PushItem> list = new ArrayList<PushItem>();
			if (personnelType.equals("leader"))
			{
				if (assetArr != null && servicemanArr != null)
				{
					for (int j = 0; j < servicemanArr.length; j++)
					{
						String content = "";
						Integer servicemanId = Integer.valueOf(servicemanArr[j]);
						for (int i = 0; i < assetArr.length; i++)
						{
							AssetRepair repair = new AssetRepair();
							repair.setAssetId(Integer.valueOf(assetArr[i]));
							repair.setPhone(phone);
							repair.setPrice(price);
							if(servicemanId.equals(userId)){
								repair.setRepairPrice(price);
							}
							repair.setRealName(realName);
							repair.setRemark(remark);
							repair.setServicemanId(servicemanId);
							repair.setType(type);
							repair.setStatus(2);
							repair.setUserId(userId);
							repair.setCreateTime(currentTime);
							repair.setReceiveTime(currentTime);
							repair.setAuditTime(currentTime);
							repair.setUpdateTime(currentTime);
							
							Integer repairId = assetService.addAssetRepair(repair);
							if (flag)
							{
								for (AssetRepairImg repairImg : repairImgList)
								{
									repairImg.setRepairId(repairId);
									assetService.addAssetRepairImg(repairImg);
								}
							}

							Asset asset = assetService.getAssetDetailById(Integer.valueOf(assetArr[i]));
							content = asset.getName() + "(" + asset.getCode() + ")";
							
							User receiver = commonService.getUserByUserIdForPush(Integer.valueOf(servicemanArr[j]));
							PushItem pi = new PushItem();
							pi.receiverId = receiver.getUserId();
							pi.channels = receiver.getBaiduChannelId();
							pi.deviceType = String.valueOf(receiver.getDeviceType());
							pi.PushContent = receiver.getRealName() + "您好，" + user.getRealName() + "已提交资产:" + content + "报修申请，请及时进行维修!";
							pi.PushType = PUSHTYPE.ASSETREPAIR.getType();
							pi.PushContentType = PUSHTYPE.ASSETREPAIR.getContentType();
							pi.title = PUSHTYPE.ASSETREPAIR.getName();
							pi.schoolId = String.valueOf(user.getSchoolId());
							pi.OperationapplyId = repairId;
							list.add(pi);
						}
					}
				}
			} else if (personnelType.equals("serviceman"))
			{
				if (assetArr != null)
				{
					String content = "";
					for (int i = 0; i < assetArr.length; i++)
					{
						AssetRepair repair = new AssetRepair();
						repair.setAssetId(Integer.valueOf(assetArr[i]));
						
						repair.setPhone(phone);
						repair.setPrice(price);
						repair.setRepairPrice(price);
						repair.setRealName(realName);
						repair.setRemark(remark);
						repair.setServicemanId(userId);
						repair.setType(type);
						repair.setStatus(1);
						repair.setUserId(userId);
						repair.setCreateTime(currentTime);
						repair.setReceiveTime(currentTime);
						repair.setUpdateTime(currentTime);
						Integer repairId = assetService.addAssetRepair(repair);
						if (flag)
						{
							for (AssetRepairImg repairImg : repairImgList)
							{
								repairImg.setRepairId(repairId);
								assetService.addAssetRepairImg(repairImg);
							}
						}

						Asset asset = assetService.getAssetDetailById(Integer.valueOf(assetArr[i]));
						content = asset.getName() + "(" + asset.getCode() + ")";
						
						List<User> leaderList = assetService.getLeaderListByServicemanIdForPush(userId, type);
						for (User leader : leaderList)
						{
							PushItem pi = new PushItem();
							pi.receiverId = leader.getUserId();
							pi.channels = leader.getBaiduChannelId();
							pi.deviceType = String.valueOf(leader.getDeviceType());
							pi.PushContent = leader.getRealName() + "您好，" + user.getRealName() + "已提交资产:" + content + "报修申请，请及时审核!";
							pi.PushType = PUSHTYPE.ASSETREPAIR.getType();
							pi.PushContentType = PUSHTYPE.ASSETREPAIR.getContentType();
							pi.title = PUSHTYPE.ASSETREPAIR.getName();
							pi.schoolId = String.valueOf(user.getSchoolId());
							pi.OperationapplyId = repairId;
							list.add(pi);
						}
					}
				}
			} else
			{
				if (assetArr != null && servicemanArr != null)
				{
					String content = "";
					for (int j = 0; j < servicemanArr.length; j++)
					{
						content = "";
						Integer servicemanId = Integer.valueOf(servicemanArr[j]);
						User receiver = commonService.getUserByUserIdForPush(servicemanId);
						for (int i = 0; i < assetArr.length; i++)
						{
							AssetRepair repair = new AssetRepair();
							repair.setAssetId(Integer.valueOf(assetArr[i]));
							repair.setCreateTime(currentTime);
							repair.setUpdateTime(currentTime);
							repair.setPhone(phone);
							repair.setPrice(price);
							if(servicemanId.equals(userId)){
								repair.setRepairPrice(price);
							}
							repair.setRealName(realName);
							repair.setRemark(remark);
							repair.setServicemanId(Integer.valueOf(servicemanArr[j]));
							repair.setType(type);
							repair.setStatus(0);
							repair.setUserId(userId);
							Integer repairId = assetService.addAssetRepair(repair);
							if (flag)
							{
								for (AssetRepairImg repairImg : repairImgList)
								{
									repairImg.setRepairId(repairId);
									assetService.addAssetRepairImg(repairImg);
								}
							}

							Asset asset = assetService.getAssetDetailById(Integer.valueOf(assetArr[i]));
							content = asset.getName() + "(" + asset.getCode() + ")";
							
							PushItem pi = new PushItem();
							pi.receiverId = receiver.getUserId();
							pi.channels = receiver.getBaiduChannelId();
							pi.deviceType = String.valueOf(receiver.getDeviceType());
							pi.PushContent = receiver.getRealName() + "您好，" + user.getRealName() + "已提交资产:" + content + "报修申请，请及时领取工单!";
							pi.PushType = PUSHTYPE.ASSETREPAIR.getType();
							pi.PushContentType = PUSHTYPE.ASSETREPAIR.getContentType();
							pi.title = PUSHTYPE.ASSETREPAIR.getName();
							pi.schoolId = String.valueOf(user.getSchoolId());
							pi.OperationapplyId = repairId;
							list.add(pi);
						}
					}
				}
			}

			if (!CollectionUtils.isEmpty(list))
			{
				commonService.pushMsg(list, false);
			}

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 校验编码是否存在
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/checkCode.do")
	public String checkCode(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			String code = request.getParameter("code");
			String oldcode = request.getParameter("oldcode");

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("code", code);
			paramMap.put("oldcode", oldcode);
			boolean flag = assetService.checkCode(paramMap);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取维修人员列表（分页）
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/getServicemanList.do")
	public String getServicemanList(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			String code = request.getParameter("code");// 员工编号或者姓名
			String type = request.getParameter("type");// 维修类型
			String choose = request.getParameter("choose");// 维修类型
			
			/**
			 * 分页信息
			 */
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("page"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			int pageSize = StringUtil.toint(request.getParameter("pageSize"));
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("code", code);
			params.put("type", type);
			params.put("choose", choose);

			Pages pages = assetService.getServicemanList(currentPage, pageSize, params);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 添加维修人员列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/doAddServiceman.do")
	public String doAddServiceman(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer servicemanId = Integer.valueOf(request.getParameter("servicemanId"));
			String serviceman = request.getParameter("serviceman");
			String phone = request.getParameter("phone");
			String code = request.getParameter("code");
			String leaderIdOne = request.getParameter("leaderIdOne");
			String leaderOne = request.getParameter("leaderOne");
			String leaderIdTwo = request.getParameter("leaderIdTwo");
			String leaderTwo = request.getParameter("leaderTwo");
			Integer type = Integer.valueOf(request.getParameter("type"));

			//添加之前需要判断维修人员维修的类型是否已经存在
			boolean flag = assetService.isExistServicemanByServicemanIdAndType(servicemanId,type);
			Gson gson = new Gson();
			String json;
			if(!flag){
				AssetServiceman as = new AssetServiceman();
				as.setServicemanId(servicemanId);
				as.setServiceman(serviceman);
				as.setPhone(phone);
				as.setCode(code);
				as.setType(type);
				if(!StringUtil.isEmpty(leaderIdOne)){
					as.setLeaderIdOne(Integer.valueOf(leaderIdOne));
					as.setLeaderOne(leaderOne);
				}
				if(!StringUtil.isEmpty(leaderIdTwo)){
					as.setLeaderIdTwo(Integer.valueOf(leaderIdTwo));
					as.setLeaderTwo(leaderTwo);
				}
				as.setCreateTime(TimeUtil.getInstance().now());
				assetService.addAssetServiceman(as);
				json = gson.toJson(true);
			}else{
				json = gson.toJson(false);
			}
			/**
			 * flush到页面
			 */
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据类型获取对应的维修人员
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getAllServicemanListByType.do")
	public String getAllServicemanListByType(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer type = StringUtil.toint(request.getParameter("type"));// 维修类型

			List<AssetServiceman> list = assetService.getAllServicemanListByType(type);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(list);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取负责人列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getRespPerson.do")
	public String getRespPerson(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			List<User> list = userService.getAllUserExceptStudentAndPArent();

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(list);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取计量单位
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getUnitsList.do")
	public String getUnitsList(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			List<String> list = Units.getList();

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(list);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取资产类型
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getAssetTypeList.do")
	public String getAssetTypeList(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			List<Type> list = AssetType.getList();

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(list);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据用户ID获取对应的部门领导人包含校长和管理员
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getLeaderListByUserId.do")
	public String getLeaderListByUserId(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{

			Integer userId = StringUtil.toint(request.getParameter("userId"));// 维修类型
			List<User> list = userService.getLeaderListByUserId(userId);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(list);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取维修列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/getAssetRepairList.do")
	public String getAssetRepairList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			User user = (User) session.getAttribute("user");
			String status = request.getParameter("status");
			String type = request.getParameter("type");
			/**
			 * 分页信息
			 */
			Integer currentPage = 1;
			try
			{
				currentPage = Integer.valueOf(request.getParameter("page"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			String personnelType = assetService.getPersonnelType(user);
			int pageSize = StringUtil.toint(request.getParameter("pageSize"));
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("status", status);
			params.put("type", type);
			params.put("userId", user.getUserId());

			Pages pages = assetService.getAssetRepairList(currentPage, pageSize, personnelType, user ,params);
			params.put("pages", pages);
			params.put("personnelType", personnelType);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(params);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 根据ID获取资产维修详情
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getAssetRepairDetailById.do")
	public String getAssetRepairDetailById(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			int id = StringUtil.toint(request.getParameter("id"));

			AssetRepair repair = assetService.getAssetRepairDetailById(id);
			List<AssetRepairImg> imgList = assetService.getAssetRepairImgListByRepairId(id);
			repair.setImgList(imgList);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(repair);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 催单通知
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/repairReminder.do")
	public String repairReminder(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			User user = (User) session.getAttribute("user");
			int repairId = StringUtil.toint(request.getParameter("repairId"));

			AssetRepair repair = assetService.getAssetRepairDetailById(repairId);
			List<PushItem> piList = new ArrayList<>();
			if (repair.getStatus() == 0)// 待处理状态通知维修人员接单处理
			{
				User receiver = commonService.getUserByUserIdForPush(repair.getServicemanId());
				PushItem pi = new PushItem();
				pi.receiverId = receiver.getUserId();
				pi.channels = receiver.getBaiduChannelId();
				pi.deviceType = String.valueOf(receiver.getDeviceType());
				pi.PushContent = receiver.getRealName() + "您好，资产：" + repair.getAssetName() + "(" + repair.getAssetCode() + ")维修申请，请及时领取工单！";
				pi.PushType = PUSHTYPE.ASSETREPAIRREMINDER.getType();
				pi.PushContentType = PUSHTYPE.ASSETREPAIRREMINDER.getContentType();
				pi.title = PUSHTYPE.ASSETREPAIRREMINDER.getName();
				pi.schoolId = String.valueOf(user.getSchoolId());
				pi.OperationapplyId = repairId;
				piList.add(pi);
			} else if (repair.getStatus() == 1)// 待审核状态通知维修人领导审核
			{
				List<User> leaderList = assetService.getLeaderListByServicemanIdForPush(repair.getServicemanId(), repair.getType());
				for (User receiver : leaderList)
				{
					PushItem pi = new PushItem();
					pi.receiverId = receiver.getUserId();
					pi.channels = receiver.getBaiduChannelId();
					pi.deviceType = String.valueOf(receiver.getDeviceType());
					pi.PushContent = receiver.getRealName() + "您好，资产：" + repair.getAssetName() + "(" + repair.getAssetCode() + ")维修申请,请及时审核！";
					pi.PushType = PUSHTYPE.ASSETREPAIRREMINDER.getType();
					pi.PushContentType = PUSHTYPE.ASSETREPAIRREMINDER.getContentType();
					pi.title = PUSHTYPE.ASSETREPAIRREMINDER.getName();
					pi.schoolId = String.valueOf(user.getSchoolId());
					pi.OperationapplyId = repairId;
					piList.add(pi);
				}
			} else// 通知维修人进行维修
			{
				User receiver = commonService.getUserByUserIdForPush(repair.getServicemanId());
				PushItem pi = new PushItem();
				pi.receiverId = receiver.getUserId();
				pi.channels = receiver.getBaiduChannelId();
				pi.deviceType = String.valueOf(receiver.getDeviceType());
				pi.PushContent = receiver.getRealName() + "您好，资产：" + repair.getAssetName() + "(" + repair.getAssetCode() + ")维修申请已审核通过，请及时进行维修！";
				pi.PushType = PUSHTYPE.ASSETREPAIRREMINDER.getType();
				pi.PushContentType = PUSHTYPE.ASSETREPAIRREMINDER.getContentType();
				pi.title = PUSHTYPE.ASSETREPAIRREMINDER.getName();
				pi.schoolId = String.valueOf(user.getSchoolId());
				pi.OperationapplyId = repairId;
				piList.add(pi);
			}
			commonService.pushMsg(piList, false);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 修改资产维修状态
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/modifyAssetRepair.do")
	public String modifyAssetRepair(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			User user = (User) session.getAttribute("user");
			Integer repairId = StringUtil.toint(request.getParameter("repairId"));
			Integer status = StringUtil.toint(request.getParameter("status"));
			String auditRemark = request.getParameter("auditRemark");
			String repairPrice = request.getParameter("repairPrice");
			String estimatedTime = request.getParameter("estimatedTime");

			boolean flag = true;
			AssetRepair repair = new AssetRepair();
			repair = assetService.getAssetRepairDetailById(repairId);
			
			repair.setId(repairId);
			repair.setStatus(status);
			if (!StringUtil.isEmpty(auditRemark))
			{
				repair.setAuditRemark(auditRemark);
			}
			if (!StringUtil.isEmpty(repairPrice))
			{
				repair.setRepairPrice(Double.valueOf(repairPrice));
			}
			if (!StringUtil.isEmpty(estimatedTime))
			{
				repair.setEstimatedTime(estimatedTime);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	            Date dt1 = sdf.parse(repair.getCreateTime());
	            Date dt2 = sdf.parse(estimatedTime);
	            if (dt1.getTime() > dt2.getTime()) {
	            	flag = false;
	            }
			}
			if(status == 1){
				repair.setReceiveTime(TimeUtil.getInstance().now());
			}else if (status == 2 || status == 3)
			{
				repair.setAuditTime(TimeUtil.getInstance().now());
			}else if (status == 4)
			{
				repair.setFinishTime(TimeUtil.getInstance().now());
			}
			repair.setUpdateTime(TimeUtil.getInstance().now());
			
			if(flag){
				assetService.updateAsserRepair(repair);
				
				List<PushItem> piList = new ArrayList<>();
				if (status == 1)// 待审核推消息给维修人员领导
				{
					List<User> userList = assetService.getLeaderListByServicemanIdForPush(repair.getServicemanId(), repair.getType());
					for (User receiver : userList)
					{
						PushItem pi = new PushItem();
						pi.receiverId = receiver.getUserId();
						pi.channels = receiver.getBaiduChannelId();
						pi.deviceType = String.valueOf(receiver.getDeviceType());
						pi.PushContent = receiver.getRealName() + "您好，" + repair.getServiceman() + "已领取资产：" + repair.getAssetName() + "(" + repair.getAssetCode()
								+ ")维修工单，请及时审核！";
						pi.PushType = PUSHTYPE.ASSETREPAIRAUDIT.getType();
						pi.PushContentType = PUSHTYPE.ASSETREPAIRAUDIT.getContentType();
						pi.title = PUSHTYPE.ASSETREPAIRAUDIT.getName();
						pi.schoolId = String.valueOf(user.getSchoolId());
						pi.OperationapplyId = repairId;
						piList.add(pi);
					}
				} else if (status == 2 || status == 3)// 审核后通知维修人员进行维修并推消息给报修人
				{
					User receiver = commonService.getUserByUserIdForPush(repair.getServicemanId());
					PushItem pi = new PushItem();
					pi.receiverId = receiver.getUserId();
					pi.channels = receiver.getBaiduChannelId();
					pi.deviceType = String.valueOf(receiver.getDeviceType());
					if (status == 2)
					{
						pi.PushContent = receiver.getRealName() + "您好，资产：" + repair.getAssetName() + "(" + repair.getAssetCode() + ")维修申请已审核通过，请及时处理！";
						pi.PushType = PUSHTYPE.ASSETREPAIRAUDITPASS.getType();
						pi.PushContentType = PUSHTYPE.ASSETREPAIRAUDITPASS.getContentType();
						pi.title = PUSHTYPE.ASSETREPAIRAUDITPASS.getName();
					} else
					{
						pi.PushContent = receiver.getRealName() + "您好，资产：" + repair.getAssetName() + "(" + repair.getAssetCode() + ")维修申请未通过审核，理由：" + auditRemark;
						pi.PushType = PUSHTYPE.ASSETREPAIRAUDITREFU.getType();
						pi.PushContentType = PUSHTYPE.ASSETREPAIRAUDITREFU.getContentType();
						pi.title = PUSHTYPE.ASSETREPAIRAUDITREFU.getName();
					}

					pi.schoolId = String.valueOf(user.getSchoolId());
					pi.OperationapplyId = repairId;
					piList.add(pi);
					// 如果报修人员又是维修人员只推送一条
					if (repair.getServicemanId() != repair.getUserId())
					{
						User receiver2 = commonService.getUserByUserIdForPush(repair.getUserId());
						PushItem pi2 = new PushItem();
						pi2.receiverId = receiver2.getUserId();
						pi2.channels = receiver2.getBaiduChannelId();
						pi2.deviceType = String.valueOf(receiver2.getDeviceType());
						if (status == 2)
						{
							pi2.PushContent = receiver2.getRealName() + "您好，您申报的资产：" + repair.getAssetName() + "(" + repair.getAssetCode()
									+ ")维修申请已审核通过，已通知维修人员维修，请耐心等候！";
							pi2.PushType = PUSHTYPE.ASSETREPAIRAUDITPASS.getType();
							pi2.PushContentType = PUSHTYPE.ASSETREPAIRAUDITPASS.getContentType();
							pi2.title = PUSHTYPE.ASSETREPAIRAUDITPASS.getName();
						} else
						{
							pi2.PushContent = receiver2.getRealName() + "您好，您申报的资产：" + repair.getAssetName() + "(" + repair.getAssetCode() + "维修申请未通过审核，理由："
									+ auditRemark;
							pi2.PushType = PUSHTYPE.ASSETREPAIRAUDITREFU.getType();
							pi2.PushContentType = PUSHTYPE.ASSETREPAIRAUDITREFU.getContentType();
							pi2.title = PUSHTYPE.ASSETREPAIRAUDITREFU.getName();
						}
						pi2.schoolId = String.valueOf(user.getSchoolId());
						pi2.OperationapplyId = repairId;
						piList.add(pi2);
					}
				} else if (status == 4)// 维修完成通知报修人
				{
					User receiver = commonService.getUserByUserIdForPush(repair.getUserId());
					PushItem pi = new PushItem();
					pi.receiverId = receiver.getUserId();
					pi.channels = receiver.getBaiduChannelId();
					pi.deviceType = String.valueOf(receiver.getDeviceType());
					pi.PushContent = receiver.getRealName() + "您好，您报修的资产：" + repair.getAssetName() + "(" + repair.getAssetCode() + ")已维修完成，请知晓！";
					pi.PushType = PUSHTYPE.ASSETREPAIRFINISH.getType();
					pi.PushContentType = PUSHTYPE.ASSETREPAIRFINISH.getContentType();
					pi.title = PUSHTYPE.ASSETREPAIRFINISH.getName();
					pi.schoolId = String.valueOf(user.getSchoolId());
					pi.OperationapplyId = repairId;
					piList.add(pi);
				}
				commonService.pushMsg(piList, false);
			}


			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(flag);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 批量导出资源详情二维码
	 * @author chenyong
	 * @Time 2017年2月27日 下午5:48:44
	 */
	@RequestMapping("/importQcode.do")
	public void importQcode(HttpServletRequest request,HttpServletResponse response,HttpSession session){
		try { 
		User user = (User) session.getAttribute("user");
		String name = URLDecoder.decode(request.getParameter("name"),"UTF-8");
		String code = URLDecoder.decode(request.getParameter("code"),"UTF-8");
		String bashPath = URLDecoder.decode(request.getParameter("bashPath"),"UTF-8");
		String type = URLDecoder.decode(request.getParameter("type"),"UTF-8");
		int personOrschool = StringUtil.toint(request.getParameter("personOrschool"));
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", name);
		params.put("code", code);
		params.put("type", type);
		params.put("userId", user.getUserId());
		List<Asset> list=assetService.getAssetQcode(personOrschool,user,params);
		String path=request.getSession().getServletContext().getRealPath("\\templet\\"+System.currentTimeMillis());
		 String zipPath=path+".zip";
		 File zipFile = null;
		 File file = new File(path);
		if(!file.exists()){
			file.mkdirs();
	     }
		    Asset asset=null;
		    String assetname="";
		    Map<String,Integer> map=new HashMap<>();
			for (int i=0;i<list.size();i++) {
			asset=list.get(i);
			assetname=asset.getName();
			if(map.containsKey(assetname)){
				map.put(assetname,map.get(assetname)+1);
				assetname=assetname+"("+map.get(assetname)+")";
			}else{
				map.put(assetname,0);			
			}
			String text = bashPath+"asset/toAppAssetDetail.do?id="+asset.getAssetId()+"&schoolId="+user.getSchoolId()+"";
			int width = 200;
			int height = 200;
			Qcode.createQcode(text, path+"\\"+assetname+".png", width, height);
			}
			Qcode.createZip(path, zipPath);
			//删除文件夹
			Qcode.deleteFile(file);
			zipFile =new File(zipPath);
			 // 输出到客户端
            OutputStream out = null;
            out = response.getOutputStream();
            response.reset();
            response.setHeader("Content-Disposition", "attachment;filename=" + new String("资产详情二维码.zip".getBytes("UTF-8"), "ISO-8859-1"));
            response.setContentType("application/octet-stream; charset=utf-8");
            response.setCharacterEncoding("UTF-8");
            out.write(FileUtils.readFileToByteArray(zipFile));
            out.flush();
            out.close();
            // 输出客户端结束后，删除压缩包
            if (zipFile.exists()) {
                zipFile.delete();
            }
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
	}
}
