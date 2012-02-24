package view {
	import com.greensock.TweenLite;
	import com.kge.containers.TileGroup;
	import com.kge.core.UIView;
	
	import controls.DressCell;
	
	import data.DataParams;
	import data.Dress;
	
	import delegates.DressCellDelegate;
	import delegates.FloatPanelDelegate;
	
	import factory.ButtonFactory;
	
	import fl.controls.Button;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.Responder;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import global.Global;

	/**
	 * @author Abel
	 */
	public class FloatPanel extends UIView implements DressCellDelegate {
		private var tileGroup : TileGroup;
		private var searchAndPages : SearchAndPages;
		protected var triangleButton : Button;
		protected var backButton : Button;
		public var _dir : String = "right";
		protected var background : Shape = new Shape();
		protected var tab : Shape = new Shape();
		protected var tabText : TextField = new TextField();
		protected var _isIndent : Boolean = false;
		private var _columnNum : int;
		protected var _tabStr : String;
		protected var _search : Boolean = true;
		private var param : String;
		private var allData:Array = [];
		private var curPage:int = 0;
		private var cellList:Vector.<DressCell> = new Vector.<DressCell>();
		private var curSelectedCell:DressCell;
		private var cellWidth : int = 66;
		private var cellHeight : int = 67;

		public function FloatPanel(columnNum : int, tabStr : String, p:String, dir : String = "right", search : Boolean = true) {
			super();
			
			_columnNum = columnNum;
			_tabStr = tabStr;
			_search = search;
			_dir = dir;
			param = p;

			init();
		}

		protected function init() : void {
			tileGroup = new TileGroup();
			tileGroup.columnCount = _columnNum;
			tileGroup.gap = 5;
			if(param == DataParams.BODY){
				cellWidth = 66;
				cellHeight = 105;
			}
			tileGroup.tileWidth = cellWidth;
			tileGroup.tileHeight = cellHeight;

			drawBackground();

			searchAndPages = new SearchAndPages(_dir, _search);
			addChild(searchAndPages);
			if (_dir == "right") {
				searchAndPages.x = background.x + background.width;
				searchAndPages.y = background.y + background.height - searchAndPages.height;
			} else {
				searchAndPages.x = background.x - 25;
				searchAndPages.y = background.y + background.height - searchAndPages.height;
			}

			triangleButton = ButtonFactory.IndentationButton(_dir);
			if (_dir == "right") backButton = ButtonFactory.IndentationButton("left");
			else backButton = ButtonFactory.IndentationButton("right");
			addChild(triangleButton);
			addChild(backButton);
			backButton.visible = false;

			tabText = new TextField();
			tabText.defaultTextFormat = Global.fontStyle.whiteStyle;
			tabText.text = _tabStr;
			tabText.width = 20;
			tabText.height = 30;
			tabText.wordWrap = true;
			tabText.selectable = false;
			tabText.mouseEnabled = true;
			tabText.mouseWheelEnabled = false;
			addChild(tabText);
			if (_dir == "right") {
				tabText.x = 220 + (tab.width - tabText.width) / 2;
				triangleButton.x = tabText.x - triangleButton.width - 5;
				backButton.x = triangleButton.x;
				tileGroup.y = 10;
			} else {
				tabText.x = -27 + (tab.width - tabText.width) / 2;
				tileGroup.x = 15;
				tileGroup.y = 10;
			}
			tabText.y = 10;
			triangleButton.y = tabText.y + 7;
			backButton.y = triangleButton.y;
			triangleButton.addEventListener(MouseEvent.CLICK, onTriangleButtonClicked);
			backButton.addEventListener(MouseEvent.CLICK, onTriangleButtonClicked);
			tabText.addEventListener(MouseEvent.CLICK, onTriangleButtonClicked);
			tabText.addEventListener(MouseEvent.MOUSE_OVER, onTab_mouseOverHandler);
			tabText.addEventListener(MouseEvent.MOUSE_OUT, onTab_mouseOutHandler);
			
			addChild(tileGroup);
			
			var pos:String = "lt";
			switch(_tabStr){
				case "上装":
				case "体型":
					pos = "lt";
					break;
				case "下装":
					pos = "lb";
					break;
				case "套装":
				case "发型":
					pos = "rt";
					break;
				case "鞋包":
				case "脸型":
					pos = "rb";
					break;
			}
			
			var cell0:DressCell = new DressCell(cellWidth, cellHeight, pos);
			var cell1:DressCell = new DressCell(cellWidth, cellHeight, pos);
			var cell2:DressCell = new DressCell(cellWidth, cellHeight, pos);
			var cell3:DressCell = new DressCell(cellWidth, cellHeight, pos);
			var cell4:DressCell = new DressCell(cellWidth, cellHeight, pos);
			var cell5:DressCell = new DressCell(cellWidth, cellHeight, pos);
			var cell6:DressCell = new DressCell(cellWidth, cellHeight, pos);
			var cell7:DressCell = new DressCell(cellWidth, cellHeight, pos);
			var cell8:DressCell = new DressCell(cellWidth, cellHeight, pos);
			
			if(param == DataParams.BODY){
				cellList.push(cell0);
				cellList.push(cell1);
				cellList.push(cell2);
				cellList.push(cell3);
				cellList.push(cell4);
				cellList.push(cell5);
				
				tileGroup.addChild(cell0);
				tileGroup.addChild(cell1);
				tileGroup.addChild(cell2);
				tileGroup.addChild(cell3);
				tileGroup.addChild(cell4);
				tileGroup.addChild(cell5);
			}else{
				cellList.push(cell0);
				cellList.push(cell1);
				cellList.push(cell2);
				cellList.push(cell3);
				cellList.push(cell4);
				cellList.push(cell5);
				cellList.push(cell6);
				cellList.push(cell7);
				cellList.push(cell8);
				
				tileGroup.addChild(cell0);
				tileGroup.addChild(cell1);
				tileGroup.addChild(cell2);
				tileGroup.addChild(cell3);
				tileGroup.addChild(cell4);
				tileGroup.addChild(cell5);
				tileGroup.addChild(cell6);
				tileGroup.addChild(cell7);
				tileGroup.addChild(cell8);
			}
			
			loadData();
		}
		
		public function cellClicked(cell:DressCell):void
		{
			if(curSelectedCell == cell) return;
			if(curSelectedCell) curSelectedCell.hideClickedSkin();
			curSelectedCell = cell;
		}
		
		private function loadData():void
		{
			Global.connection.call("FittingRoom/getDataByPageAndSex", new Responder(onResult) , "clothes", curPage, Global.curSex);
		}
		
		private function onResult(result:String):void
		{
			var xmlData:XML = new XML(result);
			XML.ignoreWhitespace = true;
			var arr:Array = [];
			for each(var item:XML in xmlData.children()){
				var dressData:Dress = new Dress();
				dressData.id = item.@id;
				dressData.dressName = item.@name;
				dressData.smallImage = item.@img;
				dressData.price = item.@price;
				dressData.type = item.@type;
				dressData.rejectType = item.@rejectType;
				dressData.sex = item.@sex;
				if(item.@colors) dressData.colorList = String(item.@colors).split(",");
				arr.push(dressData);
			}
			allData[curPage] = arr;
			var index:int = 0;
			for each(var cell:DressCell in cellList){
				if(arr[index]){
					cell.cellDeleagte = this;
					cell.data = arr[index];
					cell.loadThumbnail();
					index++;
				}
			}
		}
		
		protected function onTab_mouseOutHandler(event:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.ARROW;
		}
		
		protected function onTab_mouseOverHandler(event:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.BUTTON;
		}
		
		protected function onTriangleButtonClicked(event : MouseEvent) : void {
			if (delegate && delegate is FloatPanelDelegate) {
				(delegate as FloatPanelDelegate).indentFloatPanel(this);
			}
		}

		protected function drawBackground() : void {
			background.graphics.clear();
			background.graphics.beginFill(0x000000, .5);
			background.graphics.drawRect(0, 0, 220, 230);
			background.graphics.endFill();
			addChild(background);
			if (_dir == "right") {
				tab.graphics.clear();
				tab.graphics.beginFill(0x000000, .5);
				tab.graphics.drawRoundRectComplex(220, 0, 30, 50, 0, 8, 0, 8);
				tab.graphics.endFill();
				addChild(tab);
			} else {
				tab.graphics.clear();
				tab.graphics.beginFill(0x000000, .5);
				tab.graphics.drawRoundRectComplex(-30, 0, 30, 50, 8, 0, 8, 0);
				tab.graphics.endFill();
				addChild(tab);
			}
		}

		public function showData() : void {
		}

		public function get isIndent() : Boolean {
			return _isIndent;
		}

		public function set isIndent(isIndent : Boolean) : void {
			if (_isIndent != isIndent) {
				_isIndent = isIndent;
				if (_isIndent) {
					backButton.visible = true;
					triangleButton.visible = false;
				} else {
					backButton.visible = false;
					triangleButton.visible = true;
				}
			}
		}
	}
}
