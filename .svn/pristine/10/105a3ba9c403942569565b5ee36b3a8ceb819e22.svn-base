package com.guotop.palmschool.classphotoalbum.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.classphotoalbum.entity.Photo;

/**
 * 班级相册接口业务接口
 */
public interface PhotoService
{
	/**
	 * 添加照片
	 */
	public void addPhoto(Photo photo);
	
	/**
	 * 批量添加照片
	 */
	public void addPhotoBATCH(List<Photo> photoList);
	
	/**
	 * 获取上传记录的本次上传的相册列表
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	public List<Photo> getPhotoListByRecordsId(Map<String, Object> paramMap);
	
	/**
	 * 根据上传记录的records找出班级相册中的所有照片
	 * @param paramMap
	 * @return
	 */
	public List<Photo> getPhotoAllListByRecordsId(Map<String, Object> paramMap);
	
	/**
	 * 根据albumId加载所有的照片
	 * @param albumId
	 */
	public List<Photo> getPhotoDetailByAlbumId(Integer albumId);
	
	/**
	 * 根据albumId加载所有的照片和评论
	 * @param albumId
	 */
	public List<Photo> getPhotoListAndCommentListByAlbumId(Integer albumId);
	
	/**
	 * 根据photoId删除所有的照片和评论
	 * @param photoId
	 */
	public void deletePhotoByPhotoId(Integer photoId);
	
	/**
	 * 根据photoId修改对应的照片信息
	 * @param photo
	 */
	public void modifyPhotoByPhotoId(Photo photo);
	
	/**
	 *根据recordsId批量修改照片
	 * @param photo
	 */
	public void savePhotoByRecordsId(Photo photo);
	
	/**
	 * 根据相片id查询对应记录Id下面的所有照片
	 */
	public List<Photo> getPhotoList(Integer photoId);
	
	/**
	 * 根据recordsId删除相片和对应的评论
	 * @param recordsId
	 */
	public void deletePhotoByRecordsId(Integer recordsId);
	
	/**
	 * 根据photoId查找照片
	 * @param photoId
	 */
	public Photo getPhotoByPhotoId(Integer photoId);
}
