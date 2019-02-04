package com.guotop.palmschool.filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;

/**
 * session登录信息过滤器
 * 
 * @author M.simple
 */
public class SessionFilter extends OncePerRequestFilter
{

	public static Map<String,String> notFilterMap = new HashMap<String,String>();
	static{
		notFilterMap.put("/user/doCheckUsernamePassword.do", "user/doCheckUsernamePassword.do");
		notFilterMap.put("/user/doLoginFrom3rdApp.do", "user/doLoginFrom3rdApp.do");
		notFilterMap.put("/user/enterMain4App.do", "user/enterMain4App.do");
		notFilterMap.put("/user/toHomePage4App.do", "user/toHomePage4App.do");
		notFilterMap.put("/user/addDownLoadNum.do", "user/addDownLoadNum.do");
		//亦信获取是否具有使用智慧校园功能使用权限接口
		notFilterMap.put("/user/getLoginUserHasWisdomPermissionByApiKey.do", "user/getLoginUserHasWisdomPermissionByApiKey.do");
		notFilterMap.put("/inout/toInoutListByHuxinId.do", "inout/toInoutListByHuxinId.do");
		notFilterMap.put("/abnormal/toAbnormalListByHuxinId.do", "abnormal/toAbnormalListByHuxinId.do");
		notFilterMap.put("/leave/toLeaveAppList.do", "leave/toLeaveAppList.do");
		notFilterMap.put("/leave/toLeaveAppAdd.do", "leave/toLeaveAppAdd.do");
		notFilterMap.put("/check/toCheckListByHuxinId.do", "check/toCheckListByHuxinId.do");
		notFilterMap.put("/check/toTeacherCheckListByHuxinId.do", "check/toTeacherCheckListByHuxinId.do");
		notFilterMap.put("/check/toAttendanceRecordByHuxinId.do", "check/toAttendanceRecordByHuxinId.do");
		notFilterMap.put("/check/toCheckReportByHuxinId.do", "check/toCheckReportByHuxinId.do");
		notFilterMap.put("/check/toAttendanceRecordByHuxinId.do", "check/toAttendanceRecordByHuxinId.do");
		notFilterMap.put("/check/toStudentCheckListByHuxinId.do", "check/toStudentCheckListByHuxinId.do");
		notFilterMap.put("/meetingInout/toMeetingInoutByHuxinId.do", "meetingInout/toMeetingInoutByHuxinId.do");
		notFilterMap.put("/meetingDetail/toMeetingDetailListByHuxinId.do", "meetingDetail/toMeetingDetailListByHuxinId.do");
		notFilterMap.put("/meeting/toMeetingListByHuxinId.do", "meeting/toMeetingListByHuxinId.do");
		notFilterMap.put("/dormitory/toDormitoryInoutListByHuxinId.do", "dormitory/toDormitoryInoutListByHuxinId.do");
		notFilterMap.put("/dormitory/toDormitoryAbnormalDetailListByHuxinId.do", "dormitory/toDormitoryAbnormalDetailListByHuxinId.do");
		notFilterMap.put("/schoolbus/toSchoolBusOnListByHuxinId.do", "schoolbus/toSchoolBusOnListByHuxinId.do");
		notFilterMap.put("/schoolbus/toSchoolBusReportByHuxinId.do", "schoolbus/toSchoolBusReportByHuxinId.do");
		notFilterMap.put("/schoolbus/toSchoolBusNowPointByPhone.do", "schoolbus/toSchoolBusNowPointByPhone.do");
		notFilterMap.put("/schoolbusSms/toSchoolBusSmsByHuxinId.do", "schoolbusSms/toSchoolBusSmsByHuxinId.do");
		notFilterMap.put("/syn/synInout.do", "syn/synInout.do");
		notFilterMap.put("/syn/synYkt.do", "syn/synYkt.do");
		notFilterMap.put("/syn/synInoutByTimmy.do", "syn/synInoutByTimmy.do");
		notFilterMap.put("/syn/synInoutCwwt.do", "syn/synInoutCwwt.do");
		notFilterMap.put("/syn/synInoutDysyxx.do", "syn/synInoutDysyxx.do");
		notFilterMap.put("/syn/synInoutCwwt.do", "syn/synInoutCwwt.do");
		notFilterMap.put("/scoreSending/doSendingScore4App.do", "scoreSending/doSendingScore4App.do");
		notFilterMap.put("/locationInfoRest/addLocationInfo.do", "locationInfoRest/addLocationInfo.do");
		notFilterMap.put("/locationInfo/showLocationInfo4App.do", "locationInfo/showLocationInfo4App.do");
		notFilterMap.put("/locationInfo/getLocationInfoForwardPhone.do", "locationInfo/getLocationInfoForwardPhone.do");
		notFilterMap.put("/wcPayController/notify_Url.do", "wcPayController/notify_Url.do");
		notFilterMap.put("/curriculum/toSetCurriculumHuXin.do", "curriculum/toSetCurriculumHuXin.do");
		notFilterMap.put("/verify/verifyCardAndPerson.do", "verify/verifyCardAndPerson.do");
		notFilterMap.put("/recipe/toRecipeListByApiKey.do", "recipe/toRecipeListByApiKey.do");
		notFilterMap.put("/recipe/loadWeekRecipeByApiKey.do","recipe/loadWeekRecipeByApiKey.do");
		notFilterMap.put("/recipe/addFoodPicByApiKey.do","recipe/addFoodPicByApiKey.do");
		notFilterMap.put("/recipe/deleteDishByDishIdByApiKey.do","recipe/deleteDishByDishIdByApiKey.do");
		notFilterMap.put("/recipe/copyRecipeByApiKey.do","recipe/copyRecipeByApiKey.do");
		notFilterMap.put("/recipe/deleteWeekRecipeByApiKey.do","recipe/deleteWeekRecipeByApiKey.do");
		notFilterMap.put("/recipe/getUpTokenRecipe.do","recipe/getUpTokenRecipe.do");
		notFilterMap.put("/recipe/toRecipeListTopByApiKey.do","recipe/toRecipeListTopByApiKey.do");
		notFilterMap.put("/orderMessage/toOrderMessage4App.do", "orderMessage/toOrderMessage4App.do");
		notFilterMap.put("/orderMessage/toOrderMessagePayByApiKey.do", "orderMessage/toOrderMessagePayByApiKey.do");
		notFilterMap.put("/evaluateKindergarten/toEvaluateByApiKey.do", "evaluateKindergarten/toEvaluateByApiKey.do");
		notFilterMap.put("/morningCheck/toMorningCheckListByApiKey.do", "morningCheck/toMorningCheckListByApiKey.do");
		notFilterMap.put("/clazzPhoto/getUploadRecordsByApiKey.do", "clazzPhoto/getUploadRecordsByApiKey.do");
		notFilterMap.put("/clazzPhoto/addPraiseByApiKey.do", "clazzPhoto/addPraiseByApiKey.do");
		notFilterMap.put("/clazzPhoto/deletePraiseByApiKey.do", "clazzPhoto/deletePraiseByApiKey.do");
		notFilterMap.put("/clazzPhoto/addCommentByApiKey.do", "clazzPhoto/addCommentByApiKey.do");
		notFilterMap.put("/clazzPhoto/deleteCommentByApiKey.do", "clazzPhoto/deleteCommentByApiKey.do");
		notFilterMap.put("/clazzAlbum/loadAllAlbumListByApiKey.do", "clazzAlbum/loadAllAlbumListByApiKey.do");
		notFilterMap.put("/clazzAlbum/addAlbumByApiKey.do", "clazzAlbum/addAlbumByApiKey.do");
		notFilterMap.put("/clazzAlbum/uploadPhotoByApiKey.do", "clazzAlbum/uploadPhotoByApiKey.do");
		notFilterMap.put("/clazzAlbum/loadPhotoDetailByAlbumIdAndApiKey.do", "clazzAlbum/loadPhotoDetailByAlbumIdAndApiKey.do");
		notFilterMap.put("/clazzAlbum/deletePhotoByPhotoIdAndApiKey.do", "clazzAlbum/deletePhotoByPhotoIdAndApiKey.do");
		notFilterMap.put("/clazzAlbum/deleteAlbumByAlbumIdAndApiKey.do", "clazzAlbum/deleteAlbumByAlbumIdAndApiKey.do");
		notFilterMap.put("/clazzAlbum/getUpToken.do", "clazzAlbum/getUpToken.do");
		notFilterMap.put("/clazzAlbum/getClazzListByApiKey.do", "clazzAlbum/getClazzListByApiKey.do");
		notFilterMap.put("/clazzAlbum/collectPhotoByApiKey.do", "clazzAlbum/collectPhotoByApiKey.do");
		notFilterMap.put("/clazzAlbum/deleteUploadRecordsByApiKey.do", "clazzAlbum/deleteUploadRecordsByApiKey.do");
		notFilterMap.put("/taskAssistant/getSubjectListByApiKey.do", "taskAssistant/getSubjectListByApiKey.do");
		notFilterMap.put("/taskAssistant/sendTaskByApiKey.do", "taskAssistant/sendTaskByApiKey.do");
		notFilterMap.put("/taskAssistant/getStudentListByApiKey.do", "taskAssistant/getStudentListByApiKey.do");
		notFilterMap.put("/taskAssistant/getSendTaskListByApiKey.do", "taskAssistant/getSendTaskListByApiKey.do");
		notFilterMap.put("/taskAssistant/getReciveTaskListByApiKey.do", "taskAssistant/getReciveTaskListByApiKey.do");
		notFilterMap.put("/taskAssistant/getRoleListByApiKey.do", "taskAssistant/getRoleListByApiKey.do");
		notFilterMap.put("/schoolNewsLook/forwardDetail.do", "schoolNewsLook/forwardDetail.do");
		notFilterMap.put("/schoolNewsLook/applyInfoForward.do", "schoolNewsLook/applyInfoForward.do");
		notFilterMap.put("/schoolNewsLook/forwardDetailPhone.do", "schoolNewsLook/forwardDetailPhone.do");
		notFilterMap.put("/schoolNewsLook/forwardCommentsPhone.do","schoolNewsLook/forwardCommentsPhone.do");
		notFilterMap.put("/schoolNewsLook/applyInfoPhone.do","schoolNewsLook/applyInfoPhone.do");
		notFilterMap.put("/schoolNewsLook/forwardComments.do","schoolNewsLook/forwardComments.do");
		notFilterMap.put("/schoolNewsLook/getCommentsByAsync.do","schoolNewsLook/getCommentsByAsync.do");
		notFilterMap.put("/schoolNewsLook/getCommentsByAsyncPhone.do","schoolNewsLook/getCommentsByAsyncPhone.do");
		notFilterMap.put("/schoolNewsLook/getSchoolNewsListByApiKey.do","schoolNewsLook/getSchoolNewsListByApiKey.do");
		notFilterMap.put("/schoolNewsLook//getPersonSchoolNewsListByApiKey.do","schoolNewsLook//getPersonSchoolNewsListByApiKey.do");
		notFilterMap.put("/schoolNewsRelease/getGradeListByApiKey.do","schoolNewsRelease/getGradeListByApiKey.do");
		notFilterMap.put("/schoolNewsRelease/getClazzListByApiKey.do","schoolNewsRelease/getClazzListByApiKey.do");
		notFilterMap.put("/schoolNewsRelease/addSchoolNewsReleaseByApiKey.do","schoolNewsRelease/addSchoolNewsReleaseByApiKey.do");
		notFilterMap.put("/schoolNewsRelease/getUpToken.do","schoolNewsRelease/getUpToken.do");
		notFilterMap.put("/schoolNewsRelease/deleteSchoolNewsByApiKey.do","schoolNewsRelease/deleteSchoolNewsByApiKey.do");
		notFilterMap.put("/applyInfo/addApplyInfo.do", "applyInfo/addApplyInfo.do");
		notFilterMap.put("/getUserInfo/getUserInfo.do","getUserInfo/getUserInfo.do");
		notFilterMap.put("/getUserInfo/getGradeAndClazzBySchoolId.do","getUserInfo/getGradeAndClazzBySchoolId.do");
		notFilterMap.put("/getUserInfo/getParentsByClazzIdsAndSchoolId.do","getUserInfo/getParentsByClazzIdsAndSchoolId.do");
		notFilterMap.put("/getUserInfo/getUserByApiKey.do","getUserInfo/getUserByApiKey.do");
		notFilterMap.put("/getUserInfo/getPalmUserDetail.do","getUserInfo/getPalmUserDetail.do");
		notFilterMap.put("/camera/getCameraListByApiKey.do","camera/getCameraListByApiKey.do");
		notFilterMap.put("/personAlbum/getStudentListByApiKey.do","personAlbum/getStudentListByApiKey.do");
		notFilterMap.put("/personAlbum/loadPersonAlbumListByApiKey.do","personAlbum/loadPersonAlbumListByApiKey.do");
		notFilterMap.put("/personAlbum/addPersonAlbumByApiKey.do","personAlbum/addPersonAlbumByApiKey.do");
		notFilterMap.put("/personAlbum/uploadPersonPhotoByApiKey.do","personAlbum/uploadPersonPhotoByApiKey.do");
		notFilterMap.put("/personAlbum/loadPersonPhotoByAlbumIdAndApiKey.do","personAlbum/loadPersonPhotoByAlbumIdAndApiKey.do");
		notFilterMap.put("/personAlbum/deletePersonAlbumByAlbumIdAndApiKey.do","personAlbum/deletePersonAlbumByAlbumIdAndApiKey.do");
		notFilterMap.put("/personAlbum/deletePersonPhotoByPhotoIdAndApiKey.do","personAlbum/deletePersonPhotoByPhotoIdAndApiKey.do");
		notFilterMap.put("/todayActivity/toTodayActivityHuXin.do","todayActivity/toTodayActivityHuXin.do");
		notFilterMap.put("/teachingResources/getAppPageTeachingResources.do","teachingResources/getAppPageTeachingResources.do");
		notFilterMap.put("/teachingResources/toAppTeacherResource.do","teachingResources/toAppTeacherResource.do");
		notFilterMap.put("/teachingResources/getUpTokenInJS.do","teachingResources/getUpTokenInJS.do");
		notFilterMap.put("/teachingResources/addAppTeachingResources.do","teachingResources/addAppTeachingResources.do");
		notFilterMap.put("/dynamicGraph/loadAllGraphListByApiKey.do","dynamicGraph/loadAllGraphListByApiKey.do");
		notFilterMap.put("/appHomePage/getAPPHomePageByApiKey.do","appHomePage/getAPPHomePageByApiKey.do");
		notFilterMap.put("/appHomePage/getAddressListByApiKey.do","appHomePage/getAddressListByApiKey.do");
		notFilterMap.put("/school/addUserSchoolByHuxin.do","school/addUserSchoolByHuxin.do");
		notFilterMap.put("/school/deleteUserSchoolByHuxin.do","school/deleteUserSchoolByHuxin.do");
		notFilterMap.put("/school/getUserSchoolByApiKey.do","school/getUserSchoolByApiKey.do");
		notFilterMap.put("/mail/sendValidCode.do", "mail/sendValidCode.do");
		notFilterMap.put("/contact/getClazzContactList.do", "contact/getClazzContactList.do");
		notFilterMap.put("/contact/getSchoolContactList.do", "contact/getSchoolContactList.do");
		notFilterMap.put("/morningCheckRest/getUserInfoByCardCodeAndSchoolId.do", "morningCheckRest/getUserInfoByCardCodeAndSchoolId.do");
		notFilterMap.put("/morningCheckRest/dataReport.do", "morningCheckRest/dataReport.do");
		notFilterMap.put("/student/getStudentInfoByClassId.do", "student/getStudentInfoByClassId.do");
		notFilterMap.put("/apply/", "apply/");
		notFilterMap.put("/announce/", "announce/");
		notFilterMap.put("/message/", "message/");
		notFilterMap.put("/jspPermission/", "jspPermission/");
		notFilterMap.put("/shopping/", "shopping/");
		notFilterMap.put("/attendanceRest/", "attendanceRest/");
		notFilterMap.put("/announcement/getNweAnnouncement.do", "announcement/getNweAnnouncement.do");
		notFilterMap.put("/announcement/getPageAnnouncement.do", "announcement/getPageAnnouncement.do");
		notFilterMap.put("/announcement/getNweAnnouncementDetail.do", "announcement/getNweAnnouncementDetail.do");
		notFilterMap.put("/schoolNewsLook/getNweNews.do", "schoolNewsLook/getNweNews.do");
		notFilterMap.put("/schoolNewsLook/getPageNews.do", "schoolNewsLook/getPageNews.do");
		notFilterMap.put("/schoolNewsLook/getNweNewsById.do", "schoolNewsLook/getNweNewsById.do");
		notFilterMap.put("/userCas/doLogin.do", "userCas/doLogin.do");
		notFilterMap.put("/user/toPadLogin.do", "user/toPadLogin.do");
		notFilterMap.put("/user/toPadScoreLogin.do", "user/toPadScoreLogin.do");
		notFilterMap.put("/userCas/doLoginByFJAccount.do", "userCas/doLoginByFJAccount.do");
		notFilterMap.put("/erweima/downloadRichBook.do", "erweima/downloadRichBook.do");
		notFilterMap.put("/qiniuController/notifyURL.do", "qiniuController/notifyURL.do");
		notFilterMap.put("/qiniuController/teacherResourceNotifyURL.do", "qiniuController/teacherResourceNotifyURL.do");
		notFilterMap.put("/depart/getDepartListInteface.do", "depart/getDepartListInteface.do");
		notFilterMap.put("/teacher/getTeacherListByDepartmentId.do", "teacher/getTeacherListByDepartmentId.do");
		notFilterMap.put("/cardApply/toCardApplyByApiKey.do", "cardApply/toCardApplyByApiKey.do");
		notFilterMap.put("/cardApply/toApplyCardPayByApiKey.do", "cardApply/toCardApplyByApiKey.do");
		notFilterMap.put("/replaceRecharge/getOrderMessageListByApiKeyForCLassLeader.do", "replaceRecharge/getOrderMessageListByApiKeyForCLassLeader.do");
		notFilterMap.put("/replaceRecharge/getOrderMessageListByApiKeyForParent.do", "replaceRecharge/getOrderMessageListByApiKeyForParent.do");
		notFilterMap.put("/user/getTechnicalSupportInfo.do", "user/getTechnicalSupportInfo.do");
		notFilterMap.put("/user/getWisdomCampusClazzOrDepartGroup.do", "user/getWisdomCampusClazzOrDepartGroup.do");
		notFilterMap.put("/leave/getApplyPersonByApiKey.do", "leave/getApplyPersonByApiKey.do");
		notFilterMap.put("/leave/getAuditPersonByApiKey.do", "leave/getAuditPersonByApiKey.do");
		notFilterMap.put("/leave/getTypeListByApiKey.do", "leave/getTypeListByApiKey.do");
		notFilterMap.put("/leave/doAddLeaveByApiKey.do", "leave/doAddLeaveByApiKey.do");
		notFilterMap.put("/leave/getLeaveListByApiKey.do", "leave/getLeaveListByApiKey.do");
		notFilterMap.put("/leave/getLeaveDetailByApiKey.do", "leave/getLeaveDetailByApiKey.do");
		notFilterMap.put("/leave/getLeaveAuditListByApiKey.do", "leave/getLeaveAuditListByApiKey.do");
		notFilterMap.put("/leave/doLeaveAuditByApiKey.do", "leave/doLeaveAuditByApiKey.do");
		notFilterMap.put("/patrol/toPatrolListByApiKey.do", "patrol/toPatrolListByApiKey.do");
		notFilterMap.put("/asset/toAppAssetDetail.do", "asset/toAppAssetDetail.do");
		notFilterMap.put("/asset/getAppAssetDetailById.do", "asset/getAppAssetDetailById.do");
		notFilterMap.put("/orderMessage/getOrdersById.do", "orderMessage/getOrdersById.do");
		notFilterMap.put("/orderMessage/friendPayOrders.do", "orderMessage/friendPayOrders.do");
		//安全隐患
		notFilterMap.put("/securityDangerApp/getSecurityDangersType.do", "securityDangerApp/getSecurityDangersType.do");
		notFilterMap.put("/securityDangerApp/getSecurityDangerPages.do", "securityDangerApp/getSecurityDangerPages.do");
		notFilterMap.put("/securityDangerApp/getSecurityDangers.do", "securityDangerApp/getSecurityDangers.do");
		notFilterMap.put("/securityDangerApp/addSecurityDangers.do", "securityDangerApp/addSecurityDangers.do");
		notFilterMap.put("/securityDangerApp/getSecurityServiceman.do", "securityDangerApp/getSecurityServiceman.do");
		//学校认证
		notFilterMap.put("/authUserApp/getSchools.do", "authUserApp/getSchools.do");
		notFilterMap.put("/authUserApp/validateStudent.do", "authUserApp/validateStudent.do");
		notFilterMap.put("/authUserApp/addAuthUser.do", "authUserApp/addAuthUser.do");
		notFilterMap.put("/authUserApp/getAuthUserInfo.do", "authUserApp/getAuthUserInfo.do");
		notFilterMap.put("/authUserApp/refuse.do", "authUserApp/refuse.do");
		notFilterMap.put("/authUserApp/getClazzByLeader.do", "authUserApp/getClazzByLeader.do");
		notFilterMap.put("/authUserApp/getStudengByClazzId.do", "authUserApp/getStudengByClazzId.do");
		notFilterMap.put("/authUserApp/getUserSchoolId.do", "authUserApp/getUserSchoolId.do");
		notFilterMap.put("/authUserApp/submitUpdate.do", "authUserApp/submitUpdate.do");
		notFilterMap.put("/authUserApp/delete.do", "authUserApp/delete.do");
		notFilterMap.put("/authUserApp/validateAddParant.do", "authUserApp/validateAddParant.do");
		notFilterMap.put("/authUserApp/agree.do", "authUserApp/agree.do");
		notFilterMap.put("/authUserApp/validateUpdateParant.do", "authUserApp/validateUpdateParant.do");
		notFilterMap.put("/authUserApp/isClassLeader.do", "authUserApp/isClassLeader.do");
		notFilterMap.put("/authUserApp/getAuthUserPages.do", "authUserApp/getAuthUserPages.do");
		notFilterMap.put("/authUserApp/getAuthUser.do", "authUserApp/getAuthUser.do");
		//TODO IOS和安卓版本更新之后需要删除
		notFilterMap.put("/replaceRecharge/getStudentByClazzIdByApiKey.do", "replaceRecharge/getStudentByClazzIdByApiKey.do");
		notFilterMap.put("/replaceRecharge/getStudentListByApiKey.do", "replaceRecharge/getStudentListByApiKey.do");
		notFilterMap.put("/replaceRecharge/toOrderMessagePayByApiKey.do", "replaceRecharge/toOrderMessagePayByApiKey.do");
		notFilterMap.put("/userITC/doLogin.do", "userITC/doLogin.do");
		notFilterMap.put("/baseData/getStudentListByClazzIdByApiKey.do", "baseData/getStudentListByClazzIdByApiKey.do");
		notFilterMap.put("/apply/toApplySuccess.do", "apply/toApplySuccess.do");

		notFilterMap.put("/fileImport/tmp.do", "/fileImport/tmp.do");
		//手机端资产管理
		notFilterMap.put("/assetapp/", "assetapp/");
		//手机端扫码
		notFilterMap.put("/patrol/patrolScanCode.do", "patrol/patrolScanCode.do");
	}
	
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException
	{
		String servletPath = request.getServletPath();
		boolean doFilter = true;

		if (servletPath.indexOf(".do") != -1)
		{
			String path = servletPath.substring(0, servletPath.lastIndexOf("/")+1);
			//是否过滤
			if(notFilterMap.containsKey(servletPath)||notFilterMap.containsKey(path)){
				doFilter = false;
			}
		} else
		{
			doFilter = false;
		}
		
		if (doFilter)
		{

			// 判断session是否过期
			Object attribute = request.getSession().getAttribute("user");

			if (null == attribute)
			{
				request.setCharacterEncoding("UTF-8");
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				String loginPage = "../login.jsp";
				
				out.println("<script type='text/javascript'>alert('页面已过期，请重新登陆！');window.top.location.href='" + loginPage + "';</script>");
//				out.println("<script src='//cdn.bootcss.com/jquery/3.2.1/jquery.js'></script>"
//						+ "<script src='//cdn.bootcss.com/layer/3.0.1/layer.js'></script>"
//						+ "<script type='text/javascript'>"
//						+ "layer.open({"
//						+ "type: 1,"
//						+ "title: true,"
//						+ "closeBtn: false,"
//						+ "area: '300px;',"
//						+ "shade: 0.8,"
//						+ "id: 'LAY_layuipro' ,"
//						+ "resize: false,"
//						+ "btn: ['火速围观', '残忍拒绝'],"
//						+ "btnAlign: 'c',"
//						+ "moveType: 1,"
//						+ "content: '<div style=\"padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;\">内容<br>内容</div>',"
//						+ "success: function(layero){"
//						+ "var btn = layero.find('.layui-layer-btn');"
//						+ "btn.find('.layui-layer-btn0').attr({href: 'http://www.layui.com/',target: '_blank'});}"
//						+ "});"
//						+ "</script>");
			} else
			{
				// 获取request中用户学校ID
				User user = (User) attribute;
				String schoolId = user.getSchoolId();
				if (null != schoolId || "".equals(schoolId))
				{
					DBContextHolder.setDBType(schoolId);
				} else
				{
					DBContextHolder.setDBType("0");
				}
				filterChain.doFilter(request, response);
			}
		} else
		{
			filterChain.doFilter(request, response);
		}

	}
}
