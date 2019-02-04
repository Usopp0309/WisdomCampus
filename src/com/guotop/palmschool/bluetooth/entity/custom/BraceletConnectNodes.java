package com.guotop.palmschool.bluetooth.entity.custom;

import java.util.ArrayList;
import java.util.List;

/**
 * 蓝牙手环连接状态实体类
 * 
 * @author Administrator
 *
 */

public class BraceletConnectNodes
{
	private List<BraceletConnectStatus> nodes = new ArrayList<BraceletConnectNodes.BraceletConnectStatus>();
	
	public List<BraceletConnectStatus> getNodes()
	{
		return nodes;
	}


	public void setNodes(List<BraceletConnectStatus> nodes)
	{
		this.nodes = nodes;
	}


	public class BraceletConnectStatus{
		private String handle;
		private BraceletReciveSubData bdaddrs;
		private String connectionState;
		private String name;
		private String id;// 蓝牙手环mac地址
		private String type;
		private String chipId;

		public String getHandle()
		{
			return handle;
		}

		public void setHandle(String handle)
		{
			this.handle = handle;
		}

		public BraceletReciveSubData getBdaddrs()
		{
			return bdaddrs;
		}

		public void setBdaddrs(BraceletReciveSubData bdaddrs)
		{
			this.bdaddrs = bdaddrs;
		}

		public String getConnectionState()
		{
			return connectionState;
		}

		public void setConnectionState(String connectionState)
		{
			this.connectionState = connectionState;
		}

		public String getName()
		{
			return name;
		}

		public void setName(String name)
		{
			this.name = name;
		}

		public String getId()
		{
			return id;
		}

		public void setId(String id)
		{
			this.id = id;
		}

		public String getType()
		{
			return type;
		}

		public void setType(String type)
		{
			this.type = type;
		}

		public String getChipId()
		{
			return chipId;
		}

		public void setChipId(String chipId)
		{
			this.chipId = chipId;
		}
	}
}
