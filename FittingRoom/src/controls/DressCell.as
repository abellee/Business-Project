package controls
{
	import com.greensock.TweenLite;
	import com.kge.core.UIView;
	
	import data.Dress;
	import data.DressType;
	
	import delegates.DressCellDelegate;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import resource.Resource;
	
	public class DressCell extends UIView
	{
		private var background:Shape = new Shape();
		private var detailButton : Sprite = new Sprite();
		private var detailLabel : TextField = new TextField();
		private var clickedSkin : Shape = new Shape();
		private var loadingMotion : MovieClip = new (Resource.Chrysanthemum)();
		private var dress:Dress;
		private var loader:Loader;
		private var bitmap:Bitmap;
		public var cellDeleagte:DressCellDelegate;
		private var cellWidth:int = 66;
		private var cellHeight:int = 67;
		private var position:String = "lt";
		public function DressCell(w:int, h:int, pos:String = "lt")
		{
			super();
			
			cellWidth = w;
			cellHeight = h;
			position = pos;
			
			addEventListener(Event.REMOVED_FROM_STAGE, this_removedFromStageHandler);
			
			drawBackground();
			drawClickedSkin();
			drawDetailButton();
		}
		
		private function this_removedFromStageHandler(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, this_removedFromStageHandler);
			if(loader){
				try{
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, thumbnail_loadCompleteHandler);
					loader.close();
				}catch(e:Error){}
				loader = null;
			}
			if(bitmap){
				bitmap.bitmapData.dispose();
				bitmap = null;
			}
		}
		
		public function loadThumbnail():void
		{
			addChild(loadingMotion);
			loadingMotion.x = background.width / 2;
			loadingMotion.y = background.height / 2;
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, thumbnail_loadCompleteHandler);
			loader.load(new URLRequest(dress.smallImage));
		}
		
		private function thumbnail_loadCompleteHandler(event:Event):void
		{
			if(this.contains(loadingMotion)) this.removeChild(loadingMotion);
			bitmap = event.target.content as Bitmap;
			addChild(bitmap);
			bitmap.x = (background.width - bitmap.width) / 2;
			bitmap.y = (background.height - bitmap.height) / 2;
			addEventListener(MouseEvent.MOUSE_OVER, this_mouseEventHandler);
			addEventListener(MouseEvent.MOUSE_OUT, this_mouseEventHandler);
			addEventListener(MouseEvent.CLICK, this_mouseEventHandler);
		}
		
		private function this_mouseEventHandler(event:MouseEvent):void
		{
			switch(event.type){
				case MouseEvent.MOUSE_OVER:
					if(this.parent){
						this.parent.setChildIndex(this, this.parent.numChildren - 1);
					}
					bitmap.alpha = .5;
					if(dress.type != DressType.BODY_TYPE && dress.type != DressType.FACE && dress.type != DressType.HAIR) showDetailButton();
					break;
				case MouseEvent.MOUSE_OUT:
					bitmap.alpha = 1;
					if(dress.type != DressType.BODY_TYPE && dress.type != DressType.FACE && dress.type != DressType.HAIR) hideDetailButton();
					break;
				case MouseEvent.CLICK:
					clickedSkin.visible = true;
					if(cellDeleagte) cellDeleagte.cellClicked(this);
					break;
			}
		}
		
		private function showDetailButton():void
		{
			TweenLite.to(detailButton, .2, {y: background.height});
		}
		
		private function hideDetailButton():void
		{
			TweenLite.to(detailButton, .2, {y: background.height - detailButton.height});
		}
		
		public function hideClickedSkin():void
		{
			clickedSkin.visible = false;
		}
		
		public function set data(d:Dress):void
		{
			dress = d;
		}
		
		public function get data():Dress
		{
			return dress;
		}
		
		private function drawBackground():void
		{
			background.graphics.clear();
			background.graphics.beginFill(0xf0ede9, 1);
			background.graphics.drawRect(0, 0, cellWidth, cellHeight);
			background.graphics.endFill();
			addChildAt(background, 0);
		}
		
		private function drawClickedSkin():void
		{
			clickedSkin.graphics.clear();
			clickedSkin.graphics.lineStyle(2, 0x8eb945);
			clickedSkin.graphics.beginFill(0x000000, 0);
			clickedSkin.graphics.drawRect(0, 0, cellWidth, cellHeight);
			clickedSkin.graphics.endFill();
			clickedSkin.visible = false;
			addChild(clickedSkin);
		}
		
		private function drawDetailButton():void
		{
			detailButton.graphics.clear();
			detailButton.graphics.lineStyle(1, 0x516a05);
			detailButton.graphics.beginFill(0x6da400, 1);
			detailButton.graphics.drawRect(0, 0, 40, 18);
			detailButton.graphics.endFill();
			addChildAt(detailButton, 0);
			detailLabel.defaultTextFormat = new TextFormat(null, 12, 0xFFFFFF);
			detailLabel.text = "详情";
			detailLabel.autoSize = TextFieldAutoSize.LEFT;
			detailButton.addChild(detailLabel);
			detailButton.mouseChildren = false;
			detailLabel.selectable = false;
			detailLabel.mouseEnabled = false;
			detailLabel.x = (detailButton.width - detailLabel.width) / 2;
			detailLabel.y = (detailButton.height - detailLabel.height) / 2;
			
			detailButton.x = (background.width - detailButton.width) / 2;
			detailButton.y = background.height - detailButton.height;
			detailButton.addEventListener(MouseEvent.CLICK, detailButton_mouseClickHandler);
		}
		
		protected function detailButton_mouseClickHandler(event:MouseEvent):void
		{
			FittingRoom.instance.openDetailPanel(new Bitmap(bitmap.bitmapData.clone()), "aaddbb123", "测试名字", 145, Vector.<Number>([0xFF0000, 0xaaaaaa]), position);
		}
	}
}