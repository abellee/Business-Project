package net
{
	import events.IOEvent;
	
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;

	public class CHub extends EventDispatcher
	{
		public function CHub()
		{
		}
		public function CmdCall(cmd:String,arg:*=null,arg2:*=null)
		{
			ExternalInterface.call(cmd,arg,arg2);
		}
		public function proxycall(cmd:String,arg:*=null,arg2:*=null) : String
		{
			myTrace("MyProxyCall");
			if (cmd=="oninitfinish")
			{
				myTrace("oninitfinish in xuanskin");
				this.dispatchEvent(new IOEvent(IOEvent.START_MOTION));
				myTrace("oninitfinish START_MOTION");
				
				UpdatePlayerSize();
				ExternalInterface.call("updatectrlreg","titlebutton_mc_lx:820_ly:9_rx:985_ry:40_TL:right_top_BR:right_top");
				//CmdCall("cmd","getloginuser");
				//if (arg=="1")
				//DoShow(9,false);
				//else DoShow(0,false);
				CmdCall("xuanpage","0");
				CmdCall("proxyevent","listbtn,initfinish");
			}
			else if (cmd=="setMax")
			{
				//max_mc.visible=(arg!="1");
				//maxr_mc.visible=(arg=="1");
			}
			else if (cmd=="showplayer")
			{
				//if (arg=="1") DoShow(9,false);
				//else if (_cursel==9) DoShow(_lastviewsel,false,false);
			}
			else if (cmd=="listbtn")
			{
				if (arg=="filldata")
				{
					myTrace("fillData in AS: " + arg2);
					// 程序启动后,C++就会调用这个函数将最近播放列表加入到Flash中
					// 传过来的历史记录格式:name|id; 分号隔开每部电影,|隔开名称与ID
					// VideoName1|VideoID1;VideoNam2|VideoID2;...
					
					var ar:Array=arg2.split(";");
					var ret:String="";
					var finalArr:Array = [];
					for(var i=0;i<ar.length;i++)
					{
						var ar1:Array=ar[ar.length-1-i].split("|");
						//TODO 请将最近播放加入到视图列表
						trace(ar1[0]);
						trace(ar1[1]);
						finalArr.push(ar1);
						//ret+="<a href='event:leftHistory"+i+"'>"+FillText(ar1[0],ar1[1])+"</a><br>";
					}
					
					var ioEvent:IOEvent = new IOEvent(IOEvent.C_DATA_IN);
					//myTrace("fillData send C_DATA_IN");
					//myTrace("finalArr size:" + finalArr.length);
					
					ioEvent.result = arg2;
					this.dispatchEvent(ioEvent);
					
				}
			}
			else if (cmd=="synloginuser")
			{
				/*if (_lastloginUser!=arg)
				{
				_lastloginUser=arg;
				if (_lastloginUser.length==0)
				{
				loginuser_mc.text="";
				login_mc.visible=true;
				reg_mc.visible=true;
				logout_mc.visible=false;
				}
				else
				{
				loginuser_mc.htmlText="您好：<a href='http://zone.ku6.com/welcome.htm' target='_blank'><font color='#FF5C00'>"+_lastloginUser+"</font></a>";
				login_mc.visible=false;
				reg_mc.visible=false;
				logout_mc.visible=true;
				logout_mc.x=loginuser_mc.x+loginuser_mc.width+5;
				}
				}*/
			}
			
			return "";
		}
		public function UpdatePlayerSize()
		{
			var left= 0;
			/*const x=80;
			const y=110;
			const b=48;
			const w=948;
			const h=550;
			*/
			left = 0;
			const x=2;
			const y=35;
			const b=47;
			const w=960
			const h=600;
			
			myTrace("UpdatePlayerSize");
			trace("skinArea_mc_lx:"+(x+left)+"_ly:"+y+"_rx:"+w+"_ry:"+h+"_TL:left_top_BR:right_bottom");
			trace("playArea_mc_lx:"+(x+left)+"_ly:"+y+"_rx:"+w+"_ry:"+(h-b)+"_TL:left_top_BR:right_bottom");
			
			ExternalInterface.call("updatectrlreg","skinArea_mc_lx:"+(x+left)+"_ly:"+y+"_rx:"+w+"_ry:"+h+"_TL:left_top_BR:right_bottom");
			ExternalInterface.call("updatectrlreg","playArea_mc_lx:"+(x+left)+"_ly:"+y+"_rx:"+w+"_ry:"+(h-b)+"_TL:left_top_BR:right_bottom");
			ExternalInterface.call("updatesize");
		}
		public function myTrace(info : String) : void
		{
			info = "Proxy:" + info;
			trace(info);
			ExternalInterface.call("debug", info);
		}
	}
}