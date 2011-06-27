package modules
{
	import com.greensock.TweenLite;
	
	import events.IOEvent;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import net.CHub;

	public class ListCover extends Sprite
	{
		
		private var indexFrame:ListFrame = new ListFrame();
		
		private var txtFormat:TextFormat = new TextFormat();
		private var txtFormat1:TextFormat = new TextFormat();
		
		private var _vid:Number;
		private var _hd:uint = 1;
		private var _imgurl:String;
		
		private var nameTxt:TextField;
		private var nameTxta:TextField;
		private var scoreTxt:TextField;
		private var scoreTxta:TextField;
		
		private var loader:Loader = new Loader();
		
		private var loadingMC:LoadingMC = new LoadingMC();
		//for c
		private var chub:CHub = new CHub();

		public function ListCover()
		{
			super();
			init();
			addListener();
		}
		private function init():void{
			
			txtFormat.font = "Arial Black";
			txtFormat.size = 16;
			txtFormat.color = 0xFF9900;
			txtFormat.bold = true;
			txtFormat.letterSpacing = -1;
			
			txtFormat1.font = "黑体";
			txtFormat1.size = 12;
			txtFormat1.color = 0xffffff;
			txtFormat1.bold = false;
			
			this.addChild(indexFrame);
			this.width = indexFrame.width;
			this.height = indexFrame.height;
			
			indexFrame.addEventListener(MouseEvent.ROLL_OVER, showMaskMC);
			indexFrame.addEventListener(MouseEvent.ROLL_OUT, hideMaskMC);
			
			nameTxt = new TextField();
			nameTxt.autoSize = TextFieldAutoSize.LEFT;
			nameTxt.selectable = false;
			nameTxt.defaultTextFormat = txtFormat1;
			
			nameTxta = new TextField();
			nameTxta.autoSize = TextFieldAutoSize.LEFT;
			nameTxta.selectable = false;
			nameTxta.defaultTextFormat = txtFormat1;
			
			scoreTxt = new TextField();
			scoreTxt.autoSize = TextFieldAutoSize.LEFT;
			scoreTxt.selectable = false;
			scoreTxt.defaultTextFormat = txtFormat;
			
			scoreTxta = new TextField();
			scoreTxta.autoSize = TextFieldAutoSize.LEFT;
			scoreTxta.selectable = false;
			scoreTxta.defaultTextFormat = txtFormat;
			
			indexFrame.nameTab.addChild(nameTxt);
			indexFrame.nameTab.addChild(scoreTxt);
			indexFrame.maskMC.addChild(nameTxta);
			indexFrame.maskMC.addChild(scoreTxta);
			
			indexFrame.maskMC.detailBtn.mouseChildren = false;
			indexFrame.maskMC.detailBtn.buttonMode = true;
			
			loadingMC.alpha = 0;
			loadingMC.scaleX = loadingMC.scaleY = .5;
			
		}
		private function addListener():void{
			
			indexFrame.maskMC.playBtn.addEventListener(MouseEvent.CLICK, playMovie);
			indexFrame.maskMC.detailBtn.addEventListener(MouseEvent.CLICK, showDetailPage);
			
		}
		private function playMovie(event:MouseEvent):void{
			if( _hd == 0 )
				return;
			trace(_vid);
			//"ku6p2p://playfid/"+id;
			trace(event.target.name);
			//chub.CmdCall("proxyevent","playcmd,ku6p2p://playfid/"+_vid);
			chub.CmdCall("proxyevent","listbtn,setupfidimg," + _vid + "|" + _imgurl);  
			
			var _hdScheme:uint = 0;
			if( _hd >= 2 )
				_hdScheme = 1;
			chub.CmdCall("proxyevent","playcmd,ku6p2p://playfid/"+_vid+"/"+_hdScheme);
			
		}
		private function showDetailPage(event:MouseEvent):void{
			
			var ioEvent:IOEvent = new IOEvent(IOEvent.SHOW_DETAIL_PAGE);
			ioEvent.result = {};
			ioEvent.result.vid = _vid;
			
			//var hdflag:uint = 0;
			//if( _hd >= 2 )
				//hdflag = 1;
				
			//trace("hdflag:" + hdflag );
			ioEvent.result.hd = _hd ;
			ioEvent.result.m = "getPlayPageData";
			
			this.dispatchEvent(ioEvent);
			
		}
		public function set vid(id:Number):void{
			
			_vid = id;
			
		}
		public function get vid():Number{
			
			return _vid;
			
		}
		public function set hd(value:uint):void{
			
			_hd = value;
			if(value == 0){
				
				indexFrame.maskMC.playBtn.visible = false;
				
			}else{
				
				indexFrame.maskMC.playBtn.visible = true;
				
			}
			
		}
		public function get hd():uint{
			
			return _hd;
			
		}
		public function set filmName(str:String):void{
			
			nameTxt.text = nameTxta.text = str;
			nameTxt.x = 0;
			nameTxt.y = 6;
			nameTxta.x = 0;
			nameTxta.y = 2;
			
			
		}
		public function set score(str:Number):void{
			
			scoreTxt.text = scoreTxta.text = str + "";
			scoreTxt.x = indexFrame.nameTab.width - scoreTxt.textWidth - 4;
			scoreTxt.y = -1;
			scoreTxta.x = indexFrame.maskMC.width - scoreTxta.textWidth - 4;
			scoreTxta.y = -5;
			
		}
		public function set coverURL(str:String):void{
			_imgurl = str;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, coverImg_loadComplete_handler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, coverImg_loadFailed_handler);
			loader.load(new URLRequest(str), new LoaderContext(true, ApplicationDomain.currentDomain));
			
		}
		public function removeMaskMC():void{
			
			indexFrame.removeChild(indexFrame.maskMC);
			
		}
		private function coverImg_loadComplete_handler(event:Event):void{
			
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, coverImg_loadFailed_handler);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, coverImg_loadComplete_handler);
			
			indexFrame.removeChild(indexFrame.mcLogo);
			
			var bitmap:Bitmap = event.target.content as Bitmap;
			bitmap.width = 90;
			bitmap.height = 120;
			bitmap.x = indexFrame.maskMC.x;
			bitmap.y = indexFrame.maskMC.y;
			indexFrame.addChildAt(bitmap, 1);
			bitmap.alpha = 0;
			TweenLite.to(bitmap, .5, {alpha:1});
			
			loader = null;
			
		}
		private function coverImg_loadFailed_handler(event:IOErrorEvent):void{
			
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, coverImg_loadFailed_handler);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, coverImg_loadComplete_handler);
			loader = null;
			
		}
		private function showMaskMC(event:MouseEvent):void{
			
			indexFrame.nameTab.visible = false;
			TweenLite.to(indexFrame.maskMC, .5, {alpha:1});
			
		}
		private function hideMaskMC(event:MouseEvent):void{
			
			indexFrame.nameTab.visible = true;
			TweenLite.to(indexFrame.maskMC, .5, {alpha:0});
			
		}
	}
}