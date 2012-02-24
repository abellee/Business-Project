package controls
{
	import com.kge.core.UIView;
	
	import delegates.SearchItemDelegate;
	
	import factory.ButtonFactory;
	
	import fl.controls.Button;
	import fl.data.DataProvider;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import resource.Resource;
	
	import utils.Tool;
	
	public class SearchConditionItem extends UIView
	{
		private var conditionLabel : TextField = new TextField();
		private var button:Button;
		private var buttonLabel:TextField = new TextField();
		private var background:Bitmap = new (Resource.SearchItem)();
		public var itemDelegate:SearchItemDelegate;
		private var dir:String = "right";
		private var dp:DataProvider = null;
		public function SearchConditionItem(str:String, d:String = "right", dprovider:DataProvider = null)
		{
			super();
			
			dir = d;
			dp = dprovider;
			
			addChild(background);
			
			button = ButtonFactory.SearchConditionButton(d);
			addChild(button);
			button.addEventListener(MouseEvent.CLICK, onButton_clickHandler);
			buttonLabel.autoSize = TextFieldAutoSize.LEFT;
			buttonLabel.defaultTextFormat = new TextFormat("黑体", 12, 0xFFFFFF);
			buttonLabel.text = str;
			buttonLabel.mouseEnabled = false;
			buttonLabel.selectable = false;
			addChild(buttonLabel);
			if(dir == "right"){
				background = new (Resource.SearchItem)();
				button.x = background.width;
				background.x = 0;
				buttonLabel.x = button.x + 5;
				buttonLabel.y = button.y + 5;
			}else{
				var bp:Bitmap = new Bitmap(Tool.bitmapDataReverseX(background.bitmapData));
				removeChild(background);
				background = bp;
				addChild(background);
				button.x = 0;
				background.x = button.width;
				buttonLabel.x = button.x + 20;
				buttonLabel.y = button.y + 5;
			}
			addChild(conditionLabel);
			conditionLabel.width = background.width;
			conditionLabel.height = 18;
			conditionLabel.defaultTextFormat = new TextFormat(null, 12, 0x000000, true, null, null, null, null, "center");
			conditionLabel.x = background.x;
		}
		
		protected function onButton_clickHandler(event:MouseEvent):void
		{
			if(itemDelegate) itemDelegate.itemButtonClicked(this);
		}
		
		public function clear():void
		{
			conditionLabel.text = "";
		}
		
		public function setCondition(str:String):void
		{
			conditionLabel.text = str;
			conditionLabel.y = (background.height - conditionLabel.textHeight) / 2;
		}
		
		public function getCondition():String{
			return conditionLabel.text;
		}
	}
}