package controls
{
	import com.kge.core.UIView;
	
	import fl.controls.List;
	import fl.data.DataProvider;
	import fl.events.ListEvent;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import global.Global;
	
	import utils.ScaleBitmap;
	import utils.Tool;
	
	public class SearchPanel extends UIView
	{
		private var background:Shape = new Shape();
		private var rect:Shape = new Shape();
		private var realBackground:Shape = new Shape();
		private var realRect:Shape = new Shape();
		private var container:Sprite = new Sprite();
		private var dir:String = "right";
		private var list:List = new List();
		public var target:SearchConditionItem = null;
		public function SearchPanel(d:String = "right")
		{
			super();
			
			dir = d;
			
			drawBackground();
			
			list.setStyle("cellRenderer", ListCellRenderer);
			list.width = 140;
			list.height = 270;
			list.setStyle("skin", new Sprite());
			list.addEventListener(ListEvent.ITEM_CLICK, list_itemClickHandler);
			list.dataProvider = new DataProvider([{label:"全部", data:0}, {label:"A", data:-1}, {label:"aaa", data:12}, {label:"bbb", data:12}, {label:"aaa", data:12}, {label:"bbb", data:12}, {label:"aaa", data:12}, {label:"bbb", data:12}, {label:"aaa", data:12}, {label:"bbb", data:12}, {label:"aaa", data:12}, {label:"bbb", data:12}, {label:"aaa", data:12}, {label:"bbb", data:12}, {label:"aaa", data:12}, {label:"bbb", data:12}]);
			addChild(list);
			if(dir == "right"){
				list.x = rect.width;
			}
			list.y = -15;
			list.mouseChildren = true;
			list.mouseEnabled = true;
			var thumbUpSkin:ScaleBitmap = new ScaleBitmap(Global.staticAssets.scrollBarUp());
			thumbUpSkin.scale9Grid = new Rectangle(1, 41, 3, 14);
			var thumbDownSkin:ScaleBitmap = new ScaleBitmap(Global.staticAssets.scrollBarDown());
			thumbDownSkin.scale9Grid = new Rectangle(1, 41, 3, 14);
			list.setStyle("thumbUpSkin", thumbUpSkin);
			list.setStyle("thumbOverSkin", thumbDownSkin);
			list.setStyle("thumbDownSkin", thumbDownSkin);
			list.setStyle("upArrowUpSkin", new Sprite());
			list.setStyle("upArrowOverSkin", new Sprite());
			list.setStyle("upArrowDownSkin", new Sprite());
			list.setStyle("downArrowUpSkin", new Sprite());
			list.setStyle("downArrowOverSkin", new Sprite());
			list.setStyle("downArrowDownSkin", new Sprite());
			list.setStyle("trackUpSkin", new Sprite());
			list.setStyle("trackOverSkin", new Sprite());
			list.setStyle("trackDownSkin", new Sprite());
			list.setStyle("focusRectSkin", new Sprite());
		}
		
		protected function list_itemClickHandler(event:ListEvent):void
		{
			target.setCondition(event.item.label);
		}
		
		private function drawBackground():void{
			rect.graphics.clear();
			rect.graphics.beginFill(0x87c117, 1.0);
			rect.graphics.drawRect(0, 0, 30, 27);
			rect.graphics.endFill();
			
			background.graphics.clear();
			background.graphics.beginFill(0x87c117, 1.0);
			background.graphics.drawRoundRectComplex(0, 0, 140, 290, 10, 10, 10, 10);
			background.graphics.endFill();
			
			realRect.graphics.clear();
			realRect.graphics.beginFill(0x87c117, .5);
			realRect.graphics.drawRect(0, 0, 30, 27);
			realRect.graphics.endFill();
			
			realBackground.graphics.clear();
			realBackground.graphics.beginFill(0x87c117, .5);
			realBackground.graphics.drawRoundRectComplex(0, 0, 140, 290, 10, 10, 10, 10);
			realBackground.graphics.endFill();
			
			container.addChild(rect);
			container.addChild(background);
			background.x = rect.width;
			background.y = -25;
			container.filters = [Tool.getBitmapFilter()];
			addChild(container);
			
			addChild(realRect);
			addChild(realBackground);
			if(dir == "right"){
				rect.x = 0;
				background.x = rect.width;
				realBackground.x = realRect.width;
			}else{
				background.x = 0;
				rect.x = background.width;
				realRect.x = realBackground.width;
			}
			realBackground.y = -25;
		}
		
		public function changedPos(index:int):void
		{
			realRect.y = index * 37;
			rect.y = index * 37;
		}
	}
}