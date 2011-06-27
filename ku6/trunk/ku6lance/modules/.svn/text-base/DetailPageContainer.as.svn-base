package modules
{
	import events.IOEvent;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextFieldAutoSize;
	import flash.events.TextEvent;
	import net.CHub;
	import fl.data.DataProvider;
	import fl.managers.StyleManager;
	
	public class DetailPageContainer extends Sprite
	{
		
		private var detailPage:DetailPage = new DetailPage();
		
		private var _imgurl:String;
		private var _vid:Number;
		private var _hd:uint = 1;
		private var _vodsArr:Array = [];
		
		private var loader:Loader = new Loader();
		//for c
		private var chub:CHub = new CHub();
		
		public function DetailPageContainer()
		{
			super();
			init();
			addListener();
		}
		private function init():void{
			
			this.addChild(detailPage);
			
			this.width = detailPage.width;
			this.height = detailPage.height;
			
			detailPage.playBtn.buttonMode = true;
			detailPage.btnBack.buttonMode = true;
			//detailPage.chapterList.autoSize = TextFieldAutoSize.LEFT;
			detailPage.chapterList.setStyle("skin", new Sprite());
			detailPage.chapterList.setStyle("borderStyle", "none");
			detailPage.chapterList.setStyle("dropShadowEnabled", false);
			detailPage.chapterList.setStyle("borderThickness", 0);
			detailPage.chapterList.setStyle("backgroundAlpha", 0);
			detailPage.chapterList.setStyle("cellRenderer", CustomCellRenderer);
			detailPage.chapterList.setStyle("upArrowUpSkin", new Sprite());
			detailPage.chapterList.setStyle("downArrowUpSkin", new Sprite());
			detailPage.chapterList.setStyle("trackUpSkin", ListTrack);
			detailPage.chapterList.setStyle("trackOverSkin", ListTrack);
			detailPage.chapterList.setStyle("trackDownSkin", ListTrack);
			detailPage.chapterList.setStyle("thumbUpSkin", ListThumbIcon);
			detailPage.chapterList.setStyle("thumbOverSkin", ListThumbIcon);
			detailPage.chapterList.setStyle("thumbDownSkin", ListThumbIcon);
			detailPage.chapterList.setStyle("thumbIcon", new Sprite());
			StyleManager.clearStyle("focusRectSkin");

		}
		private function addListener():void{
			
			detailPage.btnBack.addEventListener(MouseEvent.CLICK, backToPreStep);
			detailPage.playBtn.addEventListener(MouseEvent.CLICK, playMovie);
			//detailPage.chapterList.addEventListener(TextEvent.LINK, showChapterMovie);
			detailPage.chapterList.addEventListener(Event.CHANGE, showChapterMovie);
			
		}
		
		private function playMovie(event:MouseEvent):void{
			if( _hd == 0 )
				return;
			trace(_vid);
			//"ku6p2p://playfid/"+id;
			trace(event.target.name);
			chub.CmdCall("proxyevent","listbtn,setupfidimg," + _vid + "|" + _imgurl);
			
			var _hdScheme:uint = 0;
			if( _hd >= 2 )
				_hdScheme = 1;
			chub.CmdCall("proxyevent","playcmd,ku6p2p://playfid/"+_vid+"/"+_hdScheme);

		}
		
		private function imageLoaded(event:Event):void{
			
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imageLoaded);
			
			var bitmap:Bitmap = event.target.content as Bitmap;
			
			bitmap.width = 130;
			bitmap.height = 170;
			
			detailPage.movieCover.mouseEnabled = false;
			detailPage.movieCover.mouseChildren = false;
			detailPage.movieCover.addChild(bitmap);
			
		}
		
		public function addInfo(obj:Object):void{
			
			while(detailPage.relatedMC.numChildren){
				
				detailPage.relatedMC.removeChildAt(detailPage.relatedMC.numChildren - 1);
				
			}
			
			this.imageURL = obj.pic;
			this._vid = obj.id;
			detailPage.movieTitle.selectable = false;
			detailPage.movieTitle.autoSize = TextFieldAutoSize.LEFT;
			detailPage.movieTitle.text = obj.title;
			this.hd = uint(obj.gqSmart);
			
			detailPage.movieAbout.text = "别名: "+""+"\n导演: "+obj.director+"\n编剧: "+""
				+"\n演员: "+obj.star+"\n类型: "+obj.sort+"\n制作国家/地区: "+obj.zone+"\n语言: "+obj.Language+"\n上映时间: "+obj.date;

			detailPage.desTxt.text = obj.desc;
			//detailPage.chapterList.text = "";
			
			_vodsArr = [];
			
			if(obj.chapters && obj.chapters.length){
				trace(obj.chapters.length + ">>>>>>>>");
				detailPage.chapterList.labelField = "gqTitle";
				detailPage.chapterList.dataProvider = new DataProvider(obj.chapters);
				for each(var o:Object in obj.chapters)
				{
					
					//detailPage.chapterList.htmlText += "<a href='event:"+o.vid+"'>"+o.gqTitle+"</a><br>";
					//trace(o.vid);
					_vodsArr.push(o.vid);
				}
			}else{
				
				detailPage.chapterList.dataProvider = new DataProvider();
				
			}
			//trace(detailPage.chapterList.htmlText);
			
			if(obj.filmRelatedList && obj.filmRelatedList.length){
				
				for(var i:uint=0; i < obj.filmRelatedList.length; i++){
					
					var oo:Object = obj.filmRelatedList[i];
					
					var relatedFilm:RelatedMC = new RelatedMC();
					
					relatedFilm.buttonMode = true;
					
					relatedFilm.fid = oo.id;
					relatedFilm.hd = oo.gqSmart;
					
					relatedFilm.showInfo(oo);
					
					relatedFilm.x = i * (relatedFilm.width + 10);
					relatedFilm.y = 0;
					
					relatedFilm.addEventListener(MouseEvent.CLICK, showNextDetailPage);
					
					detailPage.relatedMC.addChild(relatedFilm);
					
				}
				
			}
			this.dispatchEvent(new IOEvent(IOEvent.DETAIL_PAGE_READY));
			
		}
		private function showChapterMovie(event:Event):void{
			trace( "showChapterMovie:" + _hd );
				 
			if( _hd == 0 )
				return ;
				
			var cvid:String = detailPage.chapterList.selectedItem.vid;
			var gq:uint = 1;
			
			chub.myTrace("Current vod:" + cvid);
			//chub.myTrace("All vods size:" + _vodsArr.join("0x2c") );
			
			chub.CmdCall("proxyevent","listbtn,setupfidimg," + cvid + "|" + _imgurl);
			if( _vodsArr.length == 1)
			{
				chub.CmdCall("proxyevent","listbtn,setupfidvids," + _vid + "|" + cvid ) ;
				chub.CmdCall("proxyevent","playcmd,ku6p2p://playvod/"+ cvid );
			}
			else{
				trace(_vodsArr.join("0x2c"));
				chub.CmdCall("proxyevent","listbtn,setupfidvids," + _vid + "|" + _vodsArr.join("0x2c")) ;
				chub.CmdCall("proxyevent","playcmd,ku6p2p://playvod/"+ _vodsArr.join("0x2c") + "/"+ cvid);
			}
			
		}
		private function showNextDetailPage(event:MouseEvent):void{
			
			var relatedFilm:RelatedMC = event.currentTarget as RelatedMC;
			
			var ioEvent:IOEvent = new IOEvent(IOEvent.NEXT_DETAIL_PAGE);
			ioEvent.result = {};
			ioEvent.result.vid = relatedFilm.fid;
			var hdflag:uint = 0;
			if( relatedFilm.hd >=2 )
				hdflag = 1;
				
			ioEvent.result.hd = hdflag;
			ioEvent.result.m = "getPlayPageData";
			
			this.dispatchEvent(ioEvent);
			
		}
		
		private function backToPreStep(event:MouseEvent):void{
			
			this.dispatchEvent(new IOEvent(IOEvent.PRE_STEP));
			
		}
		
		public function set imageURL(str:String):void{
			_imgurl = str;
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			loader.load(new URLRequest(str));
			
		}
		public function get imageURL():String{
			
			return _imgurl;
			
		}
		public function set vid(value:Number):void{
			
			_vid = value;
			
		}
		public function get vid():Number{
			
			return _vid;
			
		}
		public function set hd(value:uint):void{
			trace("Detail set hd :" + value);
			
			_hd = value;
			if(value == 0){
				
				detailPage.playBtn.visible = false;
				
			}else{
				
				detailPage.playBtn.visible = true;
				
			}
			
		}
		public function get hd():uint{
			
			return _hd;
			
		}
	}
}	