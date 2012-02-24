package controls
{
	import com.kge.containers.HGroup;
	import com.kge.containers.VGroup;
	import com.kge.core.UIView;
	
	import delegates.SearchItemDelegate;
	
	import factory.ButtonFactory;
	
	import fl.controls.Button;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import utils.Tool;
	
	public class SearchConditionPanel extends UIView implements SearchItemDelegate
	{
		private var background:Shape = new Shape();
		private var realBackground:Shape = new Shape();
		private var trademark:SearchConditionItem;
		private var year:SearchConditionItem;
		private var quarter:SearchConditionItem;
		private var color:SearchConditionItem;
		private var type:SearchConditionItem;
		private var style:SearchConditionItem;
		private var vgroup:VGroup = new VGroup();
		private var hgroup:HGroup = new HGroup();
		private var searchButton:Button;
		private var clearButton:Button;
		private var closeButton:Button;
		private var searchPanel:SearchPanel;
		private var dir:String = "right";
		public function SearchConditionPanel(d:String = "right")
		{
			super();
			
			dir = d;
			
			trademark  = new SearchConditionItem("品牌", dir);
			year = new SearchConditionItem("年份", dir);
			quarter = new SearchConditionItem("季节", dir);
			color = new SearchConditionItem("颜色", dir);
			type = new SearchConditionItem("类型", dir);
			style = new SearchConditionItem("风格", dir);
			searchPanel = new SearchPanel(dir);
			
			drawBackground();
			drawRealBackground();
			
			closeButton = ButtonFactory.SearchPanelCloseButton();
			addChild(closeButton);
			if(dir == "right") closeButton.x = background.width - closeButton.width - 5;
			else closeButton.x = 5;
			closeButton.y = 5;
			closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
			
			vgroup.gap = 10;
			vgroup.addChild(trademark);
			vgroup.addChild(year);
			vgroup.addChild(quarter);
			vgroup.addChild(color);
			vgroup.addChild(type);
			vgroup.addChild(style);
			addChild(vgroup);
			vgroup.x = 17;
			vgroup.y = 30;
			
			trademark.itemDelegate = this;
			year.itemDelegate = this;
			quarter.itemDelegate = this;
			color.itemDelegate = this;
			type.itemDelegate = this;
			style.itemDelegate = this;
			
			searchButton = ButtonFactory.GreenButton();
			searchButton.addEventListener(MouseEvent.CLICK, searchButton_clickHandler);
			searchButton.label = "搜索";
			var tf:TextFormat = new TextFormat(null, 12, 0xFFFFFF);
			searchButton.setStyle("textFormat", tf);
			hgroup.addChild(searchButton);
			
			clearButton = ButtonFactory.GreenButton();
			clearButton.addEventListener(MouseEvent.CLICK, clearButton_clickHandler);
			clearButton.label = "清空";
			clearButton.setStyle("textFormat", tf);
			hgroup.addChild(clearButton);
			addChild(hgroup);
			hgroup.x = 35;
			hgroup.y = 260;
		}
		
		protected function clearButton_clickHandler(event:MouseEvent):void
		{
			trademark.clear();
			year.clear();
			quarter.clear();
			color.clear();
			type.clear();
			style.clear();
		}
		
		protected function searchButton_clickHandler(event:MouseEvent):void
		{
			if(trademark.getCondition() != "" || year.getCondition() != "" || quarter.getCondition() != "" || color.getCondition() != "" || type.getCondition() != "" || style.getCondition() != ""){
				// do searching...
			}
		}
		
		public function itemButtonClicked(sp:SearchConditionItem):void
		{
			searchPanel.target = sp;
			if(!this.contains(searchPanel)){
				addChildAt(searchPanel, 2);
				searchPanel.x = sp.x + sp.width + 15;
				searchPanel.y = sp.y + 31;
				if(dir == "left"){
					searchPanel.x = -searchPanel.width + 28;
				}
			}else{
				if(sp == trademark) searchPanel.changedPos(0);
				else if(sp == year) searchPanel.changedPos(1);
				else if(sp == quarter) searchPanel.changedPos(2);
				else if(sp == color) searchPanel.changedPos(3);
				else if(sp == type) searchPanel.changedPos(4);
				else if(sp == style) searchPanel.changedPos(5);
			}
		}
		
		private function drawRealBackground():void
		{
			realBackground.graphics.clear();
			realBackground.graphics.beginFill(0xcecece, .5);
			realBackground.graphics.drawRoundRect(0, 0, 185, 300, 5, 5);
			realBackground.graphics.endFill();
			addChild(realBackground);
		}
		
		protected function closeButton_clickHandler(event:MouseEvent):void
		{
			FittingRoom.instance.removeSearchPanel();
		}
		
		private function drawBackground():void
		{
			background.graphics.clear();
			background.graphics.beginFill(0xcecece, 1);
			background.graphics.drawRoundRect(0, 0, 185, 300, 5, 5);
			background.graphics.endFill();
			background.filters = [Tool.getBitmapFilter()];
			addChild(background);
		}
	}
}