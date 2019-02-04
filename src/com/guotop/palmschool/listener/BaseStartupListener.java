package com.guotop.palmschool.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.web.context.ContextLoaderListener;

/**
 * 系统监听基类
 * @author zhou
 */
public class BaseStartupListener extends ContextLoaderListener implements
		ServletContextListener 
{
	public void contextInitialized(ServletContextEvent event) 
	{

		ServletContext context = event.getServletContext();
		config(context);

		super.contextInitialized(event);

		init(context);
	}

	public void config(ServletContext context) 
	{
		
	}

	public void init(ServletContext context) 
	{
		
	}

	public void close(ServletContextEvent event) 
	{
		
	}

	public void contextDestroyed(ServletContextEvent event) 
	{
		close(event);
		super.contextDestroyed(event);
	}

}
