package com.guotop.palmschool.classphotoalbum.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.classphotoalbum.entity.ClassPhotoAlbum;
import com.guotop.palmschool.classphotoalbum.entity.Photo;
import com.guotop.palmschool.classphotoalbum.service.ClassAlbumService;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Grade;
import com.guotop.palmschool.service.BaseService;

@Service("/classAlbumService")
public class ClassAlbumServiceImpl extends BaseService implements ClassAlbumService
{

	/**
	 * 添加相册
	 */
	public Integer addAlbum(ClassPhotoAlbum album)
	{
		return (Integer)getBaseDao().addObject("Album.addAlbum", album);
	}
	
	/**
	 * 修改相册
	 */
	public void modifyAlbumByAlbumId(ClassPhotoAlbum album)
	{
		getBaseDao().updateObject("Album.modifyAlbumByAlbumId", album);
	}
	
	/**
	 * 设置相册封面
	 */
	public void setAlbumCover(Map<String,Object> paramMap)
	{
		getBaseDao().updateObject("Album.setAlbumCover", paramMap);
	}
	
	/**
	 * 根据班级Id查询对应的相册
	 * @param clazzId
	 */
	@SuppressWarnings("unchecked")
	public List<ClassPhotoAlbum> getAlbumListByClazzId(Integer clazzId)
	{
		return (List<ClassPhotoAlbum>)getBaseDao().selectList("Album.getAlbumListByClazzId", clazzId);
	}
	
	/**
	 * 根据albumId删除相册
	 * @param albumId
	 */
	public void deleteAlbumByAlbumId(Integer albumId)
	{
		getBaseDao().deleteObjectById("Album.deleteAlbumByAlbumId", albumId);
		
		deletePhotoByAlbumId(albumId);
		
		deleteUploadRecordsByAlbumId(albumId);
	}
	
	/**
	 * 根据albumId删除相片和对应的评论
	 * @param albumId
	 */
	public void deletePhotoByAlbumId(Integer albumId)
	{
		getBaseDao().deleteObjectById("Photo.deletePhotoByAlbumId", albumId);
	}
	
	/**
	 * 根据albumId删除上传记录和评论
	 * @param albumId
	 */
	public void deleteUploadRecordsByAlbumId(Integer albumId)
	{
		getBaseDao().deleteObjectById("Records.deleteUploadRecordsByAlbumId", albumId);
	}
	
	/**
	 * 根据albumId查找相册
	 * @param albumId
	 */
	public ClassPhotoAlbum getAlbumByAlbumId(Integer albumId)
	{
		return (ClassPhotoAlbum)getBaseDao().selectObject("Album.getAlbumByAlbumId", albumId);
	}
	
	/**
	 * 根据recordsId查找相册
	 * @param albumId
	 */
	public ClassPhotoAlbum getAlbumByRecordsId(Integer recordsId){
		return (ClassPhotoAlbum)getBaseDao().selectObject("Album.getAlbumByRecordsId", recordsId);
	}

	/**
	 * 根据albumId查找相片 取最后一条
	 */
	public Photo getPhotoByAlbumId(Integer albumId)
	{
		return (Photo)getBaseDao().selectObject("Photo.getPhotoByAlbumId", albumId);
	}
}
