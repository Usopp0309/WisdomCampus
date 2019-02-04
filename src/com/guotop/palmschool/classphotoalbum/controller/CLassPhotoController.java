package com.guotop.palmschool.classphotoalbum.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.classphotoalbum.entity.ClassPhotoAlbum;
import com.guotop.palmschool.classphotoalbum.entity.Photo;
import com.guotop.palmschool.classphotoalbum.entity.RecordsComment;
import com.guotop.palmschool.classphotoalbum.entity.UploadRecords;
import com.guotop.palmschool.classphotoalbum.service.ClassAlbumService;
import com.guotop.palmschool.classphotoalbum.service.PhotoService;
import com.guotop.palmschool.classphotoalbum.service.RecordsCommentService;
import com.guotop.palmschool.classphotoalbum.service.UploadRecordsService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.FileUploadUtil;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.richx.pojo.RichHttpResponse;

import dev.gson.GsonHelper;

/**
 * 班级照片控制类
 *
 */
@RequestMapping("/clazzPhoto")
@Controller
public class CLassPhotoController extends BaseController
{
	private Logger log = LoggerFactory.getLogger(CLassPhotoController.class);
	@Resource
	private UserService userService;
	@Resource
	private UploadRecordsService uploadRecordsService;
	@Resource
	private PhotoService photoService;
	@Resource
	private RecordsCommentService recordsCommentService;
	@Resource
	private ClassAlbumService classAlbumService;
	/**
	 * 进入班级照片页面
	 */
	@RequestMapping(value = "/toPhoto.do")
	public String toPhoto(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		Integer gradeId = StringUtil.toint(request.getParameter("gradeId"));
		Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));
		String roleCode = request.getParameter("roleCode");
		modelMap.addAttribute("gradeId", gradeId);
		modelMap.addAttribute("clazzId", clazzId);
		modelMap.addAttribute("roleCode", roleCode);
		return "classphotoalbum/photo_list";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getUploadRecords.do")
	public String getUploadRecords(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		String clazzId = request.getParameter("clazzId");
		// 根据clazzId查出该班级下所有上传记录以及图片列表,评论列表,点赞列表
		Integer currentPage = 1;

		try
		{
			currentPage = Integer.valueOf(request.getParameter("cPage"));
		} catch (Exception e)
		{
			currentPage = 1;
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("clazzId", clazzId);
		this.getPages().setPageSize(5);
		Pages page = uploadRecordsService.getUploadRecordsList(this.getPages().getPageSize(), currentPage, paramMap);
		List<UploadRecords> list = page.getList();
		if (list != null && list.size() > 0)
		{
			for (UploadRecords uploadRecords : list)
			{
				paramMap.put("recordsId", uploadRecords.getRecordsId());
				// 查询本次上传记录的图片列表,根据recordsId到palm_photo中查询出photoList
				List<Photo> photoList = photoService.getPhotoListByRecordsId(paramMap);
				if (photoList != null && photoList.size() > 0)
				{
					uploadRecords.setPhotoList(photoList);
				}
				// 查询本次上传记录的评价列表,根据recordsId、commentType=1到palm_records_comment查出commentList
				paramMap.put("commentType", 1);
				List<RecordsComment> recordsCommentList = recordsCommentService.getCommentListByRecordsIdAndCommentType(paramMap);
				Map<Integer, RecordsComment> recordsCommentMap = new HashMap<Integer, RecordsComment>();
				List<RecordsComment> recordsCommentParentList = new ArrayList<RecordsComment>();
				Map<Integer, List<RecordsComment>> recordsCommentSubMap = new HashMap<Integer, List<RecordsComment>>();
				if (recordsCommentList != null && recordsCommentList.size() > 0)
				{
					for (RecordsComment recordsComment : recordsCommentList)
					{
						// 添加到所有评论的map集合中
						recordsCommentMap.put(recordsComment.getCommentId(), recordsComment);
						/*
						 * 下面是把一级评论加到recordsCommentParentList
						 * 并且把一级评论对应的子评论加到recordsCommentParentMap
						 */
						if (recordsComment.getParentId() == 0 || StringUtil.isEmpty(recordsComment.getParentId() + ""))
						{
							recordsCommentParentList.add(recordsComment);
						} else
						{
							if (!recordsCommentSubMap.containsKey(recordsComment.getParentId()))
							{
								List<RecordsComment> subRecordsCommentsList = new ArrayList<RecordsComment>();
								subRecordsCommentsList.add(recordsComment);
								recordsCommentSubMap.put(recordsComment.getParentId(), subRecordsCommentsList);
							} else
							{
								recordsCommentSubMap.get(recordsComment.getParentId()).add(recordsComment);
							}
						}
					}
					uploadRecords.setCommentList(recordsCommentParentList);
					uploadRecords.setCommentMap(recordsCommentMap);
					uploadRecords.setCommentSubMap(recordsCommentSubMap);
				}
				// 查询本次【上传记录】的点赞列表
				// ,根据recordsId、commentType=0到palm_records_comment查出praiseList
				paramMap.put("commentType", 0);
				List<RecordsComment> recordsPariseList = recordsCommentService.getCommentListByRecordsIdAndCommentType(paramMap);
				if (recordsPariseList != null && recordsPariseList.size() > 0)
				{
					uploadRecords.setPraiseList(recordsPariseList);
				}
			}
		}

		/**
		 * flush到页面
		 */
		Gson gson = new Gson();
		String json = gson.toJson(page);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/getPhotoListDetailByRecordsId.do")
	public String getPhotoListDetailByRecordsId(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		String recordsId = request.getParameter("recordsId");
		ClassPhotoAlbum album = classAlbumService.getAlbumByRecordsId(StringUtil.toint(recordsId));
		List<Photo> photoList = photoService.getPhotoListAndCommentListByAlbumId(album.getAlbumId());
		List<Photo> result_photoList = new ArrayList<Photo>();
		Map<Integer, Photo> photoMap = new HashMap<Integer, Photo>();
		if (photoList != null && photoList.size() > 0)
		{
			for(Photo photo : photoList){
				Integer photoId = photo.getPhotoId();
				Integer commentId = photo.getCommentId();
				if(commentId != null){
					Integer parentId = photo.getParentId();
					Integer commentType = photo.getCommentType();
					RecordsComment rc = new RecordsComment();
					rc.setCommentId(commentId);
					rc.setParentId(parentId);
					rc.setCommentType(commentType);
					rc.setContent(photo.getContent());
					rc.setCommentUserId(photo.getCommentUserId());
					rc.setCommentUserName(photo.getCommentUserName());
					rc.setCreateTime(photo.getCreateTime());
					rc.setCommentReplyId(photo.getCommentReplyId());
					rc.setCommentReplyUserId(photo.getCommentReplyUserId());
					rc.setCommentReplyUserName(photo.getCommentReplyUserName());
					rc.setHeadImg(photo.getHeadImg());
					if(commentType == 0){
						//点赞
						photo.getPraiseList().add(rc);
					}else {
						photo.getCommentMap().put(Integer.valueOf(commentId), rc);
						
						if (parentId == 0 || StringUtil.isEmpty(parentId + "")){
							//父级评论
							photo.getCommentList().add(rc);
						}else{
							Map<Integer, List<RecordsComment>> commentSubMap = photo.getCommentSubMap();
							if (!commentSubMap.containsKey(parentId)){
								List<RecordsComment> subRecordsCommentsList = new ArrayList<RecordsComment>();
								subRecordsCommentsList.add(rc);
								commentSubMap.put(parentId, subRecordsCommentsList);
							} else
							{
								commentSubMap.get(parentId).add(rc);
							}
						}
					}
				}
				if(!photoMap.containsKey(photoId)){
					photoMap.put(photoId, photo);
				}else{
					Photo photo_tmp = photoMap.get(photoId);
					if(commentId != null){
						Integer parentId = photo.getParentId();
						Integer commentType = photo.getCommentType();
						if(commentType == 0){
							photo_tmp.getPraiseList().addAll(photo.getPraiseList());
						}else{
							photo_tmp.getCommentMap().putAll(photo.getCommentMap());
							if (parentId == 0 || StringUtil.isEmpty(parentId + "")){
								photo_tmp.getCommentList().addAll(photo.getCommentList());
							}else{
								Map<Integer, List<RecordsComment>> commentSubMap = photo_tmp.getCommentSubMap();
								if (!commentSubMap.containsKey(parentId)){
									List<RecordsComment> subRecordsCommentsList = new ArrayList<RecordsComment>();
									subRecordsCommentsList.add(photo.getCommentMap().get(commentId));
									commentSubMap.put(parentId, subRecordsCommentsList);
								}else{
									commentSubMap.get(parentId).addAll(photo.getCommentSubMap().get(parentId));
								}
							}
						}
					}
//					photo_tmp.getCommentSubMap().putAll(photo.getCommentSubMap());
				}
			}
			result_photoList = new ArrayList<Photo>(photoMap.values()); 
			Collections.sort(result_photoList, new Comparator<Photo>()
			{
				public int compare(Photo dish1, Photo dish2)
				{
					return dish1.getPhotoId().compareTo(dish2.getPhotoId());
				}
			});

		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("album", album);
		map.put("photoList", result_photoList);

		/*
		 * flush到页面
		 */
		Gson gson = new Gson();
		String json = gson.toJson(map);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 上传记录评论
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/addComment.do")
	public String addComment(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		User login = (User) session.getAttribute("user");
		response.setCharacterEncoding("UTF-8");
		String commentReplyId = request.getParameter("commentReplyId");
		String parentId = request.getParameter("parentId");
		String recordsId = request.getParameter("recordsId");
		String textareaText = request.getParameter("textareaText");

		RecordsComment recordsComment = new RecordsComment();
		recordsComment.setParentId(Integer.valueOf(parentId));
		recordsComment.setCommentType(1);
		recordsComment.setContent(textareaText);
		recordsComment.setCommentUserId(login.getUserId());
		recordsComment.setCommentUserName(login.getRealName());
		recordsComment.setHeadImg(login.getHeadImg());
		recordsComment.setCreateTime(TimeUtil.getInstance().nowFormat());
		recordsComment.setRecordsId(Integer.valueOf(recordsId));
		recordsComment.setPhotoId(0);
		recordsComment.setCommentReplyId(Integer.valueOf(commentReplyId));
		// 查出回复评论的详情
		RecordsComment recordsComment_reply = new RecordsComment();
		if (commentReplyId.equals("0"))
		{
			recordsComment.setCommentReplyUserId(0);
			recordsComment.setCommentReplyUserName("");
		} else
		{
			recordsComment_reply = recordsCommentService.getCommentByCommentId(Integer.valueOf(commentReplyId));
			recordsComment.setCommentReplyUserId(recordsComment_reply.getCommentUserId());
			recordsComment.setCommentReplyUserName(recordsComment_reply.getCommentUserName());
		}
		Integer commentId = recordsCommentService.addComment(recordsComment);
		recordsComment.setCommentId(commentId);
		recordsComment.setRecordsComment(recordsComment_reply);

		/*
		 * flush到页面
		 */
		Gson gson = new Gson();
		String json = gson.toJson(recordsComment);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 单个图片点评
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/addPhotoComment.do")
	public String addPhotoComment(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		User login = (User) session.getAttribute("user");
		response.setCharacterEncoding("UTF-8");
		String commentReplyId = request.getParameter("commentReplyId");
		String parentId = request.getParameter("parentId");
		String photoId = request.getParameter("photoId");
		String textareaText = request.getParameter("textareaText");

		RecordsComment recordsComment = new RecordsComment();
		recordsComment.setParentId(Integer.valueOf(parentId));
		recordsComment.setCommentType(1);
		recordsComment.setContent(textareaText);
		recordsComment.setCommentUserId(login.getUserId());
		recordsComment.setCommentUserName(login.getRealName());
		recordsComment.setHeadImg(login.getHeadImg());
		recordsComment.setCreateTime(TimeUtil.getInstance().nowFormat());
		recordsComment.setRecordsId(0);
		recordsComment.setPhotoId(Integer.valueOf(photoId));
		recordsComment.setCommentReplyId(Integer.valueOf(commentReplyId));
		// 查出回复评论的详情
		RecordsComment recordsComment_reply = new RecordsComment();
		if (commentReplyId.equals("0"))
		{
			recordsComment.setCommentReplyUserId(0);
			recordsComment.setCommentReplyUserName("");
		} else
		{
			recordsComment_reply = recordsCommentService.getCommentByCommentId(Integer.valueOf(commentReplyId));
			recordsComment.setCommentReplyUserId(recordsComment_reply.getCommentUserId());
			recordsComment.setCommentReplyUserName(recordsComment_reply.getCommentUserName());
		}
		Integer commentId = recordsCommentService.addComment(recordsComment);
		recordsComment.setCommentId(commentId);
		recordsComment.setRecordsComment(recordsComment_reply);

		/*
		 * flush到页面
		 */
		Gson gson = new Gson();
		String json = gson.toJson(recordsComment);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 点赞，或者取消赞
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/addPraise.do")
	public String addPraise(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		/**
		 * 上传记录点赞保存，需要recordsId 图片详情点赞保存，需要photoId
		 */
		User login = (User) session.getAttribute("user");
		response.setCharacterEncoding("UTF-8");
		String recordsId = request.getParameter("recordsId");
		String photoId = request.getParameter("photoId");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("commentUserId", login.getUserId());
		/*
		 * 先去数据库查询该上传记录你是否已经点赞 （有两种可能） 1. 上传记录点赞需要recordsId和userId 2.
		 * 单个图片点赞需要photoId和userId
		 */
		RecordsComment recordsComment = new RecordsComment();
		if (StringUtil.isEmpty(photoId) && !StringUtil.isEmpty(recordsId))
		{
			// 上传记录点赞
			paramMap.put("recordsId", recordsId);
			recordsComment = recordsCommentService.getPraiseByRecordsIdAndCommentTypeAndUserId(paramMap);
		} else if (!StringUtil.isEmpty(photoId) && StringUtil.isEmpty(recordsId))
		{
			// 单个图片点赞
			paramMap.put("photoId", photoId);
			recordsComment = recordsCommentService.getPraiseByPhotoIdAndCommentTypeAndUserId(paramMap);
		}

		Gson gson = new Gson();
		String json;
		RecordsComment recordsComment_new = new RecordsComment();
		if (recordsComment == null)
		{
			// 保存点赞
			recordsComment_new.setParentId(0);
			recordsComment_new.setCommentType(0);
			recordsComment_new.setContent("赞");
			recordsComment_new.setCommentUserId(login.getUserId());
			recordsComment_new.setCommentUserName(login.getRealName());
			recordsComment_new.setCreateTime(TimeUtil.getInstance().nowFormat());
			if (StringUtil.isEmpty(photoId) && !StringUtil.isEmpty(recordsId))
			{
				// 上传记录点赞
				recordsComment_new.setRecordsId(Integer.valueOf(recordsId));
				recordsComment_new.setPhotoId(0);
			} else if (!StringUtil.isEmpty(photoId) && StringUtil.isEmpty(recordsId))
			{
				// 单个图片点赞
				recordsComment_new.setRecordsId(0);
				recordsComment_new.setPhotoId(Integer.valueOf(photoId));
			}
			recordsComment_new.setCommentReplyId(0);
			recordsComment_new.setCommentReplyUserId(0);
			recordsComment_new.setCommentReplyUserName("");
			Integer commentId = recordsCommentService.addComment(recordsComment_new);
			recordsComment_new.setCommentId(commentId);
			recordsComment_new.setExistFlag(0);
			json = gson.toJson(recordsComment_new);
		} else
		{
			// 删除点赞
			recordsCommentService.deleteRecordsComment(recordsComment.getCommentId());
			recordsComment.setExistFlag(1);
			json = gson.toJson(recordsComment);
		}
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 删除上传记录
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/deleteUploadRecords.do")
	public String deleteUploadRecords(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		String recordsId = request.getParameter("recordsId");
		boolean flag = false;
		try
		{
			Map<String,Object> paramMap = new HashMap<String, Object>();
			paramMap.put("recordsId", recordsId);
			//根据recordsId查询对应的照片   用于删除七牛上对应的照片
			List<Photo> photoList = photoService.getPhotoListByRecordsId(paramMap);
			
			uploadRecordsService.deleteRecordsByRecordsId(StringUtil.toint(recordsId));
			photoService.deletePhotoByRecordsId(StringUtil.toint(recordsId));
			if(!CollectionUtils.isEmpty(photoList))
			{
				FileUploadUtil fuu = new FileUploadUtil();
				for(Photo photo : photoList)
				{
					String photoPath = photo.getPhotoPath();
					fuu.simpleDelete(Cons.QINIU_BUCKETNAME_CLASSALBUM, photoPath.substring(Cons.QINIU_URL_CLASSALBUM.length()));
				}
			}
			
			flag = true;
		} catch (Exception e)
		{
			log.error("删除上传记录失败：" + e.getMessage());
			flag = false;
		}
		Gson gson = new Gson();
		String json = gson.toJson(flag);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 删除评论
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/deleteComment.do")
	public String deleteComment(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		String commentId = request.getParameter("commentId");
		String parentId = request.getParameter("parentId");
		boolean flag = false;
		try
		{
			if (parentId.equals("0"))
			{
				// 相等的情况下是指，是一级评论，需要把下面相关的都删除根据parentId
				// 1.删除commentId为commentId的评论
				// 2.删除parentId为parentId的评论
				recordsCommentService.deleteRecordsComment(Integer.valueOf(commentId));
				recordsCommentService.deleteRecordsCommentByParentId(Integer.valueOf(commentId));
				flag = true;
			} else
			{
				// 不相等的情况下，仅仅是删除commentId的评论
				recordsCommentService.deleteRecordsComment(Integer.valueOf(commentId));
				flag = true;
			}
		} catch (Exception e)
		{
			log.error("删除评论失败：" + e.getMessage());
			flag = false;
		}

		Gson gson = new Gson();
		String json = gson.toJson(flag);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * ---------------------------下面是手机端班级相册接口----------------------------------
	 * ------------
	 */
	/**
	 * 【手机端】获取上传记录
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getUploadRecordsByApiKey.do")
	public String getUploadRecordsByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<UploadRecords>> rhr = new RichHttpResponse<List<UploadRecords>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		int clazzId = StringUtil.toint(request.getParameter("deClazzId"));
		int startRecordsId = StringUtil.toint(request.getParameter("startRecordsId"));
		int count = StringUtil.toint(request.getParameter("count"));
		if (count == 0)
		{
			count = 5;
		}
		String json;
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (loginUser != null)
		{
			session.setAttribute("user", loginUser);
			DBContextHolder.setDBType(loginUser.getSchoolId());

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("clazzId", clazzId);
			if(startRecordsId != 0){
				paramMap.put("startRecordsId", startRecordsId);
			}
			paramMap.put("count", count);
			List<UploadRecords> uploadRecordsList = uploadRecordsService.getUploadRecordsListInYIXIN(paramMap);
			if (uploadRecordsList != null && uploadRecordsList.size() > 0)
			{
				for (UploadRecords uploadRecords : uploadRecordsList)
				{
					paramMap.put("recordsId", uploadRecords.getRecordsId());
					// 查询本次上传记录的图片列表,根据recordsId到palm_photo中查询出photoList
					List<Photo> photoList = photoService.getPhotoListByRecordsId(paramMap);
					if (photoList != null && photoList.size() > 0)
					{
						uploadRecords.setPhotoList(photoList);
					}
					// 查询本次上传记录的评价列表,根据recordsId、commentType=1到palm_records_comment查出commentList
					paramMap.put("commentType", 1);
					List<RecordsComment> recordsCommentList = recordsCommentService.getCommentListByRecordsIdAndCommentType(paramMap);
					if (recordsCommentList != null && recordsCommentList.size() > 0)
					{
						uploadRecords.setCommentList(recordsCommentList);
					}
					// 查询本次【上传记录】的点赞列表
					// ,根据recordsId、commentType=0到palm_records_comment查出praiseList
					paramMap.put("commentType", 0);
					List<RecordsComment> recordsPariseList = recordsCommentService.getCommentListByRecordsIdAndCommentType(paramMap);
					if (recordsPariseList != null && recordsPariseList.size() > 0)
					{
						uploadRecords.setPraiseList(recordsPariseList);
					}
				}
			}

			rhr.ResponseCode = 0;
			rhr.ResponseResult = "获取列表成功";
			rhr.ResponseObject = uploadRecordsList;
			json = GsonHelper.toJson(rhr);
		} else
		{
			rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
			rhr.ResponseObject = null;
			rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
			json = GsonHelper.toJson(rhr);
		}
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 【手机端】上传记录评论
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/addCommentByApiKey.do")
	public String addCommentByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<RecordsComment> rhr = new RichHttpResponse<RecordsComment>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String commentReplyId = request.getParameter("commentReplyId");
		String parentId = request.getParameter("parentId");
		String recordsId = request.getParameter("recordsId");
		String textareaText = request.getParameter("textareaText");
		try
		{
			String json;
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);

			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());

				RecordsComment recordsComment = new RecordsComment();
				recordsComment.setParentId(Integer.valueOf(parentId));
				recordsComment.setCommentType(1);
				recordsComment.setContent(textareaText);
				recordsComment.setCommentUserId(loginUser.getUserId());
				recordsComment.setCommentUserName(loginUser.getRealName());
				recordsComment.setCreateTime(TimeUtil.getInstance().nowFormat());
				recordsComment.setRecordsId(Integer.valueOf(recordsId));
				recordsComment.setPhotoId(0);
				recordsComment.setCommentReplyId(Integer.valueOf(commentReplyId));
				// 查出回复评论的详情
				RecordsComment recordsComment_reply = new RecordsComment();
				if (commentReplyId.equals("0"))
				{
					recordsComment.setCommentReplyUserId(0);
					recordsComment.setCommentReplyUserName("");
				} else
				{
					recordsComment_reply = recordsCommentService.getCommentByCommentId(Integer.valueOf(commentReplyId));
					recordsComment.setCommentReplyUserId(recordsComment_reply.getCommentUserId());
					recordsComment.setCommentReplyUserName(recordsComment_reply.getCommentUserName());
				}
				Integer commentId = recordsCommentService.addComment(recordsComment);
				recordsComment.setCommentId(commentId);
				recordsComment.setRecordsComment(recordsComment_reply);

				rhr.ResponseCode = 0;
				rhr.ResponseResult = "评论成功";
				rhr.ResponseObject = recordsComment;
				json = GsonHelper.toJson(rhr);
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseObject = null;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				json = GsonHelper.toJson(rhr);
			}
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("上传记录评论失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 删除评论
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/deleteCommentByApiKey.do")
	public String deleteCommentByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<RecordsComment> rhr = new RichHttpResponse<RecordsComment>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String commentId = request.getParameter("commentId");
		String parentId = request.getParameter("parentId");
		String json;
		try
		{
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);

			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());
				
				if (parentId.equals("0"))
				{
					// 相等的情况下是指，是一级评论，需要把下面相关的都删除根据parentId
					// 1.删除commentId为commentId的评论
					// 2.删除parentId为parentId的评论
					recordsCommentService.deleteRecordsComment(Integer.valueOf(commentId));
					recordsCommentService.deleteRecordsCommentByParentId(Integer.valueOf(commentId));
				} else
				{
					// 不相等的情况下，仅仅是删除commentId的评论
					recordsCommentService.deleteRecordsComment(Integer.valueOf(commentId));
				}
				
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "删除评论成功";
				json = GsonHelper.toJson(rhr);
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseObject = null;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				json = GsonHelper.toJson(rhr);
			}
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("删除评论失败：" + e.getMessage());
		}
		
		return null;
	}
	
	/**
	 * 【手机端】上传记录点赞
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/addPraiseByApiKey.do")
	public String addPraiseByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		/**
		 * 上传记录点赞保存，需要recordsId 图片详情点赞保存，需要photoId
		 */
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<Integer> rhr = new RichHttpResponse<Integer>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String recordsId = request.getParameter("recordsId");
		try
		{
			Gson gson = new Gson();
			String json;
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);

			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());

				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("commentUserId", loginUser.getUserId());
				paramMap.put("recordsId", recordsId);
				/*
				 * 先去数据库查询该上传记录你是否已经点赞 1. 上传记录点赞需要recordsId和userId
				 */
				RecordsComment recordsComment = recordsCommentService.getPraiseByRecordsIdAndCommentTypeAndUserId(paramMap);
				RecordsComment recordsComment_new = new RecordsComment();
				if (recordsComment == null)
				{
					// 保存点赞
					recordsComment_new.setParentId(0);
					recordsComment_new.setCommentType(0);
					recordsComment_new.setContent("赞");
					recordsComment_new.setCommentUserId(loginUser.getUserId());
					recordsComment_new.setCommentUserName(loginUser.getRealName());
					recordsComment_new.setCreateTime(TimeUtil.getInstance().nowFormat());
					recordsComment_new.setRecordsId(Integer.valueOf(recordsId));
					recordsComment_new.setPhotoId(0);
					recordsComment_new.setCommentReplyId(0);
					recordsComment_new.setCommentReplyUserId(0);
					recordsComment_new.setCommentReplyUserName("");
					Integer commentId = recordsCommentService.addComment(recordsComment_new);
					recordsComment_new.setCommentId(commentId);
					recordsComment_new.setExistFlag(0);
					json = gson.toJson(recordsComment_new);
					rhr.ResponseCode = 0;
					rhr.ResponseResult = "点赞成功";
					rhr.ResponseObject = commentId;
					
					json = GsonHelper.toJson(rhr);
					response.getWriter().write(json);
					response.getWriter().flush();
					return null;
				} else
				{
					// 删除点赞
					recordsCommentService.deleteRecordsComment(recordsComment.getCommentId());
				}
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseObject = null;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				json = GsonHelper.toJson(rhr);
				response.getWriter().write(json);
				response.getWriter().flush();
			}
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("点赞失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 【手机端】取消赞
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "/deletePraiseByApiKey.do")
	public String deletePraiseByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		/**
		 * 上传记录点赞保存，需要recordsId 图片详情点赞保存，需要photoId
		 */
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<RecordsComment> rhr = new RichHttpResponse<RecordsComment>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String commentId = request.getParameter("commentId");

		try
		{
			String json;
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);

			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());
				
				// 删除点赞
				recordsCommentService.deleteRecordsComment(StringUtil.toint(commentId));
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "删除点赞成功";
				json = GsonHelper.toJson(rhr);
			} else
			{
				rhr.ResponseCode = Cons.LOGIN_APIKEY_ERROR_CODE;
				rhr.ResponseObject = null;
				rhr.ResponseResult = Cons.LOGIN_APIKEY_INVALID;
				json = GsonHelper.toJson(rhr);
			}
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("删除点赞失败：" + e.getMessage());
		}
		return null;
	}
}
