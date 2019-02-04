package com.guotop.palmschool.personAlbum.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.servlet.ServletException;
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
import com.google.gson.reflect.TypeToken;
import com.guotop.palmschool.classphotoalbum.entity.ClassPhotoAlbum;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.Student;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.personAlbum.entity.PersonAlbum;
import com.guotop.palmschool.personAlbum.entity.PersonPhoto;
import com.guotop.palmschool.personAlbum.service.PersonAlbumService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.FileDownloadUtil;
import com.guotop.palmschool.util.FileUploadUtil;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.richx.pojo.QiniuPhoto;
import com.richx.pojo.RichHttpResponse;

import dev.gson.GsonHelper;

/**
 * 个人相册控制类
 *
 */
@RequestMapping("/personAlbum")
@Controller
public class PersonAlbumController extends BaseController
{
	private Logger log = LoggerFactory.getLogger(PersonAlbumController.class);
	@Resource
	private UserService userService;

	@Resource
	private CommonService commonService;

	@Resource
	private PersonAlbumService personAlbumService;

	/**
	 * 进入个人相册页面
	 */
	@RequestMapping(value = "/toPersonAlbum.do")
	public String toPersonAlbum()
	{
		return "personalbum/person_album_list";
	}

	/**
	 * 家长查询对应的小孩信息
	 */
	@RequestMapping(value = "/loadStudentList.do")
	public String loadStudentList(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{

			User user = (User) session.getAttribute("user");

			List<User> studentList = commonService.getAllChildrenByUserId(user.getUserId());
			Gson gson = new Gson();
			String json = gson.toJson(studentList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 添加相册
	 */
	@RequestMapping(value = "/addPersonAlbum.do")
	public String addPersonAlbum(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 相册名称
			String albumName = request.getParameter("albumName");
			// 相册描述
			String albumDesc = request.getParameter("albumDescription");
			// 相册归属人id
			Integer userId = Integer.valueOf(request.getParameter("userId"));
			// 相册归属人姓名
			String userName = request.getParameter("userName");
			// 创建日期
			String createTime = TimeUtil.getInstance().date();

			PersonAlbum album = new PersonAlbum();
			album.setAlbumName(albumName);
			album.setAlbumDesc(albumDesc);
			album.setUserId(userId);
			album.setUserName(userName);
			album.setCreateTime(createTime);
			album.setUpdateTime(TimeUtil.getInstance().now());

			Integer albumId = personAlbumService.addPersonAlbum(album);

			album.setAlbumId(albumId);

			Gson gson = new Gson();
			String json = gson.toJson(album);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 根据userId加载相册
	 */
	@RequestMapping(value = "/loadAllPersonAlbumList.do")
	public String loadAllPersonAlbumList(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 班级Id
			Integer userId = Integer.valueOf(request.getParameter("userId"));

			List<PersonAlbum> albumList = personAlbumService.getPersonAlbumListByUserId(userId);
			for (PersonAlbum album : albumList)
			{
				if (StringUtil.isEmpty(album.getAlbumPath()))
				{
					PersonPhoto photo = personAlbumService.getPersonPhotoByAlbumId(album.getAlbumId());
					if (photo != null)
					{
						album.setAlbumPath(photo.getPhotoPath());
					}
				}
			}

			Gson gson = new Gson();
			String json = gson.toJson(albumList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 根据albumId修改相册
	 */
	@RequestMapping(value = "/modifyPersonAlbumByAlbumId.do")
	public String modifyPersonAlbumByAlbumId(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 相册Id
			Integer albumId = StringUtil.toint(request.getParameter("albumId"));
			// 相册名称
			String albumName = request.getParameter("albumName");
			// 相册描述
			String albumDesc = request.getParameter("albumDescription");

			PersonAlbum album = new PersonAlbum();
			album.setAlbumId(albumId);
			album.setAlbumName(albumName);
			album.setAlbumDesc(albumDesc);
			album.setUpdateTime(TimeUtil.getInstance().now());

			personAlbumService.modifyPersonAlbumByAlbumId(album);
			Gson gson = new Gson();
			String json = gson.toJson(album);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}

		return null;

	}

	/**
	 * 根据albumId删除相册和下面的所有图片
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/deletePersonAlbumByAlbumId.do")
	public String deletePersonAlbumByAlbumId(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response) throws Exception
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 相册Id
			Integer albumId = StringUtil.toint(request.getParameter("albumId"));

			// 根据albumId查询对应的所有照片 用于删除七牛对应的图片
			List<PersonPhoto> photoList = personAlbumService.getPersonPhotoDetailByAlbumId(albumId);

			personAlbumService.deletePersonAlbumByAlbumId(albumId);

			if (photoList.size() > 0)
			{
				FileUploadUtil fuu = new FileUploadUtil();
				for (PersonPhoto photo : photoList)
				{
					String photoPath = photo.getPhotoPath();
					fuu.simpleDelete(Cons.QINIU_BUCKETNAME_CLASSALBUM, photoPath.substring(Cons.QINIU_URL_CLASSALBUM.length()));
				}
			}
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 上传图片
	 * 
	 * @throws IOException
	 */
	@RequestMapping(value = "/uploadPersonPhoto.do")
	public String uploadPersonPhoto(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{

			Integer albumId = StringUtil.toint(request.getParameter("albumId"));

			String roleCode = request.getParameter("roleCode");

			String uploadPhoto = request.getParameter("photos");
			
			// 上传照片的数量
			int num = 0;
			
			if(!StringUtil.isEmpty(uploadPhoto)){
				String[] photos = uploadPhoto.split(",");
				PersonAlbum album = personAlbumService.getPersonAlbumByAlbumId(albumId);
				for (int i = 0; i < photos.length; i++)
				{
					String photoName = photos[i].substring(photos[i].lastIndexOf("/") + 5, photos[i].lastIndexOf("."));

					PersonPhoto photo = new PersonPhoto();
					photo.setAlbumId(albumId);
					photo.setPhotoName(photoName);
					photo.setPhotoPath(Cons.QINIU_URL_CLASSALBUM + photos[i]);
					photo.setUserId(album.getUserId());
					photo.setUserName(album.getUserName());
					photo.setMediaType(1);//默认类型设置为图片
					personAlbumService.addPersonPhoto(photo);
					num++;
				}
			}
			modelMap.addAttribute("uploadCom", "uploadCom");
			modelMap.addAttribute("num", num);
			modelMap.addAttribute("roleCode", roleCode);
			modelMap.addAttribute("albumId", albumId);

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return "personalbum/person_album_list";

	}

	/**
	 * 根据albumId加载相片
	 */
	@RequestMapping(value = "/loadPhotoDetailByAlbumId.do")
	public String loadPhotoDetailByAlbumId(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 相册Id
			Integer albumId = StringUtil.toint(request.getParameter("albumId"));

			PersonAlbum album = personAlbumService.getPersonAlbumByAlbumId(albumId);

			List<PersonPhoto> photoList = personAlbumService.getPersonPhotoDetailByAlbumId(albumId);

			if (album != null && StringUtil.isEmpty(album.getAlbumPath()))
			{
				if (photoList.size() > 0)
				{
					album.setAlbumPath(photoList.get(0).getPhotoPath());
				}
			}

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("album", album);
			map.put("photoList", photoList);
			Gson gson = new Gson();
			String json = gson.toJson(map);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 设置相册封面
	 */
	@RequestMapping(value = "/setPersonAlbumCover.do")
	public String setPersonAlbumCover(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 相册Id
			Integer albumId = StringUtil.toint(request.getParameter("albumId"));
			// 相册封面路劲
			String albumPath = request.getParameter("albumPath");

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("albumId", albumId);
			paramMap.put("albumPath", albumPath);
			personAlbumService.setPersonAlbumCover(paramMap);

			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 根据photoId修改照片
	 */
	@RequestMapping(value = "/modifyPersonPhotoByPhotoId.do")
	public String modifyPersonPhotoByPhotoId(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 照片Id
			Integer photoId = StringUtil.toint(request.getParameter("photoId"));
			// 照片名称
			String photoName = request.getParameter("photoName");
			// 照片描述
			String photoDesc = request.getParameter("photoDesc");

			PersonPhoto photo = new PersonPhoto();
			photo.setPhotoId(photoId);
			photo.setPhotoName(photoName);
			photo.setPhotoDesc(photoDesc);

			personAlbumService.modifyPersonPhotoByPhotoId(photo);

			Gson gson = new Gson();
			String json = gson.toJson(photo);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 根据photoId删除相片
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/deletePersonPhotoByPhotoId.do")
	public String deletePersonPhotoByPhotoId(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response) throws Exception
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			// 相片Id
			Integer photoId = StringUtil.toint(request.getParameter("photoId"));

			// 根据photoId查询照片
			PersonPhoto photo = personAlbumService.getPersonPhotoByPhotoId(photoId);
			if (photo != null)
			{
				// 删除照片
				personAlbumService.deletePersonPhotoByPhotoId(photoId);

				FileUploadUtil fuu = new FileUploadUtil();
				String photoPath = photo.getPhotoPath();
				fuu.simpleDelete(Cons.QINIU_BUCKETNAME_CLASSALBUM, photoPath.substring(Cons.QINIU_URL_CLASSALBUM.length()));
			}
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}

	public String getTempRoot()
	{
		return "D:/Guolang/WisdomCampus/";
	}

	public String getEndWith(String filename)
	{
		int i = filename.lastIndexOf(".");
		if (i >= 0)
		{
			return filename.substring(i + 1, filename.length());
		}
		return "";
	}

	/**
	 * 根据相册的Id查出所有的照片并导出zip
	 * 
	 * @throws IOException
	 */
	@RequestMapping(value = "/exportPhotoByAlbumId.do")
	public String exportPhotoByAlbumId(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response) throws IOException
	{
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String basePath = request.getSession().getServletContext().getRealPath("");

		Integer albumId = StringUtil.toint(request.getParameter("albumId"));
		String albumName = request.getParameter("albumName");

		List<PersonPhoto> photoList = personAlbumService.getPersonPhotoDetailByAlbumId(albumId);
		// 临时文件路径
		String path_tmp = "D:/personPhoto/" + albumName + "_" + albumId + "/";
		List<File> files = new ArrayList<File>();
		HashMap<String, Object> photoNameMap = new HashMap<String, Object>();
		int count = 0;
		for (PersonPhoto photo : photoList)
		{
			count++;
			if (photoNameMap.containsKey(photo.getPhotoName()))
			{
				photoNameMap.put(photo.getPhotoName() + count, photo);
				photo.setPhotoName(photo.getPhotoName() + count);
			} else
			{
				photoNameMap.put(photo.getPhotoName(), photo);
			}
			boolean flag = FileDownloadUtil.getRemoteFile(photo.getPhotoPath(), path_tmp, photo.getPhotoName() + ".jpg");
			if (flag)
			{
				File file = new File(path_tmp + photo.getPhotoName() + ".jpg");
				files.add(file);
			}
		}

		String fileName = albumName + ".zip";
		// 在服务器端创建打包下载的临时文件
		String outFilePath = basePath + "\\" + fileName;
		File file = new File(outFilePath);
		FileOutputStream outStream = new FileOutputStream(file);
		ZipOutputStream toClient = new ZipOutputStream(outStream);
		try
		{
			FileDownloadUtil.zipFile(files, toClient);
			toClient.close();
			outStream.close();
		} catch (IOException e)
		{
			e.printStackTrace();
		} catch (ServletException e)
		{
			e.printStackTrace();
		}
		FileDownloadUtil.downloadZip(file, response);
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(fileName);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}

	@RequestMapping(value = "/deleteZipFile.do")
	public void deleteZipFile(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response) throws UnsupportedEncodingException
	{
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String basePath = request.getSession().getServletContext().getRealPath("");

		String fileName = request.getParameter("fileName");
		String outFilePath = basePath + "\\" + fileName;
		File file = new File(outFilePath);
		if (file.length() > 0)
		{
			file.delete();
		}
	}

	/**
	 * ---------------------------下面是手机端班级相册接口----------------------------------
	 * ------------
	 */

	/**
	 * 根据userId加载相册
	 */
	@RequestMapping(value = "/loadPersonAlbumListByApiKey.do")
	public String loadPersonAlbumListByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<PersonAlbum>> rhr = new RichHttpResponse<List<PersonAlbum>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		Integer userId = StringUtil.toint(request.getParameter("userId"));
		String json;
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (loginUser != null)
		{
			session.setAttribute("user", loginUser);
			DBContextHolder.setDBType(loginUser.getSchoolId());

			List<PersonAlbum> albumList = personAlbumService.getPersonAlbumListByUserId(userId);
			for (PersonAlbum album : albumList)
			{
				if (StringUtil.isEmpty(album.getAlbumPath()))
				{
					PersonPhoto photo = personAlbumService.getPersonPhotoByAlbumId(album.getAlbumId());
					if (photo != null)
					{
						album.setAlbumPath(photo.getPhotoPath());
					}
				}
			}
			rhr.ResponseCode = 0;
			rhr.ResponseResult = "获取列表成功";
			rhr.ResponseObject = albumList;
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
	 * 【手机端】创建相册
	 */
	@RequestMapping(value = "/addPersonAlbumByApiKey.do")
	public String addPersonAlbumByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<PersonAlbum> rhr = new RichHttpResponse<PersonAlbum>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String albumName = request.getParameter("albumName");
		String albumDesc = request.getParameter("albumDescription");
		Integer userId = StringUtil.toint(request.getParameter("userId"));
		String realName = request.getParameter("realName");
		String json;
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		try
		{
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());
				// 创建日期
				String createTime = TimeUtil.getInstance().date();

				PersonAlbum album = new PersonAlbum();
				album.setAlbumName(albumName);
				album.setAlbumDesc(albumDesc);
				album.setUserId(userId);
				album.setUserName(realName);
				album.setCreateTime(createTime);
				album.setUpdateTime(TimeUtil.getInstance().now());
				Integer albumId = personAlbumService.addPersonAlbum(album);
				album.setAlbumId(albumId);

				rhr.ResponseCode = 0;
				rhr.ResponseResult = "创建相册成功";
				rhr.ResponseObject = album;
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
			rhr.ResponseCode = -2;
			rhr.ResponseResult = "创建相册失败";
			json = GsonHelper.toJson(rhr);

			log.error("创建相册失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 【手机端】上传图片
	 * 
	 * @throws IOException
	 */
	@RequestMapping(value = "/uploadPersonPhotoByApiKey.do")
	public String uploadPersonPhotoByApiKey(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<PersonAlbum> rhr = new RichHttpResponse<PersonAlbum>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		Integer albumId = StringUtil.toint(request.getParameter("albumId"));
		String photoDesc = request.getParameter("photoDesc");
		String qiniuPhotoUrlJson = request.getParameter("qiniuPhotoUrlJson");
		String json;

		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		try
		{
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());

				// 解析七牛图片地址list
				List<QiniuPhoto> qiniuPhotoList = GsonHelper.fromJson(qiniuPhotoUrlJson, new TypeToken<ArrayList<QiniuPhoto>>()
				{
				}.getType());
				if (!CollectionUtils.isEmpty(qiniuPhotoList))
				{

					PersonAlbum album = personAlbumService.getPersonAlbumByAlbumId(albumId);
					Integer num = 0;
					for (QiniuPhoto qiniuPhoto : qiniuPhotoList)
					{
						PersonPhoto photo = new PersonPhoto();
						photo.setAlbumId(albumId);
						photo.setPhotoName(qiniuPhoto.photoName);
						photo.setPhotoPath(qiniuPhoto.photoUrl);
						photo.setUserId(album.getUserId());
						photo.setUserName(album.getUserName());
						photo.setPhotoDesc(photoDesc);
						if(null == qiniuPhoto.mediaType){
							photo.setMediaType(1);
						}else{
							photo.setMediaType(qiniuPhoto.mediaType);
						}
						photo.setMediaSecordUrl(qiniuPhoto.mediaSecordUrl);
						personAlbumService.addPersonPhoto(photo);
						num++;
					}
				}
				rhr.ResponseCode = 0;
				rhr.ResponseResult = "上传图片成功";
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
			log.error("手机端个人相册json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("手机端个人相册上传图片失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 【手机端】根据albumId加载相片
	 */
	@RequestMapping(value = "/loadPersonPhotoByAlbumIdAndApiKey.do")
	public String loadPersonPhotoByAlbumIdAndApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{

		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<PersonPhoto>> rhr = new RichHttpResponse<List<PersonPhoto>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		Integer albumId = StringUtil.toint(request.getParameter("albumId"));
		String json;
		// 这边是利用apikey 进行模拟登录
		User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		try
		{
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());

				List<PersonPhoto> photoList = personAlbumService.getPersonPhotoDetailByAlbumId(albumId);

				rhr.ResponseCode = 0;
				rhr.ResponseResult = "上传图片成功";
				rhr.ResponseObject = photoList;
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
			log.error("手机端个人相册json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("手机端个人相册加载图片失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 【手机端】根据albumId删除相册和下面的所有图片
	 */
	@RequestMapping(value = "/deletePersonAlbumByAlbumIdAndApiKey.do")
	public String deletePersonAlbumByAlbumIdAndApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<ClassPhotoAlbum> rhr = new RichHttpResponse<ClassPhotoAlbum>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		Integer albumId = StringUtil.toint(request.getParameter("albumId"));
		try
		{
			String json;
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);

			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());

				// 根据albumId查询对应的所有照片 用于删除七牛对应的图片
				List<PersonPhoto> photoList = personAlbumService.getPersonPhotoDetailByAlbumId(albumId);

				personAlbumService.deletePersonAlbumByAlbumId(albumId);

				if (photoList.size() > 0)
				{
					FileUploadUtil fuu = new FileUploadUtil();
					for (PersonPhoto photo : photoList)
					{
						String photoPath = photo.getPhotoPath();
						fuu.simpleDelete(Cons.QINIU_BUCKETNAME_CLASSALBUM, photoPath.substring(Cons.QINIU_URL_CLASSALBUM.length()));
					}
				}

				rhr.ResponseCode = 0;
				rhr.ResponseResult = "删除相册成功";
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
			log.error("删除相册失败：" + e.getMessage());
		}
		return null;

	}

	/**
	 * 【手机端】根据photoId删除相片
	 */
	@RequestMapping(value = "/deletePersonPhotoByPhotoIdAndApiKey.do")
	public String deletePersonPhotoByPhotoIdAndApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<ClassPhotoAlbum> rhr = new RichHttpResponse<ClassPhotoAlbum>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		Integer photoId = StringUtil.toint(request.getParameter("photoId"));
		try
		{
			String json;
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);

			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());

				// 根据photoId查询照片
				PersonPhoto photo = personAlbumService.getPersonPhotoByPhotoId(photoId);
				if (photo != null)
				{
					// 删除照片
					personAlbumService.deletePersonPhotoByPhotoId(photoId);

					FileUploadUtil fuu = new FileUploadUtil();
					String photoPath = photo.getPhotoPath();
					fuu.simpleDelete(Cons.QINIU_BUCKETNAME_CLASSALBUM, photoPath.substring(Cons.QINIU_URL_CLASSALBUM.length()));
				}

				rhr.ResponseCode = 0;
				rhr.ResponseResult = "删除照片成功";
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
			log.error("删除照片失败：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 【手机端】获取所有人员（家长是自己小孩   其他是自己）
	 */
	@RequestMapping(value = "/getStudentListByApiKey.do")
	public String getStudentListByApiKey(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		RichHttpResponse<List<Student>> rhr = new RichHttpResponse<List<Student>>();
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		try
		{
			String json;
			// 这边是利用apikey 进行模拟登录
			User loginUser = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			if (loginUser != null)
			{
				session.setAttribute("user", loginUser);
				DBContextHolder.setDBType(loginUser.getSchoolId());

				List<Student> studentsList = new ArrayList<Student>();
				List<Role> roleList = loginUser.getRoleList();
				
				for (Role role : roleList)
				{
					List<Student> student = new ArrayList<Student>();
					
					if(("parent").equals(role.getRoleCode()))
					{
						student = commonService.getAllChildrenByUserIdYixin(loginUser.getUserId());
					}else
					{
						student = commonService.getUserByUserIdYixin(loginUser.getUserId());
					}
					studentsList.addAll(student);
				}

				rhr.ResponseCode = 0;
				rhr.ResponseObject = studentsList;
				rhr.ResponseResult = "获取成功";
				json = GsonHelper.toJsonWithAnnotation(rhr);
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
		}
		return null;
	}

}
